import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/team.dart';

/// Simple Room-like database service using sqflite
/// Provides CRUD operations for favorite teams
class DatabaseService {
  static Database? _database;
  static const String _databaseName = 'football_app.db';
  static const int _databaseVersion = 1;
  
  // Table and column names
  static const String _tableFavorites = 'favorite_teams';
  static const String _columnId = 'id';
  static const String _columnName = 'name';
  static const String _columnShortName = 'short_name';
  static const String _columnTla = 'tla';
  static const String _columnCrest = 'crest';
  static const String _columnVenue = 'venue';
  static const String _columnFounded = 'founded';
  static const String _columnClubColors = 'club_colors';
  static const String _columnAddedAt = 'added_at';

  /// Singleton pattern - get database instance
  static Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  /// Initialize database and create tables
  static Future<Database> _initDatabase() async {
    final String path = join(await getDatabasesPath(), _databaseName);
    
    return await openDatabase(
      path,
      version: _databaseVersion,
      onCreate: _createDatabase,
      onUpgrade: _upgradeDatabase,
    );
  }

  /// Create database tables (Room-like schema creation)
  static Future<void> _createDatabase(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $_tableFavorites (
        $_columnId INTEGER PRIMARY KEY,
        $_columnName TEXT NOT NULL,
        $_columnShortName TEXT NOT NULL,
        $_columnTla TEXT NOT NULL,
        $_columnCrest TEXT NOT NULL,
        $_columnVenue TEXT,
        $_columnFounded INTEGER,
        $_columnClubColors TEXT,
        $_columnAddedAt DATETIME DEFAULT CURRENT_TIMESTAMP
      )
    ''');
  }

  /// Handle database upgrades (for future schema changes)
  static Future<void> _upgradeDatabase(Database db, int oldVersion, int newVersion) async {
    // Handle future database migrations here
    if (oldVersion < 2) {
      // Example: ALTER TABLE statements for version 2
    }
  }

  // CRUD Operations (Room-like DAO pattern)

  /// Get all favorite teams
  /// @Query("SELECT * FROM favorite_teams ORDER BY added_at DESC")
  static Future<List<FavoriteTeam>> getAllFavorites() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      _tableFavorites,
      orderBy: '$_columnAddedAt DESC',
    );
    
    return List.generate(maps.length, (i) => FavoriteTeam.fromMap(maps[i]));
  }

  /// Add team to favorites
  /// @Insert
  static Future<int> addFavorite(Team team) async {
    final db = await database;
    return await db.insert(
      _tableFavorites,
      FavoriteTeam.fromTeam(team).toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  /// Remove team from favorites
  /// @Delete("DELETE FROM favorite_teams WHERE id = ?")
  static Future<int> removeFavorite(int teamId) async {
    final db = await database;
    return await db.delete(
      _tableFavorites,
      where: '$_columnId = ?',
      whereArgs: [teamId],
    );
  }

  /// Check if team is favorite
  /// @Query("SELECT COUNT(*) FROM favorite_teams WHERE id = ?")
  static Future<bool> isFavorite(int teamId) async {
    final db = await database;
    final List<Map<String, dynamic>> result = await db.query(
      _tableFavorites,
      where: '$_columnId = ?',
      whereArgs: [teamId],
      limit: 1,
    );
    
    return result.isNotEmpty;
  }

  /// Toggle favorite status
  static Future<bool> toggleFavorite(Team team) async {
    final isCurrentlyFavorite = await isFavorite(team.id);
    
    if (isCurrentlyFavorite) {
      await removeFavorite(team.id);
      return false;
    } else {
      await addFavorite(team);
      return true;
    }
  }

  /// Get count of favorite teams
  /// @Query("SELECT COUNT(*) FROM favorite_teams")
  static Future<int> getFavoritesCount() async {
    final db = await database;
    final result = await db.rawQuery('SELECT COUNT(*) as count FROM $_tableFavorites');
    return (result.first['count'] as int?) ?? 0;
  }

  /// Clear all favorites (for testing or reset functionality)
  /// @Query("DELETE FROM favorite_teams")
  static Future<int> clearAllFavorites() async {
    final db = await database;
    return await db.delete(_tableFavorites);
  }

  /// Close database connection
  static Future<void> close() async {
    final db = _database;
    if (db != null) {
      await db.close();
      _database = null;
    }
  }
}

/// Simple data class representing a favorite team (Room Entity)
/// @Entity(tableName = "favorite_teams")
class FavoriteTeam {
  final int id;
  final String name;
  final String shortName;
  final String tla;
  final String crest;
  final String? venue;
  final int? founded;
  final String? clubColors;
  final DateTime addedAt;

  FavoriteTeam({
    required this.id,
    required this.name,
    required this.shortName,
    required this.tla,
    required this.crest,
    this.venue,
    this.founded,
    this.clubColors,
    required this.addedAt,
  });

  /// Create FavoriteTeam from Team object
  factory FavoriteTeam.fromTeam(Team team) {
    return FavoriteTeam(
      id: team.id,
      name: team.name,
      shortName: team.shortName,
      tla: team.tla,
      crest: team.crest,
      venue: team.venue,
      founded: team.founded,
      clubColors: team.clubColors,
      addedAt: DateTime.now(),
    );
  }

  /// Create FavoriteTeam from database map
  factory FavoriteTeam.fromMap(Map<String, dynamic> map) {
    return FavoriteTeam(
      id: map['id'],
      name: map['name'],
      shortName: map['short_name'],
      tla: map['tla'],
      crest: map['crest'],
      venue: map['venue'],
      founded: map['founded'],
      clubColors: map['club_colors'],
      addedAt: DateTime.parse(map['added_at']),
    );
  }

  /// Convert FavoriteTeam to database map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'short_name': shortName,
      'tla': tla,
      'crest': crest,
      'venue': venue,
      'founded': founded,
      'club_colors': clubColors,
      'added_at': addedAt.toIso8601String(),
    };
  }

  /// Convert FavoriteTeam back to Team object (for UI)
  Team toTeam() {
    return Team(
      id: id,
      name: name,
      shortName: shortName,
      tla: tla,
      crest: crest,
      venue: venue,
      founded: founded,
      clubColors: clubColors,
    );
  }

  @override
  String toString() {
    return 'FavoriteTeam(id: $id, name: $name, addedAt: $addedAt)';
  }
} 