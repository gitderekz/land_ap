import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';

class MakeCall extends StatefulWidget {
  final receptionPhone;
  const MakeCall({Key? key,required this.receptionPhone}) : super(key: key);

  @override
  State<MakeCall> createState() => _MakeCallState();
}

class _MakeCallState extends State<MakeCall> {
  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      title: Column(
        children: [
          Center(
            child: Text(
              'make a call',
              style: TextStyle(color: Colors.green),
            ),
          ),
          Divider(
            color: Colors.grey,
            thickness: 0.5,
          ),
        ],
      ),
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.min,
          children: [
            InkWell(
              onTap: () async {
                Navigator.pop(context);
                await FlutterPhoneDirectCaller.callNumber(widget.receptionPhone.toString());
              },
              child: Container(
                width: 150,
                padding: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                decoration: BoxDecoration(
                  color: Colors.green[100],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Icon(Icons.call_outlined,color: Colors.green,),
                      Text(
                        'Continue',
                        style: TextStyle(
                            color: Colors.green,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            SizedBox(height: 20,),

            //close
            InkWell(
              onTap: ()=>Navigator.pop(context),
              child: Container(
                width: 150,
                padding: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                decoration: BoxDecoration(
                  color: Colors.red[100],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(
                  child: Text(
                    'Close',
                    style: TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          ],
        ),



      ],
    );
  }
}
