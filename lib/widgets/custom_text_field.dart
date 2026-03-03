import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CustomTextField extends StatelessWidget {
  CustomTextField({
    super.key,
    required this.controller,
    required this.labelText,
    required this.hintText, required this.iconDescription,
    this.obscureText = false, 
  });

  final TextEditingController controller;
  final String labelText;
  final String hintText;
  final IconData iconDescription;
  bool? obscureText ;

  @override
  Widget build(BuildContext context) {
    return TextFormField(

      obscureText: obscureText!,


      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your $labelText';
        }
        return null;
      },
      controller: controller,
      style: TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold,
        fontFamily: "Pacifico",
      ),
      decoration: InputDecoration(
        label: Text(
          labelText,
          style: TextStyle(
            color: Colors.white70,
            fontWeight: FontWeight.bold,
            fontFamily: "SourceCodePro",
          ),
        ),
        hintText: hintText,
        hintStyle: TextStyle(
          color: Colors.white54,
          fontWeight: FontWeight.bold,
        ),
        prefixIcon: Icon(iconDescription , color: Colors.white70),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
      ),
    );
  }
}

// Icons.lock_outline,

// final String label;
//   final TextEditingController controller;
//   final bool obscureText;

//   const CustomTextField({
//     Key? key,
//     required this.label,
//     required this.controller,
//     this.obscureText = false,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return TextField(
//       controller: controller,
//       obscureText: obscureText,
//       decoration: InputDecoration(
//         labelText: label,
//         border: OutlineInputBorder(),
//       ),
//     );
//   }
