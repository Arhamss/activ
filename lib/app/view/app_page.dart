import 'package:activ/app/view/app_view.dart';
import 'package:activ/core/locale/cubit/locale_cubit.dart';
import 'package:activ/features/home/data/home_repository_implementation.dart';
import 'package:activ/features/home/presentation/cubit/cubit.dart';
import 'package:activ/features/onboarding_flow/data/repositories/onboarding_flow_repository_impl.dart';
import 'package:activ/features/onboarding_flow/presentation/cubit/cubit.dart';
import 'package:activ/utils/widgets/core_widgets/phone_textfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => LocaleCubit()),
        BlocProvider(
          create: (context) => HomeCubit(
            repository: HomeRepositoryImplementation(),
          ),
        ),
        BlocProvider(
          create: (context) => OnboardingFlowCubit(
            repository: OnboardingFlowRepositoryImpl(),
          ),
        ),
        BlocProvider(
          create: (context) => PhoneFieldCubit(),
        ),
      ],
      child: const AppView(),
    );
  }
}
