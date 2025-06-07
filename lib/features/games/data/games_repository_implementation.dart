import 'package:activ/core/api_service/api_service.dart';
import 'package:activ/core/app_preferences/app_preferences.dart';
import 'package:activ/core/di/injector.dart';
import 'package:activ/core/endpoints/endpoints.dart';
import 'package:activ/core/models/games/game_model.dart';
import 'package:activ/core/models/games/game_response_model.dart';
import 'package:activ/core/models/location_model.dart';
import 'package:activ/core/models/user_model/user_model.dart';
import 'package:activ/features/games/domain/games_repository.dart';
import 'package:activ/utils/helpers/repository_response.dart';

class GamesRepositoryImplementation implements GamesRepository {
  GamesRepositoryImplementation({
    ApiService? apiService,
    AppPreferences? baseStorage,
  })  : _apiService = apiService ?? ApiService(),
        _cache = baseStorage ?? Injector.resolve<AppPreferences>();

  final ApiService _apiService;
  final AppPreferences _cache;

  @override
  Future<RepositoryResponse<void>> addGame(
    LocationModel location,
    String gameId,
    String fee,
    String gameLevel,
    int maxNumberOfPlayers,
    String? dateTime,
  ) async {
    try {
      final feeCents = int.parse(fee) * 100;
      final level = gameLevel.toLowerCase();

      final response = await _apiService.post(
        endpoint: Endpoints.addGame,
        data: {
          'address': location.address,
          'sportId': gameId,
          'level': level,
          'datetime': dateTime,
          'location': {
            'lat': location.latitude,
            'lng': location.longitude,
          },
          'maxPlayers': maxNumberOfPlayers,
          'feeCents': feeCents,
          'city': location.city,
        },
      );

      if (response.statusCode == 200) {
        return RepositoryResponse(
          isSuccess: true,
        );
      }

      return RepositoryResponse(
        isSuccess: false,
        message: response.data['message'] as String,
      );
    } catch (e) {
      return RepositoryResponse(
        isSuccess: false,
        message: e.toString(),
      );
    }
  }

  @override
  Future<RepositoryResponse<List<GameModel>>> getUpcomingGames() async {
    try {
      final response = await _apiService.get(Endpoints.getUpcomingGames);

      if (response.statusCode == 200) {
        final result = GameResponseModel.parseResponse(response);
        return RepositoryResponse(
          isSuccess: true,
          data: result.response?.data?.games,
        );
      }

      return RepositoryResponse(
        isSuccess: false,
        message: response.data['message'] as String,
      );
    } catch (e) {
      return RepositoryResponse(
        isSuccess: false,
        message: e.toString(),
      );
    }
  }
}
