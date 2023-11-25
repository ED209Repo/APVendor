import 'package:flutter/material.dart';
import 'package:vendor/SignUp.dart';
import 'package:vendor/Widgets/AppColors.dart';
import 'package:vendor/Widgets/CustomButton.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'Employe_code.dart';
class VendorScreen extends StatefulWidget {
  const VendorScreen({super.key});

  @override
  State<VendorScreen> createState() => _VendorScreenState();
}

class _VendorScreenState extends State<VendorScreen> {
  @override
  Widget build(BuildContext context) {
    return   Scaffold(
      body: Container(
        decoration: const BoxDecoration(
        gradient: LinearGradient(colors:[
        Color(0xff358597),
    Color(0xffF5A896)
    ],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    ),
    ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(AppLocalizations.of(context)!.loginas,
              style:TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
              color: AppColors.whitetext,
            ),),
            const SizedBox(height: 30),
           CustomButton(text: AppLocalizations.of(context)!.owner, onPressed: (){
             Navigator.push(context, MaterialPageRoute(builder: (context)=> const SignupPage()));
           }),
            const SizedBox(height: 30),
            Text(AppLocalizations.of(context)!.or,
              style:TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.normal,
                color: AppColors.whitetext,
              ),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.themeColor,
                  elevation: 3,
                  shape:  RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                  minimumSize: const Size(165, 47),
                ),
              onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=> const ecodescreen()));
             },
              child: Text(AppLocalizations.of(context)!.employee),),
          ],
        ),
      )
        ),
    );
  }
}
