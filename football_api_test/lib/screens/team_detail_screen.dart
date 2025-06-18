import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../models/team.dart';
import '../models/match.dart';
import '../providers/providers.dart';

class TeamDetailScreen extends ConsumerWidget {
  final String teamId;

  const TeamDetailScreen({super.key, required this.teamId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final teamAsync = ref.watch(teamByIdProvider(int.parse(teamId)));
    final isFavoriteAsync = ref.watch(isTeamFavoriteProvider(int.parse(teamId)));

    return Scaffold(
      body: teamAsync.when(
        data: (team) => _buildTeamDetails(context, ref, team, isFavoriteAsync),
        loading: () => const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(),
              SizedBox(height: 16),
              Text('Loading team details...'),
            ],
          ),
        ),
        error: (error, stackTrace) => Center(
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
              Text(
                error.toString(),
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
              ),
              const SizedBox(height: 16),
              FilledButton.icon(
                onPressed: () {
                  ref.invalidate(teamByIdProvider(int.parse(teamId)));
                },
                icon: const Icon(Icons.refresh),
                label: const Text('Retry'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTeamDetails(
    BuildContext context,
    WidgetRef ref,
    Team team,
    AsyncValue<bool> isFavoriteAsync,
  ) {
    final upcomingMatchesAsync = ref.watch(teamUpcomingMatchesProvider(team.id));
    final theme = Theme.of(context);

    return CustomScrollView(
      slivers: [
        // App bar with team crest and name
        SliverAppBar(
          expandedHeight: 200,
          pinned: true,
          flexibleSpace: FlexibleSpaceBar(
            title: Text(
              team.shortName,
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
                    theme.colorScheme.primary,
                    theme.colorScheme.primaryContainer,
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
                        imageUrl: team.crest,
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
            isFavoriteAsync.when(
              data: (isFavorite) => IconButton(
                onPressed: () async {
                  final favoritesNotifier = ref.read(favoritesNotifierProvider.notifier);
                  await favoritesNotifier.toggleFavorite(team);
                },
                icon: Icon(
                  isFavorite ? Icons.favorite : Icons.favorite_border,
                  color: isFavorite ? Colors.red : Colors.white,
                ),
                tooltip: isFavorite ? 'Remove from favorites' : 'Add to favorites',
              ),
              loading: () => const Padding(
                padding: EdgeInsets.all(12.0),
                child: SizedBox(
                  width: 24,
                  height: 24,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: Colors.white,
                  ),
                ),
              ),
              error: (_, __) => IconButton(
                onPressed: null,
                icon: Icon(
                  Icons.error_outline,
                  color: theme.colorScheme.error,
                ),
              ),
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
                          team.name,
                          style: theme.textTheme.headlineSmall?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        _buildInfoRow(
                          icon: Icons.location_on,
                          label: 'Venue',
                          value: team.venue ?? 'Not available',
                          theme: theme,
                        ),
                        const SizedBox(height: 8),
                        _buildInfoRow(
                          icon: Icons.calendar_today,
                          label: 'Founded',
                          value: team.founded?.toString() ?? 'Not available',
                          theme: theme,
                        ),
                        const SizedBox(height: 8),
                        _buildInfoRow(
                          icon: Icons.palette,
                          label: 'Colors',
                          value: team.clubColors ?? 'Not available',
                          theme: theme,
                        ),
                        if (team.website != null) ...[
                          const SizedBox(height: 8),
                          _buildInfoRow(
                            icon: Icons.language,
                            label: 'Website',
                            value: team.website!,
                            theme: theme,
                          ),
                        ],
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 24),

                // Upcoming matches section
                Text(
                  'Upcoming Matches',
                  style: theme.textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                upcomingMatchesAsync.when(
                  data: (matches) => _buildMatchesList(matches, theme),
                  loading: () => const Card(
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
                  ),
                  error: (error, stackTrace) => Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          Icon(
                            Icons.error_outline,
                            size: 48,
                            color: theme.colorScheme.error,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Failed to load matches',
                            style: theme.textTheme.titleMedium,
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Please try again later',
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: theme.colorScheme.onSurfaceVariant,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                // Footer attribution
                const SizedBox(height: 32),
                Container(
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.surfaceContainerHighest.withValues(alpha: 0.3),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    'Football data provided by the Football-Data.org API',
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildInfoRow({
    required IconData icon,
    required String label,
    required String value,
    required ThemeData theme,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          icon,
          size: 20,
          color: theme.colorScheme.primary,
        ),
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
              Text(
                value,
                style: theme.textTheme.bodyMedium,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildMatchesList(List<Match> matches, ThemeData theme) {
    if (matches.isEmpty) {
      return Card(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            children: [
              Icon(
                Icons.event_busy,
                size: 48,
                color: theme.colorScheme.onSurfaceVariant,
              ),
              const SizedBox(height: 16),
              Text(
                'No upcoming matches',
                style: theme.textTheme.titleMedium,
              ),
              Text(
                'Check back later for new fixtures',
                style: theme.textTheme.bodySmall?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
        ),
      );
    }

    return Column(
      children: matches.map((match) => _buildMatchCard(match, theme)).toList(),
    );
  }

  Widget _buildMatchCard(Match match, ThemeData theme) {
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
                  match.competition.name,
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
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
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