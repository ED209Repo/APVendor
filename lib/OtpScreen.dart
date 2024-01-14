import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:vendor/HomeScreen.dart';
import 'package:vendor/Employe_code.dart';
import 'package:vendor/Vendor_or_Employe.dart';
import 'SignUp.dart';
import 'Widgets/AppColors.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
class otpscreen extends StatefulWidget {
  final String verificationId;
  const otpscreen({Key? key, required this.verificationId}) : super(key: key);

  @override
  State<otpscreen> createState() => _otpscreenState();
}

class _otpscreenState extends State<otpscreen> {
  final TextEditingController otpController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // GestureDetector(
                      //   onTap: () => Navigator.of(context).pop(),
                      //   child: Icon(Icons.arrow_back_ios_new),
                      // ),
                      const Spacer(),
                      const Spacer(),
                      Text(AppLocalizations.of(context)!.verifynumber,
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold
                      ),),
                      const Spacer(),
                      const Spacer()
                    ],
                  ),
                  const SizedBox(height: 20),
                  Text(
                    AppLocalizations.of(context)!.entertheotpsenttoyourphonenumber,
                    style: TextStyle(
                      fontWeight: FontWeight.normal,
                      color: AppColors.blackColor,
                      fontSize: 15,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  Pinput(
                    controller: otpController,
                    length: 6,
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
                      if (pin.length == 6) {
                        // Replace "employeeOTP" with the actual OTP for employees
                        if (pin == "111111") {
                          CoolAlert.show(
                            context: context,
                            type: CoolAlertType.loading,
                            text: AppLocalizations.of(context)!.otpverified,
                            autoCloseDuration: const Duration(seconds: 2),
                            lottieAsset: "images/verified.json",
                            animType: CoolAlertAnimType.scale,
                          );
                          await Future.delayed(const Duration(milliseconds: 2000));
                          // If the OTP is correct, navigate to the employee-specific screen
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ecodescreen(),
                            ),
                          );
                        } else {
                          CoolAlert.show(
                            context: context,
                            type: CoolAlertType.loading,
                            text: AppLocalizations.of(context)!.otpverified,
                            autoCloseDuration: const Duration(seconds: 2),
                            lottieAsset: "images/verified.json",
                            animType: CoolAlertAnimType.scale,
                          );
                          await Future.delayed(const Duration(milliseconds: 2000));
                          // If the OTP is incorrect, navigate to the vendor screen
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const VendorScreen(),
                            ),
                          );
                        }
                      }
                    },

                  ),
                  const SizedBox(height: 20.0),
                ],
              ),
            ),
    );
  }
}