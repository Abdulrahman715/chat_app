import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String objOfText;
  final VoidCallback? onPressed;

  const CustomButton({super.key, required this.objOfText, this.onPressed});

  
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.blueGrey.shade900,
        padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      ),
      child: Text(
        objOfText,
        style: TextStyle(
          fontSize: 18,
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontFamily: "SourceCodePro",
        ),
      ),
    );
  }
}
