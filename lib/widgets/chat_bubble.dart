import 'package:chat_app/constants.dart';
import 'package:chat_app/models/message_model.dart';
import 'package:flutter/material.dart';

class ChatBubble extends StatelessWidget {
  const ChatBubble({
    super.key,
    required this.message,
  });


  final MessageModel message;

  
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        margin: EdgeInsets.all(20),
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: kPrimaryColor.shade700,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
            bottomRight: Radius.circular(20),
          ),
        ),
        child: Text(
          message.messageInFirebase,
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
      ),
    );
  }
}




class ChatBubbleForMyFriend extends StatelessWidget {
  const ChatBubbleForMyFriend({
    super.key,
    required this.message,
  });


  final MessageModel message;

  
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        margin: EdgeInsets.all(20),
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: kPrimaryColor.shade300,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
            bottomLeft: Radius.circular(20),
          ),
        ),
        child: Text(
          message.messageInFirebase,
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
      ),
    );
  }
}
