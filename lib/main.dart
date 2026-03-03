import 'package:chat_app/firebase_options.dart';
import 'package:chat_app/views/chat_login_view.dart';
import 'package:chat_app/views/chat_regiter_view.dart';
import 'package:chat_app/views/chat_view.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async{
  // 1. تهيئة الفلاتر قبل تشغيل التطبيق
  WidgetsFlutterBinding.ensureInitialized();

  // 2. تهيئة فايربيز باستخدام الملف السحري
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(ChatApp());
}

class ChatApp extends StatelessWidget {
  const ChatApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      routes: {
        ChatLoginView.id: (context) => ChatLoginView(),
        ChatRegisterView.id: (context) => ChatRegisterView(),
        ChatView.id: (context) => ChatView(),
      },
      initialRoute: ChatLoginView.id,
    );
  }
}