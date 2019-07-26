import 'package:flutter/material.dart';

class ChooseBoxE extends StatelessWidget {
  final bool isActive;
  final String text;
  final Function onTap;
  ChooseBoxE(this.text, {this.onTap, this.isActive = false});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ChooseBox(
        text,
        onTap: onTap,
        isActive: isActive,
      ),
    );
  }
}

class ChooseBox extends StatelessWidget {
  final bool isActive;
  final String text;
  final double height;
  final Function onTap;
  ChooseBox(this.text, {this.height = 45, this.onTap, this.isActive = false});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        alignment: Alignment(0, 0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(3)),
          color: isActive ? Colors.red : Colors.red[300],
          border: Border.all(width: 3, color: Colors.red),
        ),
        height: height,
        child: Text(
          text,
          style: TextStyle(fontSize: 22, color: Colors.white),
        ),
      ),
    );
  }
}
