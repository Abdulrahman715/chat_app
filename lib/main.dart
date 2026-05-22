
import 'package:chat_app/bloc/login/login_bloc.dart';
import 'package:chat_app/cubit/chat_cubit/chat_cubit.dart';
// import 'package:chat_app/cubit/login/login_cubit.dart';
import 'package:chat_app/cubit/register/register_cubit.dart';
import 'package:chat_app/firebase_options.dart';
import 'package:chat_app/simple_bloc_observer.dart';
import 'package:chat_app/views/chat_login_view.dart';
import 'package:chat_app/views/chat_regiter_view.dart';
import 'package:chat_app/views/chat_view.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  // 1. تهيئة الفلاتر قبل تشغيل التطبيق
  WidgetsFlutterBinding.ensureInitialized();

  // 2. تهيئة فايربيز باستخدام الملف السحري
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  Bloc.observer = SimpleBlocObserver(); // 3. تهيئة الـ Bloc Observer

  runApp(ChatApp());
}

class ChatApp extends StatelessWidget {
  const ChatApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        // BlocProvider(create: (context) => LoginCubit()),
        BlocProvider(create: (context) => RegisterCubit()),
        BlocProvider(create: (context) => ChatCubit()),
        BlocProvider(create: (context) => LoginBloc()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,

        routes: {
          ChatLoginView.id: (context) => ChatLoginView(),
          ChatRegisterView.id: (context) => ChatRegisterView(),
          ChatView.id: (context) => ChatView(),
        },
        initialRoute: ChatLoginView.id,
      ),
    );
  }
}
