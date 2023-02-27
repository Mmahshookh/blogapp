import 'package:flutter/material.dart';

class RoundButton extends StatelessWidget {

  final String title;
  final VoidCallback onPress;
  const RoundButton({Key? key, required this.title, required this.onPress}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(10),
      clipBehavior: Clip.antiAlias,
      child: MaterialButton(
        color: Colors.cyan,
        height: 50,
        minWidth: double.minPositive,
        child: Text(title,style: TextStyle(
          color: Colors.white
        ),),
        onPressed: onPress,
      ),
    );
  }
}
