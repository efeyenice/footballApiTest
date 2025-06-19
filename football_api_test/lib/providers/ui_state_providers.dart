import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../models/team.dart';
import 'teams_providers.dart';

part 'ui_state_providers.g.dart';

/// Enum for view modes
enum ViewMode { list, grid }

/// Enum for sorting options
enum SortOrder { nameAsc, nameDesc }

/// Provider for view mode (list or grid)
@riverpod
class ViewModeNotifier extends _$ViewModeNotifier {
  @override
  ViewMode build() => ViewMode.list;

  void setListView() => state = ViewMode.list;
  void setGridView() => state = ViewMode.grid;
  void toggle() =>
      state = state == ViewMode.list ? ViewMode.grid : ViewMode.list;
}

/// Provider for sorting order
@riverpod
class SortOrderNotifier extends _$SortOrderNotifier {
  @override
  SortOrder build() => SortOrder.nameAsc;

  void setSortOrder(SortOrder order) => state = order;
  void toggleSort() => state = state == SortOrder.nameAsc
      ? SortOrder.nameDesc
      : SortOrder.nameAsc;
}

/// Provider for search/filter text
@riverpod
class SearchTextNotifier extends _$SearchTextNotifier {
  @override
  String build() => '';

  void setSearchText(String text) => state = text;
  void clearSearch() => state = '';
}

/// Provider that combines teams with filtering and sorting
@riverpod
Future<List<Team>> filteredAndSortedTeams(ref) async {
  // Get teams from the Premier League teams provider
  final teams = await ref.watch(premierLeagueTeamsProvider.future);
  final searchText = ref.watch(searchTextNotifierProvider);
  final sortOrder = ref.watch(sortOrderNotifierProvider);

  // Filter teams based on search text
  var filteredTeams = teams.where((team) {
    if (searchText.isEmpty) return true;
    return team.name.toLowerCase().contains(searchText.toLowerCase()) ||
        team.shortName.toLowerCase().contains(searchText.toLowerCase());
  }).toList();

  // Sort teams based on sort order
  if (sortOrder == SortOrder.nameAsc) {
    filteredTeams.sort((a, b) => a.name.compareTo(b.name));
  } else {
    filteredTeams.sort((a, b) => b.name.compareTo(a.name));
  }

  return filteredTeams;
}

/// Provider for UI loading states
@riverpod
class LoadingStateNotifier extends _$LoadingStateNotifier {
  @override
  bool build() => false;

  void setLoading(bool loading) => state = loading;
}

/// Provider for error messages
@riverpod
class ErrorMessageNotifier extends _$ErrorMessageNotifier {
  @override
  String? build() => null;

  void setError(String? error) => state = error;
  void clearError() => state = null;
}
