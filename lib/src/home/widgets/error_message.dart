import 'package:flutter/material.dart';

class ErrorMessage extends StatelessWidget {
  final String errorMessage;
  const ErrorMessage({super.key, required this.errorMessage});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
        margin: const EdgeInsets.symmetric(vertical: 5),
        padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
        width: size.width * 0.8,
        child: Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Row(
            children: [
              const Icon(Icons.error_outline_rounded, color: Colors.red),
              const SizedBox(width: 4),
              Text(errorMessage,style:const TextStyle(color: Colors.red),),

            ],
          ),
        ));
  }
}
