import 'package:activ/features/chat/domain/chat_repository.dart';
import 'package:activ/features/chat/presentation/cubit/state.dart';
import 'package:activ/utils/helpers/data_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit({required this.repository}) : super(const ChatState());

  final ChatRepository repository;

  Future<void> getUser() async {
    emit(state.copyWith(user: const DataState.loading()));

    final response = await repository.getUser();

    if (response.isSuccess) {
      emit(
        state.copyWith(
          user: DataState.loaded(
            data: response.data,
          ),
        ),
      );
    } else {
      emit(
        state.copyWith(
          user: DataState.failure(
            error: response.message,
          ),
        ),
      );
    }
  }
}
