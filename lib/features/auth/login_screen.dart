import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_5_oy_imtixon/controller/my_controller.dart';
import 'package:flutter_5_oy_imtixon/core/widgets/custom_button.dart';
import 'package:flutter_5_oy_imtixon/core/widgets/custom_text_field.dart';
import 'package:flutter_5_oy_imtixon/database/google_sheets_service.dart';
import 'package:flutter_5_oy_imtixon/features/auth/register_screen.dart';
import 'package:flutter_5_oy_imtixon/features/home/oil_reminder/oil_input_screen.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final key = GlobalKey<FormState>();
  final myController = MyController();
  @override
  Widget build(BuildContext context) {
    return Form(
      key: key,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Login'),
          backgroundColor: Colors.black,
        ),
        body: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: 16,
            children: [
              CustomTextfield(
                controller: emailController,
                width: double.infinity,
                onChanged: (a) {},
                hintext: "Email",
                onTapTextField: () {},
                validator: (v) {
                  if (v == null || v.isEmpty) {
                    return "Iltimos, ma'lumot kiriting";
                  }
                  if (!v.contains('@')) {
                    return "Iltimos, email kiriting";
                  }
                  return null;
                },
              ),
              CustomTextfield(
                controller: passwordController,
                width: double.infinity,
                onChanged: (a) {},
                hintext: "Password",
                onTapTextField: () {},
                validator: (v) {
                  if (v == null || v.isEmpty) {
                    return "Iltimos, ma'lumot kiriting";
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              Obx(() {
                return myController.errorTextAuth.value.isNotEmpty
                    ? Text(
                        myController.errorTextAuth.toString(),
                        style: TextStyle(
                          color: Colors.red,
                        ),
                      )
                    : SizedBox();
              }),
              Obx(() {
                return myController.isLoadingAuth.value
                    ? Center(
                        child: CircularProgressIndicator.adaptive(),
                      )
                    : CustomButton(
                        text: "Login",
                        height: 64,
                        width: double.infinity,
                        onTap: () async {
                          if (key.currentState!.validate()) {
                            myController.isLoadingAuth.value = true;
                            final res = await SheetService.login(
                                email: emailController.text,
                                password: passwordController.text);
                            myController.isLoadingAuth.value = false;
                            if (res) {
                              if (context.mounted) {
                                Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          OilInputScreen(emailController.text),
                                    ), (a) {
                                  return false;
                                });
                              }
                            } else {
                              myController.errorTextAuth.value =
                                  "Email yoki parol noto'g'ri kiritildi";
                            }
                          }
                        },
                      );
              }),
              SizedBox(height: 32),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    CupertinoPageRoute(
                      builder: (context) => RegisterScreen(),
                    ),
                  );
                },
                child: Text('Don\'t have an account? Register'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
