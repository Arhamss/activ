import 'package:activ/core/locale/cubit/locale_cubit.dart';
import 'package:activ/exports.dart';
import 'package:activ/go_router/exports.dart';
import 'package:activ/l10n/l10n.dart';
import 'package:activ/l10n/localization_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:toastification/toastification.dart';

class AppView extends StatelessWidget {
  const AppView({super.key});

  @override
  Widget build(BuildContext context) {
    return Phoenix(
      child: BlocProvider(
        create: (context) => LocaleCubit(context: context),
        child: BlocBuilder<LocaleCubit, LocaleState>(
          builder: (context, state) {
            Localization.init(context);
            return ToastificationWrapper(
              child: MaterialApp.router(
                routerConfig: AppRouter.router,
                theme: ThemeData(
                  appBarTheme: const AppBarTheme(
                    backgroundColor: Colors.transparent,
                    elevation: 0,
                  ),
                  useMaterial3: true,
                ),
                locale: state.locale,
                localizationsDelegates: AppLocalizations.localizationsDelegates,
                supportedLocales: AppLocalizations.supportedLocales,
                debugShowCheckedModeBanner: false,
              ),
            );
          },
        ),
      ),
    );
  }
}
