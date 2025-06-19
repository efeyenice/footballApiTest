import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import '../lib/models/api_responses.dart';

void main() async {
  const String baseUrl = 'https://api.football-data.org/v4';
  const String apiKey = '7d6d02ad9fdf4f4bb24e1b89dcd1efc2';
  const String premierLeagueCode = 'PL';

  final url = Uri.parse('$baseUrl/competitions/$premierLeagueCode/teams');
  final headers = {
    'X-Auth-Token': apiKey,
    'Content-Type': 'application/json',
  };

  try {
    print('🔗 Making API call to: $url');
    final response = await http.get(url, headers: headers);

    print('📡 Response status: ${response.statusCode}');
    if (response.statusCode == 200) {
      print('🔍 Attempting to parse JSON...');
      final jsonData = jsonDecode(response.body) as Map<String, dynamic>;
      print('✅ JSON parsed successfully');
      print('📊 Top-level keys: ${jsonData.keys.toList()}');

      print('\n🏆 Testing TeamsResponse parsing...');
      final teamsResponse = TeamsResponse.fromJson(jsonData);
      print('✅ TeamsResponse parsed successfully!');
      print('👥 Number of teams: ${teamsResponse.teams.length}');
      
      if (teamsResponse.teams.isNotEmpty) {
        final firstTeam = teamsResponse.teams.first;
        print('🏟️ First team: ${firstTeam.name}');
        print('👨‍💼 Coach: ${firstTeam.coach?.name ?? 'No coach data'}');
        print('👥 Squad size: ${firstTeam.squad?.length ?? 0} players');
        print('✅ All parsing successful!');
      }
    } else {
      print('❌ Error: ${response.statusCode} - ${response.body}');
    }
  } catch (e, stackTrace) {
    print('🚫 Exception: $e');
    print('📍 Stack trace: $stackTrace');
  }
} 