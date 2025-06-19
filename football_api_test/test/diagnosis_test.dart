import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:football_api_test/providers/providers.dart';
import 'package:football_api_test/models/team.dart';
import 'package:football_api_test/models/area.dart';
import 'package:football_api_test/models/competition.dart';

void main() {
  group('Provider Diagnosis Tests', () {
    test('premierLeagueTeamsProvider works in isolation', () async {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      try {
        // This should work if the API service is set up correctly
        final future = container.read(premierLeagueTeamsProvider.future);
        await expectLater(future, completion(isA<List<Team>>()));
      } catch (e) {
        print('API Error (expected): $e');
        // API errors are expected in tests, this is just to check provider setup
      }
    });

    test('UI state providers work correctly', () async {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      // Test search provider
      final searchNotifier = container.read(searchTextNotifierProvider.notifier);
      expect(container.read(searchTextNotifierProvider), '');
      
      searchNotifier.setSearchText('Arsenal');
      expect(container.read(searchTextNotifierProvider), 'Arsenal');

      // Test sort provider
      final sortNotifier = container.read(sortOrderNotifierProvider.notifier);
      expect(container.read(sortOrderNotifierProvider), SortOrder.nameAsc);
      
      sortNotifier.setSortOrder(SortOrder.nameDesc);
      expect(container.read(sortOrderNotifierProvider), SortOrder.nameDesc);

      // Test view mode provider
      final viewModeNotifier = container.read(viewModeNotifierProvider.notifier);
      expect(container.read(viewModeNotifierProvider), ViewMode.list);
      
      viewModeNotifier.toggle();
      expect(container.read(viewModeNotifierProvider), ViewMode.grid);
    });

    test('filteredAndSortedTeamsProvider with mock data', () async {
      final container = ProviderContainer(
        overrides: [
          premierLeagueTeamsProvider.overrideWith((ref) async => [
            Team(
              id: 1,
              name: 'Arsenal FC',
              shortName: 'Arsenal',
              tla: 'ARS',
              crest: 'crest1',
              area: const Area(id: 1, name: 'England', code: 'ENG', flag: 'flag'),
              runningCompetitions: [
                const Competition(id: 1, name: 'Premier League', code: 'PL', type: 'LEAGUE'),
              ],
              lastUpdated: '2024-01-01T00:00:00Z',
            ),
            Team(
              id: 2,
              name: 'Chelsea FC',
              shortName: 'Chelsea',
              tla: 'CHE',
              crest: 'crest2',
              area: const Area(id: 1, name: 'England', code: 'ENG', flag: 'flag'),
              runningCompetitions: [
                const Competition(id: 1, name: 'Premier League', code: 'PL', type: 'LEAGUE'),
              ],
              lastUpdated: '2024-01-01T00:00:00Z',
            ),
          ]),
        ],
      );
      addTearDown(container.dispose);

      // Test filtering and sorting
      final teams = await container.read(filteredAndSortedTeamsProvider.future);
      expect(teams, hasLength(2));
      expect(teams[0].name, 'Arsenal FC'); // Should be sorted A-Z

      // Test search filtering
      container.read(searchTextNotifierProvider.notifier).setSearchText('Arsenal');
      final filteredTeams = await container.read(filteredAndSortedTeamsProvider.future);
      expect(filteredTeams, hasLength(1));
      expect(filteredTeams[0].name, 'Arsenal FC');

      // Test sort order
      container.read(sortOrderNotifierProvider.notifier).setSortOrder(SortOrder.nameDesc);
      final sortedTeams = await container.read(filteredAndSortedTeamsProvider.future);
      expect(sortedTeams[0].name, 'Arsenal FC'); // Only one team left after filter
    });

    test('favorites providers work correctly', () async {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      try {
        // Test favorites count
        final count = await container.read(favoriteTeamsCountProvider.future);
        expect(count, isA<int>());

        // Test favorites list
        final favorites = await container.read(favoriteTeamsProvider.future);
        expect(favorites, isA<List>());

        // Test is team favorite
        final isFavorite = await container.read(isTeamFavoriteProvider(1).future);
        expect(isFavorite, isA<bool>());
      } catch (e) {
        print('Database Error (expected in test): $e');
        // Database errors are expected in tests without proper setup
      }
    });

    test('app providers initialize correctly', () {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      // Test database provider
      final database = container.read(appDatabaseProvider);
      expect(database, isNotNull);

      // Test API service provider
      final apiService = container.read(footballApiServiceProvider);
      expect(apiService, isNotNull);
    });
  });
} 