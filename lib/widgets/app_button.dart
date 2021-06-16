import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  const AppButton(
      {Key key,
      @required this.label,
      this.onTap,
      this.backgroundColor,
      this.textColor})
      : super(key: key);

  final String label;
  final VoidCallback onTap;
  final Color backgroundColor;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: onTap != null
              ? backgroundColor ?? Theme.of(context).primaryColor
              : Colors.grey,
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: textColor ?? Colors.white,
          ),
        ),
      ),
    );
  }
}
