import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:football_api_test/screens/team_detail_screen.dart';
import 'package:football_api_test/models/team.dart';
import 'package:football_api_test/models/area.dart';
import 'package:football_api_test/models/competition.dart';
import 'package:football_api_test/models/match.dart';
import 'package:football_api_test/models/team_summary.dart';
import 'package:football_api_test/models/season.dart';
import 'package:football_api_test/models/score.dart';
import 'package:football_api_test/providers/providers.dart';

void main() {
  group('TeamDetailScreen Tests', () {
    late GoRouter router;

    setUp(() {
      router = GoRouter(
        routes: [
          GoRoute(
            path: '/team/:teamId',
            builder: (context, state) => TeamDetailScreen(
              teamId: state.pathParameters['teamId']!,
            ),
          ),
        ],
      );
    });

    Widget createTestWidget(String teamId, {List<Override> overrides = const []}) {
      return ProviderScope(
        overrides: overrides,
        child: MaterialApp.router(
          routerConfig: GoRouter(
            initialLocation: '/team/$teamId',
            routes: [
              GoRoute(
                path: '/team/:teamId',
                builder: (context, state) => TeamDetailScreen(
                  teamId: state.pathParameters['teamId']!,
                ),
              ),
            ],
          ),
        ),
      );
    }

    testWidgets('displays loading state initially', (WidgetTester tester) async {
      await tester.pumpWidget(createTestWidget('57'));

      expect(find.text('Loading team details...'), findsOneWidget);
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('displays team details when data is loaded successfully', (WidgetTester tester) async {
      const teamId = 57;
      final mockTeam = Team(
        id: teamId,
        name: 'Arsenal FC',
        shortName: 'Arsenal',
        tla: 'ARS',
        crest: 'https://crests.football-data.org/57.png',
        venue: 'Emirates Stadium',
        founded: 1886,
        clubColors: 'Red / White',
        website: 'http://www.arsenal.com',
        area: const Area(id: 1, name: 'England', code: 'ENG', flag: 'flag'),
        runningCompetitions: [
          const Competition(id: 1, name: 'Premier League', code: 'PL', type: 'LEAGUE'),
        ],
        lastUpdated: '2024-01-01T00:00:00Z',
      );

      final mockMatches = [
        Match(
          id: 1,
          utcDate: '2024-02-01T15:00:00Z',
          status: 'SCHEDULED',
          homeTeam: const TeamSummary(id: 57, name: 'Arsenal FC', shortName: 'Arsenal', tla: 'ARS', crest: 'crest1'),
          awayTeam: const TeamSummary(id: 61, name: 'Chelsea FC', shortName: 'Chelsea', tla: 'CHE', crest: 'crest2'),
          competition: const Competition(id: 1, name: 'Premier League', code: 'PL', type: 'LEAGUE'),
        ),
      ];

      await tester.pumpWidget(createTestWidget('57', overrides: [
        teamByIdProvider(teamId).overrideWith((ref) async => mockTeam),
        isTeamFavoriteProvider(teamId).overrideWith((ref) async => false),
        teamUpcomingMatchesProvider(teamId).overrideWith((ref) async => mockMatches),
      ]));

      await tester.pumpAndSettle();

      // Verify team basic info is displayed
      expect(find.text('Arsenal'), findsWidgets);
      expect(find.text('Arsenal FC'), findsOneWidget);
      expect(find.text('Emirates Stadium'), findsOneWidget);
      expect(find.text('1886'), findsOneWidget);
      expect(find.text('Red / White'), findsOneWidget);

      // Verify info sections
      expect(find.text('Venue'), findsOneWidget);
      expect(find.text('Founded'), findsOneWidget);
      expect(find.text('Colors'), findsOneWidget);
      expect(find.text('Website'), findsOneWidget);

      // Verify upcoming matches section
      expect(find.text('Upcoming Matches'), findsOneWidget);
      expect(find.text('Premier League'), findsWidgets);
      expect(find.text('VS'), findsOneWidget);
    });

    testWidgets('displays error state when team fails to load', (WidgetTester tester) async {
      const errorMessage = 'Team not found';

      await tester.pumpWidget(createTestWidget('57', overrides: [
        teamByIdProvider(57).overrideWith((ref) => throw Exception(errorMessage)),
      ]));

      await tester.pumpAndSettle();

      expect(find.text('Failed to load team details'), findsOneWidget);
      expect(find.text('Exception: $errorMessage'), findsOneWidget);
      expect(find.text('Retry'), findsOneWidget);
      expect(find.byIcon(Icons.error_outline), findsOneWidget);
    });

    testWidgets('displays no upcoming matches when none available', (WidgetTester tester) async {
      const teamId = 57;
      final mockTeam = Team(
        id: teamId,
        name: 'Arsenal FC',
        shortName: 'Arsenal',
        tla: 'ARS',
        crest: 'crest',
        area: const Area(id: 1, name: 'England', code: 'ENG', flag: 'flag'),
        runningCompetitions: [
          const Competition(id: 1, name: 'Premier League', code: 'PL', type: 'LEAGUE'),
        ],
        lastUpdated: '2024-01-01T00:00:00Z',
      );

      await tester.pumpWidget(createTestWidget('57', overrides: [
        teamByIdProvider(teamId).overrideWith((ref) async => mockTeam),
        isTeamFavoriteProvider(teamId).overrideWith((ref) async => false),
        teamUpcomingMatchesProvider(teamId).overrideWith((ref) async => <Match>[]),
      ]));

      await tester.pumpAndSettle();

      expect(find.text('No upcoming matches'), findsOneWidget);
      expect(find.text('Check back later for new fixtures'), findsOneWidget);
      expect(find.byIcon(Icons.event_busy), findsOneWidget);
    });

    testWidgets('displays matches loading state', (WidgetTester tester) async {
      const teamId = 57;
      final mockTeam = Team(
        id: teamId,
        name: 'Arsenal FC',
        shortName: 'Arsenal',
        tla: 'ARS',
        crest: 'crest',
        area: const Area(id: 1, name: 'England', code: 'ENG', flag: 'flag'),
        runningCompetitions: [
          const Competition(id: 1, name: 'Premier League', code: 'PL', type: 'LEAGUE'),
        ],
        lastUpdated: '2024-01-01T00:00:00Z',
      );

      await tester.pumpWidget(createTestWidget('57', overrides: [
        teamByIdProvider(teamId).overrideWith((ref) async => mockTeam),
        isTeamFavoriteProvider(teamId).overrideWith((ref) async => false),
        // Don't override matches provider to simulate loading
      ]));

      await tester.pumpAndSettle();

      expect(find.text('Loading upcoming matches...'), findsOneWidget);
      expect(find.byType(CircularProgressIndicator), findsAtLeastOneWidget);
    });

    testWidgets('displays matches error state', (WidgetTester tester) async {
      const teamId = 57;
      final mockTeam = Team(
        id: teamId,
        name: 'Arsenal FC',
        shortName: 'Arsenal',
        tla: 'ARS',
        crest: 'crest',
        area: const Area(id: 1, name: 'England', code: 'ENG', flag: 'flag'),
        runningCompetitions: [
          const Competition(id: 1, name: 'Premier League', code: 'PL', type: 'LEAGUE'),
        ],
        lastUpdated: '2024-01-01T00:00:00Z',
      );

      await tester.pumpWidget(createTestWidget('57', overrides: [
        teamByIdProvider(teamId).overrideWith((ref) async => mockTeam),
        isTeamFavoriteProvider(teamId).overrideWith((ref) async => false),
        teamUpcomingMatchesProvider(teamId).overrideWith((ref) => throw Exception('Match error')),
      ]));

      await tester.pumpAndSettle();

      expect(find.text('Failed to load matches'), findsOneWidget);
      expect(find.text('Please try again later'), findsOneWidget);
      expect(find.byIcon(Icons.error_outline), findsAtLeastOneWidget);
    });

    testWidgets('favorite button works correctly', (WidgetTester tester) async {
      const teamId = 57;
      final mockTeam = Team(
        id: teamId,
        name: 'Arsenal FC',
        shortName: 'Arsenal',
        tla: 'ARS',
        crest: 'crest',
        area: const Area(id: 1, name: 'England', code: 'ENG', flag: 'flag'),
        runningCompetitions: [
          const Competition(id: 1, name: 'Premier League', code: 'PL', type: 'LEAGUE'),
        ],
        lastUpdated: '2024-01-01T00:00:00Z',
      );

      bool isFavorite = false;

      await tester.pumpWidget(createTestWidget('57', overrides: [
        teamByIdProvider(teamId).overrideWith((ref) async => mockTeam),
        isTeamFavoriteProvider(teamId).overrideWith((ref) async => isFavorite),
        teamUpcomingMatchesProvider(teamId).overrideWith((ref) async => <Match>[]),
      ]));

      await tester.pumpAndSettle();

      // Should show unfavorite icon initially
      expect(find.byIcon(Icons.favorite_border), findsOneWidget);

      // Tap favorite button
      await tester.tap(find.byIcon(Icons.favorite_border));
      await tester.pumpAndSettle();

      // Note: This test verifies the button exists and is tappable
      // The actual favorite state change would be tested in provider tests
    });

    testWidgets('handles optional team data gracefully', (WidgetTester tester) async {
      const teamId = 57;
      final mockTeam = Team(
        id: teamId,
        name: 'Arsenal FC',
        shortName: 'Arsenal',
        tla: 'ARS',
        crest: 'crest',
        // No optional fields set
        area: const Area(id: 1, name: 'England', code: 'ENG', flag: 'flag'),
        runningCompetitions: [
          const Competition(id: 1, name: 'Premier League', code: 'PL', type: 'LEAGUE'),
        ],
        lastUpdated: '2024-01-01T00:00:00Z',
      );

      await tester.pumpWidget(createTestWidget('57', overrides: [
        teamByIdProvider(teamId).overrideWith((ref) async => mockTeam),
        isTeamFavoriteProvider(teamId).overrideWith((ref) async => false),
        teamUpcomingMatchesProvider(teamId).overrideWith((ref) async => <Match>[]),
      ]));

      await tester.pumpAndSettle();

      // Should show 'Not available' for missing fields
      expect(find.text('Not available'), findsAtLeastOneWidget);
      
      // Should not show website section if not provided
      expect(find.text('Website'), findsNothing);
    });

    testWidgets('retry button works on team load error', (WidgetTester tester) async {
      bool shouldThrowError = true;

      await tester.pumpWidget(createTestWidget('57', overrides: [
        teamByIdProvider(57).overrideWith((ref) {
          if (shouldThrowError) {
            throw Exception('Network error');
          }
          return Future.value(Team(
            id: 57,
            name: 'Arsenal FC',
            shortName: 'Arsenal',
            tla: 'ARS',
            crest: 'crest',
            area: const Area(id: 1, name: 'England', code: 'ENG', flag: 'flag'),
            runningCompetitions: [
              const Competition(id: 1, name: 'Premier League', code: 'PL', type: 'LEAGUE'),
            ],
            lastUpdated: '2024-01-01T00:00:00Z',
          ));
        }),
      ]));

      await tester.pumpAndSettle();

      // Should show error state
      expect(find.text('Failed to load team details'), findsOneWidget);
      expect(find.text('Retry'), findsOneWidget);

      // Change error condition
      shouldThrowError = false;

      // Tap retry button
      await tester.tap(find.text('Retry'));
      await tester.pumpAndSettle();

      // Should attempt to reload data
      expect(find.text('Arsenal FC'), findsOneWidget);
    });
  });
} 