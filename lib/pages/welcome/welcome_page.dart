import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'package:google_fonts/google_fonts.dart';
import 'package:health_ai_test/components/change_theme_button.dart';
import 'package:health_ai_test/components/language_picker_widget.dart';
import 'package:health_ai_test/pages/auth_page.dart';
import 'package:health_ai_test/provider/theme_provider.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../components/gradient_animation_welcome.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  PageController _controller = PageController();
  List<String> items = [
    'English',
    'Swahili',
    'France',
    'Spanish',
  ];
  String dropdownValue = 'English';

  @override
  Widget build(BuildContext context) {
    final mode = Provider.of<ThemeProvider>(context).themeMode == ThemeMode.dark ? 'Dark Theme' : 'Light Theme';
    final textColor = Provider.of<ThemeProvider>(context).themeMode == ThemeMode.dark
        // ? Colors.green
        ? Colors.orangeAccent
        : Colors.white;
    final welcomePageColor = Provider.of<ThemeProvider>(context).themeMode == ThemeMode.dark
        ? Color(0xFF1B1E1F)
        // : Colors.green;
        : Colors.orangeAccent;
    return Scaffold(
      backgroundColor: welcomePageColor,
      body: Stack(
        alignment: AlignmentDirectional.topStart,
        children: [
          WelcomeGradientBackground(
            child: Container(
              child: PageView(
                controller: _controller,
                children: [
                  Container(
                    child: Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            // color: Theme.of(context).focusColor,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.zero,
                              topRight: Radius.zero,
                              bottomLeft: Radius.circular(8.0),
                              bottomRight: Radius.circular(8.0),
                            ),
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(25.0),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Text(
                                      '${mode}',
                                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: textColor),
                                    ),
                                    ChangeThemeButtonWidget(),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Lottie.asset('assets/jsons/translate.json'),
                              Text(
                                AppLocalizations.of(context)!.choose_lang,
                                textAlign: TextAlign.center,
                                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: textColor),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  // Text(
                                  //   AppLocalizations.of(context)!.language,
                                  //   style: TextStyle(
                                  //     fontWeight: FontWeight.bold,
                                  //     fontSize: 18,
                                  //   ),
                                  // ),
                                  Container(
                                    decoration: BoxDecoration(
                                      // color: Theme.of(context).cardColor,
                                      borderRadius: BorderRadius.circular(8.0),
                                    ),
                                    child: LanguagePickerWidget(),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 0.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Container(
                              padding: const EdgeInsets.all(10.0),
                              margin: EdgeInsets.only(right: 10),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20.0),
                                // color: Colors.green[300]
                              ),
                              child: TextButton(
                                child: Row(
                                  children: [
                                    Text(
                                      'NEXT',
                                      style: TextStyle(
                                        color: textColor,
                                        fontSize: 20,
                                      ),
                                    ),
                                    Icon(
                                      Icons.navigate_next,
                                      color: Colors.orangeAccent,
                                    ),
                                  ],
                                ),
                                onPressed: () {
                                  _controller.animateToPage(1, duration: Duration(milliseconds: 500), curve: Curves.bounceInOut);
                                },
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    // color: Colors.grey[500],
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Lottie.asset('assets/jsons/business.json'),
                          Text(
                            'Welcome to',
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: textColor),
                          ),
                          Text(
                            'Land Ap',
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: textColor),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Container(
                                padding: const EdgeInsets.all(10.0),
                                margin: EdgeInsets.only(right: 10),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20.0),
                                  // color: Colors.green[300]
                                ),
                                child: TextButton(
                                  child: Row(
                                    children: [
                                      Text(
                                        'NEXT',
                                        style: TextStyle(
                                          color: textColor,
                                          fontSize: 20,
                                        ),
                                      ),
                                      Icon(
                                        Icons.navigate_next,
                                        color: Colors.orangeAccent,
                                      ),
                                    ],
                                  ),
                                  onPressed: () {
                                    _controller.animateToPage(2, duration: Duration(milliseconds: 500), curve: Curves.bounceInOut);
                                  },
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    // color: Colors.white,
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Lottie.asset('assets/jsons/real_estate.json'),
                          Text(
                            'This app is dedicated to \nsimplify land services',
                            textAlign: TextAlign.center,
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: textColor),
                            // style: TextStyle(
                            //     fontWeight: FontWeight.bold,
                            //     fontSize: 30,
                            //     color: Colors.green[300]
                            // ),
                          ),
                          Text(
                            '..',
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30, color: Colors.green[300]),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Container(
                                padding: const EdgeInsets.all(10.0),
                                margin: EdgeInsets.only(right: 10),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20.0),
                                  // color: Colors.green[300]
                                ),
                                child: TextButton(
                                  child: Row(
                                    children: [
                                      Text(
                                        'NEXT',
                                        style: TextStyle(
                                          color: textColor,
                                          fontSize: 20,
                                        ),
                                      ),
                                      Icon(
                                        Icons.navigate_next,
                                        color: Colors.orangeAccent,
                                      ),
                                    ],
                                  ),
                                  onPressed: () {
                                    _controller.animateToPage(3, duration: Duration(milliseconds: 500), curve: Curves.bounceInOut);
                                  },
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    // color: Colors.deepPurple,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Lottie.asset('assets/jsons/location-animation.json'),
                        Center(
                          child: Text(
                            'We bring',
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: textColor),
                          ),
                        ),
                        Center(
                          child: Text(
                            'land services',
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: textColor),
                          ),
                        ),
                        Center(
                          child: Text(
                            'close to you',
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: textColor),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Container(
                              padding: const EdgeInsets.all(10.0),
                              margin: EdgeInsets.only(right: 10),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20.0),
                                // color: Colors.green[300]
                              ),
                              child: TextButton(
                                child: Row(
                                  children: [
                                    Text(
                                      'START',
                                      style: TextStyle(
                                        color: textColor,
                                        fontSize: 20,
                                      ),
                                    ),
                                    Icon(
                                      Icons.navigate_next,
                                      color: Colors.orangeAccent,
                                    ),
                                  ],
                                ),
                                onPressed: () {
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => AuthPage()));
                                },
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
              alignment: Alignment(0, 0.8),
              child: SmoothPageIndicator(
                controller: _controller,
                count: 4,
                effect: WormEffect(activeDotColor: mode == "dark theme" ? Colors.green : Colors.white),
              )),
        ],
      ),
    );
  }
}
