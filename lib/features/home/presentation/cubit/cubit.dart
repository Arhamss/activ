import 'package:activ/core/models/location_model.dart';
import 'package:activ/exports.dart';
import 'package:activ/features/home/domain/home_repository.dart';
import 'package:activ/features/home/presentation/cubit/state.dart';
import 'package:activ/features/games/presentation/views/location_picker_screen.dart';
import 'package:activ/utils/helpers/data_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit({required this.repository}) : super(const HomeState());

  final HomeRepository repository;

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


  
  void setIsSearching(bool value) {
    emit(state.copyWith(isSearching: value));
  }
}
