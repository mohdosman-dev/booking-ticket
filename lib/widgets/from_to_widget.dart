import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';

class FromToWidget extends StatelessWidget {
  const FromToWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          Icon(
            Icons.circle,
            color: Colors.grey,
            size: 16,
          ),
          SizedBox(width: 2),
          Expanded(
            child: DottedLine(
              direction: Axis.horizontal,
              lineThickness: 1.0,
              dashLength: 4.0,
              dashColor: Colors.grey,
              dashRadius: 0.0,
              dashGapLength: 8.0,
              dashGapColor: Colors.transparent,
              dashGapRadius: 0.0,
            ),
          ),
          SizedBox(width: 2),
          RotatedBox(
            quarterTurns: 1,
            child: Icon(
              Icons.flight,
              color: Colors.grey,
              size: 24,
            ),
          ),
          SizedBox(width: 2),
          Expanded(
            child: DottedLine(
              direction: Axis.horizontal,
              lineThickness: 1.0,
              dashLength: 4.0,
              dashColor: Colors.grey,
              dashRadius: 0.0,
              dashGapLength: 8.0,
              dashGapColor: Colors.transparent,
              dashGapRadius: 0.0,
            ),
          ),
          SizedBox(width: 2),
          Container(
            width: 12,
            height: 12,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              border: Border.all(
                color: Colors.grey,
                style: BorderStyle.solid,
                width: 2,
              ),
            ),
          )
        ],
      ),
    );
  }
}
