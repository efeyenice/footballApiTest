// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'teams_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$premierLeagueTeamsHash() =>
    r'7a1784bd3c2157b997ad1e89123702b18c3200eb';

/// Provider that fetches all Premier League teams
///
/// Copied from [premierLeagueTeams].
@ProviderFor(premierLeagueTeams)
final premierLeagueTeamsProvider =
    AutoDisposeFutureProvider<List<Team>>.internal(
      premierLeagueTeams,
      name: r'premierLeagueTeamsProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$premierLeagueTeamsHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef PremierLeagueTeamsRef = AutoDisposeFutureProviderRef<List<Team>>;
String _$teamByIdHash() => r'bc13c7c7bc1f571439e48f21639115895acefc3c';

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

/// Provider that gets a specific team by ID
///
/// Copied from [teamById].
@ProviderFor(teamById)
const teamByIdProvider = TeamByIdFamily();

/// Provider that gets a specific team by ID
///
/// Copied from [teamById].
class TeamByIdFamily extends Family<AsyncValue<Team>> {
  /// Provider that gets a specific team by ID
  ///
  /// Copied from [teamById].
  const TeamByIdFamily();

  /// Provider that gets a specific team by ID
  ///
  /// Copied from [teamById].
  TeamByIdProvider call(int teamId) {
    return TeamByIdProvider(teamId);
  }

  @override
  TeamByIdProvider getProviderOverride(covariant TeamByIdProvider provider) {
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
  String? get name => r'teamByIdProvider';
}

/// Provider that gets a specific team by ID
///
/// Copied from [teamById].
class TeamByIdProvider extends AutoDisposeFutureProvider<Team> {
  /// Provider that gets a specific team by ID
  ///
  /// Copied from [teamById].
  TeamByIdProvider(int teamId)
    : this._internal(
        (ref) => teamById(ref as TeamByIdRef, teamId),
        from: teamByIdProvider,
        name: r'teamByIdProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$teamByIdHash,
        dependencies: TeamByIdFamily._dependencies,
        allTransitiveDependencies: TeamByIdFamily._allTransitiveDependencies,
        teamId: teamId,
      );

  TeamByIdProvider._internal(
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
  Override overrideWith(FutureOr<Team> Function(TeamByIdRef provider) create) {
    return ProviderOverride(
      origin: this,
      override: TeamByIdProvider._internal(
        (ref) => create(ref as TeamByIdRef),
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
  AutoDisposeFutureProviderElement<Team> createElement() {
    return _TeamByIdProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is TeamByIdProvider && other.teamId == teamId;
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
mixin TeamByIdRef on AutoDisposeFutureProviderRef<Team> {
  /// The parameter `teamId` of this provider.
  int get teamId;
}

class _TeamByIdProviderElement extends AutoDisposeFutureProviderElement<Team>
    with TeamByIdRef {
  _TeamByIdProviderElement(super.provider);

  @override
  int get teamId => (origin as TeamByIdProvider).teamId;
}

String _$teamUpcomingMatchesHash() =>
    r'dc69fd132b77cf607300bbcd431a79599a2bc913';

/// Provider that gets upcoming matches for a team
///
/// Copied from [teamUpcomingMatches].
@ProviderFor(teamUpcomingMatches)
const teamUpcomingMatchesProvider = TeamUpcomingMatchesFamily();

/// Provider that gets upcoming matches for a team
///
/// Copied from [teamUpcomingMatches].
class TeamUpcomingMatchesFamily extends Family<AsyncValue<List<Match>>> {
  /// Provider that gets upcoming matches for a team
  ///
  /// Copied from [teamUpcomingMatches].
  const TeamUpcomingMatchesFamily();

  /// Provider that gets upcoming matches for a team
  ///
  /// Copied from [teamUpcomingMatches].
  TeamUpcomingMatchesProvider call(int teamId) {
    return TeamUpcomingMatchesProvider(teamId);
  }

  @override
  TeamUpcomingMatchesProvider getProviderOverride(
    covariant TeamUpcomingMatchesProvider provider,
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
  String? get name => r'teamUpcomingMatchesProvider';
}

/// Provider that gets upcoming matches for a team
///
/// Copied from [teamUpcomingMatches].
class TeamUpcomingMatchesProvider
    extends AutoDisposeFutureProvider<List<Match>> {
  /// Provider that gets upcoming matches for a team
  ///
  /// Copied from [teamUpcomingMatches].
  TeamUpcomingMatchesProvider(int teamId)
    : this._internal(
        (ref) => teamUpcomingMatches(ref as TeamUpcomingMatchesRef, teamId),
        from: teamUpcomingMatchesProvider,
        name: r'teamUpcomingMatchesProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$teamUpcomingMatchesHash,
        dependencies: TeamUpcomingMatchesFamily._dependencies,
        allTransitiveDependencies:
            TeamUpcomingMatchesFamily._allTransitiveDependencies,
        teamId: teamId,
      );

  TeamUpcomingMatchesProvider._internal(
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
    FutureOr<List<Match>> Function(TeamUpcomingMatchesRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: TeamUpcomingMatchesProvider._internal(
        (ref) => create(ref as TeamUpcomingMatchesRef),
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
  AutoDisposeFutureProviderElement<List<Match>> createElement() {
    return _TeamUpcomingMatchesProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is TeamUpcomingMatchesProvider && other.teamId == teamId;
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
mixin TeamUpcomingMatchesRef on AutoDisposeFutureProviderRef<List<Match>> {
  /// The parameter `teamId` of this provider.
  int get teamId;
}

class _TeamUpcomingMatchesProviderElement
    extends AutoDisposeFutureProviderElement<List<Match>>
    with TeamUpcomingMatchesRef {
  _TeamUpcomingMatchesProviderElement(super.provider);

  @override
  int get teamId => (origin as TeamUpcomingMatchesProvider).teamId;
}

String _$teamFinishedMatchesHash() =>
    r'3d675bd152ca2602ec1cbfb55804e70f5e0a38b3';

/// Provider that gets finished matches for a team
///
/// Copied from [teamFinishedMatches].
@ProviderFor(teamFinishedMatches)
const teamFinishedMatchesProvider = TeamFinishedMatchesFamily();

/// Provider that gets finished matches for a team
///
/// Copied from [teamFinishedMatches].
class TeamFinishedMatchesFamily extends Family<AsyncValue<List<Match>>> {
  /// Provider that gets finished matches for a team
  ///
  /// Copied from [teamFinishedMatches].
  const TeamFinishedMatchesFamily();

  /// Provider that gets finished matches for a team
  ///
  /// Copied from [teamFinishedMatches].
  TeamFinishedMatchesProvider call(int teamId) {
    return TeamFinishedMatchesProvider(teamId);
  }

  @override
  TeamFinishedMatchesProvider getProviderOverride(
    covariant TeamFinishedMatchesProvider provider,
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
  String? get name => r'teamFinishedMatchesProvider';
}

/// Provider that gets finished matches for a team
///
/// Copied from [teamFinishedMatches].
class TeamFinishedMatchesProvider
    extends AutoDisposeFutureProvider<List<Match>> {
  /// Provider that gets finished matches for a team
  ///
  /// Copied from [teamFinishedMatches].
  TeamFinishedMatchesProvider(int teamId)
    : this._internal(
        (ref) => teamFinishedMatches(ref as TeamFinishedMatchesRef, teamId),
        from: teamFinishedMatchesProvider,
        name: r'teamFinishedMatchesProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$teamFinishedMatchesHash,
        dependencies: TeamFinishedMatchesFamily._dependencies,
        allTransitiveDependencies:
            TeamFinishedMatchesFamily._allTransitiveDependencies,
        teamId: teamId,
      );

  TeamFinishedMatchesProvider._internal(
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
    FutureOr<List<Match>> Function(TeamFinishedMatchesRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: TeamFinishedMatchesProvider._internal(
        (ref) => create(ref as TeamFinishedMatchesRef),
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
  AutoDisposeFutureProviderElement<List<Match>> createElement() {
    return _TeamFinishedMatchesProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is TeamFinishedMatchesProvider && other.teamId == teamId;
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
mixin TeamFinishedMatchesRef on AutoDisposeFutureProviderRef<List<Match>> {
  /// The parameter `teamId` of this provider.
  int get teamId;
}

class _TeamFinishedMatchesProviderElement
    extends AutoDisposeFutureProviderElement<List<Match>>
    with TeamFinishedMatchesRef {
  _TeamFinishedMatchesProviderElement(super.provider);

  @override
  int get teamId => (origin as TeamFinishedMatchesProvider).teamId;
}

String _$teamMatchesPlayedHash() => r'edd3db7c48792620ef6e5a9b7b154beca2c7d3fd';

/// Provider that gets the number of matches played for a team
///
/// Copied from [teamMatchesPlayed].
@ProviderFor(teamMatchesPlayed)
const teamMatchesPlayedProvider = TeamMatchesPlayedFamily();

/// Provider that gets the number of matches played for a team
///
/// Copied from [teamMatchesPlayed].
class TeamMatchesPlayedFamily extends Family<AsyncValue<int>> {
  /// Provider that gets the number of matches played for a team
  ///
  /// Copied from [teamMatchesPlayed].
  const TeamMatchesPlayedFamily();

  /// Provider that gets the number of matches played for a team
  ///
  /// Copied from [teamMatchesPlayed].
  TeamMatchesPlayedProvider call(int teamId) {
    return TeamMatchesPlayedProvider(teamId);
  }

  @override
  TeamMatchesPlayedProvider getProviderOverride(
    covariant TeamMatchesPlayedProvider provider,
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
  String? get name => r'teamMatchesPlayedProvider';
}

/// Provider that gets the number of matches played for a team
///
/// Copied from [teamMatchesPlayed].
class TeamMatchesPlayedProvider extends AutoDisposeFutureProvider<int> {
  /// Provider that gets the number of matches played for a team
  ///
  /// Copied from [teamMatchesPlayed].
  TeamMatchesPlayedProvider(int teamId)
    : this._internal(
        (ref) => teamMatchesPlayed(ref as TeamMatchesPlayedRef, teamId),
        from: teamMatchesPlayedProvider,
        name: r'teamMatchesPlayedProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$teamMatchesPlayedHash,
        dependencies: TeamMatchesPlayedFamily._dependencies,
        allTransitiveDependencies:
            TeamMatchesPlayedFamily._allTransitiveDependencies,
        teamId: teamId,
      );

  TeamMatchesPlayedProvider._internal(
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
    FutureOr<int> Function(TeamMatchesPlayedRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: TeamMatchesPlayedProvider._internal(
        (ref) => create(ref as TeamMatchesPlayedRef),
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
  AutoDisposeFutureProviderElement<int> createElement() {
    return _TeamMatchesPlayedProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is TeamMatchesPlayedProvider && other.teamId == teamId;
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
mixin TeamMatchesPlayedRef on AutoDisposeFutureProviderRef<int> {
  /// The parameter `teamId` of this provider.
  int get teamId;
}

class _TeamMatchesPlayedProviderElement
    extends AutoDisposeFutureProviderElement<int>
    with TeamMatchesPlayedRef {
  _TeamMatchesPlayedProviderElement(super.provider);

  @override
  int get teamId => (origin as TeamMatchesPlayedProvider).teamId;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
