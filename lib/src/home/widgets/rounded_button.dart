import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  final String text;
  final Color color, textColor;
  final VoidCallback press;
  const RoundedButton({
    super.key,
    required this.text,
    required this.color,
    required this.textColor,
    required this.press,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      width: size.width * 0.8,
        child: ElevatedButton(
          onPressed: press,
          style: ElevatedButton.styleFrom(
            padding:const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
            backgroundColor: color,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          ),
          child: Text(
            text,
            style: TextStyle(
                color: textColor, fontWeight: FontWeight.bold, fontSize: 22),
          ),
        ),
      
    );
  }
}
