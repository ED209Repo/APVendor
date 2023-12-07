import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Widgets/AppColors.dart';
import 'Widgets/CustomButton.dart';
import 'homeScreen.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class SignupPage extends StatefulWidget {
  const SignupPage({Key? key}) : super(key: key);

  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _usernameController = TextEditingController();
  String _fullname = '';
  String _username = '';
  String _email = '';
  String level = 'MALE';
  String selectvalue = '';
  String myAge = '';
  String SelectedDate = '';
  bool showvalue = false;

  @override
  void initState() {
    super.initState();
  }

  void _saveUsername(String username) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString('username', username);
  }

  Future<Map<String, dynamic>> _registerUser(
      String username,
      String fullname,
      String email,
      String gender,
      String dob,
      ) async {
    final apiUrl = 'https://165e-206-84-144-36.ngrok-free.app/api/user/Signup'; // Replace with your actual API URL

    try {
      final response = await http.post(
        Uri.parse('$apiUrl/signup'), // Replace with the endpoint
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'username': username,
          'fullname': fullname,
          'email': email,
          'gender': gender,
          'dob': dob,
        }),
      );

      return jsonDecode(response.body);
    } catch (e) {
      print('API Error: $e');
      throw e;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              Row(
                children: <Widget>[
                  GestureDetector(
                    onTap: () => Navigator.of(context).pop(),
                    child: const Icon(Icons.arrow_back_ios_new),
                  ),
                  Expanded(
                    child: Text(
                      AppLocalizations.of(context)!.createanaccount,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 32,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20.0),
              TextFormField(
                enabled: false,
                initialValue: '555123321',
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: AppColors.themeColor,
                      width: 3,
                    ),
                  ),
                  labelText: AppLocalizations.of(context)!.phonenumber,
                  labelStyle: TextStyle(
                    color: AppColors.blackColor,
                    fontSize: 16,
                  ),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a phone number';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20.0),
              TextFormField(
                controller: _usernameController,
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: AppColors.themeColor,
                      width: 3,
                    ),
                  ),
                  labelText: AppLocalizations.of(context)!.fullname,
                  labelStyle: TextStyle(
                    color: AppColors.blackColor,
                    fontSize: 16,
                  ),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return AppLocalizations.of(context)!.pleaseenteryourfullname;
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20.0),
              TextFormField(
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: AppColors.themeColor,
                      width: 3,
                    ),
                  ),
                  labelText: AppLocalizations.of(context)!.emailaddress,
                  labelStyle: TextStyle(
                    color: AppColors.blackColor,
                    fontSize: 16,
                  ),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return AppLocalizations.of(context)!.pleaseneteryouremail;
                  }
                  if (!value.contains('@') && !value.contains('.com')) {
                    return AppLocalizations.of(context)!.pleaseenteryourvaildemail;
                  }
                  return null;
                },
                onSaved: (value) {
                  _email = value!;
                },
              ),
              const SizedBox(height: 20.0),
              Text(
                AppLocalizations.of(context)!.gender,
                style: const TextStyle(
                  fontSize: 17,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: RadioListTile(
                      fillColor: MaterialStateColor.resolveWith(
                              (states) => AppColors.themeColor),
                      hoverColor: MaterialStateColor.resolveWith(
                              (states) => AppColors.blackColor),
                      title: const Text(
                        "M",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                      value: 'MALE',
                      groupValue: selectvalue,
                      onChanged: (value) {
                        setState(() {
                          selectvalue = value.toString();
                        });
                      },
                    ),
                  ),
                  Expanded(
                    child: RadioListTile(
                      fillColor: MaterialStateColor.resolveWith(
                              (states) => AppColors.themeColor),
                      hoverColor: MaterialStateColor.resolveWith(
                              (states) => AppColors.blackColor),
                      title: const Text(
                        "F",
                        style: TextStyle(
                          fontWeight: FontWeight.normal,
                          fontSize: 15,
                        ),
                      ),
                      value: 'FEMALE',
                      groupValue: selectvalue,
                      onChanged: (value) {
                        setState(() {
                          selectvalue = value.toString();
                        });
                      },
                    ),
                  ),
                  const Spacer(),
                  const Spacer(),
                ],
              ),
              const SizedBox(height: 15),
              Text(
                AppLocalizations.of(context)!.dob,
                style: const TextStyle(
                  fontSize: 17,
                ),
              ),
              const SizedBox(height: 10.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  const SizedBox(width: 30),
                  Row(
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: TextButton(
                          onPressed: pickDob,
                          style: ButtonStyle(
                            foregroundColor:
                            MaterialStateProperty.all<Color>(AppColors.themeColor),
                          ),
                          child: Text(
                            myAge.isEmpty
                                ? AppLocalizations.of(context)!.choosedate
                                : '$SelectedDate',
                            style: const TextStyle(
                              decorationThickness: 2.5,
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                ],
              ),
              const SizedBox(height: 50.0),
              SizedBox(
                height: 40,
                child: CustomButton(
                  text: AppLocalizations.of(context)!.createanaccount,
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();

                      CoolAlert.show(
                        context: context,
                        type: CoolAlertType.loading,
                        text: AppLocalizations.of(context)!.signUpSuccessfull,
                        autoCloseDuration: const Duration(seconds: 2),
                        lottieAsset: "images/signup.json",
                        animType: CoolAlertAnimType.scale,
                      );

                      // Register the user with the backend
                      try {
                        final response = await _registerUser(
                          _usernameController.text,
                          _fullname,
                          _email,
                          selectvalue,
                          SelectedDate,
                        );

                        // Handle the response from the backend
                        print('Registration Successful: $response');

                        _saveUsername(_usernameController.text);

                        await Future.delayed(const Duration(milliseconds: 2000));
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => HomeScreen()),
                        );
                      } catch (e) {
                        // Handle registration error
                        print('Registration Error: $e');
                        CoolAlert.show(
                          context: context,
                          type: CoolAlertType.error,
                          text: 'Registration failed. Please try again.',
                        );
                      }
                    }
                  },
                ),
              ),
              const SizedBox(height: 30.0),
              Column(
                children: [
                  Text(
                    AppLocalizations.of(context)!.bycontinuingyouagreeto,
                    style: const TextStyle(
                      fontSize: 17,
                    ),
                  ),
                  Text(
                    AppLocalizations.of(context)!.anypicktermsconditions,
                    style: TextStyle(
                      decoration: TextDecoration.underline,
                      decorationThickness: 3,
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                      color: AppColors.themeColor,
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

  Future<void> pickDob() async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            primaryColor: AppColors.themeColor2,
            buttonTheme: const ButtonThemeData(textTheme: ButtonTextTheme.primary),
            colorScheme: ColorScheme.light(primary: AppColors.themeColor)
                .copyWith(secondary: AppColors.themeColor),
          ),
          child: child!,
        );
      },
    );

    if (pickedDate != null) {
      calculateAge(pickedDate);
      String formattedDate = "${pickedDate.day}/${pickedDate.month}/${pickedDate.year}";
      setState(() {
        SelectedDate = formattedDate; // Update myAge with the selected date
      });
    }
  }

  void calculateAge(DateTime birth) {
    DateTime now = DateTime.now();
    Duration age = now.difference(birth);
    int years = age.inDays ~/ 365;
    setState(() {
      myAge = '$years years';
    });
  }
}
