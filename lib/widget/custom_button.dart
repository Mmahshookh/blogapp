import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String title;
  final Function function;
  const CustomButton({
    required this.function, required this.title,Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => function(),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(5),
        ),
        child: Text(
          title,
          style: TextStyle(
            fontSize: 18,
            color: Colors.black,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}

