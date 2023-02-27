import 'package:flutter/material.dart';

class Tile extends StatelessWidget {
  final IconData icon;
  final String title;
  final Function function;
  const Tile({
    required this.function,
    required this.title,
    required this.icon,
    Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: EdgeInsets.symmetric(vertical: 10),
      child: GestureDetector(
        onTap: () => function(),
        child: Material(
          elevation: 4,
          borderRadius: BorderRadius.circular(10),
          child: SizedBox(
            height: 60,
            width: 330,
            child: Row(
              children: [
                SizedBox(
                  width: 25,
                ),
                Icon(
                  icon,
                  size: 25,
                ),
                SizedBox(
                  width: 30,
                ),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
