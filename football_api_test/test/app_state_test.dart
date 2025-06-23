import 'package:flutter_test/flutter_test.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import '../lib/services/app_state.dart';
import '../lib/models/team.dart';

void main() {
  group('AppState Provider Tests', () {
    late AppState appState;

    setUpAll(() {
      // Initialize FFI for testing
      sqfliteFfiInit();
      databaseFactory = databaseFactoryFfi;
    });

    setUp(() {
      appState = AppState();
    });

    tearDown(() async {
      // Reset state to defaults for singleton
      appState.clearError();
      appState.clearSearch();
      appState.setViewMode(ViewMode.list);
      appState.setSortOrder(SortOrder.nameAsc);
      appState.setLoading(false);
      await appState.clearAllFavorites();
    });

    test('should initialize with default values', () {
      expect(appState.viewMode, equals(ViewMode.list));
      expect(appState.sortOrder, equals(SortOrder.nameAsc));
      expect(appState.searchText, equals(''));
      expect(appState.isLoading, equals(false));
      expect(appState.errorMessage, isNull);
      expect(appState.teams, isEmpty);
      expect(appState.favoritesCount, equals(0));
    });

    test('should update view mode', () {
      bool wasNotified = false;
      appState.addListener(() => wasNotified = true);

      appState.setViewMode(ViewMode.grid);
      
      expect(appState.viewMode, equals(ViewMode.grid));
      expect(wasNotified, isTrue);
    });

    test('should toggle view mode', () {
      expect(appState.viewMode, equals(ViewMode.list));
      
      appState.toggleViewMode();
      expect(appState.viewMode, equals(ViewMode.grid));
      
      appState.toggleViewMode();
      expect(appState.viewMode, equals(ViewMode.list));
    });

    test('should update sort order', () {
      bool wasNotified = false;
      appState.addListener(() => wasNotified = true);

      appState.setSortOrder(SortOrder.nameDesc);
      
      expect(appState.sortOrder, equals(SortOrder.nameDesc));
      expect(wasNotified, isTrue);
    });

    test('should toggle sort order', () {
      expect(appState.sortOrder, equals(SortOrder.nameAsc));
      
      appState.toggleSortOrder();
      expect(appState.sortOrder, equals(SortOrder.nameDesc));
      
      appState.toggleSortOrder();
      expect(appState.sortOrder, equals(SortOrder.nameAsc));
    });

    test('should update search text', () {
      bool wasNotified = false;
      appState.addListener(() => wasNotified = true);

      appState.setSearchText('Arsenal');
      
      expect(appState.searchText, equals('Arsenal'));
      expect(wasNotified, isTrue);
    });

    test('should clear search text', () {
      appState.setSearchText('Test');
      expect(appState.searchText, equals('Test'));
      
      appState.clearSearch();
      expect(appState.searchText, equals(''));
    });

    test('should update loading state', () {
      bool wasNotified = false;
      appState.addListener(() => wasNotified = true);

      appState.setLoading(true);
      
      expect(appState.isLoading, isTrue);
      expect(wasNotified, isTrue);
      
      appState.setLoading(false);
      expect(appState.isLoading, isFalse);
    });

    test('should update error message', () {
      bool wasNotified = false;
      appState.addListener(() => wasNotified = true);

      appState.setError('Test error');
      
      expect(appState.errorMessage, equals('Test error'));
      expect(wasNotified, isTrue);
      
      appState.clearError();
      expect(appState.errorMessage, isNull);
    });

    test('should handle favorites', () async {
      const testTeam = Team(
        id: 1,
        name: 'Test FC',
        shortName: 'Test',
        tla: 'TST',
        crest: 'https://example.com/crest.png',
        venue: 'Test Stadium',
        founded: 2000,
        clubColors: 'Red / Blue',
      );

      // Initially not favorite
      expect(appState.isTeamFavorite(testTeam.id), isFalse);
      expect(appState.favoritesCount, equals(0));

      // Add to favorites
      await appState.addFavorite(testTeam);
      expect(appState.isTeamFavorite(testTeam.id), isTrue);
      expect(appState.favoritesCount, equals(1));

      // Remove from favorites
      await appState.removeFavorite(testTeam.id);
      expect(appState.isTeamFavorite(testTeam.id), isFalse);
      expect(appState.favoritesCount, equals(0));
    });

    test('should toggle favorites', () async {
      const testTeam = Team(
        id: 2,
        name: 'Another FC',
        shortName: 'Another',
        tla: 'ANO',
        crest: 'https://example.com/crest2.png',
      );

      // Toggle to favorite
      await appState.toggleFavorite(testTeam);
      expect(appState.isTeamFavorite(testTeam.id), isTrue);
      expect(appState.favoritesCount, equals(1));

      // Toggle back to not favorite
      await appState.toggleFavorite(testTeam);
      expect(appState.isTeamFavorite(testTeam.id), isFalse);
      expect(appState.favoritesCount, equals(0));
    });
  });
} 