import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../auth_services.dart';
import '../provider/provider.dart';
import 'home_page.dart';
import 'login_or_register_page.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  GoogleSignIn _googleSignIn = GoogleSignIn();
  GoogleSignInAccount? _currentUser;
  String _contactText = '';

  @override
  void initState() {
    super.initState();
    _googleSignIn.onCurrentUserChanged.listen((GoogleSignInAccount? account) {
      setState(() {
        _currentUser = account;
      });
      if (_currentUser != null) {
        // _handleGetContact(_currentUser!);
      }
    });
    _googleSignIn.signInSilently();
  }


  @override
  Widget build(BuildContext context) {
    // final AuthService? auth = Provider.of(context)?.auth;

    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        // stream: auth?.onAuthStateChanged,
        builder: (context, snapshot) {
        // builder: (context, AsyncSnapshot<User?> snapshot) {
          // user is logged in
          if (snapshot.hasData || _currentUser != null ) {
            print('has data');
            return HomePage();
          }
          // user is NOT logged in
          else {
            print('has no data');
            return LoginOrRegisterPage();
          }
        },
      ),
    );
  }
}
