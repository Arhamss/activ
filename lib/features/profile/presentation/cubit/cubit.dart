import 'package:activ/exports.dart';
import 'package:activ/features/profile/domain/profile_repository.dart';
import 'package:activ/features/profile/presentation/cubit/state.dart';
import 'package:activ/utils/helpers/data_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit({required this.repository}) : super(const ProfileState());

  final ProfileRepository repository;

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
