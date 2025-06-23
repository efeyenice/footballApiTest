import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'screens/teams_list_screen.dart';
import 'screens/team_detail_screen.dart';
import 'screens/favorites_screen.dart';

void main() {
  runApp(const ProviderScope(child: FootballApp()));
}

class FootballApp extends StatelessWidget {
  const FootballApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Premier League Teams',
      debugShowCheckedModeBanner: false,
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

final GoRouter _router = GoRouter(
  routes: [
    GoRoute(path: '/', builder: (context, state) => const TeamsListScreen()),
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
