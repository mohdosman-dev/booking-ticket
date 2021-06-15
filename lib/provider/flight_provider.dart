import 'package:booking_smt_test/model/flight.dart';
import 'package:booking_smt_test/repositories/flight_repository.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';

class FlightProvider with ChangeNotifier {
  FlightProvider._();
  FlightProvider();
  List<Flight> _flights = [];
  List<Flight> get flights => this._flights;

  bool _isLoading = false;
  bool get isLoading => this._isLoading;

  String _errorMsg = '';
  String get errorMsg => this._errorMsg;

  final _repo = FlightReposiroty();

  factory FlightProvider.of(BuildContext context, {bool listen = false}) {
    return Provider.of<FlightProvider>(context, listen: listen);
  }

  factory FlightProvider.instance() => GetIt.instance<FlightProvider>();

  static Future<FlightProvider> init() async {
    return FlightProvider._();
  }

  void getFlights(String iataFrom) async {
    this._isLoading = true;
    await Future.delayed(Duration(milliseconds: 100));
    this.notifyListeners();
    try {
      this._flights = await _repo.getAllFlights(iataFrom: iataFrom);
      this._isLoading = false;
      this.notifyListeners();
    } catch (e) {
      this._errorMsg = e;
    }
    this._isLoading = false;
    this.notifyListeners();
  }

  void search() async {}
}
