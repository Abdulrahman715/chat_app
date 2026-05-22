import 'package:chat_app/constants.dart';
import 'package:chat_app/cubit/chat_cubit/chat_states.dart';
import 'package:chat_app/models/message_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatCubit extends Cubit<ChatStates> {
  ChatCubit() : super(ChatInitialState());

  // Create a CollectionReference called messages that references the firestore collection
  final CollectionReference messages = FirebaseFirestore.instance.collection(
    kMessagesCollectionName,
  );

  void sendMessage({required String message, required String email}) {
    messages
        .add({
          kMessageFieldName: message,
          //! مهم جداً: لازم نستخدم serverTimestamp عشان نضمن ان التوقيت هيكون متزامن مع السيرفر مش مع الجهاز
          'timestamp': FieldValue.serverTimestamp(),

          // ignore: avoid_print
          kSenderEmailFieldName:
              email, // بنضيف البريد الإلكتروني للمرسل مع كل رسالة في قاعدة البيانات
        })
        .then((value) => print("Message Added"))
        // ignore: avoid_print
        .catchError((error) => print("Failed to add message: $error"));
  }

  void recieveMessage() {
    messages
        .orderBy('timestamp', descending: true)
        .snapshots()
        .listen((event) {
          List<MessageModel> messagesList = [];

          messagesList.clear(); // بنمسح القائمة القديمة عشان نضيف الرسائل الجديدة فقط
          // هنا بنستمع لأي تغييرات في مجموعة الرسائل
          for (var doc in event.docs) {
            messagesList.add(MessageModel.fromJson(doc)); // بنحول كل مستند ل MessageModel
            // بنطبع كل رسالة جديدة تم إضافتها
            print("New message: ${doc[kMessageFieldName]} from ${doc[kSenderEmailFieldName]}");
          }
          emit(ChatSendMessageSuccessState(messagesList)); // بنبعت الحالة مع قائمة الرسائل الجديدة
        });
  }
}