import 'dart:developer';

import 'package:booking_smt_test/model/flight.dart';
import 'package:booking_smt_test/repositories/api_provider.dart';

class FlightReposiroty {
  ApiProvider _provider = ApiProvider();

  Future<List<Flight>> getAllFlights(
      {String iataFrom = 'JED',
      String iataTo = '',
      String dateFrom = '',
      String dateTo = ''}) async {
    Map<String, dynamic> response = await _provider
        .getHTTP('flights?flyFrom=$iataFrom&to=$iataTo&limit=50&asc=0');
    return (response['data'] as List).map((e) => Flight.fromJson(e)).toList();
  }

  Future<List<Flight>> search(Map<String, dynamic> query) async {
    Map<String, dynamic> response =
        await _provider.getHTTP('flights?limit=50&asc=0', body: query);
    return (response['data'] as List).map((e) => Flight.fromJson(e)).toList();
  }
}
