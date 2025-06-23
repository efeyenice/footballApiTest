/// Simplified Match model without code generation
class Match {
  final int id;
  final String utcDate;
  final String status;        // SCHEDULED, FINISHED, IN_PLAY, etc.
  final String? stage;
  final MatchTeam homeTeam;
  final MatchTeam awayTeam;
  final MatchScore score;
  final String competitionName;

  const Match({
    required this.id,
    required this.utcDate,
    required this.status,
    this.stage,
    required this.homeTeam,
    required this.awayTeam,
    required this.score,
    required this.competitionName,
  });

  /// Create Match from API JSON response
  factory Match.fromJson(Map<String, dynamic> json) {
    return Match(
      id: json['id'] as int,
      utcDate: json['utcDate'] as String,
      status: json['status'] as String,
      stage: json['stage'] as String?,
      homeTeam: MatchTeam.fromJson(json['homeTeam'] as Map<String, dynamic>),
      awayTeam: MatchTeam.fromJson(json['awayTeam'] as Map<String, dynamic>),
      score: MatchScore.fromJson(json['score'] as Map<String, dynamic>),
      competitionName: json['competition']?['name'] as String? ?? 'Unknown',
    );
  }

  /// Helper method to get formatted date
  DateTime get dateTime => DateTime.parse(utcDate);

  /// Helper method to check if match is upcoming
  bool get isUpcoming => ['SCHEDULED', 'TIMED'].contains(status);

  /// Helper method to check if match is finished
  bool get isFinished => status == 'FINISHED';

  /// Helper method to check if match is live
  bool get isLive => ['IN_PLAY', 'PAUSED', 'HALF_TIME'].contains(status);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Match && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() =>
      'Match(id: $id, ${homeTeam.shortName} vs ${awayTeam.shortName}, $status)';
}

/// Simplified team representation for matches
class MatchTeam {
  final int id;
  final String name;
  final String shortName;
  final String tla;
  final String crest;

  const MatchTeam({
    required this.id,
    required this.name,
    required this.shortName,
    required this.tla,
    required this.crest,
  });

  factory MatchTeam.fromJson(Map<String, dynamic> json) {
    return MatchTeam(
      id: json['id'] as int,
      name: json['name'] as String,
      shortName: json['shortName'] as String,
      tla: json['tla'] as String,
      crest: json['crest'] as String,
    );
  }
}

/// Simplified match score
class MatchScore {
  final String? winner;
  final int? homeScore;
  final int? awayScore;

  const MatchScore({
    this.winner,
    this.homeScore,
    this.awayScore,
  });

  factory MatchScore.fromJson(Map<String, dynamic> json) {
    final fullTime = json['fullTime'] as Map<String, dynamic>?;
    return MatchScore(
      winner: json['winner'] as String?,
      homeScore: fullTime?['home'] as int?,
      awayScore: fullTime?['away'] as int?,
    );
  }

  String get displayScore {
    if (homeScore != null && awayScore != null) {
      return '$homeScore - $awayScore';
    }
    return 'vs';
  }
}
