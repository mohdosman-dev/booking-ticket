import 'package:booking_smt_test/model/flight.dart';
import 'package:booking_smt_test/pages/flight_details.dart';
import 'package:booking_smt_test/repositories/flight_repository.dart';
import 'package:booking_smt_test/widgets/app_badge.dart';
import 'package:booking_smt_test/widgets/from_to_widget.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:fw_ticket/fw_ticket.dart';

class FlightsPage extends StatefulWidget {
  FlightsPage({Key key, @required this.flight}) : super(key: key);

  final Flight flight;

  @override
  _FlightsPageState createState() => _FlightsPageState();
}

class _FlightsPageState extends State<FlightsPage> {
  Future<List<Flight>> _flights;
  final _repo = FlightReposiroty();

  @override
  void initState() {
    super.initState();
    loadDate();
  }

  void loadDate() async {
    this._flights = _repo.getAllFlights(
      iataFrom: widget.flight.cityCodeFrom,
      iataTo: widget.flight.cityCodeTo,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
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
              child: FutureBuilder<List<Flight>>(
                future: this._flights,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  if (snapshot.hasError) {
                    return Center(
                      child: Text('Error'),
                    );
                  }
                  if (snapshot.hasData) {
                    final flights = snapshot.data;
                    return ListView.separated(
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(
                              builder: (context) {
                                return FlightDetails(flight: flights[index]);
                              },
                            ));
                          },
                          child: TicketWidget(flights[index]),
                        );
                      },
                      separatorBuilder: (context, index) => SizedBox(height: 8),
                      itemCount: flights.length,
                    );
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class TicketWidget extends StatelessWidget {
  const TicketWidget(
    this.flight, {
    Key key,
  }) : super(key: key);

  final Flight flight;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Ticket(
          innerRadius: BorderRadius.only(
              bottomLeft: Radius.circular(16.0),
              bottomRight: Radius.circular(16.0)),
          dashedBottom: false,
          outerRadius: new BorderRadius.circular(0),
          child: Container(
            constraints: BoxConstraints(minHeight: 200),
            padding: const EdgeInsets.all(16),
            height: 200,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              children: [
                RotatedBox(
                  quarterTurns: 1,
                  child: FromToWidget(),
                ),
                SizedBox(width: 8),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildColumn(
                        'From',
                        DateTime.fromMillisecondsSinceEpoch(flight.dTime),
                        flight.cityCodeFrom,
                      ),
                      _buildColumn(
                        'To',
                        DateTime.fromMillisecondsSinceEpoch(flight.dTime),
                        flight.cityCodeTo,
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 8),
                Container(
                  alignment: Alignment.topCenter,
                  child: AppBadge(
                    text: flight.airlines[0],
                    textColor: Theme.of(context).primaryColor,
                    backgroundColor:
                        Theme.of(context).primaryColorLight.withOpacity(.5),
                  ),
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: DottedLine(
            direction: Axis.horizontal,
            lineThickness: 1.0,
            dashLength: 4.0,
            dashColor: Colors.grey.shade400,
            dashRadius: 0.0,
            dashGapLength: 8.0,
            dashGapColor: Colors.transparent,
            dashGapRadius: 0.0,
          ),
        ),
        Ticket(
          innerRadius: BorderRadius.only(
              topLeft: Radius.circular(16.0), topRight: Radius.circular(16.0)),
          dashedBottom: true,
          outerRadius: new BorderRadius.circular(0),
          child: Container(
            padding: const EdgeInsets.all(16),
            constraints: BoxConstraints(
              minHeight: 60,
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    RotatedBox(
                      quarterTurns: 1,
                      child: Icon(
                        Icons.flight,
                        color: Colors.grey.shade400,
                        size: 24,
                      ),
                    ),
                    SizedBox(width: 8),
                    Text(
                      '${flight.route[0].flightNo}',
                      style: TextStyle(
                        color: Colors.grey.shade400,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
                AppBadge(
                  text: '${flight.typeFlights[0]}'.toUpperCase(),
                  textColor: Colors.grey,
                  backgroundColor: Colors.grey.shade200,
                ),
                Text(
                  '${flight.flyDuration}',
                  style: TextStyle(
                    color: Colors.grey.shade400,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildColumn(String label, DateTime dateTime, String iata,
      [bool start = true]) {
    return Column(
      crossAxisAlignment:
          start ? CrossAxisAlignment.start : CrossAxisAlignment.end,
      children: [
        Text(
          label.toUpperCase(),
          style: TextStyle(
            color: Colors.blueGrey,
            fontSize: 12,
          ),
        ),
        SizedBox(height: 6),
        Text(
          iata.toUpperCase(),
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.bold,
            letterSpacing: 2,
          ),
        ),
        SizedBox(height: 6),
        Row(
          children: [
            Text(
              DateFormat('MMM,dd hh:mm a').format(dateTime).toUpperCase(),
              style: TextStyle(
                color: Colors.blueGrey,
                fontSize: 12,
              ),
            ),
            SizedBox(width: 16),
            Row(
              children: [],
            ),
          ],
        ),
      ],
    );
  }
}
