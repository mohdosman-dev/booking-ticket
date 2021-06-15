import 'package:booking_smt_test/pages/splash_page.dart';
import 'package:booking_smt_test/provider/flight_provider.dart';
import 'package:booking_smt_test/utils/constants.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';

class Application extends StatelessWidget {
  // This widget is the root of your application.

  final _flighBloc = GetIt.instance<FlightProvider>();
  @override
  void dispose() {
    _flighBloc.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<FlightProvider>.value(value: FlightProvider())
      ],
      builder: (_, child) {
        return MaterialApp(
          title: 'Booking SMT',
          theme: ThemeData(
            primaryColor: kPrimaryColor,
            primaryColorLight: kPrimaryColorLight,
            primaryColorDark: kPrimaryColorDark,
          ),
          debugShowCheckedModeBanner: false,
          // locale: context.locale,
          // supportedLocales: context.supportedLocales,
          // localizationsDelegates: context.localizationDelegates,
          home: SplashPage(),
        );
      },
    );
  }
}
