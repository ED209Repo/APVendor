import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:country_picker/country_picker.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vendor/HomeScreen.dart';
import 'package:vendor/SignUp.dart';
import 'Widgets/AppColors.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:uuid/uuid.dart';

class registerscreen extends StatefulWidget {
  const registerscreen({Key? key}) : super(key: key);

  @override
  State<registerscreen> createState() => _registerscreenState();
}

class _registerscreenState extends State<registerscreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController phoneController = TextEditingController();
  Country selectedCountry = Country(
    phoneCode: "966",
    countryCode: "SA",
    e164Sc: 0,
    geographic: true,
    level: 1,
    name: "Saudi Arabia",
    example: "Saudi Arabia",
    displayName: "Saudi Arabia",
    displayNameNoCountryCode: "Saudi Arabia",
    e164Key: " ",
  );

  bool isPhoneValid() {
    return phoneController.text.length == 9;
  }

  savePhoneNumberLocally(String phoneNumber) async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setString('phoneNumber', phoneNumber);
  }

   Future<http.Response?> LoginCall() async {
       String uuid =  Uuid().v4();
       print(uuid);
        var client = http.Client();
        var uri = Uri.parse('https://0133-206-84-149-102.ngrok-free.app/api/user/login?Devicid=$uuid&Roleid=2&Verified=true&phone=$phoneController');
        var response = await client.post(uri);
        print(response.body);
        if (response.statusCode == 404){
            print(response.body);
            Navigator.push(context, MaterialPageRoute(builder: (context)=>SignupPage()));
      
           return response;


        }else if (response.statusCode==200){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>HomeScreen()));
        }


    }

  @override
  Widget build(BuildContext context) {
    phoneController.selection = TextSelection.fromPosition(
      TextPosition(
        offset: phoneController.text.length,
      ),
    );
    final double screenHeight = MediaQuery.of(context).size.height;
    final double buttonHeight = screenHeight * 0.08;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context)!.login,
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
        automaticallyImplyLeading: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        toolbarHeight: 40,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 0.0),
                    child: Text(
                      AppLocalizations.of(context)!.enteryourphonenumber,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppColors.blackColor,
                        fontSize: 20,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30),
              TextFormField(
                autofocus: true,
                inputFormatters: [
                  LengthLimitingTextInputFormatter(9), // Set the max length to 10
                  FilteringTextInputFormatter.digitsOnly, // Allow only digits
                ],
                keyboardType: TextInputType.number,
                textInputAction: TextInputAction.done,
                cursorColor: AppColors.cursorColor,
                onChanged: (value) {
                  print(value);
                  setState(() {
                    phoneController.text = value;
                  });
                },
                controller: phoneController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return AppLocalizations.of(context)!
                        .pleaseenteraphonenumber;
                  }
                  if (value.length != 9) {
                    return AppLocalizations.of(context)!
                        .pleaseenteravalid9digitphonenumber;
                  }
                  return null;
                },
                onSaved: (value) {},
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
                decoration: InputDecoration(
                  hintText: "59xxxxxxx",
                  hintStyle: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 22,
                    color: AppColors.greyText,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                      color: AppColors.borderColor,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                      color: AppColors.borderColor,
                    ),
                  ),
                  prefixIcon: Container(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                      onTap: () {
                        showCountryPicker(
                          context: context,
                          countryListTheme: const CountryListThemeData(
                            bottomSheetHeight: 600,
                          ),
                          onSelect: (Country value) {
                            setState(() {
                              selectedCountry = value;
                            });
                          },
                        );
                      },
                      child: Text(
                        "${selectedCountry.flagEmoji} ${selectedCountry.phoneCode}",
                        style: TextStyle(
                          fontSize: 19,
                          color: AppColors.blackColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  suffixIcon: phoneController.text.length == 9
                      ? Container(
                    height: 30,
                    width: 30,
                    margin: const EdgeInsets.all(10.0),
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.green,
                    ),
                    child: const Icon(
                      Icons.done,
                      color: Colors.white,
                      size: 20,
                    ),
                  )
                      : phoneController.text.length >= 10
                      ? Container(
                    height: 30,
                    width: 30,
                    margin: const EdgeInsets.all(10.0),
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.red,
                    ),
                    child: const Icon(
                      Icons.clear,
                      color: Colors.white,
                      size: 20,
                    ),
                  )
                      : null,
                ),
                onTapOutside: (event) {
                  if (phoneController.text.length == 9) {
                    FocusManager.instance.primaryFocus?.unfocus();
                    behavior: HitTestBehavior.opaque;
                  }
                },
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.themeColor,
                  elevation: 3,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  minimumSize: const Size(300, 50),
                ),
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();

                    // Save the phone number locally
                    await savePhoneNumberLocally(phoneController.text);

                    print('End of signup button logic');
                    // Perform login API call
                    http.Response? response = (await  LoginCall()) as http.Response?;
                  } else{
                    print('Form validation failed');
                  }
                },
                child: Text(AppLocalizations.of(context)!.signup),
              ),
              const SizedBox(height: 30),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
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
}
