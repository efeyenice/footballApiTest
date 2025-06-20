import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import '../models/api_responses.dart';
import '../models/team.dart';
import '../models/match.dart';

class FootballApiService {
  static const String _baseUrl = 'https://api.football-data.org/v4'; 
  static const String _apiKey = '7d6d02ad9fdf4f4bb24e1b89dcd1efc2'; // It is free API key so need for .env file
  static const String _premierLeagueCode = 'PL';

  final http.Client _client;

  FootballApiService({http.Client? client}) : _client = client ?? http.Client();

  /// Common headers for all API requests
  Map<String, String> get _headers => {
    'X-Auth-Token': _apiKey,
    'Content-Type': 'application/json',
  };

  /// Get all Premier League teams
  Future<List<Team>> getPremierLeagueTeams() async {
    final url = Uri.parse('$_baseUrl/competitions/$_premierLeagueCode/teams');

    try {
      print('🔗 Making API call to: $url');
      print('📋 Headers: $_headers');
      
      final response = await _client.get(url, headers: _headers);
      
      print('📡 Response status: ${response.statusCode}');
      print('📄 Response headers: ${response.headers}');
      print('📝 Response body preview: ${response.body.substring(0, response.body.length > 200 ? 200 : response.body.length)}...');

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body) as Map<String, dynamic>;
        final teamsResponse = TeamsResponse.fromJson(jsonData);
        print('✅ Successfully parsed ${teamsResponse.teams.length} teams');
        return teamsResponse.teams;
      } else if (response.statusCode == 429) {
        throw ApiException('Rate limit exceeded. Please try again later.');
      } else if (response.statusCode >= 400 && response.statusCode < 500) {
        throw ApiException('Client error: ${response.statusCode} - ${response.body}');
      } else {
        throw ApiException('Server error: ${response.statusCode} - ${response.body}');
      }
    } on SocketException catch (e) {
      print('🚫 Network error: $e');
      throw ApiException('No internet connection');
    } on FormatException catch (e) {
      print('🚫 Format error: $e');
      throw ApiException('Invalid response format - received HTML instead of JSON');
    } catch (e) {
      print('🚫 Unexpected error: $e');
      if (e is ApiException) rethrow;
      throw ApiException('Unexpected error: ${e.toString()}');
    }
  }

  /// Get team details by ID
  Future<Team> getTeamById(int teamId) async {
    final url = Uri.parse('$_baseUrl/teams/$teamId');

    try {
      final response = await _client.get(url, headers: _headers);

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body) as Map<String, dynamic>;
        return Team.fromJson(jsonData);
      } else if (response.statusCode == 404) {
        throw ApiException('Team not found');
      } else if (response.statusCode == 429) {
        throw ApiException('Rate limit exceeded. Please try again later.');
      } else {
        throw ApiException('Error: ${response.statusCode}');
      }
    } on SocketException {
      throw ApiException('No internet connection');
    } on FormatException {
      throw ApiException('Invalid response format');
    } catch (e) {
      if (e is ApiException) rethrow;
      throw ApiException('Unexpected error: ${e.toString()}');
    }
  }

  /// Get upcoming matches for a team
  Future<List<Match>> getTeamUpcomingMatches(
    int teamId, {
    int limit = 5,
  }) async {
    final url = Uri.parse('$_baseUrl/teams/$teamId/matches').replace(
      queryParameters: {'status': 'SCHEDULED,TIMED', 'limit': limit.toString()},
    );

    try {
      final response = await _client.get(url, headers: _headers);

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body) as Map<String, dynamic>;
        final matchesResponse = MatchesResponse.fromJson(jsonData);
        return matchesResponse.matches;
      } else if (response.statusCode == 429) {
        throw ApiException('Rate limit exceeded. Please try again later.');
      } else {
        throw ApiException('Error: ${response.statusCode}');
      }
    } on SocketException {
      throw ApiException('No internet connection');
    } on FormatException {
      throw ApiException('Invalid response format');
    } catch (e) {
      if (e is ApiException) rethrow;
      throw ApiException('Unexpected error: ${e.toString()}');
    }
  }

  /// Get finished matches for a team
  Future<List<Match>> getTeamFinishedMatches(
    int teamId, {
    int limit = 10,
  }) async {
    final url = Uri.parse('$_baseUrl/teams/$teamId/matches').replace(
      queryParameters: {'status': 'FINISHED', 'limit': limit.toString()},
    );

    try {
      final response = await _client.get(url, headers: _headers);

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body) as Map<String, dynamic>;
        final matchesResponse = MatchesResponse.fromJson(jsonData);
        return matchesResponse.matches;
      } else if (response.statusCode == 429) {
        throw ApiException('Rate limit exceeded. Please try again later.');
      } else {
        throw ApiException('Error: ${response.statusCode}');
      }
    } on SocketException {
      throw ApiException('No internet connection');
    } on FormatException {
      throw ApiException('Invalid response format');
    } catch (e) {
      if (e is ApiException) rethrow;
      throw ApiException('Unexpected error: ${e.toString()}');
    }
  }

  /// Calculate total matches played for a team
  /// This requires fetching finished matches and counting them
  Future<int> getTeamMatchesPlayed(int teamId) async {
    try {
      final finishedMatches = await getTeamFinishedMatches(teamId, limit: 100);
      return finishedMatches.length;
    } catch (e) {
      // Return 0 if we can't fetch the data
      return 0;
    }
  }

  void dispose() {
    _client.close();
  }
}

/// Custom exception for API errors
class ApiException implements Exception {
  final String message;

  const ApiException(this.message);

  @override
  String toString() => 'ApiException: $message';
}
