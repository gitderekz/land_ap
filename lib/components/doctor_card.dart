import 'package:flutter/material.dart';
import 'package:health_ai_test/components/read_more.dart';

class DoctorCard extends StatelessWidget {
  final doctorImagePath;
  final doctorName;
  final doctorProfession;
  final hospitalId;
  final hospitalSnapshot;
  final receptionPhone;
  // user details
  final userFirstName;
  final userLastName;
  final userAddress;
  final userGender;
  final userPhone;
  final userId;

  const DoctorCard({
    Key? key,
    required this.doctorImagePath,
    required this.doctorName,
    required this.doctorProfession,
    required this.hospitalId,
    required this.hospitalSnapshot,
    required this.receptionPhone,required this.userFirstName,required this.userLastName,required this.userAddress,required this.userGender,required this.userPhone,required this.userId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return
      Padding(
        padding: const EdgeInsets.only(left: 25.0),
        child: Container(
          width: 150,
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: BorderRadius.circular(12)
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              //picture
              ClipRRect(
                borderRadius: BorderRadius.circular(50),
                child: Image.network(
                  doctorImagePath,
                  height: 100,
                ),
              ),
              SizedBox(height: 10,),

              //rating
              // Row(
              //   children: [
              //     Icon(
              //       Icons.star,
              //       color: Colors.yellow[600],
              //     ),
              //     Text(
              //       doctorRate,
              //       style: TextStyle(
              //         fontWeight: FontWeight.bold,
              //       ),
              //     ),
              //   ],
              // ),
              // SizedBox(height: 10,),

              //doctor name
              Text(
                doctorName,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  overflow: TextOverflow.clip
                ),
              ),

              //doctor title
              Text(doctorProfession,overflow: TextOverflow.ellipsis,),
              SizedBox(height: 10,),

              //read more
              ReadMore(
                hospitalImagePath: doctorImagePath,
                hospitalName: doctorName,
                hospitalLocation: hospitalId,
                hospitalDescription: doctorProfession,
                hospitalSnapshot: hospitalSnapshot,
                hospitalId:hospitalId,
                receptionPhone:receptionPhone,
                  // user details
                  userFirstName:userFirstName,
                  userLastName:userLastName,
                  userAddress:userAddress,
                  userGender:userGender,
                  userPhone:userPhone,
                  userId:userId
              ),
              // Text(
              //   'Read more',
              //   style: TextStyle(
              //     fontWeight: FontWeight.bold,
              //     color: Colors.green,
              //     fontSize: 16,
              //   ),
              // )
            ],
          ),
        ),
      );
  }
}
