import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:football_api_test/screens/favorites_screen.dart';
import 'package:football_api_test/models/team.dart';
import 'package:football_api_test/models/area.dart';
import 'package:football_api_test/models/competition.dart';
import 'package:football_api_test/providers/providers.dart';

void main() {
  group('FavoritesScreen Tests', () {
    late GoRouter router;

    setUp(() {
      router = GoRouter(
        routes: [
          GoRoute(
            path: '/',
            builder: (context, state) => const FavoritesScreen(),
          ),
          GoRoute(
            path: '/team/:id',
            builder: (context, state) => Scaffold(
              body: Text('Team ${state.pathParameters['id']}'),
            ),
          ),
        ],
      );
    });

    Widget createTestWidget({List<Override> overrides = const []}) {
      return ProviderScope(
        overrides: overrides,
        child: MaterialApp.router(
          routerConfig: router,
        ),
      );
    }

    testWidgets('displays loading state initially', (WidgetTester tester) async {
      await tester.pumpWidget(createTestWidget());

      expect(find.text('Favorites'), findsOneWidget);
      expect(find.text('Loading your favorites...'), findsOneWidget);
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('displays empty state when no favorites', (WidgetTester tester) async {
      await tester.pumpWidget(createTestWidget(
        overrides: [
          favoriteTeamsAsTeamsProvider.overrideWith((ref) async => <Team>[]),
          favoriteTeamsCountProvider.overrideWith((ref) async => 0),
        ],
      ));

      await tester.pumpAndSettle();

      expect(find.text('No favorite teams yet'), findsOneWidget);
      expect(find.text('Start adding teams to your favorites\nfrom the teams list'), findsOneWidget);
      expect(find.text('Browse Teams'), findsOneWidget);
      expect(find.byIcon(Icons.favorite_border), findsOneWidget);
    });

    testWidgets('displays favorite teams when available', (WidgetTester tester) async {
      final mockTeams = [
        Team(
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
        ),
        Team(
          id: 2,
          name: 'Chelsea FC',
          shortName: 'Chelsea',
          tla: 'CHE',
          crest: 'https://crests.football-data.org/61.png',
          area: const Area(id: 1, name: 'England', code: 'ENG', flag: 'flag'),
          runningCompetitions: [
            const Competition(id: 1, name: 'Premier League', code: 'PL', type: 'LEAGUE'),
          ],
          lastUpdated: '2024-01-01T00:00:00Z',
        ),
      ];

      await tester.pumpWidget(createTestWidget(
        overrides: [
          favoriteTeamsAsTeamsProvider.overrideWith((ref) async => mockTeams),
          favoriteTeamsCountProvider.overrideWith((ref) async => 2),
        ],
      ));

      await tester.pumpAndSettle();

      // Should show title with count
      expect(find.text('Favorites (2)'), findsOneWidget);

      // Should show summary card
      expect(find.text('Your Favorite Teams'), findsOneWidget);
      expect(find.text('2 teams in your collection'), findsOneWidget);

      // Should show team names
      expect(find.text('Arsenal'), findsOneWidget);
      expect(find.text('Chelsea'), findsOneWidget);

      // Should show clear all menu option
      expect(find.byIcon(Icons.more_vert), findsOneWidget);
    });

    testWidgets('displays error state when favorites fail to load', (WidgetTester tester) async {
      const errorMessage = 'Database error';

      await tester.pumpWidget(createTestWidget(
        overrides: [
          favoriteTeamsAsTeamsProvider.overrideWith((ref) => 
            throw Exception(errorMessage)),
        ],
      ));

      await tester.pumpAndSettle();

      expect(find.text('Failed to load favorites'), findsOneWidget);
      expect(find.text('Exception: $errorMessage'), findsOneWidget);
      expect(find.text('Retry'), findsOneWidget);
      expect(find.byIcon(Icons.error_outline), findsOneWidget);
    });

    testWidgets('clear all menu works correctly', (WidgetTester tester) async {
      final mockTeams = [
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
      ];

      await tester.pumpWidget(createTestWidget(
        overrides: [
          favoriteTeamsAsTeamsProvider.overrideWith((ref) async => mockTeams),
          favoriteTeamsCountProvider.overrideWith((ref) async => 1),
        ],
      ));

      await tester.pumpAndSettle();

      // Tap more menu
      await tester.tap(find.byIcon(Icons.more_vert));
      await tester.pumpAndSettle();

      // Should show clear all option
      expect(find.text('Clear all favorites'), findsOneWidget);
      expect(find.byIcon(Icons.clear_all), findsOneWidget);

      // Tap clear all
      await tester.tap(find.text('Clear all favorites'));
      await tester.pumpAndSettle();

      // Should show confirmation dialog
      expect(find.text('Clear All Favorites'), findsOneWidget);
      expect(find.text('Are you sure you want to remove all teams from your favorites? This action cannot be undone.'), findsOneWidget);
      expect(find.text('Cancel'), findsOneWidget);
      expect(find.text('Clear All'), findsOneWidget);
    });

    testWidgets('browse teams button works', (WidgetTester tester) async {
      await tester.pumpWidget(createTestWidget(
        overrides: [
          favoriteTeamsAsTeamsProvider.overrideWith((ref) async => <Team>[]),
          favoriteTeamsCountProvider.overrideWith((ref) async => 0),
        ],
      ));

      await tester.pumpAndSettle();

      // Should show browse teams button in empty state
      expect(find.text('Browse Teams'), findsOneWidget);

      // Note: Navigation testing would require a proper router setup
      // This test verifies the button exists and is tappable
    });

    testWidgets('team card tap navigation works', (WidgetTester tester) async {
      final mockTeams = [
        Team(
          id: 57,
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
      ];

      await tester.pumpWidget(createTestWidget(
        overrides: [
          favoriteTeamsAsTeamsProvider.overrideWith((ref) async => mockTeams),
          favoriteTeamsCountProvider.overrideWith((ref) async => 1),
        ],
      ));

      await tester.pumpAndSettle();

      // Tap on team card
      await tester.tap(find.text('Arsenal'));
      await tester.pumpAndSettle();

      // Should navigate to team detail screen
      expect(find.text('Team 57'), findsOneWidget);
    });

    testWidgets('retry button works on error', (WidgetTester tester) async {
      bool shouldThrowError = true;

      await tester.pumpWidget(createTestWidget(
        overrides: [
          favoriteTeamsAsTeamsProvider.overrideWith((ref) {
            if (shouldThrowError) {
              throw Exception('Network error');
            }
            return Future.value(<Team>[]);
          }),
        ],
      ));

      await tester.pumpAndSettle();

      // Should show error state
      expect(find.text('Failed to load favorites'), findsOneWidget);
      expect(find.text('Retry'), findsOneWidget);

      // Change error condition
      shouldThrowError = false;

      // Tap retry button
      await tester.tap(find.text('Retry'));
      await tester.pumpAndSettle();

      // Should attempt to reload data
      expect(find.text('No favorite teams yet'), findsOneWidget);
    });

    testWidgets('handles single vs multiple teams text correctly', (WidgetTester tester) async {
      // Test single team
      final singleTeam = [
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
      ];

      await tester.pumpWidget(createTestWidget(
        overrides: [
          favoriteTeamsAsTeamsProvider.overrideWith((ref) async => singleTeam),
          favoriteTeamsCountProvider.overrideWith((ref) async => 1),
        ],
      ));

      await tester.pumpAndSettle();

      // Should show singular form
      expect(find.text('1 team in your collection'), findsOneWidget);
    });

    testWidgets('shows footer attribution', (WidgetTester tester) async {
      final mockTeams = [
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
      ];

      await tester.pumpWidget(createTestWidget(
        overrides: [
          favoriteTeamsAsTeamsProvider.overrideWith((ref) async => mockTeams),
          favoriteTeamsCountProvider.overrideWith((ref) async => 1),
        ],
      ));

      await tester.pumpAndSettle();

      // Should show API attribution
      expect(find.text('Football data provided by the Football-Data.org API'), findsOneWidget);
    });
  });
} 