import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../models/team.dart';
import '../services/app_state.dart';

class TeamCard extends StatelessWidget {
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
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Consumer<AppState>(
      builder: (context, appState, child) {
        final isFavorite = appState.isTeamFavorite(team.id);
        
        return Card(
          elevation: 2,
          clipBehavior: Clip.antiAlias,
          child: InkWell(
            onTap: onTap,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: isGridView
                  ? _buildGridLayout(context, theme, isFavorite, appState)
                  : _buildListLayout(context, theme, isFavorite, appState),
            ),
          ),
        );
      },
    );
  }

  Widget _buildListLayout(
    BuildContext context,
    ThemeData theme,
    bool isFavorite,
    AppState appState,
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
              _buildTeamInfo(theme),
            ],
          ),
        ),

        // Favorite button
        _buildFavoriteButton(context, isFavorite, appState),
      ],
    );
  }

  Widget _buildGridLayout(
    BuildContext context,
    ThemeData theme,
    bool isFavorite,
    AppState appState,
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

        // Team info
        _buildTeamInfo(theme),
        const SizedBox(height: 8),

        // Favorite button
        _buildFavoriteButton(context, isFavorite, appState),
      ],
    );
  }

  Widget _buildTeamCrest(double size) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade300, width: 1),
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

  Widget _buildTeamInfo(ThemeData theme) {
    // Show team founding year if available
    if (team.founded != null) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.calendar_today, size: 16, color: theme.colorScheme.primary),
          const SizedBox(width: 4),
          Text(
            'Founded ${team.founded}',
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      );
    }
    
    // Show TLA as fallback
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(Icons.sports_soccer, size: 16, color: theme.colorScheme.primary),
        const SizedBox(width: 4),
        Text(
          team.tla,
          style: theme.textTheme.bodySmall?.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget _buildFavoriteButton(
    BuildContext context,
    bool isFavorite,
    AppState appState,
  ) {
    return IconButton(
      onPressed: () async {
        await appState.toggleFavorite(team);
      },
      icon: Icon(
        isFavorite ? Icons.favorite : Icons.favorite_border,
        color: isFavorite ? Colors.red : null,
      ),
      tooltip: isFavorite ? 'Remove from favorites' : 'Add to favorites',
    );
  }
}
