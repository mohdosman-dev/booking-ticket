import 'package:flutter/material.dart';

class AppBadge extends StatelessWidget {
  const AppBadge({Key key, this.backgroundColor, this.text, this.textColor})
      : super(key: key);

  final Color backgroundColor;
  final String text;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      decoration: BoxDecoration(
        color: backgroundColor ?? Theme.of(context).primaryColorLight,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: textColor ?? Theme.of(context).primaryColor,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
