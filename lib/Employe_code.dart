import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:vendor/Vendor_or_Employe.dart';
import 'Widgets/AppColors.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'for_employee.dart';

class ecodescreen extends StatefulWidget {
  const ecodescreen({Key? key}) : super(key: key);

  @override
  State<ecodescreen> createState() => _ecodescreenState();
}

class _ecodescreenState extends State<ecodescreen> {
  final TextEditingController ecoController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Spacer(),
                  Text(
                    "Enter your 4-digit code",
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Spacer(),
                  const Spacer(),
                ],
              ),
              const SizedBox(height: 20),
              Pinput(
                controller: ecoController,
                length: 4,
                showCursor: true,
                autofocus: true,
                textInputAction: TextInputAction.done,
                defaultPinTheme: PinTheme(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    border: Border.all(
                      color: AppColors.borderColor,
                    ),
                  ),
                  textStyle: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                onCompleted: (pin) async {
                  if (pin.length == 4) {
                    // Replace "employeePIN" with the actual PIN for employees
                    if (pin == "1234") {
                      CoolAlert.show(
                        context: context,
                        type: CoolAlertType.loading,
                        text: "Login Successful",
                        autoCloseDuration: const Duration(seconds: 2),
                        lottieAsset: "images/signup.json",
                        animType: CoolAlertAnimType.scale,
                      );
                      await Future.delayed(const Duration(milliseconds: 2000));
                      // If the PIN is correct, navigate to the employee-specific screen
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => EmployeeHomeScreen(),
                        ),
                      );
                    } else {
                      CoolAlert.show(
                        context: context,
                        type: CoolAlertType.error,
                        text: "Invalid PIN",
                        animType: CoolAlertAnimType.scale,
                      );
                    }
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
