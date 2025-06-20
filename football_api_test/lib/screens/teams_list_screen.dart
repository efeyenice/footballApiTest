import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../models/team.dart';
import '../providers/providers.dart';
import '../widgets/team_card.dart';

class TeamsListScreen extends ConsumerStatefulWidget {
  const TeamsListScreen({super.key});

  @override
  ConsumerState<TeamsListScreen> createState() => _TeamsListScreenState();
}

class _TeamsListScreenState extends ConsumerState<TeamsListScreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _searchController.addListener(() {
      ref
          .read(searchTextNotifierProvider.notifier)
          .setSearchText(_searchController.text);
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final teamsAsync = ref.watch(filteredAndSortedTeamsProvider);
    final viewMode = ref.watch(viewModeNotifierProvider);
    final sortOrder = ref.watch(sortOrderNotifierProvider);
    final favoriteCountAsync = ref.watch(favoriteTeamsCountProvider);
    final searchText = ref.watch(searchTextNotifierProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Premier League Teams'),
        actions: [
          // Favorites count and navigation
          favoriteCountAsync.when(
            data: (count) => Badge(
              label: Text('$count'),
              isLabelVisible: count > 0,
              child: IconButton(
                icon: const Icon(Icons.favorite),
                onPressed: () => context.push('/favorites'),
                tooltip: 'Favorites',
              ),
            ),
            loading: () => IconButton(
              icon: const Icon(Icons.favorite),
              onPressed: () => context.push('/favorites'),
            ),
            error: (_, __) => IconButton(
              icon: const Icon(Icons.favorite),
              onPressed: () => context.push('/favorites'),
            ),
          ),

          // Sort button
          PopupMenuButton<SortOrder>(
            icon: const Icon(Icons.sort),
            tooltip: 'Sort teams',
            onSelected: (order) {
              ref.read(sortOrderNotifierProvider.notifier).setSortOrder(order);
            },
            itemBuilder: (context) => [
              PopupMenuItem(
                value: SortOrder.nameAsc,
                child: Row(
                  children: [
                    Icon(
                      Icons.sort_by_alpha,
                      color: sortOrder == SortOrder.nameAsc
                          ? Theme.of(context).colorScheme.primary
                          : null,
                    ),
                    const SizedBox(width: 8),
                    const Text('Name A-Z'),
                  ],
                ),
              ),
              PopupMenuItem(
                value: SortOrder.nameDesc,
                child: Row(
                  children: [
                    Icon(
                      Icons.sort_by_alpha,
                      color: sortOrder == SortOrder.nameDesc
                          ? Theme.of(context).colorScheme.primary
                          : null,
                    ),
                    const SizedBox(width: 8),
                    const Text('Name Z-A'),
                  ],
                ),
              ),
            ],
          ),

          // View mode toggle
          IconButton(
            icon: Icon(
              viewMode == ViewMode.list ? Icons.grid_view : Icons.view_list,
            ),
            onPressed: () {
              ref.read(viewModeNotifierProvider.notifier).toggle();
            },
            tooltip: viewMode == ViewMode.list ? 'Grid view' : 'List view',
          ),
        ],
      ),
      body: Column(
        children: [
          // Search bar
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: SearchBar(
              controller: _searchController,
              hintText: 'Search teams...',
              leading: const Icon(Icons.search),
              trailing: [
                if (searchText.isNotEmpty)
                  IconButton(
                    icon: const Icon(Icons.clear),
                    onPressed: () {
                      _searchController.clear();
                      ref
                          .read(searchTextNotifierProvider.notifier)
                          .clearSearch();
                    },
                  ),
              ],
              onChanged: (value) {
                // This ensures immediate updates even if listener doesn't fire
                ref
                    .read(searchTextNotifierProvider.notifier)
                    .setSearchText(value);
              },
            ),
          ),

          // Teams list/grid
          Expanded(
            child: teamsAsync.when(
              data: (teams) => _buildTeamsList(teams, viewMode),
              loading: () => const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(),
                    SizedBox(height: 16),
                    Text('Loading Premier League teams...'),
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
                      'Failed to load teams',
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
                        ref.invalidate(premierLeagueTeamsProvider);
                      },
                      icon: const Icon(Icons.refresh),
                      label: const Text('Retry'),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Footer with attribution
          Container(
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Theme.of(
                context,
              ).colorScheme.surfaceContainerHighest.withValues(alpha: 0.3),
              border: Border(
                top: BorderSide(
                  color: Theme.of(
                    context,
                  ).colorScheme.outline.withValues(alpha: 0.2),
                ),
              ),
            ),
            child: Text(
              'Football data provided by the Football-Data.org API',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTeamsList(List<Team> teams, ViewMode viewMode) {
    if (teams.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.search_off,
              size: 64,
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
            const SizedBox(height: 16),
            Text(
              'No teams found',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 8),
            Text(
              'Try adjusting your search terms',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
      );
    }

    if (viewMode == ViewMode.grid) {
      return GridView.builder(
        padding: const EdgeInsets.all(16.0),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.8,
          crossAxisSpacing: 16.0,
          mainAxisSpacing: 16.0,
        ),
        itemCount: teams.length,
        itemBuilder: (context, index) {
          final team = teams[index];
          return TeamCard(
            team: team,
            isGridView: true,
            onTap: () => context.push('/team/${team.id}'),
          );
        },
      );
    } else {
      return ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: teams.length,
        itemBuilder: (context, index) {
          final team = teams[index];
          return Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: TeamCard(
              team: team,
              isGridView: false,
              onTap: () => context.push('/team/${team.id}'),
            ),
          );
        },
      );
    }
  }
}
