import 'package:booking_smt_test/model/flight.dart';
import 'package:booking_smt_test/pages/flights_page.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class FlightDetails extends StatefulWidget {
  FlightDetails({Key key, @required this.flight}) : super(key: key);

  final Flight flight;

  @override
  _FlightDetailsState createState() => _FlightDetailsState();
}

class _FlightDetailsState extends State<FlightDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        elevation: 20,
        child: Icon(Icons.flight),
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
                  right: 16,
                  left: 16,
                  top: 50,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () => Navigator.pop(context),
                        child: Icon(
                          Icons.arrow_back_ios_outlined,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        '${widget.flight.cityFrom} to ${widget.flight.cityTo}',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Positioned.fill(
            top: 100,
            left: 16,
            right: 16,
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 400,
                    height: 300,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: FadeInImage.assetNetwork(
                          placeholder: 'assets/images/logo.png',
                          fit: BoxFit.cover,
                          image:
                              'https://images.kiwi.com/airlines/128x128/${widget.flight.airlines[0]}.png',
                        ).image,
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                  Text(
                    DateFormat('EEEE MMM,DD').format(
                        DateTime.fromMillisecondsSinceEpoch(
                            widget.flight.dTime)),
                    style: TextStyle(
                      color: Colors.blueGrey,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                    textAlign: TextAlign.start,
                  ),
                  SizedBox(height: 8),
                  TicketWidget(widget.flight),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
