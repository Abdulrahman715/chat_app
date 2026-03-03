import 'package:chat_app/constants.dart';
import 'package:chat_app/views/chat_regiter_view.dart';
import 'package:chat_app/views/chat_view.dart';
import 'package:chat_app/widgets/custom_button.dart';
import 'package:chat_app/widgets/custom_text_field.dart';
import 'package:chat_app/helper/show_snack_bar_message.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

// ignore: must_be_immutable
class LoginBody extends StatefulWidget {
  const LoginBody({super.key});

  @override
  State<LoginBody> createState() => _LoginBodyState();
}

class _LoginBodyState extends State<LoginBody> {
  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  final GlobalKey<FormState> formkey = GlobalKey<FormState>();

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: isLoading,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 90.0),
        child: Form(
          key: formkey,
          child: ListView(
            children: [
              Image(
                image: AssetImage(kLogo),
                width: 150,
                height: 150,
              ),
              // SizedBox(height: 5),
              Center(
                child: Text(
                  "Scholar Chat",
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontFamily: "Pacifico",
                  ),
                ),
              ),
              SizedBox(height: 60),
              Text(
                'Sign In ',
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white70,
                  fontFamily: "SourceCodePro",
                ),
              ),
              SizedBox(height: 20),
              CustomTextField(
                controller: emailController,
                labelText: "Email",
                hintText: "Enter your email",
                iconDescription: Icons.email_outlined,
              ),
              SizedBox(height: 20),
              CustomTextField(
                controller: passwordController,
                labelText: "Password",
                hintText: "Enter your password",
                iconDescription: Icons.lock_outline,
                obscureText: true,
              ),
              SizedBox(height: 20),

              //! This is a custom button widget that is used for the login action. It is styled with a specific background color, padding, and text style to match the overall design of the login screen. The onPressed callback is currently empty, but it can be implemented to handle the login logic when the button is pressed.
              CustomButton(
                onPressed: () async {
                  //! هنتاكد ان الفورم صح قبل ما نعمل اي حاجة
                  if (formkey.currentState?.validate() ?? false) {
                    //! بعد ما يتاكد ان الفورم صح هنخلي ال شاشة تحمل عشان نشوف فى مشكلة ولا تم تسجيل
                    isLoading = true;
                    setState(
                      () {},
                    ); // Update the UI to show the loading indicator

                    try {
                      // Implement login  here using emailController.text and passwordController.text
                      await loginUser();

                      //! After a successful login, it's important to check if the context is still valid before trying to show a snackbar or navigate to another screen. This is because the user might have navigated away from the login screen or the widget might have been disposed of, which would make the context invalid. By checking if the context is still mounted, you can avoid potential errors and ensure that your app behaves correctly after a successful login.
                      if (!context.mounted) return;

                      //? If login is successful, you can navigate to the chat screen or show a success message
                      // showSnackBarMessage(context, message: "login successful");

                      //? Navigate to the chat screen (replace with your actual chat screen route)
                      //! send the email to the chat screen as an argument to recognize who is the user that logged in and send messages with his name
                      Navigator.pushNamed(context, ChatView.id , arguments: emailController.text);


                    } on FirebaseAuthException catch (e) {
                      //! هنعمل فحص ان الودجت لسة موجودة
                      if (!context.mounted) return;

                      if (e.code == 'user-not-found') {
                        showSnackBarMessage(
                          context,
                          message: 'No user found for that email.',
                        );
                      } else if (e.code == 'wrong-password') {
                        showSnackBarMessage(
                          context,
                          message: 'Wrong password provided for that user.',
                        );
                      }
                    } catch (e) {
                      //! هنعمل فحص ان الودجت لسة موجودة
                      if (!context.mounted) return;

                      // Handle login errors here
                      showSnackBarMessage(
                        context,
                        message:
                            'An error occurred during login. Please try again.',
                      );
                    } finally {
                      //! بعد ما يخلص عملية تسجيل الدخول سواء نجحت او فشلت لازم نوقف ال شاشة التحميل
                      isLoading = false;
                      setState(
                        () {},
                      ); // Update the UI to hide the loading indicator
                    }
                  } else {
                    //? If the form is not valid, you can show an error message or highlight the invalid fields
                    showSnackBarMessage(
                      context,
                      message: "Please fill in all fields correctly.",
                    );
                  }
                },
                objOfText: "login",
              ),

              SizedBox(height: 20),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Don't have an account? ",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white70,
                      fontFamily: "SourceCodePro",
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      //! This is the navigation logic that allows users to move from the login screen to the registration screen. It uses the Navigator class to push a new route onto the stack, which in this case is the ChatRegisterView. The navigation can be done using either MaterialPageRoute or named routes, and in this code snippet, it is implemented using named routes for better readability and maintainability.
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(builder: (context) => ChatRegisterView()),
                      // );

                      //! Using named routes for navigation is a cleaner and more maintainable approach, especially as the application grows in complexity. It allows for better organization of routes and makes it easier to manage navigation throughout the app. In this case, the named route 'chat_register_view' is defined in the main.dart file, and it points to the ChatRegisterView widget, making it straightforward to navigate to the registration screen when the user clicks on the "Sign Up" button.
                      // Navigator.pushNamed(context, 'chat_register_view');

                      //! This is the navigation logic that allows users to move from the login screen to the registration screen. It uses the Navigator class to push a new route onto the stack, which in this case is the ChatRegisterView. The navigation can be done using either MaterialPageRoute or named routes, and in this code snippet, it is implemented using named routes for better readability and maintainability.
                      Navigator.pushNamed(context, ChatRegisterView.id);
                    },
                    child: Text(
                      "Sign Up",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.blueGrey.shade100,
                        fontWeight: FontWeight.bold,
                        fontFamily: "SourceCodePro",
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> loginUser() async {
    await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: emailController.text,
      password: passwordController.text,
    );
  }
}
