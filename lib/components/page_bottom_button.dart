import 'package:flutter/material.dart';
import '../constants.dart';

class PageBottomButton extends StatelessWidget {
  final VoidCallback onPress;
  final String label;

  PageBottomButton({required this.label, required this.onPress});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      child: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.only(bottom: 20.0),
        color: kBottomContainerColor,
        margin: EdgeInsets.only(top: 15),
        width: double.infinity,
        height: kBottomContainerHeight,
        child: Text(
          label,
          style: kLargeButtonTextStyle,
        ),
      ),
    );
  }
}
