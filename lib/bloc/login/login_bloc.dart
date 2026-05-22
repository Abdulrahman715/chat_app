import 'package:chat_app/bloc/login/login_events.dart';
import 'package:chat_app/bloc/login/login_states.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginBloc extends Bloc<LoginEvents, LoginStates> {
  LoginBloc() : super(LoginInitial()) {
    on<LoginEvents>((event, emit) async {
      if (event is LoginButtonPressed) {
        emit(LoginLoading()); // 1. بدأنا التحميل

        try {
          await FirebaseAuth.instance.signInWithEmailAndPassword(
            email: event.email,
            password: event.password,
          );
          emit(LoginSuccess()); // 2. نجاح
        } on FirebaseAuthException catch (e) {
          // 3. هنا كان الخطأ.. يجب عمل emit للحالة لكي يشعر الـ UI بتوقف التحميل
          if (e.code == 'user-not-found') {
            emit(LoginFailure(errMessage: 'No user found for that email.'));
          } else if (e.code == 'wrong-password') {
            emit(
              LoginFailure(
                errMessage: 'Wrong password provided for that user.',
              ),
            );
          } else {
            emit(
              LoginFailure(
                errMessage: 'Authentication failed. Please try again.',
              ),
            );
          }
        } catch (e) {
          // 4. لأي خطأ آخر غير متوقع
          emit(
            LoginFailure(errMessage: 'Something went wrong. Please try again.'),
          );
        }
      }
    });
  }
}
