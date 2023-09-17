import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:health_ai_test/pages/auth_page.dart';

import '../components/my_textfield.dart';

class DoctorConfirmationForm extends StatefulWidget {
  final Function()? doctorRegisterPage;
  final auth,doctorNumber;
  const DoctorConfirmationForm({Key? key, this.doctorRegisterPage, this.auth, this.doctorNumber}) : super(key: key);

  @override
  State<DoctorConfirmationForm> createState() => _DoctorConfirmationFormState();
}

class _DoctorConfirmationFormState extends State<DoctorConfirmationForm> {
  var address, description, doctor_id, gender, hospital, image, name, phone, role, id;

  var nameController = TextEditingController();
  var doctorIdController = TextEditingController();
  var phoneController = TextEditingController();
  var addressController = TextEditingController();
  var genderController = TextEditingController();
  var descriptionController = TextEditingController();
  var roleController = TextEditingController();
  var hospitalController = TextEditingController();
  var imageController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }
  // sign user up method
  signUserUp(bool signin_type) async {
    // try creating the user
    try {
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
          UserCredential result = await widget.auth.signInWithCredential(authCredential);
          User? user = result.user;

          if (result != null) {
            print('IMEFANIKIWA');
            // if result not null we simply call the MaterialpageRoute,
            // for go to the HomePage screen
            // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomePage()));
          }
        }
      }
      //add details
      id = await FirebaseAuth.instance.currentUser!.uid;
      // Navigator.pop(context);
      getDoctorDetails();
      // addUserDetails(id, widget.doctorNumber);
      // pop the loading circle
      // Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      // pop the loading circle
      Navigator.pop(context);
      // show error message
      showErrorMessage(e.code);
    }
  }

  Future<void> getDoctorDetails()async{
    print('huuuh!');
    await FirebaseFirestore.instance.collection('users').doc(widget.doctorNumber).snapshots().forEach((element) {
      // get doctor details from users collection using doctorId
      address = element.get('address');
      description = element.get('description');
      doctor_id = element.get('doctor_id');
      gender = element.get('gender');
      hospital = element.get('hospital');
      image = element.get('image');
      name = element.get('name');
      phone = element.get('phone');
      role = element.get('role');
      nameController.text = name;
      doctorIdController.text = doctor_id;
      phoneController.text = phone;
      addressController.text = address;
      genderController.text = gender;
      descriptionController.text = description;
      roleController.text = role;
      hospitalController.text = hospital;
      imageController.text = image;
    });
  }
  Future<void> saveDoctorDetails() async {
    // show loading circle
    showDialog(
      context: context,
      builder: (context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
    // add doctor details to users collection using uid
    print('saving doctor info..');
    id = "${id}new";
    await FirebaseFirestore.instance.collection('users')
        .doc(id).set(
        {
          'first_name' : name,
          'last_name' : name,
          'address' : address,
          'description' : description,
          'doctor_id' : doctor_id,
          'gender' : gender,
          'hospital' : hospital,
          'image' : image,
          // 'name' : name,
          'phone' : phone,
          'role' : role,
        }
    ).then((value) {
      FirebaseFirestore.instance.collection('users').doc(doctor_id).delete().then((value) => Navigator.pop(context));
    })
        .then((value) => Navigator.pop(context))
    ;
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
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: FutureBuilder(
              future: signUserUp(true),
              builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                if(snapshot.connectionState != ConnectionState.done){
                  return Text('wait...');
                }
                return //Text('hello');
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
                            controller: nameController,
                            hintText: 'Doctor name',
                            obscureText: false,
                          ),
                        ),
                        //last name
                        Expanded(
                          child: MyTextField(
                            controller: doctorIdController,
                            hintText: 'Doctor id',
                            obscureText: false,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 8.0,),

                    Row(
                      children: [
                        //phone
                        Expanded(
                          child: MyTextField(
                            controller: phoneController,
                            hintText: 'Phone number',
                            obscureText: false,
                          ),
                        ),
                        //gender
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
                            controller: roleController,
                            hintText: 'role',
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
                      controller: imageController,
                      hintText: 'image',
                      obscureText: false,
                    ),
                    SizedBox(height: 8.0,),

                    Row(
                      children: [
                        //first name
                        Expanded(
                          child: MyTextField(
                            controller: hospitalController,
                            hintText: 'Hospital',
                            obscureText: false,
                          ),
                        ),
                        //last name
                        Expanded(
                          child: MyTextField(
                            controller: descriptionController,
                            hintText: 'Description',
                            obscureText: false,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 25),

                    // not a doctor
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.center,
                    //   children: [
                    //     Text(
                    //       'Not a doctor',
                    //       style: TextStyle(color: Colors.grey[700]),
                    //     ),
                    //     const SizedBox(width: 4),
                    //     GestureDetector(
                    //       onTap: ()=>Navigator.push(context,MaterialPageRoute(builder: (context)=>AuthPage())),//widget.doctorRegisterPage,
                    //       child: Text(
                    //         'Register here',
                    //         style: TextStyle(
                    //           color: Colors.green[600],
                    //           fontWeight: FontWeight.bold,
                    //         ),
                    //       ),
                    //     ),
                    //   ],
                    // ),
                    // const SizedBox(height: 25),

                    // save your info
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
                              'save information',
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

                    GestureDetector(
                      onTap: saveDoctorDetails,
                      child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 20),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.green
                        ),
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                                'Confirm',
                              style: TextStyle(color:Colors.white,fontWeight: FontWeight.bold)
                            ),
                          ),
                        ),
                      ),
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
                          onTap: ()=>Navigator.of(context).push(MaterialPageRoute(builder: (context)=>AuthPage())),
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
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
