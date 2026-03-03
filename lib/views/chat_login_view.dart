import 'package:chat_app/constants.dart';
import 'package:chat_app/widgets/login_body.dart';
import 'package:flutter/material.dart';

class ChatLoginView extends StatelessWidget {
  const ChatLoginView({super.key});

  static const String id = "chat_login_view";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor.shade800,
      body: LoginBody(),
    );
  }
}
