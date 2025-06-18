import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

void main() {
  runApp(const ProviderScope(child: FootballApp()));
}

class FootballApp extends ConsumerWidget {
  const FootballApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp.router(
      title: 'Football Teams',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.green,
          brightness: Brightness.light,
        ),
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.green,
          brightness: Brightness.dark,
        ),
      ),
      routerConfig: _router,
    );
  }
}

// Basic router configuration - we'll expand this in Phase 4
final _router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const TeamsListScreen(),
    ),
    GoRoute(
      path: '/team/:teamId',
      builder: (context, state) {
        final teamId = state.pathParameters['teamId']!;
        return TeamDetailScreen(teamId: teamId);
      },
    ),
    GoRoute(
      path: '/favorites',
      builder: (context, state) => const FavoritesScreen(),
    ),
  ],
);

// Placeholder screens - we'll implement these in Phase 4
class TeamsListScreen extends StatelessWidget {
  const TeamsListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Premier League Teams'),
        actions: [
          IconButton(
            icon: const Icon(Icons.favorite),
            onPressed: () => context.push('/favorites'),
          ),
        ],
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(),
            SizedBox(height: 16),
            Text('Loading teams...'),
            SizedBox(height: 32),
            Text(
              'Football data provided by the Football-Data.org API',
              style: TextStyle(fontSize: 12, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}

class TeamDetailScreen extends StatelessWidget {
  final String teamId;
  
  const TeamDetailScreen({super.key, required this.teamId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Team Details'),
      ),
      body: Center(
        child: Text('Team ID: $teamId'),
      ),
    );
  }
}

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorite Teams'),
      ),
      body: const Center(
        child: Text('No favorite teams yet'),
      ),
    );
  }
}
