import 'package:chat_app/constants.dart';
import 'package:chat_app/widgets/register_body.dart';
import 'package:flutter/material.dart';

class ChatRegisterView extends StatelessWidget {
  const ChatRegisterView({super.key});


  //! use static make it easier to connect the variable with the class directly without the need to create an instance of the class. This is particularly useful for navigation purposes, as it allows you to reference the route name directly from the class, making the code cleaner and more maintainable. By defining a static constant for the route name, you can easily manage and update your routes in one place, reducing the chances of errors and improving the overall organization of your code.
  static const  String id = "chat_register_view";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor.shade800,
      body: RegisterBody(),
    );
  }
}
