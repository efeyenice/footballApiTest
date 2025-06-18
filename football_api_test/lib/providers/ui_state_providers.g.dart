// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ui_state_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$filteredAndSortedTeamsHash() =>
    r'251e090999aa9780b6fcc5b29f0ba64e29e95f91';

/// Provider that combines teams with filtering and sorting
///
/// Copied from [filteredAndSortedTeams].
@ProviderFor(filteredAndSortedTeams)
final filteredAndSortedTeamsProvider =
    AutoDisposeFutureProvider<List<Team>>.internal(
      filteredAndSortedTeams,
      name: r'filteredAndSortedTeamsProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$filteredAndSortedTeamsHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef FilteredAndSortedTeamsRef = AutoDisposeFutureProviderRef<List<Team>>;
String _$viewModeNotifierHash() => r'5f115a597211899045c99a2bc3880eb19ce24be3';

/// Provider for view mode (list or grid)
///
/// Copied from [ViewModeNotifier].
@ProviderFor(ViewModeNotifier)
final viewModeNotifierProvider =
    AutoDisposeNotifierProvider<ViewModeNotifier, ViewMode>.internal(
      ViewModeNotifier.new,
      name: r'viewModeNotifierProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$viewModeNotifierHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$ViewModeNotifier = AutoDisposeNotifier<ViewMode>;
String _$sortOrderNotifierHash() => r'4c8ceea4fb50ea2c37ce2322919a7511108fbd18';

/// Provider for sorting order
///
/// Copied from [SortOrderNotifier].
@ProviderFor(SortOrderNotifier)
final sortOrderNotifierProvider =
    AutoDisposeNotifierProvider<SortOrderNotifier, SortOrder>.internal(
      SortOrderNotifier.new,
      name: r'sortOrderNotifierProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$sortOrderNotifierHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$SortOrderNotifier = AutoDisposeNotifier<SortOrder>;
String _$searchTextNotifierHash() =>
    r'6eff00c9db50371fd432c08865f29da48ceb2fce';

/// Provider for search/filter text
///
/// Copied from [SearchTextNotifier].
@ProviderFor(SearchTextNotifier)
final searchTextNotifierProvider =
    AutoDisposeNotifierProvider<SearchTextNotifier, String>.internal(
      SearchTextNotifier.new,
      name: r'searchTextNotifierProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$searchTextNotifierHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$SearchTextNotifier = AutoDisposeNotifier<String>;
String _$loadingStateNotifierHash() =>
    r'0b6a12c570d6b3539091fc301698469e60b43f73';

/// Provider for UI loading states
///
/// Copied from [LoadingStateNotifier].
@ProviderFor(LoadingStateNotifier)
final loadingStateNotifierProvider =
    AutoDisposeNotifierProvider<LoadingStateNotifier, bool>.internal(
      LoadingStateNotifier.new,
      name: r'loadingStateNotifierProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$loadingStateNotifierHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$LoadingStateNotifier = AutoDisposeNotifier<bool>;
String _$errorMessageNotifierHash() =>
    r'b765e07de9ecdbd7f8dc5e0be7bd22d376ed3fd4';

/// Provider for error messages
///
/// Copied from [ErrorMessageNotifier].
@ProviderFor(ErrorMessageNotifier)
final errorMessageNotifierProvider =
    AutoDisposeNotifierProvider<ErrorMessageNotifier, String?>.internal(
      ErrorMessageNotifier.new,
      name: r'errorMessageNotifierProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$errorMessageNotifierHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$ErrorMessageNotifier = AutoDisposeNotifier<String?>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
