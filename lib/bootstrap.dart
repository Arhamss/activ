import 'dart:async';
import 'dart:developer';

import 'package:activ/config/api_environment.dart';
import 'package:activ/core/di/injector.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

class AppBlocObserver extends BlocObserver {
  const AppBlocObserver();

  @override
  void onError(BlocBase<dynamic> bloc, Object error, StackTrace stackTrace) {
    log('onError(${bloc.runtimeType}, $error, $stackTrace)');
    super.onError(bloc, error, stackTrace);
  }
}

Future<void> bootstrap(FutureOr<Widget> Function() builder) async {
  FlutterError.onError = (details) {
    log(details.exceptionAsString(), stackTrace: details.stack);
  };

  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer  = const AppBlocObserver();

  MapboxOptions.setAccessToken(ApiEnvironment.current.mapboxAPIKey);

  await Injector.setup();
  runApp(await builder());
}
