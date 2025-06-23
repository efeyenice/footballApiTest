/// Simplified Team model without code generation
class Team {
  final int id;
  final String name;
  final String shortName;
  final String tla;          // Three Letter Abbreviation
  final String crest;        // Team logo URL
  final String? venue;
  final int? founded;
  final String? clubColors;
  final String? website;
  final String? address;

  const Team({
    required this.id,
    required this.name,
    required this.shortName,
    required this.tla,
    required this.crest,
    this.venue,
    this.founded,
    this.clubColors,
    this.website,
    this.address,
  });

  /// Create Team from API JSON response
  factory Team.fromJson(Map<String, dynamic> json) {
    return Team(
      id: json['id'] as int,
      name: json['name'] as String,
      shortName: json['shortName'] as String,
      tla: json['tla'] as String,
      crest: json['crest'] as String,
      venue: json['venue'] as String?,
      founded: json['founded'] as int?,
      clubColors: json['clubColors'] as String?,
      website: json['website'] as String?,
      address: json['address'] as String?,
    );
  }

  /// Convert Team to JSON (for database storage if needed)
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'shortName': shortName,
      'tla': tla,
      'crest': crest,
      'venue': venue,
      'founded': founded,
      'clubColors': clubColors,
      'website': website,
      'address': address,
    };
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Team && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() => 'Team(id: $id, name: $name, shortName: $shortName)';
}
