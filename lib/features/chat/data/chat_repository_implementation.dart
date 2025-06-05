import 'package:activ/core/api_service/api_service.dart';
import 'package:activ/core/app_preferences/app_preferences.dart';
import 'package:activ/core/di/injector.dart';
import 'package:activ/core/endpoints/endpoints.dart';
import 'package:activ/core/models/chats/chat_model.dart';
import 'package:activ/core/models/chats/chat_response_model.dart';
import 'package:activ/core/models/stream_chat/stream_chat_auth_model.dart';
import 'package:activ/core/models/stream_chat/stream_chat_auth_response_model.dart';
import 'package:activ/core/models/user_model/user_model.dart';
import 'package:activ/features/chat/domain/chat_repository.dart';
import 'package:activ/utils/helpers/repository_response.dart';

class ChatRepositoryImplementation implements ChatRepository {
  ChatRepositoryImplementation({
    ApiService? apiService,
    AppPreferences? baseStorage,
  })  : _apiService = apiService ?? ApiService(),
        _cache = baseStorage ?? Injector.resolve<AppPreferences>();
  final ApiService _apiService;
  final AppPreferences _cache;

  @override
  Future<RepositoryResponse<List<ChatModel>>> getChats() async {
    try {
      final response = await _apiService.get(Endpoints.getChats);
      if (response.statusCode == 200) {
        final result = ChatResponseModel.parseResponse(response);
        return RepositoryResponse(
          isSuccess: true,
          data: result.response?.data?.chats,
        );
      } else {
        return RepositoryResponse(
          isSuccess: false,
          message: response.data['message'] as String,
        );
      }
    } catch (e) {
      return RepositoryResponse(
        isSuccess: false,
        message: e.toString(),
      );
    }
  }

  @override
  Future<RepositoryResponse<StreamChatAuthModel>> getStreamChatAuth() async {
    try {
      final response = await _apiService.get(Endpoints.getStreamChatAuth);
      if (response.statusCode == 200) {
        final result = StreamChatAuthResponseModel.parseResponse(response);
        return RepositoryResponse(
          isSuccess: true,
          data: result.response?.data?.streamChatAuth,
        );
      } else {
        return RepositoryResponse(
          isSuccess: false,
          message: response.data['message'] as String,
        );
      }
    } catch (e) {
      return RepositoryResponse(
        isSuccess: false,
        message: e.toString(),
      );
    }
  }
}
