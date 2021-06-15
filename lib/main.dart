import 'package:booking_smt_test/application.dart';
import 'package:booking_smt_test/provider/flight_provider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';

void main() async {
  // Needs to be called so that we can await for EasyLocalization.ensureInitialized();
  WidgetsFlutterBinding.ensureInitialized();

  await EasyLocalization.ensureInitialized();

  // init app settings
  final appSettingsBloc = await FlightProvider.init();
  GetIt.instance.registerSingleton<FlightProvider>(appSettingsBloc);

  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Color(0xFF283593),
  ));

  runApp(Application());
}
