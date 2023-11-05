import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:health_ai_test/components/my_button.dart';
import 'package:health_ai_test/components/my_textfield.dart';
import 'package:health_ai_test/components/square_tile.dart';

import 'doctor_register_page.dart';

class RegisterPage extends StatefulWidget {
  final Function()? onTap;
  const RegisterPage({super.key, required this.onTap });

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  // text editing controllers
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final phoneController = TextEditingController();
  final genderController = TextEditingController();
  final kinPhoneController = TextEditingController();
  final kinFullNameController = TextEditingController();
  final kinRelationController = TextEditingController();
  final addressController = TextEditingController();
  final ageController = TextEditingController();
  var isDoctor = false;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    firstNameController.dispose();
    lastNameController.dispose();
    phoneController.dispose();
    genderController.dispose();
    kinPhoneController.dispose();
    kinFullNameController.dispose();
    kinRelationController.dispose();
    addressController.dispose();
    ageController.dispose();
    super.dispose();
  }

  // sign user up method
  void signUserUp(bool signin_type) async {
    // show loading circle
    showDialog(
      context: context,
      builder: (context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
    // try creating the user
    try {
      // check if password is confirmed
      if (passwordController.text == confirmPasswordController.text) {
        //create user
        // sign in with gmail
        if(signin_type){
          // await _googleSignIn.signIn() ;
          final GoogleSignIn googleSignIn = GoogleSignIn();
          final GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();
          if (googleSignInAccount != null) {
            final GoogleSignInAuthentication googleSignInAuthentication =
            await googleSignInAccount.authentication;
            final AuthCredential authCredential = GoogleAuthProvider.credential(
                idToken: googleSignInAuthentication.idToken,
                accessToken: googleSignInAuthentication.accessToken);

            // Getting users credential
            UserCredential result = await auth.signInWithCredential(authCredential);
            User? user = result.user;

            if (result != null) {
              print('IMEFANIKIWA');
              // if result not null we simply call the MaterialpageRoute,
              // for go to the HomePage screen
              // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomePage()));
            }
          }
        }else {
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: emailController.text,
            password: passwordController.text,
          );
        }
        //add details
        String id = await FirebaseAuth.instance.currentUser!.uid;
        addUserDetails(
          id,
          firstNameController.text.trim(),
          lastNameController.text.trim(),
          phoneController.text.trim(),
          genderController.text.trim(),
          int.parse(ageController.text.trim()),
          addressController.text.trim(),
          kinFullNameController.text.trim(),
          kinPhoneController.text.trim(),
          kinRelationController.text.trim(),
        );
      } else {
        // show error message, passwords don't match
        showErrorMessage("Passwords don't match!");
      }
      // pop the loading circle
      Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      // pop the loading circle
      Navigator.pop(context);
      // show error message
      showErrorMessage(e.code);
    }
  }

  void doctorRegisterPage(){
    setState(() {
      isDoctor = !isDoctor;
    });
  }
  Future<void> addUserDetails(String id,String firstName,String lastName,String phone,String gender,int age,String address,String kinName,String kinPhone,String kinRelation) async {
    await FirebaseFirestore.instance.collection('users')
        // .add(
        .doc(id).set(
      {
        'first_name':firstName,
        'last_name':lastName,
        'phone':phone,
        'gender':gender,
        'age':age,
        'address':address,
        'kin_name':kinName,
        'kin_phone':kinPhone,
        'kin_relation':kinRelation,
        'role':'normal',
      }
    );
    // .add();
  }

  // error message to user
  void showErrorMessage(String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.deepPurple,
          title: Center(
            child: Text(
              message,
              style: const TextStyle(color: Colors.white),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: isDoctor?
            DoctorRegisterPage(
              auth: auth,
              onTap: widget.onTap,
              doctorRegisterPage:doctorRegisterPage,
            ):
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 25),

                // logo
                Icon(
                  Icons.lock,
                  size: 50,
                  color: Colors.green[600],
                ),

                const SizedBox(height: 25),

                // let's create an account for you
                Text(
                  'Let\'s create an account for you!',
                  style: TextStyle(
                    color: Colors.grey[700],
                    fontSize: 16,
                  ),
                ),

                const SizedBox(height: 25),

                Row(
                  children: [
                    //first name
                    Expanded(
                      child: MyTextField(
                        controller: firstNameController,
                        hintText: 'First name',
                        obscureText: false,
                      ),
                    ),
                    //last name
                    Expanded(
                      child: MyTextField(
                        controller: lastNameController,
                        hintText: 'Last Name',
                        obscureText: false,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8.0,),

                Row(
                  children: [
                    //first name
                    Expanded(
                      child: MyTextField(
                        controller: phoneController,
                        hintText: 'Phone',
                        obscureText: false,
                      ),
                    ),
                    //last name
                    Expanded(
                      child: MyTextField(
                        controller: genderController,
                        hintText: 'Gender',
                        obscureText: false,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8.0,),

                Row(
                  children: [
                    //first name
                    Expanded(
                      child: MyTextField(
                        controller: ageController,
                        hintText: 'age',
                        obscureText: false,
                      ),
                    ),
                    //last name
                    Expanded(
                      child: MyTextField(
                        controller: addressController,
                        hintText: 'Address',
                        obscureText: false,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8.0,),

                MyTextField(
                  controller: kinFullNameController,
                  hintText: 'Kin\'s full name',
                  obscureText: false,
                ),
                SizedBox(height: 8.0,),

                Row(
                  children: [
                    //first name
                    Expanded(
                      child: MyTextField(
                        controller: kinPhoneController,
                        hintText: 'Kin phone',
                        obscureText: false,
                      ),
                    ),
                    //last name
                    Expanded(
                      child: MyTextField(
                        controller: kinRelationController,
                        hintText: 'Kin relation',
                        obscureText: false,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 25),

                // Doctors only
                Card(
                  margin: EdgeInsets.symmetric(horizontal: 25),
                  child: Container(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Sellers only',
                          style: TextStyle(color: Colors.grey[700]),
                        ),
                        const SizedBox(width: 4),
                        GestureDetector(
                          onTap: doctorRegisterPage,
                          child: Text(
                            'Sellers Register here',
                            style: TextStyle(
                              color: Colors.green[600],
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 25),

                // finish with
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Divider(
                          thickness: 0.5,
                          color: Colors.grey[400],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Text(
                          'finish with',
                          style: TextStyle(color: Colors.grey[700]),
                        ),
                      ),
                      Expanded(
                        child: Divider(
                          thickness: 0.5,
                          color: Colors.grey[400],
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 30),

                // google + apple sign in buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // google button
                    InkWell(
                      onTap:  (){signUserUp(true);},
                      child: Column(
                        children: [
                          SquareTile(imagePath: 'assets/images/google.png'),
                          Text(
                            'Finishing Register With Gmail',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),

                    // SizedBox(width: 25),
                    //
                    // // apple button
                    // SquareTile(imagePath: 'assets/images/apple.png')
                  ],
                ),

                const SizedBox(height: 30),

                // already a member? login now
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Already have an account?',
                      style: TextStyle(color: Colors.grey[700]),
                    ),
                    const SizedBox(width: 4),
                    GestureDetector(
                      onTap: widget.onTap,
                      child: Text(
                        'Login now',
                        style: TextStyle(
                          color: Colors.green[600],
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 30,),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
