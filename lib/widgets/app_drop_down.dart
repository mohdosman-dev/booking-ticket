import 'package:flutter/material.dart';

class AppDropdown extends StatefulWidget {
  final String label;
  final List labels;
  final String displayLabel;
  final Function(dynamic data) onChange;
  final String selectedId;
  final String selectedKey;
  final IconData icon;
  final Color backgroundColor;
  final Widget prefix;

  AppDropdown({
    Key key,
    this.icon = Icons.arrow_drop_down,
    @required this.onChange,
    @required this.labels,
    this.label,
    this.selectedId = "0",
    this.selectedKey = "id",
    @required this.displayLabel,
    this.backgroundColor,
    this.prefix,
  }) : super(key: key);

  @override
  _AppDropdownState createState() => _AppDropdownState();
}

class _AppDropdownState extends State<AppDropdown> {
  var dropdownValue;

  @override
  void initState() {
    if (widget.labels.isNotEmpty) {
      dropdownValue = widget.labels[0];
      for (int i = 0; i < widget.labels.length; i++) {
        if (widget.labels[i][widget.selectedKey].toString() ==
            widget.selectedId.toString()) {
          dropdownValue = widget.labels[i];
        }
      }
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.labels.isEmpty) {
      return Container();
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        widget.label != null
            ? Padding(
                padding: const EdgeInsets.only(top: 8, bottom: 4),
                child: Text(
                  widget.label,
                  textAlign: TextAlign.start,
                  style: TextStyle(color: Colors.grey, fontSize: 14),
                ),
              )
            : Container(),
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: widget.backgroundColor ?? Colors.grey.shade100,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Row(
            children: [
              widget.prefix ?? Container(),
              SizedBox(
                width: 8,
              ),
              Expanded(
                child: DropdownButton<dynamic>(
                  icon: Icon(widget.icon),
                  value: dropdownValue,
                  isExpanded: true,
                  underline: Container(),
                  onChanged: (dynamic newValue) {
                    setState(() {
                      dropdownValue = newValue;
                    });
                    widget.onChange(newValue);
                  },
                  items: widget.labels
                      .map<DropdownMenuItem<dynamic>>((dynamic value) {
                    return DropdownMenuItem<dynamic>(
                      value: value,
                      child: Row(
                        children: [
                          value["icon"] != null ? value["icon"] : Container(),
                          value["icon"] != null
                              ? SizedBox(
                                  width: 12,
                                )
                              : Container(),
                          Expanded(child: Text(value[widget.displayLabel])),
                        ],
                      ),
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
