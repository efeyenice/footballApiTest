import 'package:flutter/foundation.dart';
import '../models/team.dart';
import '../models/match.dart';
import 'football_api_service.dart';
import 'database_service.dart';

/// Simple state management for the football app
/// Replaces complex Riverpod providers with clean, readable Provider classes

/// Enum for view modes
enum ViewMode { list, grid }

/// Enum for sorting options  
enum SortOrder { nameAsc, nameDesc }

/// Main app state manager - replaces multiple Riverpod providers
class AppState with ChangeNotifier {
  static final AppState _instance = AppState._internal();
  factory AppState() => _instance;
  AppState._internal();

  // Services
  final FootballApiService _apiService = FootballApiService();

  // UI State
  ViewMode _viewMode = ViewMode.list;
  SortOrder _sortOrder = SortOrder.nameAsc;
  String _searchText = '';
  bool _isLoading = false;
  String? _errorMessage;

  // Data State
  List<Team>? _allTeams;
  List<Team> _filteredTeams = [];
  final Map<int, Team> _teamCache = {};
  final Map<int, List<Match>> _upcomingMatchesCache = {};
  final Map<int, List<Match>> _finishedMatchesCache = {};
  final Map<int, int> _matchesPlayedCache = {};

  // Favorites State
  List<FavoriteTeam> _favoriteTeams = [];
  Set<int> _favoriteTeamIds = {};
  int _favoritesCount = 0;

  // Getters
  ViewMode get viewMode => _viewMode;
  SortOrder get sortOrder => _sortOrder;
  String get searchText => _searchText;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  
  List<Team> get teams => _filteredTeams;
  List<FavoriteTeam> get favoriteTeams => _favoriteTeams;
  int get favoritesCount => _favoritesCount;

  /// Initialize app state - call this on app startup
  Future<void> initialize() async {
    try {
      setLoading(true);
      await _loadFavorites();
      await loadTeams();
    } catch (e) {
      setError('Failed to initialize app: $e');
    } finally {
      setLoading(false);
    }
  }

  // UI State Methods
  void setViewMode(ViewMode mode) {
    if (_viewMode != mode) {
      _viewMode = mode;
      notifyListeners();
    }
  }

  void toggleViewMode() {
    setViewMode(_viewMode == ViewMode.list ? ViewMode.grid : ViewMode.list);
  }

  void setSortOrder(SortOrder order) {
    if (_sortOrder != order) {
      _sortOrder = order;
      _applySortingAndFiltering();
      notifyListeners();
    }
  }

  void toggleSortOrder() {
    setSortOrder(_sortOrder == SortOrder.nameAsc ? SortOrder.nameDesc : SortOrder.nameAsc);
  }

  void setSearchText(String text) {
    if (_searchText != text) {
      _searchText = text;
      _applySortingAndFiltering();
      notifyListeners();
    }
  }

  void clearSearch() {
    setSearchText('');
  }

  void setLoading(bool loading) {
    if (_isLoading != loading) {
      _isLoading = loading;
      notifyListeners();
    }
  }

  void setError(String? error) {
    if (_errorMessage != error) {
      _errorMessage = error;
      notifyListeners();
    }
  }

  void clearError() {
    setError(null);
  }

  // Teams Data Methods
  Future<void> loadTeams() async {
    try {
      setLoading(true);
      clearError();
      
      _allTeams = await _apiService.getPremierLeagueTeams();
      _applySortingAndFiltering();
      
    } catch (e) {
      setError('Failed to load teams: $e');
    } finally {
      setLoading(false);
    }
  }

  Future<Team?> getTeamById(int teamId) async {
    // Check cache first
    if (_teamCache.containsKey(teamId)) {
      return _teamCache[teamId];
    }

    try {
      final team = await _apiService.getTeamById(teamId);
      _teamCache[teamId] = team;
      return team;
    } catch (e) {
      setError('Failed to load team: $e');
      return null;
    }
  }

  Future<List<Match>> getUpcomingMatches(int teamId) async {
    // Check cache first
    if (_upcomingMatchesCache.containsKey(teamId)) {
      return _upcomingMatchesCache[teamId] ?? [];
    }

    try {
      final matches = await _apiService.getTeamUpcomingMatches(teamId);
      _upcomingMatchesCache[teamId] = matches;
      return matches;
    } catch (e) {
      setError('Failed to load upcoming matches: $e');
      return [];
    }
  }

  Future<List<Match>> getFinishedMatches(int teamId) async {
    // Check cache first
    if (_finishedMatchesCache.containsKey(teamId)) {
      return _finishedMatchesCache[teamId] ?? [];
    }

    try {
      final matches = await _apiService.getTeamFinishedMatches(teamId);
      _finishedMatchesCache[teamId] = matches;
      return matches;
    } catch (e) {
      setError('Failed to load finished matches: $e');
      return [];
    }
  }

  Future<int> getMatchesPlayed(int teamId) async {
    // Check cache first
    if (_matchesPlayedCache.containsKey(teamId)) {
      return _matchesPlayedCache[teamId] ?? 0;
    }

    try {
      final matchesPlayed = await _apiService.getTeamMatchesPlayed(teamId);
      _matchesPlayedCache[teamId] = matchesPlayed;
      return matchesPlayed;
    } catch (e) {
      // Don't set global error for this, as it's not critical
      // Just return 0 and cache it
      _matchesPlayedCache[teamId] = 0;
      return 0;
    }
  }

  /// Get cached matches played count (returns null if not cached)
  int? getCachedMatchesPlayed(int teamId) {
    return _matchesPlayedCache[teamId];
  }

  /// Preload matches played for multiple teams
  Future<void> preloadMatchesPlayed(List<Team> teams) async {
    final futures = teams.map((team) => getMatchesPlayed(team.id));
    await Future.wait(futures);
    notifyListeners();
  }

  // Favorites Methods
  Future<void> _loadFavorites() async {
    try {
      _favoriteTeams = await DatabaseService.getAllFavorites();
      _favoriteTeamIds = _favoriteTeams.map((f) => f.id).toSet();
      _favoritesCount = _favoriteTeams.length;
    } catch (e) {
      setError('Failed to load favorites: $e');
    }
  }

  bool isTeamFavorite(int teamId) {
    return _favoriteTeamIds.contains(teamId);
  }

  Future<void> toggleFavorite(Team team) async {
    try {
      final wasFavorite = isTeamFavorite(team.id);
      final isNowFavorite = await DatabaseService.toggleFavorite(team);
      
      if (isNowFavorite && !wasFavorite) {
        // Added to favorites
        final favoriteTeam = FavoriteTeam.fromTeam(team);
        _favoriteTeams.insert(0, favoriteTeam); // Add to beginning
        _favoriteTeamIds.add(team.id);
        _favoritesCount++;
      } else if (!isNowFavorite && wasFavorite) {
        // Removed from favorites
        _favoriteTeams.removeWhere((f) => f.id == team.id);
        _favoriteTeamIds.remove(team.id);
        _favoritesCount--;
      }
      
      notifyListeners();
    } catch (e) {
      setError('Failed to toggle favorite: $e');
    }
  }

  Future<void> addFavorite(Team team) async {
    if (!isTeamFavorite(team.id)) {
      try {
        await DatabaseService.addFavorite(team);
        final favoriteTeam = FavoriteTeam.fromTeam(team);
        _favoriteTeams.insert(0, favoriteTeam);
        _favoriteTeamIds.add(team.id);
        _favoritesCount++;
        notifyListeners();
      } catch (e) {
        setError('Failed to add favorite: $e');
      }
    }
  }

  Future<void> removeFavorite(int teamId) async {
    if (isTeamFavorite(teamId)) {
      try {
        await DatabaseService.removeFavorite(teamId);
        _favoriteTeams.removeWhere((f) => f.id == teamId);
        _favoriteTeamIds.remove(teamId);
        _favoritesCount--;
        notifyListeners();
      } catch (e) {
        setError('Failed to remove favorite: $e');
      }
    }
  }

  Future<void> clearAllFavorites() async {
    try {
      await DatabaseService.clearAllFavorites();
      _favoriteTeams.clear();
      _favoriteTeamIds.clear();
      _favoritesCount = 0;
      notifyListeners();
    } catch (e) {
      setError('Failed to clear favorites: $e');
    }
  }

  List<Team> get favoriteTeamsAsTeams {
    return _favoriteTeams.map((f) => f.toTeam()).toList();
  }

  // Private Helper Methods
  void _applySortingAndFiltering() {
    if (_allTeams == null) return;

    // Filter teams based on search text
    var filtered = _allTeams!.where((team) {
      if (_searchText.isEmpty) return true;
      final searchLower = _searchText.toLowerCase();
      return team.name.toLowerCase().contains(searchLower) ||
          team.shortName.toLowerCase().contains(searchLower);
    }).toList();

    // Sort teams based on sort order
    if (_sortOrder == SortOrder.nameAsc) {
      filtered.sort((a, b) => a.name.compareTo(b.name));
    } else {
      filtered.sort((a, b) => b.name.compareTo(a.name));
    }

    _filteredTeams = filtered;
  }

  // Cleanup
  @override
  void dispose() {
    _apiService.dispose();
    super.dispose();
  }
} 