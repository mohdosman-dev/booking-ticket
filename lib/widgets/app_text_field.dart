import 'package:flutter/material.dart';

class AppTextField extends StatelessWidget {
  const AppTextField({
    Key key,
    this.controller,
    this.prefix,
    this.onTap,
    this.enabled = true,
    this.readOnly = false,
    this.hintText,
    this.backgroundColor,
  }) : super(key: key);

  final TextEditingController controller;
  final Widget prefix;
  final VoidCallback onTap;
  final bool enabled;
  final bool readOnly;
  final String hintText;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: backgroundColor ?? Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          prefix != null ? prefix : Container(),
          SizedBox(width: 8),
          Flexible(
            child: TextField(
              controller: controller,
              readOnly: readOnly,
              enabled: enabled,
              onTap: onTap,
              decoration: InputDecoration.collapsed(
                hintText: hintText,
                hintStyle: TextStyle(
                  color: Colors.grey.shade400,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
