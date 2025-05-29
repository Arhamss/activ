import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:activ/features/search/domain/search_repository.dart';
import 'package:activ/features/search/presentation/cubit/state.dart';
import 'package:activ/utils/helpers/data_state.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit({required this.repository}) : super(const SearchState());

  final SearchRepository repository;

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
