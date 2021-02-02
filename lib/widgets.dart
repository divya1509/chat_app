import 'package:flutter/material.dart';

TextEditingController usernameController = new TextEditingController();
TextEditingController emailController = new TextEditingController();
TextEditingController passwordController = new TextEditingController();

Widget appBarMain(BuildContext context) {
  return AppBar(
    title: Text(
      'Chat App',
      style: TextStyle(
        color: Colors.white,
      ),
    ),
    backgroundColor: Colors.indigo[200],
  );
}

String checkValidationEmail(String val) {
  return RegExp(
              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
          .hasMatch(val)
      ? null
      : "Please enter a valid email";
}

String checkValidationPassword(String val) {
  return RegExp(r"^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$")
              .hasMatch(val) &&
          val.length > 6
      ? null
      : "Please enter a valid Password containing \n 1 lower case alphabet \n 1 upercase alphabet \n 1 digit \n 1 special character";
}

String checkValidationUsername(String val) {
  return val.length >= 4 ? null : "Please enter min 4 characters";
}

String check(String content, String val) {
  print(val);
  if (content == "username")
    return checkValidationUsername(val);
  else if (content == "email")
    return checkValidationEmail(val);
  else if (content == "password") return checkValidationPassword(val);
  return null;
}

Widget textStyling(String content, TextEditingController control) {
  return TextFormField(
    obscureText: content == "password" ? true : false,
    validator: (val) {
      return check(content, val);
    },
    controller: control,
    decoration: InputDecoration(
      hintText: content,
      hintStyle: TextStyle(
        color: Colors.black54,
      ),
      focusedBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: Colors.black54),
      ),
    ),
  );
}
