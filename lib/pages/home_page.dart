import 'dart:developer';

import 'package:booking_smt_test/model/flight.dart';
import 'package:booking_smt_test/pages/flights_page.dart';
import 'package:booking_smt_test/pages/search_page.dart';
import 'package:booking_smt_test/provider/flight_provider.dart';
import 'package:booking_smt_test/repositories/flight_repository.dart';
import 'package:booking_smt_test/utils/constants.dart';
import 'package:booking_smt_test/widgets/app_text_field.dart';
import 'package:booking_smt_test/widgets/from_to_widget.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<List<Flight>> _flights;
  FlightReposiroty _reposiroty = FlightReposiroty();

  FlightProvider _provider;
  @override
  void initState() {
    super.initState();
    _provider = FlightProvider.of(context);
    _provider.getFlights(iataList[0]['iata']);
    loadDate();
  }

  void loadDate() async {
    this._flights = _reposiroty.getAllFlights(iataFrom: iataList[0]['iata']);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        elevation: 20,
        child: Icon(Icons.add),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: Stack(
        children: [
          Positioned(
            right: 0,
            top: 0,
            left: 0,
            child: Stack(
              children: [
                Container(
                  height: 300,
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                Positioned(
                  // alignment: Alignment.topCenter,
                  right: 20,
                  left: 20,
                  top: -40,
                  child: Image.asset(
                    'assets/images/airplane.png',
                    scale: 2,
                  ),
                ),
                Container(
                  height: 300,
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor.withOpacity(.7),
                  ),
                ),
                Positioned(
                  right: 16,
                  left: 16,
                  top: 50,
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Flights',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Icon(
                            Icons.settings,
                            color: Colors.white,
                          ),
                        ],
                      ),
                      SizedBox(height: 30),
                      AppTextField(
                        readOnly: true,
                        hintText: 'Search',
                        onTap: () async {
                          log('Move to search page');
                          Map<String, dynamic> searchFilter =
                              await Navigator.push(context, MaterialPageRoute(
                            builder: (context) {
                              return SearchPage();
                            },
                          ));

                          if (searchFilter != null) {
                            setState(() {
                              this._flights = _reposiroty.search(searchFilter);
                            });
                          }
                        },
                        prefix: Icon(
                          Icons.search,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Positioned.fill(
            right: 16,
            left: 16,
            top: 180,
            child: Container(
              child: FutureBuilder<List<Flight>>(
                  future: this._flights,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }

                    if (snapshot.hasError) {
                      return Container(
                        child: Text('Error'),
                      );
                    }

                    if (snapshot.hasData) {
                      List<Flight> flights = snapshot.data;
                      return ListView.separated(
                        shrinkWrap: true,
                        itemCount: flights.length,
                        itemBuilder: (context, index) {
                          Flight flight = flights[index];
                          return _buildFlightCard(flight);
                        },
                        separatorBuilder: (BuildContext context, int index) {
                          return SizedBox(
                            height: 8,
                          );
                        },
                      );
                    }
                    return Container();
                  }),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFlightCard(Flight flight) {
    return InkWell(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(
          builder: (context) {
            return FlightsPage(
              flight: flight,
            );
          },
        ));
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'From ${flight.cityFrom} TO ${flight.cityTo}'.toUpperCase(),
              style: TextStyle(
                color: Colors.black,
              ),
            ),
            SizedBox(height: 16),
            Row(
              children: [
                _buildColumn(
                  DateFormat('MMM, DD').format(
                      DateTime.fromMillisecondsSinceEpoch(flight.dTime)),
                  DateFormat('hh:mm a').format(
                      DateTime.fromMillisecondsSinceEpoch(flight.dTime)),
                  flight.cityCodeFrom,
                ),
                Expanded(
                  child: FromToWidget(),
                ),
                _buildColumn(
                  DateFormat('MMM, DD').format(
                      DateTime.fromMillisecondsSinceEpoch(flight.aTime)),
                  DateFormat('hh:mm a').format(
                      DateTime.fromMillisecondsSinceEpoch(flight.aTime)),
                  flight.cityCodeTo,
                  false,
                ),
              ],
            ),
            SizedBox(height: 16),
            Container(
              alignment: Alignment.bottomCenter,
              child: Text(
                flight.flyDuration,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: Colors.blueGrey,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildColumn(String date, String time, String text,
      [bool start = true]) {
    return Column(
      crossAxisAlignment:
          start ? CrossAxisAlignment.start : CrossAxisAlignment.end,
      children: [
        Text(
          date.toUpperCase(),
          style: TextStyle(
            color: Colors.blueGrey,
            fontSize: 12,
          ),
        ),
        SizedBox(height: 6),
        Text(
          text.toUpperCase(),
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.bold,
            letterSpacing: 2,
          ),
        ),
        SizedBox(height: 6),
        Text(
          time.toUpperCase(),
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
