abstract class LoginEvents {}

class LoginButtonPressed extends LoginEvents {
  final String email;
  final String password;

  LoginButtonPressed({required this.email, required this.password});
}