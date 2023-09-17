import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:health_ai_test/pages/welcome/welcome_page.dart';
import 'package:health_ai_test/provider/theme_provider.dart';
import 'package:provider/provider.dart';
import 'auth_services.dart';
import 'firebase_options.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'l10n/l10n.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    name: "health_ai_test",
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(MyApp(appTheme: MyThemes()));
}

class MyApp extends StatelessWidget {
  final MyThemes appTheme;
  const MyApp({super.key,required this.appTheme,});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => ThemeProvider(),
        builder: (context, _) {
          final themeProvider = Provider.of<ThemeProvider>(context);
          // final provider = Provider.of<LocaleProvider>(context);

          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: appTheme.lightTheme,
            darkTheme: appTheme.darkTheme,
            themeMode: themeProvider.themeMode,

            locale: themeProvider.locale,
            supportedLocales: L10n.all,
            localizationsDelegates: [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
            ],
            home: WelcomePage(),
          );
        },
    );


    //   Provider(
    //   auth: AuthService(),
    //   child: MaterialApp(
    //     debugShowCheckedModeBanner: false,
    //     home: WelcomePage(),
    //     theme: ThemeData(primarySwatch: Colors.green),
    //   ),
    // );
  }
}
