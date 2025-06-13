import 'package:activ/core/locale/cubit/locale_cubit.dart';
import 'package:activ/exports.dart';
import 'package:activ/go_router/exports.dart';
import 'package:activ/l10n/arb/app_localizations.dart';
import 'package:activ/l10n/l10n.dart';
import 'package:activ/l10n/localization_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';
import 'package:toastification/toastification.dart';

class AppView extends StatelessWidget {
  AppView({super.key});

  late final client = StreamChatClient(
    'xuumnwwzkpnh',
    logLevel: Level.OFF,
  );

  @override
  Widget build(BuildContext context) {
    return Phoenix(
      child: BlocProvider(
        create: (context) => LocaleCubit(context: context),
        child: BlocBuilder<LocaleCubit, LocaleState>(
          builder: (context, state) {
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
                builder: (context, child) {
                  Localization.init(context);
                  return StreamChat(
                    client: client,
                    streamChatThemeData: StreamChatThemeData(
                      messageListViewTheme:
                          const StreamMessageListViewThemeData(
                        backgroundColor: AppColors.darkWhiteBackground,
                      ),
                      messageInputTheme: StreamMessageInputThemeData(
                      
                        inputTextStyle: context.b1.copyWith(
                          color: AppColors.chatText,
                        ),
                        borderRadius: BorderRadius.circular(15),
                        inputBackgroundColor: AppColors.white,
                        inputDecoration: InputDecoration(
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 12,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: const BorderSide(
                              color: AppColors.chatTimeText,
                            ),
                          ),
                        ),
                      ),
                    ),
                    child: child,
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
