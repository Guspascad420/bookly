import 'package:bookly/home_page.dart';
import 'package:bookly/login_page.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class AuthController extends GetxController {
  final TextEditingController nameTextController = TextEditingController();
  final TextEditingController passwordTextController = TextEditingController();
  final TextEditingController passwordConfirmTextController =
      TextEditingController();
  final TextEditingController emailTextController = TextEditingController();
  final dio = Dio();
  GetStorage box = GetStorage();

  var isLoading = false.obs;
  var isNameFilled = true.obs;
  var isEmailValid = true.obs;
  var isPasswordValid = true.obs;
  var isBothPasswordMatch = true.obs;
  var isLoginSucceeded = true.obs;
  var isLoginButtonEnabled = false.obs;
  var isSignUpButtonEnabled = false.obs;
  final validEmail = RegExp(
      r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$");
  final validPassword = RegExp(r"^(?=.*[0-9]).{8,}$");

  void checkEmail() {
    isEmailValid.value =
        validEmail.hasMatch(emailTextController.text) ? true : false;
  }

  void checkName() {
    isNameFilled.value = nameTextController.text.isNotEmpty ? true : false;
  }

  void checkPassword() {
    isPasswordValid.value =
        validPassword.hasMatch(passwordTextController.text) ? true : false;
  }

  void checkConfirmPassword() {
    isBothPasswordMatch.value =
        passwordTextController.text == passwordConfirmTextController.text
            ? true
            : false;
  }

  void setIsLoading() => isLoading.value = !isLoading.value;

  void setIsLoginButtonEnabled() {
    if (emailTextController.text.isNotEmpty &&
        passwordTextController.text.isNotEmpty) {
      isLoginButtonEnabled.value = true;
    } else {
      isLoginButtonEnabled.value = false;
    }
  }

  void setIsSignUpButtonEnabled() {
    if (emailTextController.text.isNotEmpty &&
        passwordTextController.text.isNotEmpty &&
        nameTextController.text.isNotEmpty &&
        passwordConfirmTextController.text.isNotEmpty) {
      isSignUpButtonEnabled.value = true;
    } else {
      isSignUpButtonEnabled.value = false;
    }
  }

  void handleSignUp() {
    checkName();
    checkEmail();
    checkPassword();
    checkConfirmPassword();
    if (isPasswordValid.value &&
        isEmailValid.value &&
        isNameFilled.value &&
        isBothPasswordMatch.value) {
      setIsLoading();
      dio.post('https://book-crud-service-6dmqxfovfq-et.a.run.app/api/register',
          options: Options(headers: {Headers.acceptHeader: 'application/json'}),
          data: {
            'name': nameTextController.text,
            'email': emailTextController.text,
            'password': passwordTextController.text,
            'password_confirmation': passwordConfirmTextController.text
          }).then((response) {
        setIsLoading();
        if (response.statusCode == 200) {
          Get.to(const LoginPage());
        } else {
          Get.showSnackbar(
            GetSnackBar(
              title: "Error",
              message: response.data["message"],
              backgroundColor: Colors.red,
              duration: const Duration(seconds: 3),
            ),
          );
        }
      });
    }
  }

  void handleLogin() {
    setIsLoading();
    dio.post(
        'https://book-crud-service-6dmqxfovfq-et.a.run.app/api/login',
        options: Options(
            validateStatus: (_) => true,
            headers: {
              Headers.acceptHeader: 'application/json'
            }
        ),
        data: {
          'email': emailTextController.text,
          'password': passwordTextController.text,
        }
    ).then((response) {
      if (response.statusCode == 200) {
        isLoginSucceeded.value = true;
        Map<String, dynamic> loginResponse = response.data;
        box.write('token', loginResponse['token']);
        Get.offAll(const HomePage());
      }
      else {
        isLoginSucceeded.value = false;
      }
      setIsLoading();
    });
  }
}
