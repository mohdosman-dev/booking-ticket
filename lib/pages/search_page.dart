import 'dart:developer';

import 'package:booking_smt_test/utils/constants.dart';
import 'package:booking_smt_test/widgets/app_button.dart';
import 'package:booking_smt_test/widgets/app_drop_down.dart';
import 'package:booking_smt_test/widgets/app_text_field.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  SearchPage({Key key}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  Map<String, dynamic> query = {};

  TextEditingController _fromController = TextEditingController();
  TextEditingController _toController = TextEditingController();

  double start = 50;
  double end = 250;

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
                        'Search',
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
            left: 16,
            right: 16,
            top: 100,
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppDropdown(
                    displayLabel: "name",
                    selectedKey: "iata",
                    labels: iataList,
                    backgroundColor: Colors.grey.shade100,
                    label: 'Flight from',
                    onChange: (data) {
                      log('Data: $data');
                      query['fly_from'] = data['iata'];
                    },
                  ),
                  SizedBox(height: 16),
                  AppDropdown(
                    displayLabel: "name",
                    selectedKey: "iata",
                    labels: iataList,
                    backgroundColor: Colors.grey.shade100,
                    label: 'Flight to',
                    onChange: (data) {
                      log('Data: $data');
                      query['fly_to'] = data['iata'];
                    },
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Select departure date',
                    textAlign: TextAlign.start,
                    style: TextStyle(color: Colors.grey, fontSize: 14),
                  ),
                  SizedBox(height: 16),
                  Row(
                    children: [
                      Flexible(
                        child: AppTextField(
                          controller: _fromController,
                          readOnly: true,
                          hintText: 'From date',
                          backgroundColor: Colors.grey.shade100,
                          onTap: () async {
                            DateTimeRange range = await showDateRangePicker(
                              context: context,
                              firstDate: DateTime.now(),
                              lastDate: DateTime(DateTime.now().year + 5),
                            );
                            log('Range(${range.start} - ${range.end})');
                            setState(() {
                              String formattedStartDate =
                                  DateFormat('dd/MM/yyyy').format(range.start);
                              String formattedEndDate =
                                  DateFormat('dd/MM/yyyy').format(range.end);
                              _fromController.text = formattedStartDate;
                              query['date_from'] = formattedStartDate;
                              _toController.text = formattedEndDate;
                              query['date_to'] = formattedEndDate;
                            });
                          },
                        ),
                      ),
                      SizedBox(width: 8),
                      Flexible(
                        child: AppTextField(
                          controller: _toController,
                          readOnly: true,
                          hintText: 'To date',
                          backgroundColor: Colors.grey.shade100,
                          onTap: () async {
                            DateTimeRange range = await showDateRangePicker(
                              context: context,
                              firstDate: DateTime.now(),
                              lastDate: DateTime(DateTime.now().year + 5),
                            );
                            log('Range(${range.start} - ${range.end})');
                            setState(() {
                              String formattedStartDate =
                                  DateFormat('dd/MM/yyyy').format(range.start);
                              String formattedEndDate =
                                  DateFormat('dd/MM/yyyy').format(range.end);
                              _fromController.text = formattedStartDate;
                              query['date_from'] = formattedStartDate;
                              _toController.text = formattedEndDate;
                              query['date_to'] = formattedEndDate;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Select price range',
                    textAlign: TextAlign.start,
                    style: TextStyle(color: Colors.grey, fontSize: 14),
                  ),
                  SizedBox(height: 16),
                  Row(
                    children: [
                      Text(
                        '50 \$',
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 16,
                        ),
                      ),
                      Flexible(
                        child: RangeSlider(
                          values: RangeValues(start, end),
                          onChanged: (value) {
                            setState(() {
                              start = value.start;
                              end = value.end;

                              query['price_from'] = start.toInt();
                              query['price_to'] = end.toInt();
                            });
                          },
                          max: 250,
                          min: 50,
                          divisions: 10,
                          labels: RangeLabels("$start \$", "$end \$"),
                        ),
                      ),
                      Text(
                        '250 \$',
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 30),
                  AppButton(
                    label: 'Submit',
                    onTap: () {
                      Navigator.pop(context, query);
                    },
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
