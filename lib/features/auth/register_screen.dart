import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_5_oy_imtixon/controller/my_controller.dart';
import 'package:flutter_5_oy_imtixon/core/widgets/custom_button.dart';
import 'package:flutter_5_oy_imtixon/core/widgets/custom_text_field.dart';
import 'package:flutter_5_oy_imtixon/database/google_sheets_service.dart';
import 'package:flutter_5_oy_imtixon/features/auth/login_screen.dart';
import 'package:flutter_5_oy_imtixon/features/home/oil_reminder/oil_input_screen.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final nameController = TextEditingController();
  final key = GlobalKey<FormState>();
  final myController = MyController();
  @override
  Widget build(BuildContext context) {
    return Form(
      key: key,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Register'),
          backgroundColor: Colors.black,
        ),
        body: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: 16,
            children: [
              CustomTextfield(
                controller: nameController,
                width: double.infinity,
                onChanged: (a) {},
                hintext: "Name",
                onTapTextField: () {},
                validator: (v) {
                  if (v == null || v.isEmpty) {
                    return "Iltimos, ma'lumot kiriting";
                  }
                  return null;
                },
              ),
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
              SizedBox(height: 32),
              Obx(() {
                return myController.isLoadingAuth.value
                    ? Center(
                        child: CircularProgressIndicator.adaptive(),
                      )
                    : CustomButton(
                        text: "Register",
                        height: 64,
                        width: double.infinity,
                        onTap: () async {
                          if (key.currentState!.validate()) {
                            myController.isLoadingAuth.value = true;
                            final res = await SheetService.insertUser(
                                nameController.text,
                                emailController.text,
                                passwordController.text);
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
                      builder: (context) => LoginScreen(),
                    ),
                  );
                },
                child: Text('You have already have account? Login'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
