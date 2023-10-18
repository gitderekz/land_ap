import 'package:flutter/material.dart';

import 'make_call.dart';
import 'options_popup.dart';

class ClinicCard extends StatelessWidget {
  final iconImagePath,receptionPhone;
  final String categoryName;

  const ClinicCard({Key? key,required this.iconImagePath, required this.categoryName, required this.receptionPhone}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return
      Padding(
        padding: const EdgeInsets.only(left: 8.0),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: Theme.of(context).cardColor,
          ),
          padding: EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.asset(
                    iconImagePath,
                    height: 30,
                  ),
                  SizedBox(width: 20,),
                  Text(categoryName),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                      onTap: ()=>showDialog(context: context, builder: (BuildContext context) { return MakeCall(receptionPhone: receptionPhone,); }),
                      child: Icon(
                        Icons.call_outlined,
                        color: Colors.green[600],
                      )
                  )
                ],
              ),
            ],
          ),
        ),
      );
  }
}
