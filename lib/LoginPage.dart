import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'HomeScreen.dart';
import 'Widgets/AppColors.dart';
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body:Padding(
        padding: const EdgeInsets.all(15.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () => Navigator.of(context).pop(),
                    child: const Icon(Icons.arrow_back_ios_new),
                  ),
                  const Spacer(),
                  const Spacer(),
                  const Text("Login",style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold
                  ),),
                  const Spacer(),
                  const Spacer()
                ],
              ),
              const SizedBox(height: 15),
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Login as Employee",
                    style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 15),
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Enter your Username and Password\nProvided to you by Restaurant Owner",
                    softWrap: true,
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.normal
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 15),
              TextFormField(
                decoration:  InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: AppColors.themeColor,
                      width: 3,
                    ),
                  ),
                  labelText: "Username",
                  labelStyle: TextStyle(
                    color: AppColors.blackColor,
                    fontSize: 16,
                  ),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Please Enter Your Username";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 15),
              TextFormField(
                obscureText: true,
                decoration:  InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: AppColors.themeColor,
                      width: 3,
                    ),
                  ),
                  labelText: "Password",
                  labelStyle: TextStyle(
                    color: AppColors.blackColor,
                    fontSize: 16,
                  ),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Please Enter Your Password";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 200),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.themeColor,
                  elevation: 3,
                  shape:  RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                  minimumSize: const Size(350, 50),
                ),
                child: const Text("Login"),
                onPressed: () async {
                  if  (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    CoolAlert.show(context: context, type: CoolAlertType.loading,
                      text: "Login Successful",
                      autoCloseDuration: const Duration(seconds: 2),
                      lottieAsset: "images/signup.json",
                      animType: CoolAlertAnimType.scale,
                    );
                    await Future.delayed(const Duration(milliseconds: 2000));
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) =>  HomeScreen()),
                    );}
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
