import 'package:flutter/material.dart';

import '../components/my_textfield.dart';
import '../components/square_tile.dart';
import 'doctor_confirmation_form.dart';

class DoctorRegisterPage extends StatefulWidget {
  final Function()? doctorRegisterPage;
  final auth,onTap;
  const DoctorRegisterPage({Key? key,required this.auth,required this.onTap,required this.doctorRegisterPage }) : super(key: key);

  @override
  State<DoctorRegisterPage> createState() => _DoctorRegisterPageState();
}

class _DoctorRegisterPageState extends State<DoctorRegisterPage> {
  final doctorNumberController = TextEditingController();

  @override
  void dispose() {
    doctorNumberController.dispose();
    super.dispose();
  }



  @override
  Widget build(BuildContext context) {
    return Column(
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

        MyTextField(
          controller: doctorNumberController,
          hintText: 'Seller\'s number',
          obscureText: false,
        ),
        SizedBox(height: 8.0,),

        // not a doctor
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Not a seller',
              style: TextStyle(color: Colors.grey[700]),
            ),
            const SizedBox(width: 4),
            GestureDetector(
              onTap: widget.doctorRegisterPage,
              child: Text(
                'Go back',
                style: TextStyle(
                  color: Colors.green[600],
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
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
              onTap:  (){
                String doctorNumber = doctorNumberController.text.trim();
                Navigator.push(context,MaterialPageRoute(builder: (context)=>DoctorConfirmationForm(
                    auth: widget.auth,
                    doctorRegisterPage:widget.doctorRegisterPage,
                    doctorNumber:doctorNumber
                )));
                // signUserUp(true);
                },
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
    );
  }
}

