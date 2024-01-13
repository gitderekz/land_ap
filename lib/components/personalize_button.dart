import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:health_ai_test/provider/theme_provider.dart';
import 'options_popup.dart';

class PersonalizeButton extends StatefulWidget {
  final Widget? child;
  final EdgeInsetsGeometry? padding;
  final Decoration? decoration;
  final String userFirstName;
  final String userLastName;
  final String userAddress;
  final String userGender;
  final String userPhone;
  final String userImage;
  final String userId;
  const PersonalizeButton({Key? key, this.child, this.padding, this.decoration, required this.userFirstName, required this.userLastName, required this.userAddress, required this.userGender, required this.userPhone, required this.userImage, required this.userId}) : super(key: key);

  @override
  PersonalizeButtonState createState() => PersonalizeButtonState();
}

class PersonalizeButtonState extends State<PersonalizeButton> {
  @override
  Widget build(BuildContext context) {
    final orangeCardColor = Provider.of<ThemeProvider>(context).themeMode == ThemeMode.dark
        ? Theme.of(context).cardColor
        // : Colors.green[100];
        : Colors.orange[100];
    return InkWell(
      onTap: () => showDialog(
          context: context,
          builder: (BuildContext context) {
            return OptionsPopup(
              userFirstName: widget.userFirstName,
              userLastName: widget.userLastName,
              userAddress: widget.userAddress,
              userGender: widget.userGender,
              userPhone: widget.userPhone,
              userId: widget.userId,
              userImage: widget.userImage,
            );
          }),
      child: Container(
          padding: EdgeInsets.all(10), //12
          decoration: BoxDecoration(
            color: orangeCardColor, //greenCardColor,
            borderRadius: BorderRadius.circular(12),
          ),
          child:
              // Image.asset(
              //   'assets/icons/logo48.ico',
              //   height: 30,
              // ),
              Icon(
            Icons.person,
            color: Colors.white,
          )),
    );
  }
}
