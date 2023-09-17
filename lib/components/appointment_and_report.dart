import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/theme_provider.dart';

class AppointmentAndReport extends StatelessWidget {
  final iconImagePath;
  final String categoryName;

  const AppointmentAndReport({Key? key,required this.iconImagePath, required this.categoryName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final orangeCardColor = Provider.of<ThemeProvider>(context).themeMode == ThemeMode.dark
      ? Colors.deepOrange[200]
      : Colors.deepOrange[100];
    return
       Container(
         width: 150,
         decoration: BoxDecoration(
           borderRadius: BorderRadius.circular(12),
           color: orangeCardColor,
         ),
         padding: EdgeInsets.all(20.0),
         child: Row(
           children: [
             Image.asset(
               iconImagePath,
               height: 30,
             ),
             SizedBox(width: 20,),
             Flexible(
               child: Text(
                 categoryName,
                 overflow: TextOverflow.ellipsis,
                 style: TextStyle(
                   // fontSize: 10,
                 ),
               ),
             ),
           ],
         ),
       );
  }
}
