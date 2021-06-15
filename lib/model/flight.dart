// To parse this JSON data, do
//
//     final flight = flightFromJson(jsonString);

import 'dart:convert';

Flight flightFromJson(String str) => Flight.fromJson(json.decode(str));

String flightToJson(Flight data) => json.encode(data.toJson());

class Flight {
  Flight({
    this.id,
    this.flyFrom,
    this.flyTo,
    this.cityFrom,
    this.cityCodeFrom,
    this.cityTo,
    this.cityCodeTo,
    this.dTime,
    this.aTime,
    this.typeFlights,
    this.distance,
    this.flyDuration,
    this.price,
    this.availability,
    this.airlines,
    this.route,
  });

  final String id;
  final String flyFrom;
  final String flyTo;
  final String cityFrom;
  final String cityCodeFrom;
  final String cityTo;
  final String cityCodeTo;
  final int dTime;
  final int aTime;
  final List<String> typeFlights;
  final double distance;
  final String flyDuration;
  final int price;
  final Availability availability;
  final List<String> airlines;
  final List<Route> route;

  factory Flight.fromJson(Map<String, dynamic> json) => Flight(
        id: json["id"] == null ? null : json["id"],
        flyFrom: json["flyFrom"] == null ? null : json["flyFrom"],
        flyTo: json["flyTo"] == null ? null : json["flyTo"],
        cityFrom: json["cityFrom"] == null ? null : json["cityFrom"],
        cityCodeFrom:
            json["cityCodeFrom"] == null ? null : json["cityCodeFrom"],
        cityTo: json["cityTo"] == null ? null : json["cityTo"],
        cityCodeTo: json["cityCodeTo"] == null ? null : json["cityCodeTo"],
        dTime: json["dTime"] == null ? null : json["dTime"],
        aTime: json["aTime"] == null ? null : json["aTime"],
        typeFlights: json["type_flights"] == null
            ? null
            : List<String>.from(json["type_flights"].map((x) => x)),
        distance: json["distance"] == null ? null : json["distance"].toDouble(),
        flyDuration: json["fly_duration"] == null ? null : json["fly_duration"],
        price: json["price"] == null ? null : json["price"],
        availability: json["availability"] == null
            ? null
            : Availability.fromJson(json["availability"]),
        airlines: json["airlines"] == null
            ? null
            : List<String>.from(json["airlines"].map((x) => x)),
        route: json["route"] == null
            ? null
            : List<Route>.from(json["route"].map((x) => Route.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "flyFrom": flyFrom == null ? null : flyFrom,
        "flyTo": flyTo == null ? null : flyTo,
        "cityFrom": cityFrom == null ? null : cityFrom,
        "cityCodeFrom": cityCodeFrom == null ? null : cityCodeFrom,
        "cityTo": cityTo == null ? null : cityTo,
        "cityCodeTo": cityCodeTo == null ? null : cityCodeTo,
        "dTime": dTime == null ? null : dTime,
        "aTime": aTime == null ? null : aTime,
        "type_flights": typeFlights == null
            ? null
            : List<dynamic>.from(typeFlights.map((x) => x)),
        "distance": distance == null ? null : distance,
        "fly_duration": flyDuration == null ? null : flyDuration,
        "price": price == null ? null : price,
        "availability": availability == null ? null : availability.toJson(),
        "airlines": airlines == null
            ? null
            : List<dynamic>.from(airlines.map((x) => x)),
        "route": route == null
            ? null
            : List<dynamic>.from(route.map((x) => x.toJson())),
      };
}

class Availability {
  Availability({
    this.seats,
  });

  final int seats;

  factory Availability.fromJson(Map<String, dynamic> json) => Availability(
        seats: json["seats"] == null ? null : json["seats"],
      );

  Map<String, dynamic> toJson() => {
        "seats": seats == null ? null : seats,
      };
}

class Route {
  Route({
    this.id,
    this.flightNo,
    this.operatingCarrier,
  });

  final String id;
  final int flightNo;
  final String operatingCarrier;

  factory Route.fromJson(Map<String, dynamic> json) => Route(
        id: json["id"] == null ? null : json["id"],
        flightNo: json["flight_no"] == null ? null : json["flight_no"],
        operatingCarrier: json["operating_carrier"] == null
            ? null
            : json["operating_carrier"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "flight_no": flightNo == null ? null : flightNo,
        "operating_carrier": operatingCarrier == null ? null : operatingCarrier,
      };
}
