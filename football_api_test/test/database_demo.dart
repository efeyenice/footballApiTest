import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import '../lib/services/database_service.dart';
import '../lib/models/team.dart';

/// Demo script showing Room-like database functionality
void main() async {
  // Initialize database for testing
  sqfliteFfiInit();
  databaseFactory = databaseFactoryFfi;

  print('🏗️ Football App Database Demo - Room-like Functionality');
  print('=' * 60);

  // Sample teams
  final arsenal = const Team(
    id: 57,
    name: 'Arsenal FC',
    shortName: 'Arsenal',
    tla: 'ARS',
    crest: 'https://crests.football-data.org/57.png',
    venue: 'Emirates Stadium',
    founded: 1886,
    clubColors: 'Red / White',
  );

  final chelsea = const Team(
    id: 61,
    name: 'Chelsea FC',
    shortName: 'Chelsea',
    tla: 'CHE',
    crest: 'https://crests.football-data.org/61.png',
    venue: 'Stamford Bridge',
    founded: 1905,
    clubColors: 'Blue / White',
  );

  try {
    // Demo CRUD operations
    print('\n📋 Initial State:');
    print('Favorites count: ${await DatabaseService.getFavoritesCount()}');

    print('\n➕ Adding Arsenal to favorites...');
    await DatabaseService.addFavorite(arsenal);
    print('Arsenal is favorite: ${await DatabaseService.isFavorite(arsenal.id)}');
    print('Favorites count: ${await DatabaseService.getFavoritesCount()}');

    print('\n➕ Adding Chelsea to favorites...');
    await DatabaseService.addFavorite(chelsea);
    print('Chelsea is favorite: ${await DatabaseService.isFavorite(chelsea.id)}');
    print('Favorites count: ${await DatabaseService.getFavoritesCount()}');

    print('\n📜 All favorites:');
    final favorites = await DatabaseService.getAllFavorites();
    for (final fav in favorites) {
      print('  - ${fav.name} (${fav.shortName}) - Added: ${fav.addedAt}');
    }

    print('\n🔄 Toggling Arsenal favorite status...');
    final arsenalStillFavorite = await DatabaseService.toggleFavorite(arsenal);
    print('Arsenal is favorite: $arsenalStillFavorite');
    print('Favorites count: ${await DatabaseService.getFavoritesCount()}');

    print('\n🔄 Toggling Arsenal back...');
    final arsenalFavoriteAgain = await DatabaseService.toggleFavorite(arsenal);
    print('Arsenal is favorite: $arsenalFavoriteAgain');
    print('Favorites count: ${await DatabaseService.getFavoritesCount()}');

    print('\n❌ Removing Chelsea from favorites...');
    await DatabaseService.removeFavorite(chelsea.id);
    print('Chelsea is favorite: ${await DatabaseService.isFavorite(chelsea.id)}');
    print('Favorites count: ${await DatabaseService.getFavoritesCount()}');

    print('\n📜 Final favorites list:');
    final finalFavorites = await DatabaseService.getAllFavorites();
    for (final fav in finalFavorites) {
      print('  - ${fav.name} (${fav.shortName})');
    }

    print('\n✅ Database Demo Complete!');
    print('\n🚀 Room-like Features Demonstrated:');
    print('  ✅ Singleton database instance');
    print('  ✅ Automatic table creation');
    print('  ✅ CRUD operations with type safety');
    print('  ✅ Entity to object conversion');
    print('  ✅ Query methods with parameters');
    print('  ✅ Data persistence');

  } catch (e) {
    print('❌ Error: $e');
  } finally {
    // Cleanup
    await DatabaseService.clearAllFavorites();
    await DatabaseService.close();
    print('\n🧹 Database cleaned up and closed.');
  }
} 