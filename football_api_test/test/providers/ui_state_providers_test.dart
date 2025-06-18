import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:football_api_test/providers/ui_state_providers.dart';

void main() {
  group('UI State Providers', () {
    late ProviderContainer container;

    setUp(() {
      container = ProviderContainer();
    });

    tearDown(() {
      container.dispose();
    });

    group('ViewModeNotifier', () {
      test('should start with list view mode', () {
        final viewMode = container.read(viewModeNotifierProvider);
        expect(viewMode, equals(ViewMode.list));
      });

      test('should switch to grid view when setGridView is called', () {
        final notifier = container.read(viewModeNotifierProvider.notifier);
        notifier.setGridView();

        final viewMode = container.read(viewModeNotifierProvider);
        expect(viewMode, equals(ViewMode.grid));
      });

      test('should toggle between list and grid views', () {
        final notifier = container.read(viewModeNotifierProvider.notifier);

        // Start with list view
        expect(container.read(viewModeNotifierProvider), equals(ViewMode.list));

        // Toggle to grid
        notifier.toggle();
        expect(container.read(viewModeNotifierProvider), equals(ViewMode.grid));

        // Toggle back to list
        notifier.toggle();
        expect(container.read(viewModeNotifierProvider), equals(ViewMode.list));
      });
    });

    group('SortOrderNotifier', () {
      test('should start with name ascending sort order', () {
        final sortOrder = container.read(sortOrderNotifierProvider);
        expect(sortOrder, equals(SortOrder.nameAsc));
      });

      test('should change sort order when setSortOrder is called', () {
        final notifier = container.read(sortOrderNotifierProvider.notifier);
        notifier.setSortOrder(SortOrder.nameDesc);

        final sortOrder = container.read(sortOrderNotifierProvider);
        expect(sortOrder, equals(SortOrder.nameDesc));
      });

      test('should toggle between ascending and descending sort orders', () {
        final notifier = container.read(sortOrderNotifierProvider.notifier);

        // Start with ascending
        expect(
          container.read(sortOrderNotifierProvider),
          equals(SortOrder.nameAsc),
        );

        // Toggle to descending
        notifier.toggleSort();
        expect(
          container.read(sortOrderNotifierProvider),
          equals(SortOrder.nameDesc),
        );

        // Toggle back to ascending
        notifier.toggleSort();
        expect(
          container.read(sortOrderNotifierProvider),
          equals(SortOrder.nameAsc),
        );
      });
    });

    group('SearchTextNotifier', () {
      test('should start with empty search text', () {
        final searchText = container.read(searchTextNotifierProvider);
        expect(searchText, equals(''));
      });

      test('should update search text when setSearchText is called', () {
        final notifier = container.read(searchTextNotifierProvider.notifier);
        notifier.setSearchText('Arsenal');

        final searchText = container.read(searchTextNotifierProvider);
        expect(searchText, equals('Arsenal'));
      });

      test('should clear search text when clearSearch is called', () {
        final notifier = container.read(searchTextNotifierProvider.notifier);

        // Set some search text
        notifier.setSearchText('Chelsea');
        expect(container.read(searchTextNotifierProvider), equals('Chelsea'));

        // Clear the search
        notifier.clearSearch();
        expect(container.read(searchTextNotifierProvider), equals(''));
      });
    });

    group('LoadingStateNotifier', () {
      test('should start with false loading state', () {
        final loading = container.read(loadingStateNotifierProvider);
        expect(loading, equals(false));
      });

      test('should update loading state when setLoading is called', () {
        final notifier = container.read(loadingStateNotifierProvider.notifier);
        notifier.setLoading(true);

        final loading = container.read(loadingStateNotifierProvider);
        expect(loading, equals(true));
      });
    });

    group('ErrorMessageNotifier', () {
      test('should start with null error message', () {
        final error = container.read(errorMessageNotifierProvider);
        expect(error, isNull);
      });

      test('should update error message when setError is called', () {
        final notifier = container.read(errorMessageNotifierProvider.notifier);
        notifier.setError('Network error');

        final error = container.read(errorMessageNotifierProvider);
        expect(error, equals('Network error'));
      });

      test('should clear error message when clearError is called', () {
        final notifier = container.read(errorMessageNotifierProvider.notifier);

        // Set an error
        notifier.setError('Some error');
        expect(
          container.read(errorMessageNotifierProvider),
          equals('Some error'),
        );

        // Clear the error
        notifier.clearError();
        expect(container.read(errorMessageNotifierProvider), isNull);
      });
    });
  });
}
