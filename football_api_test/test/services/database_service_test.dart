import 'package:flutter_test/flutter_test.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:football_api_test/services/database_service.dart';
import 'package:football_api_test/models/team.dart';

void main() {
  group('DatabaseService Tests', () {
    late Team testTeam;

    setUpAll(() {
      // Initialize FFI for testing
      sqfliteFfiInit();
      databaseFactory = databaseFactoryFfi;
    });

    setUp(() {
      testTeam = const Team(
        id: 1,
        name: 'Test FC',
        shortName: 'Test',
        tla: 'TST',
        crest: 'https://example.com/crest.png',
        venue: 'Test Stadium',
        founded: 2000,
        clubColors: 'Red / Blue',
      );
    });

    tearDown(() async {
      // Clean up after each test
      await DatabaseService.clearAllFavorites();
      await DatabaseService.close();
    });

    test('should add team to favorites', () async {
      // Act
      final result = await DatabaseService.addFavorite(testTeam);
      
      // Assert
      expect(result, greaterThan(0)); // Should return row ID
      
      final isFavorite = await DatabaseService.isFavorite(testTeam.id);
      expect(isFavorite, isTrue);
    });

    test('should remove team from favorites', () async {
      // Arrange
      await DatabaseService.addFavorite(testTeam);
      
      // Act
      final result = await DatabaseService.removeFavorite(testTeam.id);
      
      // Assert
      expect(result, equals(1)); // Should delete 1 row
      
      final isFavorite = await DatabaseService.isFavorite(testTeam.id);
      expect(isFavorite, isFalse);
    });

    test('should toggle favorite status', () async {
      // Initial state - not favorite
      expect(await DatabaseService.isFavorite(testTeam.id), isFalse);
      
      // Toggle to favorite
      final isNowFavorite = await DatabaseService.toggleFavorite(testTeam);
      expect(isNowFavorite, isTrue);
      expect(await DatabaseService.isFavorite(testTeam.id), isTrue);
      
      // Toggle back to not favorite
      final isNoLongerFavorite = await DatabaseService.toggleFavorite(testTeam);
      expect(isNoLongerFavorite, isFalse);
      expect(await DatabaseService.isFavorite(testTeam.id), isFalse);
    });

    test('should get all favorites', () async {
      // Arrange
      final team2 = const Team(
        id: 2,
        name: 'Another FC',
        shortName: 'Another',
        tla: 'ANO',
        crest: 'https://example.com/crest2.png',
      );
      
      await DatabaseService.addFavorite(testTeam);
      await DatabaseService.addFavorite(team2);
      
      // Act
      final favorites = await DatabaseService.getAllFavorites();
      
      // Assert
      expect(favorites.length, equals(2));
      expect(favorites.any((f) => f.id == testTeam.id), isTrue);
      expect(favorites.any((f) => f.id == team2.id), isTrue);
    });

    test('should get favorites count', () async {
      // Initial count should be 0
      expect(await DatabaseService.getFavoritesCount(), equals(0));
      
      // Add favorites
      await DatabaseService.addFavorite(testTeam);
      expect(await DatabaseService.getFavoritesCount(), equals(1));
      
      final team2 = const Team(
        id: 2,
        name: 'Another FC',
        shortName: 'Another',
        tla: 'ANO',
        crest: 'https://example.com/crest2.png',
      );
      await DatabaseService.addFavorite(team2);
      expect(await DatabaseService.getFavoritesCount(), equals(2));
    });

    test('should convert between Team and FavoriteTeam', () async {
      // Add to favorites
      await DatabaseService.addFavorite(testTeam);
      
      // Get from database
      final favorites = await DatabaseService.getAllFavorites();
      final favoriteTeam = favorites.first;
      
      // Convert back to Team
      final convertedTeam = favoriteTeam.toTeam();
      
      // Assert all fields match
      expect(convertedTeam.id, equals(testTeam.id));
      expect(convertedTeam.name, equals(testTeam.name));
      expect(convertedTeam.shortName, equals(testTeam.shortName));
      expect(convertedTeam.tla, equals(testTeam.tla));
      expect(convertedTeam.crest, equals(testTeam.crest));
      expect(convertedTeam.venue, equals(testTeam.venue));
      expect(convertedTeam.founded, equals(testTeam.founded));
      expect(convertedTeam.clubColors, equals(testTeam.clubColors));
    });

    test('should handle database persistence', () async {
      // Add favorite
      await DatabaseService.addFavorite(testTeam);
      expect(await DatabaseService.getFavoritesCount(), equals(1));
      
      // Close database
      await DatabaseService.close();
      
      // Reopen and check data is still there
      expect(await DatabaseService.getFavoritesCount(), equals(1));
      expect(await DatabaseService.isFavorite(testTeam.id), isTrue);
    });
  });
} 