import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../database/app_database.dart';
import '../services/football_api_service.dart';

part 'app_providers.g.dart';

/// Provider for the app database instance
@Riverpod(keepAlive: true)
AppDatabase appDatabase(ref) {
  final database = AppDatabase();
  ref.onDispose(() => database.close());
  return database;
}

/// Provider for the football API service
@Riverpod(keepAlive: true)
FootballApiService footballApiService(ref) {
  final service = FootballApiService();
  ref.onDispose(() => service.dispose());
  return service;
}
