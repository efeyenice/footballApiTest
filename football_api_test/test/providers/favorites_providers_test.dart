import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:football_api_test/providers/favorites_providers.dart';
import 'package:football_api_test/providers/app_providers.dart';
import 'package:football_api_test/database/app_database.dart';
import 'package:football_api_test/models/team.dart';
import 'package:football_api_test/models/area.dart';
import 'package:football_api_test/models/competition.dart';

void main() {
  group('Favorites Providers Tests', () {
    late ProviderContainer container;
    late AppDatabase testDatabase;

    setUp(() {
      // Create a test database
      testDatabase = AppDatabase();

      container = ProviderContainer(
        overrides: [
          appDatabaseProvider.overrideWithValue(testDatabase),
        ],
      );
    });

    tearDown(() async {
      await testDatabase.close();
      container.dispose();
    });

    group('favoriteTeamsProvider', () {
      test('returns empty list initially', () async {
        final favorites = await container.read(favoriteTeamsProvider.future);
        expect(favorites, isEmpty);
      });

      test('returns favorite teams after adding some', () async {
        final notifier = container.read(favoritesNotifierProvider.notifier);
        
        final testTeam = Team(
          id: 1,
          name: 'Arsenal FC',
          shortName: 'Arsenal',
          tla: 'ARS',
          crest: 'https://crests.football-data.org/57.png',
          area: const Area(id: 1, name: 'England', code: 'ENG', flag: 'flag'),
          runningCompetitions: [
            const Competition(id: 1, name: 'Premier League', code: 'PL', type: 'LEAGUE'),
          ],
          lastUpdated: '2024-01-01T00:00:00Z',
        );

        await notifier.addFavorite(testTeam);

        final favorites = await container.read(favoriteTeamsProvider.future);
        expect(favorites, hasLength(1));
        expect(favorites.first.id, equals(1));
        expect(favorites.first.name, equals('Arsenal FC'));
      });
    });

    group('favoriteTeamsAsTeamsProvider', () {
      test('returns empty list initially', () async {
        final teams = await container.read(favoriteTeamsAsTeamsProvider.future);
        expect(teams, isEmpty);
        expect(teams, isA<List<Team>>());
      });

      test('converts FavoriteTeam to Team correctly', () async {
        final notifier = container.read(favoritesNotifierProvider.notifier);
        
        final testTeam = Team(
          id: 1,
          name: 'Arsenal FC',
          shortName: 'Arsenal',
          tla: 'ARS',
          crest: 'https://crests.football-data.org/57.png',
          venue: 'Emirates Stadium',
          founded: 1886,
          clubColors: 'Red / White',
          area: const Area(id: 1, name: 'England', code: 'ENG', flag: 'flag'),
          runningCompetitions: [
            const Competition(id: 1, name: 'Premier League', code: 'PL', type: 'LEAGUE'),
          ],
          lastUpdated: '2024-01-01T00:00:00Z',
        );

        await notifier.addFavorite(testTeam);

        final teams = await container.read(favoriteTeamsAsTeamsProvider.future);
        expect(teams, hasLength(1));
        expect(teams, isA<List<Team>>());
        
        final convertedTeam = teams.first;
        expect(convertedTeam.id, equals(1));
        expect(convertedTeam.name, equals('Arsenal FC'));
        expect(convertedTeam.shortName, equals('Arsenal'));
        expect(convertedTeam.tla, equals('ARS'));
        expect(convertedTeam.crest, equals('https://crests.football-data.org/57.png'));
        expect(convertedTeam.venue, equals('Emirates Stadium'));
        expect(convertedTeam.founded, equals(1886));
        expect(convertedTeam.clubColors, equals('Red / White'));
        expect(convertedTeam.area.name, equals('Unknown')); // Default area in favorites
        expect(convertedTeam.runningCompetitions, isEmpty); // Not stored in favorites
      });

      test('handles multiple teams correctly', () async {
        final notifier = container.read(favoritesNotifierProvider.notifier);
        
        final teams = [
          Team(
            id: 1,
            name: 'Arsenal FC',
            shortName: 'Arsenal',
            tla: 'ARS',
            crest: 'crest1',
            area: const Area(id: 1, name: 'England', code: 'ENG', flag: 'flag'),
            runningCompetitions: [],
            lastUpdated: '2024-01-01T00:00:00Z',
          ),
          Team(
            id: 2,
            name: 'Chelsea FC',
            shortName: 'Chelsea',
            tla: 'CHE',
            crest: 'crest2',
            area: const Area(id: 1, name: 'England', code: 'ENG', flag: 'flag'),
            runningCompetitions: [],
            lastUpdated: '2024-01-01T00:00:00Z',
          ),
        ];

        for (final team in teams) {
          await notifier.addFavorite(team);
        }

        final favoriteTeams = await container.read(favoriteTeamsAsTeamsProvider.future);
        expect(favoriteTeams, hasLength(2));
        expect(favoriteTeams, isA<List<Team>>());
        
        expect(favoriteTeams.map((t) => t.id).toList(), containsAll([1, 2]));
        expect(favoriteTeams.map((t) => t.name).toList(), containsAll(['Arsenal FC', 'Chelsea FC']));
      });
    });

    group('isTeamFavoriteProvider', () {
      test('returns false for non-favorite team', () async {
        final isFavorite = await container.read(isTeamFavoriteProvider(1).future);
        expect(isFavorite, isFalse);
      });

      test('returns true for favorite team', () async {
        final notifier = container.read(favoritesNotifierProvider.notifier);
        
        final testTeam = Team(
          id: 1,
          name: 'Arsenal FC',
          shortName: 'Arsenal',
          tla: 'ARS',
          crest: 'crest',
          area: const Area(id: 1, name: 'England', code: 'ENG', flag: 'flag'),
          runningCompetitions: [],
          lastUpdated: '2024-01-01T00:00:00Z',
        );

        await notifier.addFavorite(testTeam);

        final isFavorite = await container.read(isTeamFavoriteProvider(1).future);
        expect(isFavorite, isTrue);
        
        final isNotFavorite = await container.read(isTeamFavoriteProvider(999).future);
        expect(isNotFavorite, isFalse);
      });
    });

    group('favoriteTeamsCountProvider', () {
      test('returns 0 initially', () async {
        final count = await container.read(favoriteTeamsCountProvider.future);
        expect(count, equals(0));
      });

      test('returns correct count after adding teams', () async {
        final notifier = container.read(favoritesNotifierProvider.notifier);
        
        final teams = List.generate(3, (index) => Team(
          id: index + 1,
          name: 'Team ${index + 1}',
          shortName: 'T${index + 1}',
          tla: 'T${index + 1}',
          crest: 'crest${index + 1}',
          area: const Area(id: 1, name: 'England', code: 'ENG', flag: 'flag'),
          runningCompetitions: [],
          lastUpdated: '2024-01-01T00:00:00Z',
        ));

        for (final team in teams) {
          await notifier.addFavorite(team);
        }

        final count = await container.read(favoriteTeamsCountProvider.future);
        expect(count, equals(3));
      });

      test('updates count when removing teams', () async {
        final notifier = container.read(favoritesNotifierProvider.notifier);
        
        final testTeam = Team(
          id: 1,
          name: 'Arsenal FC',
          shortName: 'Arsenal',
          tla: 'ARS',
          crest: 'crest',
          area: const Area(id: 1, name: 'England', code: 'ENG', flag: 'flag'),
          runningCompetitions: [],
          lastUpdated: '2024-01-01T00:00:00Z',
        );

        await notifier.addFavorite(testTeam);
        var count = await container.read(favoriteTeamsCountProvider.future);
        expect(count, equals(1));

        await notifier.removeFavorite(1);
        count = await container.read(favoriteTeamsCountProvider.future);
        expect(count, equals(0));
      });
    });

    group('FavoritesNotifier', () {
      test('addFavorite adds team to database', () async {
        final notifier = container.read(favoritesNotifierProvider.notifier);
        
        final testTeam = Team(
          id: 1,
          name: 'Arsenal FC',
          shortName: 'Arsenal',
          tla: 'ARS',
          crest: 'crest',
          area: const Area(id: 1, name: 'England', code: 'ENG', flag: 'flag'),
          runningCompetitions: [],
          lastUpdated: '2024-01-01T00:00:00Z',
        );

        await notifier.addFavorite(testTeam);

        final favorites = await container.read(favoriteTeamsProvider.future);
        expect(favorites, hasLength(1));
        expect(favorites.first.id, equals(1));
      });

      test('removeFavorite removes team from database', () async {
        final notifier = container.read(favoritesNotifierProvider.notifier);
        
        final testTeam = Team(
          id: 1,
          name: 'Arsenal FC',
          shortName: 'Arsenal',
          tla: 'ARS',
          crest: 'crest',
          area: const Area(id: 1, name: 'England', code: 'ENG', flag: 'flag'),
          runningCompetitions: [],
          lastUpdated: '2024-01-01T00:00:00Z',
        );

        await notifier.addFavorite(testTeam);
        var favorites = await container.read(favoriteTeamsProvider.future);
        expect(favorites, hasLength(1));

        await notifier.removeFavorite(1);
        favorites = await container.read(favoriteTeamsProvider.future);
        expect(favorites, isEmpty);
      });

      test('toggleFavorite adds team when not favorite', () async {
        final notifier = container.read(favoritesNotifierProvider.notifier);
        
        final testTeam = Team(
          id: 1,
          name: 'Arsenal FC',
          shortName: 'Arsenal',
          tla: 'ARS',
          crest: 'crest',
          area: const Area(id: 1, name: 'England', code: 'ENG', flag: 'flag'),
          runningCompetitions: [],
          lastUpdated: '2024-01-01T00:00:00Z',
        );

        var isFavorite = await container.read(isTeamFavoriteProvider(1).future);
        expect(isFavorite, isFalse);

        await notifier.toggleFavorite(testTeam);

        isFavorite = await container.read(isTeamFavoriteProvider(1).future);
        expect(isFavorite, isTrue);
      });

      test('toggleFavorite removes team when favorite', () async {
        final notifier = container.read(favoritesNotifierProvider.notifier);
        
        final testTeam = Team(
          id: 1,
          name: 'Arsenal FC',
          shortName: 'Arsenal',
          tla: 'ARS',
          crest: 'crest',
          area: const Area(id: 1, name: 'England', code: 'ENG', flag: 'flag'),
          runningCompetitions: [],
          lastUpdated: '2024-01-01T00:00:00Z',
        );

        await notifier.addFavorite(testTeam);
        var isFavorite = await container.read(isTeamFavoriteProvider(1).future);
        expect(isFavorite, isTrue);

        await notifier.toggleFavorite(testTeam);

        isFavorite = await container.read(isTeamFavoriteProvider(1).future);
        expect(isFavorite, isFalse);
      });

      test('clearAllFavorites removes all teams', () async {
        final notifier = container.read(favoritesNotifierProvider.notifier);
        
        final teams = List.generate(3, (index) => Team(
          id: index + 1,
          name: 'Team ${index + 1}',
          shortName: 'T${index + 1}',
          tla: 'T${index + 1}',
          crest: 'crest${index + 1}',
          area: const Area(id: 1, name: 'England', code: 'ENG', flag: 'flag'),
          runningCompetitions: [],
          lastUpdated: '2024-01-01T00:00:00Z',
        ));

        for (final team in teams) {
          await notifier.addFavorite(team);
        }

        var count = await container.read(favoriteTeamsCountProvider.future);
        expect(count, equals(3));

        await notifier.clearAllFavorites();

        count = await container.read(favoriteTeamsCountProvider.future);
        expect(count, equals(0));
        
        final favorites = await container.read(favoriteTeamsProvider.future);
        expect(favorites, isEmpty);
      });
    });

    group('Integration Tests', () {
      test('full workflow: add, check, remove, verify', () async {
        final notifier = container.read(favoritesNotifierProvider.notifier);
        
        final testTeam = Team(
          id: 1,
          name: 'Arsenal FC',
          shortName: 'Arsenal',
          tla: 'ARS',
          crest: 'https://crests.football-data.org/57.png',
          venue: 'Emirates Stadium',
          founded: 1886,
          clubColors: 'Red / White',
          area: const Area(id: 1, name: 'England', code: 'ENG', flag: '🏴󠁧󠁢󠁥󠁮󠁧󠁿'),
          runningCompetitions: [
            const Competition(id: 1, name: 'Premier League', code: 'PL', type: 'LEAGUE'),
          ],
          lastUpdated: '2024-01-01T00:00:00Z',
        );

        // Initially no favorites
        var count = await container.read(favoriteTeamsCountProvider.future);
        expect(count, equals(0));
        
        var isFavorite = await container.read(isTeamFavoriteProvider(1).future);
        expect(isFavorite, isFalse);
        
        var teams = await container.read(favoriteTeamsAsTeamsProvider.future);
        expect(teams, isEmpty);

        // Add to favorites
        await notifier.addFavorite(testTeam);

        // Verify it's added
        count = await container.read(favoriteTeamsCountProvider.future);
        expect(count, equals(1));
        
        isFavorite = await container.read(isTeamFavoriteProvider(1).future);
        expect(isFavorite, isTrue);
        
        teams = await container.read(favoriteTeamsAsTeamsProvider.future);
        expect(teams, hasLength(1));
        expect(teams.first.id, equals(1));
        expect(teams.first.name, equals('Arsenal FC'));

        // Remove from favorites
        await notifier.removeFavorite(1);

        // Verify it's removed
        count = await container.read(favoriteTeamsCountProvider.future);
        expect(count, equals(0));
        
        isFavorite = await container.read(isTeamFavoriteProvider(1).future);
        expect(isFavorite, isFalse);
        
        teams = await container.read(favoriteTeamsAsTeamsProvider.future);
        expect(teams, isEmpty);
      });

      test('persistence test: teams remain after provider refresh', () async {
        final notifier = container.read(favoritesNotifierProvider.notifier);
        
        final testTeam = Team(
          id: 1,
          name: 'Arsenal FC',
          shortName: 'Arsenal',
          tla: 'ARS',
          crest: 'crest',
          area: const Area(id: 1, name: 'England', code: 'ENG', flag: 'flag'),
          runningCompetitions: [],
          lastUpdated: '2024-01-01T00:00:00Z',
        );

        // Add team to favorites
        await notifier.addFavorite(testTeam);

        // Verify it's there
        var teams = await container.read(favoriteTeamsAsTeamsProvider.future);
        expect(teams, hasLength(1));

        // Invalidate providers to simulate refresh
        container.invalidate(favoriteTeamsProvider);
        container.invalidate(favoriteTeamsAsTeamsProvider);
        container.invalidate(favoriteTeamsCountProvider);

        // Verify team is still there after refresh
        teams = await container.read(favoriteTeamsAsTeamsProvider.future);
        expect(teams, hasLength(1));
        expect(teams.first.id, equals(1));
        
        final count = await container.read(favoriteTeamsCountProvider.future);
        expect(count, equals(1));
        
        final isFavorite = await container.read(isTeamFavoriteProvider(1).future);
        expect(isFavorite, isTrue);
      });
    });
  });
} 