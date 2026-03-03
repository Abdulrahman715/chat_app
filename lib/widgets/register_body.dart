import 'package:chat_app/constants.dart';
import 'package:chat_app/views/chat_view.dart';
import 'package:chat_app/widgets/custom_button.dart';
import 'package:chat_app/widgets/custom_text_field.dart';
import 'package:chat_app/helper/show_snack_bar_message.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class RegisterBody extends StatefulWidget {
  const RegisterBody({super.key});

  @override
  State<RegisterBody> createState() => _RegisterBodyState();
}

class _RegisterBodyState extends State<RegisterBody> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    //! add dispose to controllers to save my memory
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  //! This is a GlobalKey that is used to identify the form and access its state. It allows us to validate the form and perform actions based on the form's state, such as showing error messages or submitting the form data.
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: isLoading,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 90.0),
        child: Form(
          key: formKey,
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
                'Sign Up ',
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

              //! This is a custom button widget that is used for the register action. It is styled with a specific background color, padding, and text style to match the overall design of the register screen. The onPressed callback is currently empty, but it can be implemented to handle the register logic when the button is pressed.
              CustomButton(
                onPressed: () async {
                  //! هنتاكد ان الفورم صح قبل ما نعمل اي حاجة
                  if (formKey.currentState?.validate() ?? false) {
                    //! بعد ما يتاكد ان الفورم صح هنخلي ال شاشة تحمل عشان نشوف فى مشكلة ولا تم تسجيل
                    isLoading = true; //loading indicator

                    //! علشان نحدث الواجهة ونشوف ال شاشة التحميل لازم نستخدم
                    setState(() {});

                    try {
                      await registerUser();

                      //! هنعمل فحص ان الودجت لسة موجودة
                      if (!context.mounted) return;

                      showSnackBarMessage(
                        context,
                        message: "User registered successfully!",
                      );

                      //! Navigate to the chat screen (replace with your actual chat screen route)
                      //? send the email to the chat screen as an argument to recognize the user in the chat screen and show his messages
                      Navigator.pushNamed(context, ChatView.id , arguments: emailController.text);

                      // print(credential.user?.email);
                    } on FirebaseAuthException catch (e) {
                      //! هنعمل فحص ان الودجت لسة موجودة
                      if (!context.mounted) return;

                      if (e.code == 'weak-password') {
                        showSnackBarMessage(
                          context,
                          message: 'The password provided is too weak.',
                        );
                      } else if (e.code == 'email-already-in-use') {
                        showSnackBarMessage(
                          context,
                          message: 'The email is already in use.',
                        );
                      }
                    } catch (e) {
                      //! هنعمل فحص ان الودجت لسة موجودة
                      if (!context.mounted) return;

                      showSnackBarMessage(
                        context,
                        message: 'An error occurred. Please try again.',
                      );
                      //!'An error occurred. Please try again.'
                    }

                    isLoading = false; //?stop loading indicator
                    setState(
                      () {},
                    ); //?update the UI to stop showing the loading indicator
                  } else {
                    //! هنعمل فحص ان الودجت لسة موجودة
                    if (!context.mounted) return;

                    showSnackBarMessage(
                      context,
                      message: 'Please fill in all fields correctly.',
                    );
                  }
                },
                objOfText: "Register",
              ),

              SizedBox(height: 20),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Relly have an account? ",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white70,
                      fontFamily: "SourceCodePro",
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      "Sign In",
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

  Future<void> registerUser() async {
    await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: emailController.text,
      password: passwordController.text,
    );
  }
}
