import 'package:activ/core/models/location_model.dart';
import 'package:activ/exports.dart';
import 'package:activ/features/home/domain/home_repository.dart';
import 'package:activ/features/home/presentation/cubit/state.dart';
import 'package:activ/features/home/presentation/views/location_picker_screen.dart';
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

  Future<void> pickLocation() async {
    final result = await Navigator.of(
      AppRouter.appContext!,
    ).push<LocationModel>(
      MaterialPageRoute(
        builder: (context) => const LocationPickerScreen(),
      ),
    );

    if (result != null) {
      setSelectedLocation(result);
    }
  }

  void setSelectedLocation(LocationModel location) {
    emit(state.copyWith(selectedLocation: location));
  }

  void clearSelectedLocation() {
    emit(state.copyWith());
  }

  void setIsSearching(bool value) {
    emit(state.copyWith(isSearching: value));
  }

  void setLevels(List<String> levels) {
    emit(state.copyWith(levels: levels));
  }

  void addLevel(String level) {
    emit(state.copyWith(levels: [...state.levels, level]));
  }

  void removeLevel(String level) {
    emit(
      state.copyWith(
        levels: state.levels.where((e) => e != level).toList(),
      ),
    );
  }
}
