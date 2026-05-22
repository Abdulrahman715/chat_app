import 'package:chat_app/models/message_model.dart';

abstract class ChatStates {}

class ChatInitialState extends ChatStates {}

class ChatSendMessageSuccessState extends ChatStates {
  final List<MessageModel> messagesList;

  ChatSendMessageSuccessState(this.messagesList);
}

class ChatSendMessageErrorState extends ChatStates {
  final String error;

  ChatSendMessageErrorState(this.error);
}