import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../models/team.dart';
import '../providers/providers.dart';

class TeamCard extends ConsumerWidget {
  final Team team;
  final bool isGridView;
  final VoidCallback? onTap;

  const TeamCard({
    super.key,
    required this.team,
    this.isGridView = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final isFavoriteAsync = ref.watch(isTeamFavoriteProvider(team.id));
    final matchesPlayedAsync = ref.watch(teamMatchesPlayedProvider(team.id));

    return Card(
      elevation: 2,
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: isGridView ? _buildGridLayout(
            context, 
            theme, 
            isFavoriteAsync, 
            matchesPlayedAsync, 
            ref,
          ) : _buildListLayout(
            context, 
            theme, 
            isFavoriteAsync, 
            matchesPlayedAsync, 
            ref,
          ),
        ),
      ),
    );
  }

  Widget _buildListLayout(
    BuildContext context,
    ThemeData theme,
    AsyncValue<bool> isFavoriteAsync,
    AsyncValue<int> matchesPlayedAsync,
    WidgetRef ref,
  ) {
    return Row(
      children: [
        // Team crest
        _buildTeamCrest(60),
        const SizedBox(width: 16),
        
        // Team info
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                team.name,
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 4),
              Text(
                team.shortName,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
              const SizedBox(height: 8),
              _buildMatchesPlayed(matchesPlayedAsync, theme),
            ],
          ),
        ),
        
        // Favorite button
        _buildFavoriteButton(context, isFavoriteAsync, ref),
      ],
    );
  }

  Widget _buildGridLayout(
    BuildContext context,
    ThemeData theme,
    AsyncValue<bool> isFavoriteAsync,
    AsyncValue<int> matchesPlayedAsync,
    WidgetRef ref,
  ) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Team crest
        _buildTeamCrest(80),
        const SizedBox(height: 12),
        
        // Team name
        Text(
          team.shortName,
          style: theme.textTheme.titleSmall?.copyWith(
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        const SizedBox(height: 8),
        
        // Matches played
        _buildMatchesPlayed(matchesPlayedAsync, theme),
        const SizedBox(height: 8),
        
        // Favorite button
        _buildFavoriteButton(context, isFavoriteAsync, ref),
      ],
    );
  }

  Widget _buildTeamCrest(double size) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: Colors.grey.shade300,
          width: 1,
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(7),
        child: CachedNetworkImage(
          imageUrl: team.crest,
          fit: BoxFit.contain,
          placeholder: (context, url) => Container(
            color: Colors.grey.shade100,
            child: const Center(
              child: CircularProgressIndicator(strokeWidth: 2),
            ),
          ),
          errorWidget: (context, url, error) => Container(
            color: Colors.grey.shade100,
            child: Icon(
              Icons.sports_soccer,
              size: size * 0.5,
              color: Colors.grey.shade400,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMatchesPlayed(AsyncValue<int> matchesPlayedAsync, ThemeData theme) {
    return matchesPlayedAsync.when(
      data: (matchesPlayed) => Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.sports_soccer,
            size: 16,
            color: theme.colorScheme.primary,
          ),
          const SizedBox(width: 4),
          Text(
            '$matchesPlayed matches',
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
      loading: () => Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: 12,
            height: 12,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              color: theme.colorScheme.primary,
            ),
          ),
          const SizedBox(width: 4),
          Text(
            'Loading...',
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
      error: (_, __) => Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.error_outline,
            size: 16,
            color: theme.colorScheme.error,
          ),
          const SizedBox(width: 4),
          Text(
            'Error',
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.colorScheme.error,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFavoriteButton(
    BuildContext context,
    AsyncValue<bool> isFavoriteAsync,
    WidgetRef ref,
  ) {
    return isFavoriteAsync.when(
      data: (isFavorite) => IconButton(
        onPressed: () async {
          final favoritesNotifier = ref.read(favoritesNotifierProvider.notifier);
          await favoritesNotifier.toggleFavorite(team);
        },
        icon: Icon(
          isFavorite ? Icons.favorite : Icons.favorite_border,
          color: isFavorite ? Colors.red : null,
        ),
        tooltip: isFavorite ? 'Remove from favorites' : 'Add to favorites',
      ),
      loading: () => const SizedBox(
        width: 48,
        height: 48,
        child: Center(
          child: SizedBox(
            width: 20,
            height: 20,
            child: CircularProgressIndicator(strokeWidth: 2),
          ),
        ),
      ),
      error: (_, __) => IconButton(
        onPressed: null,
        icon: Icon(
          Icons.error_outline,
          color: Theme.of(context).colorScheme.error,
        ),
      ),
    );
  }
} 