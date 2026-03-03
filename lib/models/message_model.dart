import 'package:chat_app/constants.dart';

class MessageModel {
  final String messageInFirebase;
  final String senderEmail;

  MessageModel({
    required this.messageInFirebase,
    required this.senderEmail,
  });

  factory MessageModel.fromJson(json) {
    return MessageModel(
      // تأكد أن الأسماء 'text' و kSenderEmailFieldName مطابقة تماماً للي في Firebase
      messageInFirebase: json[kMessageFieldName] ?? 'No message content', 
      senderEmail: json[kSenderEmailFieldName] ?? 'Unknown Sender', // إضافة القيمة الافتراضية
    );
  }
}