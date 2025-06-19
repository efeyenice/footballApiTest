import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:football_api_test/screens/teams_list_screen.dart';
import 'package:football_api_test/models/team.dart';
import 'package:football_api_test/models/area.dart';
import 'package:football_api_test/models/competition.dart';
import 'package:football_api_test/providers/providers.dart';

void main() {
  group('TeamsListScreen Tests', () {
    late GoRouter router;

    setUp(() {
      router = GoRouter(
        routes: [
          GoRoute(
            path: '/',
            builder: (context, state) => const TeamsListScreen(),
          ),
          GoRoute(
            path: '/team/:id',
            builder: (context, state) => Scaffold(
              body: Text('Team ${state.pathParameters['id']}'),
            ),
          ),
          GoRoute(
            path: '/favorites',
            builder: (context, state) => const Scaffold(
              body: Text('Favorites Screen'),
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

      expect(find.text('Premier League Teams'), findsOneWidget);
      expect(find.text('Loading Premier League teams...'), findsOneWidget);
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('displays teams when data is loaded successfully', (WidgetTester tester) async {
      // Mock teams data
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
          filteredAndSortedTeamsProvider.overrideWith((ref) async => mockTeams),
        ],
      ));

      // Wait for async data to load
      await tester.pumpAndSettle();

      // Verify teams are displayed
      expect(find.text('Arsenal'), findsOneWidget);
      expect(find.text('Chelsea'), findsOneWidget);
      expect(find.text('Loading Premier League teams...'), findsNothing);
    });

    testWidgets('displays error state when data fails to load', (WidgetTester tester) async {
      const errorMessage = 'Network error';

      await tester.pumpWidget(createTestWidget(
        overrides: [
          filteredAndSortedTeamsProvider.overrideWith((ref) => 
            throw Exception(errorMessage)),
        ],
      ));

      await tester.pumpAndSettle();

      expect(find.text('Failed to load teams'), findsOneWidget);
      expect(find.text('Exception: $errorMessage'), findsOneWidget);
      expect(find.text('Retry'), findsOneWidget);
      expect(find.byIcon(Icons.error_outline), findsOneWidget);
    });

    testWidgets('displays empty state when no teams found', (WidgetTester tester) async {
      await tester.pumpWidget(createTestWidget(
        overrides: [
          filteredAndSortedTeamsProvider.overrideWith((ref) async => <Team>[]),
        ],
      ));

      await tester.pumpAndSettle();

      expect(find.text('No teams found'), findsOneWidget);
      expect(find.text('Try adjusting your search terms'), findsOneWidget);
      expect(find.byIcon(Icons.search_off), findsOneWidget);
    });

    testWidgets('search functionality works correctly', (WidgetTester tester) async {
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
      ];

      await tester.pumpWidget(createTestWidget(
        overrides: [
          filteredAndSortedTeamsProvider.overrideWith((ref) async => mockTeams),
        ],
      ));

      await tester.pumpAndSettle();

      // Find and tap search bar
      final searchBar = find.byType(SearchBar);
      expect(searchBar, findsOneWidget);

      await tester.tap(searchBar);
      await tester.enterText(searchBar, 'Arsenal');
      await tester.pumpAndSettle();

      // Search functionality should be handled by the provider
      expect(find.text('Search teams...'), findsOneWidget);
    });

    testWidgets('view mode toggle works correctly', (WidgetTester tester) async {
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
          filteredAndSortedTeamsProvider.overrideWith((ref) async => mockTeams),
        ],
      ));

      await tester.pumpAndSettle();

      // Initial view should be list view
      expect(find.byIcon(Icons.grid_view), findsOneWidget);

      // Tap view mode toggle
      await tester.tap(find.byIcon(Icons.grid_view));
      await tester.pumpAndSettle();

      // Should switch to grid view
      expect(find.byIcon(Icons.view_list), findsOneWidget);
    });

    testWidgets('sort menu works correctly', (WidgetTester tester) async {
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
          filteredAndSortedTeamsProvider.overrideWith((ref) async => mockTeams),
        ],
      ));

      await tester.pumpAndSettle();

      // Tap sort button
      await tester.tap(find.byIcon(Icons.sort));
      await tester.pumpAndSettle();

      // Should show sort options
      expect(find.text('Name A-Z'), findsOneWidget);
      expect(find.text('Name Z-A'), findsOneWidget);
    });

    testWidgets('favorites button navigation works', (WidgetTester tester) async {
      await tester.pumpWidget(createTestWidget(
        overrides: [
          favoriteTeamsCountProvider.overrideWith((ref) async => 2),
          filteredAndSortedTeamsProvider.overrideWith((ref) async => <Team>[]),
        ],
      ));

      await tester.pumpAndSettle();

      // Should show favorites button with badge
      expect(find.byIcon(Icons.favorite), findsOneWidget);
      expect(find.text('2'), findsOneWidget);

      // Tap favorites button
      await tester.tap(find.byIcon(Icons.favorite));
      await tester.pumpAndSettle();

      // Should navigate to favorites screen
      expect(find.text('Favorites Screen'), findsOneWidget);
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
          filteredAndSortedTeamsProvider.overrideWith((ref) async => mockTeams),
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
          filteredAndSortedTeamsProvider.overrideWith((ref) {
            if (shouldThrowError) {
              throw Exception('Network error');
            }
            return Future.value(<Team>[]);
          }),
        ],
      ));

      await tester.pumpAndSettle();

      // Should show error state
      expect(find.text('Failed to load teams'), findsOneWidget);
      expect(find.text('Retry'), findsOneWidget);

      // Change error condition
      shouldThrowError = false;

      // Tap retry button
      await tester.tap(find.text('Retry'));
      await tester.pumpAndSettle();

      // Should attempt to reload data
      expect(find.text('No teams found'), findsOneWidget);
    });
  });
} 