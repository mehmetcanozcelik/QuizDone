import 'package:flutter/material.dart';
import 'package:quizdone/constants.dart';

class OptionCard extends StatelessWidget {
  const OptionCard(
      {Key? key,
      required this.option,
      required this.color,
      required this.onTap})
      : super(key: key);
  final String option;
  final VoidCallback onTap;
  final Color color;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        color: color,
        child: ListTile(
          title: Center(
            child: Text(
              option,
              style: TextStyle(
                  fontSize: 22.0,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    );
  }
}
