import 'package:activ/features/chat/domain/chat_repository.dart';
import 'package:activ/features/chat/presentation/cubit/state.dart';
import 'package:activ/utils/helpers/data_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit({required this.repository}) : super(const ChatState());

  final ChatRepository repository;

  Future<void> getChats() async {
    emit(state.copyWith(chats: const DataState.loading()));

    final response = await repository.getChats();

    if (response.isSuccess) {
      emit(state.copyWith(chats: DataState.loaded(data: response.data)));
    } else {
      emit(state.copyWith(chats: DataState.failure(error: response.message)));
    }
  }
}
