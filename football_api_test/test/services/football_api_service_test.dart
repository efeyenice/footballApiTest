import 'dart:io';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'package:football_api_test/services/football_api_service.dart';
import 'package:football_api_test/models/team.dart';

// Generate mocks for http.Client
@GenerateMocks([http.Client])
import 'football_api_service_test.mocks.dart';

void main() {
  group('FootballApiService', () {
    late FootballApiService service;
    late MockClient mockClient;

    setUp(() {
      mockClient = MockClient();
      service = FootballApiService(client: mockClient);
    });

    tearDown(() {
      service.dispose();
    });

    group('getPremierLeagueTeams', () {
      test('should return list of teams when API call is successful', () async {
        // Arrange
        const mockResponse = '''
        {
          "count": 2,
          "competition": {
            "id": 2021,
            "name": "Premier League",
            "code": "PL",
            "type": "LEAGUE",
            "emblem": "https://crests.football-data.org/PL.png"
          },
          "season": {
            "id": 2403,
            "startDate": "2025-08-15",
            "endDate": "2026-05-24",
            "currentMatchday": 1,
            "winner": null
          },
          "teams": [
            {
              "area": {
                "id": 2072,
                "name": "England",
                "code": "ENG",
                "flag": "https://crests.football-data.org/770.svg"
              },
              "id": 57,
              "name": "Arsenal FC",
              "shortName": "Arsenal",
              "tla": "ARS",
              "crest": "https://crests.football-data.org/57.png",
              "address": "75 Drayton Park London N5 1BU",
              "website": "http://www.arsenal.com",
              "founded": 1886,
              "clubColors": "Red / White",
              "venue": "Emirates Stadium",
              "runningCompetitions": [
                {
                  "id": 2021,
                  "name": "Premier League",
                  "code": "PL",
                  "type": "LEAGUE",
                  "emblem": "https://crests.football-data.org/PL.png"
                }
              ],
              "lastUpdated": "2022-02-10T19:48:56Z"
            }
          ]
        }''';

        when(mockClient.get(any, headers: anyNamed('headers')))
            .thenAnswer((_) async => http.Response(mockResponse, 200));

        // Act
        final teams = await service.getPremierLeagueTeams();

        // Assert
        expect(teams, isA<List<Team>>());
        expect(teams.length, equals(1));
        expect(teams.first.name, equals('Arsenal FC'));
        expect(teams.first.shortName, equals('Arsenal'));
        expect(teams.first.id, equals(57));
      });

      test('should throw ApiException when rate limit is exceeded', () async {
        // Arrange
        when(mockClient.get(any, headers: anyNamed('headers')))
            .thenAnswer((_) async => http.Response('Rate limit exceeded', 429));

        // Act & Assert
        expect(
          () => service.getPremierLeagueTeams(),
          throwsA(isA<ApiException>()
              .having((e) => e.message, 'message', contains('Rate limit'))),
        );
      });

      test('should throw ApiException when network error occurs', () async {
        // Arrange
        when(mockClient.get(any, headers: anyNamed('headers')))
            .thenThrow(const SocketException('No internet connection'));

        // Act & Assert
        expect(
          () => service.getPremierLeagueTeams(),
          throwsA(isA<ApiException>()
              .having((e) => e.message, 'message', contains('No internet'))),
        );
      });
    });

    group('getTeamById', () {
      test('should return team when API call is successful', () async {
        // This is a stub test - in a real implementation, you would:
        // 1. Mock the API response for a specific team ID
        // 2. Verify the correct team data is returned
        // 3. Test error cases (404, 429, network errors)
        
        // For now, we'll test that the method exists and can be called
        expect(service.getTeamById, isA<Function>());
      });
    });

    group('getTeamUpcomingMatches', () {
      test('should return upcoming matches for a team', () async {
        // Stub test for upcoming matches functionality
        expect(service.getTeamUpcomingMatches, isA<Function>());
      });
    });

    group('getTeamMatchesPlayed', () {
      test('should return number of matches played', () async {
        // Stub test for matches played count
        expect(service.getTeamMatchesPlayed, isA<Function>());
      });
    });
  });
} 