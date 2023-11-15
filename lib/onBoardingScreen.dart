import 'package:flutter/material.dart';
import 'package:liquid_swipe/liquid_swipe.dart';
import 'package:provider/provider.dart';
import 'package:vendor/HomeScreen.dart';
import 'package:vendor/controller/language_change_controller.dart';
import 'Register.dart';
import 'Widgets/AppColors.dart';
import 'Widgets/CustomButton.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
enum Language{ English,Arabic}
class OnboardScreen extends StatefulWidget {
  const OnboardScreen({Key? key}) : super(key: key);

  @override
  _OnboardscreenState createState() => _OnboardscreenState();
}

class _OnboardscreenState extends State<OnboardScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final pages = [
    Container(
      width: double.infinity,
      color: AppColors.whitetext,
      child: Padding(
        padding: const EdgeInsets.only(top:80),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 5),
              child: Image.asset(
                'images/mainlogo.png',
                height: 150,
                width: 150,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 5),
              child: Image.asset(
                'images/onboard.jpg',
                height: 250,
                width: 250,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 90),
              child: Text(
                "Find your desired food around you",
                style: TextStyle(
                  color: AppColors.greyText,
                  fontSize: 14,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ),
          ],
        ),
      ),
    ),
    Container(
      width: double.infinity,
      color: AppColors.themeColor2,
      child: Padding(
        padding: const EdgeInsets.only(top: 80),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 5,),
              child: Image.asset(
                'images/whiteicon.png',
                height: 150,
                width: 150,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 5),
              child: Image.asset(
                'images/onboarding4.png',
                height: 250,
                width: 250,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 90),
              child: Text(
                "Pickup your food on the go",
                style: TextStyle(
                  color: AppColors.whitetext,
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ],
        ),
      ),
    ),
    Container(
      color: AppColors.whitetext,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(padding: const EdgeInsets.fromLTRB(320,25,0,0),
              child: Consumer<LanguageChangeController>(builder: (context,provider,child){
                return PopupMenuButton(
                    icon: const Icon(Icons.language_rounded),
                    onSelected: (Language item){
                      if(Language.English.name==item.name){
                        provider.changeLanguage(const Locale('en'));
                      } else{
                        provider.changeLanguage(const Locale('ar'));
                      }
                    },
                    itemBuilder: (BuildContext context)=> <PopupMenuEntry<Language>>[
                      const PopupMenuItem(
                          value: Language.English,
                          child: Text("Enlgish")),
                      const PopupMenuItem(
                          value: Language.Arabic,
                          child: Text("العربية")),
                    ]
                );
              })),
          Padding(
            padding: const EdgeInsets.only(bottom: 60,top: 30),
            child: Image.asset(
              "images/mainlogo.png",
              height: 150,
              width: 150,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 40),
            child: Image.asset(
              "images/continue.png",
              height: 150,
              width: 150,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 140 , left: 10 , right: 10),
            child: Text(
              "We are excited, let's get started!",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.normal,
                fontSize: 14,
                color: AppColors.blackColor,
              ),
            ),
          ),

        ],
      ),
    ),
  ];

  int currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
            children: [
              LiquidSwipe(
                pages: pages,
                enableLoop: false,
                waveType: WaveType.liquidReveal,
                onPageChangeCallback: (page) {
                  setState(() {
                    currentPage = page;
                  });
                },
              ),
              Positioned(
                bottom: 100,
                left: 30,
                right: 30,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    (currentPage == 2 )
                        ? CustomButton(text: AppLocalizations.of(context)!.continuetext,
                      onPressed: () => HomeMethod(context),) :
                    Column(
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            ...List<Widget>.generate(pages.length, (index) {
                              return AnimatedContainer(
                                duration: const Duration(milliseconds: 200),
                                height: 10,
                                width: index == currentPage ? 15 : 10,
                                margin: const EdgeInsets.symmetric(horizontal: 5),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: index == currentPage
                                      ? AppColors.themeColor
                                      : AppColors.greyText,
                                ),
                              );
                            }),
                          ],
                        ),

                      ],
                    )
                  ],
                ),
              ),
            ]));
  }

  void continueMethod(BuildContext context) {
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => const registerscreen()),
          (Route<dynamic> route) => false,
    );
  }
  void HomeMethod(BuildContext context) {
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => const registerscreen()),
            (Route<dynamic> route) => false,
        );
    }
}