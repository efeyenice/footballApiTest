import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:go_router/go_router.dart';
import '../models/team.dart';
import '../models/match.dart';
import '../services/app_state.dart';

class TeamDetailScreen extends StatefulWidget {
  final String teamId;

  const TeamDetailScreen({super.key, required this.teamId});

  @override
  State<TeamDetailScreen> createState() => _TeamDetailScreenState();
}

class _TeamDetailScreenState extends State<TeamDetailScreen> {
  Team? team;
  List<Match> upcomingMatches = [];
  bool isLoadingTeam = true;
  bool isLoadingMatches = true;
  String? teamError;
  String? matchesError;

  @override
  void initState() {
    super.initState();
    _loadTeamData();
  }

  Future<void> _loadTeamData() async {
    final appState = context.read<AppState>();
    final teamId = int.parse(widget.teamId);

    // Load team details
    try {
      final loadedTeam = await appState.getTeamById(teamId);
      if (mounted) {
        setState(() {
          team = loadedTeam;
          isLoadingTeam = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          teamError = e.toString();
          isLoadingTeam = false;
        });
      }
    }

    // Load upcoming matches
    try {
      final matches = await appState.getUpcomingMatches(teamId);
      if (mounted) {
        setState(() {
          upcomingMatches = matches;
          isLoadingMatches = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          matchesError = e.toString();
          isLoadingMatches = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoadingTeam) {
      return Scaffold(
        appBar: AppBar(),
        body: const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(),
              SizedBox(height: 16),
              Text('Loading team details...'),
            ],
          ),
        ),
      );
    }

    if (teamError != null) {
      return Scaffold(
        appBar: AppBar(),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.error_outline,
                size: 64,
                color: Theme.of(context).colorScheme.error,
              ),
              const SizedBox(height: 16),
              Text(
                'Failed to load team details',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: 8),
              SelectableText.rich(
                TextSpan(
                  text: teamError!,
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.error,
                  ),
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  OutlinedButton(
                    onPressed: () => context.pop(),
                    child: const Text('Go Back'),
                  ),
                  const SizedBox(width: 16),
                  FilledButton.icon(
                    onPressed: () {
                      setState(() {
                        isLoadingTeam = true;
                        teamError = null;
                      });
                      _loadTeamData();
                    },
                    icon: const Icon(Icons.refresh),
                    label: const Text('Retry'),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    }

    return Consumer<AppState>(
      builder: (context, appState, child) {
        final isFavorite = appState.isTeamFavorite(team!.id);
        
        return Scaffold(
          body: CustomScrollView(
            slivers: [
              // App bar with team crest and name
              SliverAppBar(
                expandedHeight: 200,
                pinned: true,
                flexibleSpace: FlexibleSpaceBar(
                  title: Text(
                    team!.shortName,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      shadows: [
                        Shadow(
                          offset: Offset(0, 1),
                          blurRadius: 3,
                          color: Colors.black45,
                        ),
                      ],
                    ),
                  ),
                  background: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Theme.of(context).colorScheme.primary,
                          Theme.of(context).colorScheme.primaryContainer,
                        ],
                      ),
                    ),
                    child: Center(
                      child: Container(
                        width: 120,
                        height: 120,
                        margin: const EdgeInsets.only(bottom: 60),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.2),
                              blurRadius: 10,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: Container(
                            color: Colors.white,
                            padding: const EdgeInsets.all(16),
                            child: CachedNetworkImage(
                              imageUrl: team!.crest,
                              fit: BoxFit.contain,
                              errorWidget: (context, url, error) => Icon(
                                Icons.sports_soccer,
                                size: 60,
                                color: Colors.grey.shade400,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                actions: [
                  // Favorite button
                  IconButton(
                    onPressed: () => appState.toggleFavorite(team!),
                    icon: Icon(
                      isFavorite ? Icons.favorite : Icons.favorite_border,
                      color: isFavorite ? Colors.red : Colors.white,
                    ),
                    tooltip: isFavorite
                        ? 'Remove from favorites'
                        : 'Add to favorites',
                  ),
                ],
              ),

              // Team information
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Team name card
                      Card(
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                team!.name,
                                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 8),
                              _buildInfoRow(
                                icon: Icons.location_on,
                                label: 'Venue',
                                value: team!.venue ?? 'Not available',
                              ),
                              const SizedBox(height: 8),
                              _buildInfoRow(
                                icon: Icons.calendar_today,
                                label: 'Founded',
                                value: team!.founded?.toString() ?? 'Not available',
                              ),
                              const SizedBox(height: 8),
                              _buildInfoRow(
                                icon: Icons.palette,
                                label: 'Colors',
                                value: team!.clubColors ?? 'Not available',
                              ),
                            ],
                          ),
                        ),
                      ),

                      const SizedBox(height: 24),

                      // Upcoming matches section
                      Text(
                        'Upcoming Matches',
                        style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),
                      _buildMatchesSection(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildInfoRow({
    required IconData icon,
    required String label,
    required String value,
  }) {
    final theme = Theme.of(context);
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 20, color: theme.colorScheme.primary),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: theme.textTheme.labelSmall?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(value, style: theme.textTheme.bodyMedium),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildMatchesSection() {
    if (isLoadingMatches) {
      return const Card(
        child: Padding(
          padding: EdgeInsets.all(32.0),
          child: Center(
            child: Column(
              children: [
                CircularProgressIndicator(),
                SizedBox(height: 16),
                Text('Loading upcoming matches...'),
              ],
            ),
          ),
        ),
      );
    }

    if (matchesError != null) {
      return Card(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Icon(
                Icons.error_outline,
                size: 48,
                color: Theme.of(context).colorScheme.error,
              ),
              const SizedBox(height: 8),
              Text(
                'Failed to load matches',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 4),
              SelectableText.rich(
                TextSpan(
                  text: matchesError!,
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.error,
                  ),
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      );
    }

    if (upcomingMatches.isEmpty) {
      return Card(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            children: [
              Icon(
                Icons.event_busy,
                size: 48,
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
              const SizedBox(height: 16),
              Text('No upcoming matches', style: Theme.of(context).textTheme.titleMedium),
              Text(
                'Check back later for new fixtures',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
        ),
      );
    }

    return Column(
      children: upcomingMatches.map(_buildMatchCard).toList(),
    );
  }

  Widget _buildMatchCard(Match match) {
    final theme = Theme.of(context);
    final matchDate = DateTime.parse(match.utcDate);
    final formattedDate = "${matchDate.day}/${matchDate.month}/${matchDate.year}";
    final formattedTime = "${matchDate.hour.toString().padLeft(2, '0')}:${matchDate.minute.toString().padLeft(2, '0')}";

    return Card(
      margin: const EdgeInsets.only(bottom: 8.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Competition and date
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  match.competitionName,
                  style: theme.textTheme.labelMedium?.copyWith(
                    color: theme.colorScheme.primary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  '$formattedDate • $formattedTime',
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),

            // Teams
            Row(
              children: [
                // Home team
                Expanded(
                  child: Column(
                    children: [
                      CachedNetworkImage(
                        imageUrl: match.homeTeam.crest,
                        width: 32,
                        height: 32,
                        errorWidget: (context, url, error) => Icon(
                          Icons.sports_soccer,
                          size: 32,
                          color: Colors.grey.shade400,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        match.homeTeam.shortName,
                        style: theme.textTheme.bodySmall,
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),

                // VS
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text(
                    'VS',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                ),

                // Away team
                Expanded(
                  child: Column(
                    children: [
                      CachedNetworkImage(
                        imageUrl: match.awayTeam.crest,
                        width: 32,
                        height: 32,
                        errorWidget: (context, url, error) => Icon(
                          Icons.sports_soccer,
                          size: 32,
                          color: Colors.grey.shade400,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        match.awayTeam.shortName,
                        style: theme.textTheme.bodySmall,
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
