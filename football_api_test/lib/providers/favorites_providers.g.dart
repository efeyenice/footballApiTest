// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'favorites_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$favoriteTeamsHash() => r'fd8622c0c49593b6f849775f50d86b915aeae411';

/// Provider that gets all favorite teams from the database
///
/// Copied from [favoriteTeams].
@ProviderFor(favoriteTeams)
final favoriteTeamsProvider =
    AutoDisposeFutureProvider<List<FavoriteTeam>>.internal(
      favoriteTeams,
      name: r'favoriteTeamsProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$favoriteTeamsHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef FavoriteTeamsRef = AutoDisposeFutureProviderRef<List<FavoriteTeam>>;
String _$isTeamFavoriteHash() => r'918c4c7a07ae732d84dbf746621cfbc8595d3d8a';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

/// Provider that checks if a specific team is favorite
///
/// Copied from [isTeamFavorite].
@ProviderFor(isTeamFavorite)
const isTeamFavoriteProvider = IsTeamFavoriteFamily();

/// Provider that checks if a specific team is favorite
///
/// Copied from [isTeamFavorite].
class IsTeamFavoriteFamily extends Family<AsyncValue<bool>> {
  /// Provider that checks if a specific team is favorite
  ///
  /// Copied from [isTeamFavorite].
  const IsTeamFavoriteFamily();

  /// Provider that checks if a specific team is favorite
  ///
  /// Copied from [isTeamFavorite].
  IsTeamFavoriteProvider call(int teamId) {
    return IsTeamFavoriteProvider(teamId);
  }

  @override
  IsTeamFavoriteProvider getProviderOverride(
    covariant IsTeamFavoriteProvider provider,
  ) {
    return call(provider.teamId);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'isTeamFavoriteProvider';
}

/// Provider that checks if a specific team is favorite
///
/// Copied from [isTeamFavorite].
class IsTeamFavoriteProvider extends AutoDisposeFutureProvider<bool> {
  /// Provider that checks if a specific team is favorite
  ///
  /// Copied from [isTeamFavorite].
  IsTeamFavoriteProvider(int teamId)
    : this._internal(
        (ref) => isTeamFavorite(ref as IsTeamFavoriteRef, teamId),
        from: isTeamFavoriteProvider,
        name: r'isTeamFavoriteProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$isTeamFavoriteHash,
        dependencies: IsTeamFavoriteFamily._dependencies,
        allTransitiveDependencies:
            IsTeamFavoriteFamily._allTransitiveDependencies,
        teamId: teamId,
      );

  IsTeamFavoriteProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.teamId,
  }) : super.internal();

  final int teamId;

  @override
  Override overrideWith(
    FutureOr<bool> Function(IsTeamFavoriteRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: IsTeamFavoriteProvider._internal(
        (ref) => create(ref as IsTeamFavoriteRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        teamId: teamId,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<bool> createElement() {
    return _IsTeamFavoriteProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is IsTeamFavoriteProvider && other.teamId == teamId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, teamId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin IsTeamFavoriteRef on AutoDisposeFutureProviderRef<bool> {
  /// The parameter `teamId` of this provider.
  int get teamId;
}

class _IsTeamFavoriteProviderElement
    extends AutoDisposeFutureProviderElement<bool>
    with IsTeamFavoriteRef {
  _IsTeamFavoriteProviderElement(super.provider);

  @override
  int get teamId => (origin as IsTeamFavoriteProvider).teamId;
}

String _$favoriteTeamsCountHash() =>
    r'863eff57e75877d2734fa173990170e1677db8ff';

/// Provider that gets the count of favorite teams
///
/// Copied from [favoriteTeamsCount].
@ProviderFor(favoriteTeamsCount)
final favoriteTeamsCountProvider = AutoDisposeFutureProvider<int>.internal(
  favoriteTeamsCount,
  name: r'favoriteTeamsCountProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$favoriteTeamsCountHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef FavoriteTeamsCountRef = AutoDisposeFutureProviderRef<int>;
String _$favoritesNotifierHash() => r'5506dc830992824d424377ebf98d26c1c46cc0cb';

/// Notifier for managing favorite teams state
///
/// Copied from [FavoritesNotifier].
@ProviderFor(FavoritesNotifier)
final favoritesNotifierProvider =
    AutoDisposeAsyncNotifierProvider<
      FavoritesNotifier,
      List<FavoriteTeam>
    >.internal(
      FavoritesNotifier.new,
      name: r'favoritesNotifierProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$favoritesNotifierHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$FavoritesNotifier = AutoDisposeAsyncNotifier<List<FavoriteTeam>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
