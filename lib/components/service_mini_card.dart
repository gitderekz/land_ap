import 'package:flutter/material.dart';
import 'package:health_ai_test/components/read_more.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../firebase/hifadhi_shughuli.dart';
import 'bottom_page.dart';
import 'make_call.dart';

class ServiceMiniCard extends StatefulWidget {
  final kiwanjaImagePath;
  final kiwanjaName;
  final kiwanjaMahali;
  final kiwanjaId;
  final kiwanjaNjia;
  final kiwanjaBio;
  final kiwanjaBei;
  final kiwanjaSnapshot;
  final receptionPhone;
  // user details
  final userFirstName;
  final userLastName;
  final userAddress;
  final userGender;
  final userPhone;
  final userId;

  const ServiceMiniCard({
    Key? key,
    required this.kiwanjaImagePath,
    required this.kiwanjaName,
    required this.kiwanjaMahali,
    required this.kiwanjaId,
    required this.kiwanjaNjia,
    required this.kiwanjaBio,
    required this.kiwanjaBei,
    required this.kiwanjaSnapshot,
    required this.receptionPhone,
    required this.userFirstName,
    required this.userLastName,
    required this.userAddress,
    required this.userGender,
    required this.userPhone,
    required this.userId,
  }) : super(key: key);

  @override
  State<ServiceMiniCard> createState() => _ServiceMiniCardState();
}

class _ServiceMiniCardState extends State<ServiceMiniCard> {
  Color rangiToroli = Colors.white;
  Color rangiPenda = Colors.white;
  List<bool> badiliRangi = [false, false];
  bool maongezi = false, lipa = false;
  var safu_njia = [];
  var kilicho_pendwa = '';

  matukioKurasaYaChini(dhumuni, bidhaaId) async {
    if (dhumuni == 'maongezi') {
      setState(() {
        maongezi = !maongezi;
        print(maongezi);
      });
    }
    if (dhumuni == 'lipa') {
      setState(() {
        lipa = !lipa;
      });
    }
    if (dhumuni == 'toroli') {
      badiliRangi[0] = !badiliRangi[0];
      String message = await hifadhiShughuli().saveData(
        userFirstName: widget.userFirstName,
        userLastName: widget.userLastName,
        userPhone: widget.userPhone,
        userId: widget.userId,
        njia: widget.kiwanjaNjia,
        muda_asili: safu_njia[5],
        shughuli: dhumuni,
        kazi: badiliRangi[0],
        context: context,
      );
      setState(() {
        badiliRangi[0] == true ? rangiToroli = Colors.deepOrangeAccent.shade700 : rangiToroli = Colors.white;
      });
      if (message == 'haijafanikiwa') {
        setState(() {
          badiliRangi[0] == true ? rangiToroli = Colors.deepOrangeAccent.shade700 : rangiToroli = Colors.white;
        });
      }
    }
    if (dhumuni == 'penda') {
      badiliRangi[1] = !badiliRangi[1];
      String message = await hifadhiShughuli().saveData(userFirstName: widget.userFirstName, userLastName: widget.userLastName, userPhone: widget.userPhone, userId: widget.userId, njia: widget.kiwanjaNjia, muda_asili: safu_njia[5], shughuli: dhumuni, kazi: badiliRangi[1], context: context);
      setState(() {
        badiliRangi[1] == true ? rangiPenda = Colors.deepOrangeAccent.shade700 : rangiPenda = Colors.white;
      });
      if (message == 'haijafanikiwa') {
        setState(() {
          badiliRangi[1] == true ? rangiPenda = Colors.deepOrangeAccent.shade700 : rangiPenda = Colors.white;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => showModalBottomSheet(
          isScrollControlled: true,
          constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.height * (3 / 4)),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(25.0))),
          context: context,
          // builder: (context)=>readMore(context)
          builder: (context) => KurasaYaChini(
              kiwanjaImagePath: widget.kiwanjaImagePath,
              kiwanjaName: widget.kiwanjaName,
              kiwanjaMahali: widget.kiwanjaMahali,
              kiwanjaId: widget.kiwanjaId,
              kiwanjaNjia: widget.kiwanjaNjia,
              kiwanjaBio: widget.kiwanjaBio,
              kiwanjaBei: widget.kiwanjaBei,
              kiwanjaSnapshot: widget.kiwanjaSnapshot,
              receptionPhone: widget.receptionPhone,
              // user details
              userFirstName: widget.userFirstName,
              userLastName: widget.userLastName,
              userAddress: widget.userAddress,
              userGender: widget.userGender,
              userPhone: widget.userPhone,
              userId: widget.userId)),
      child: Padding(
        padding: EdgeInsets.zero,
        child: Container(
          width: 160,
          padding: EdgeInsets.all(8.0),
          decoration: BoxDecoration(color: Theme.of(context).cardColor, borderRadius: BorderRadius.circular(12)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              //picture
              Container(
                decoration: BoxDecoration(
                    // color: Colors.yellow[50],
                    // borderRadius: BorderRadius.circular(20),
                    ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20.0),
                  child: Image.network(
                    widget.kiwanjaImagePath[0],
                    height: 90,
                    // width: 100,
                  ),
                ),
              ),

              SizedBox(
                height: 0.0,
              ),

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
                widget.kiwanjaName,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, overflow: TextOverflow.clip),
              ),

              //doctor title
              Text(
                widget.kiwanjaMahali,
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(
                height: 10,
              ),

              //read more
              // ReadMore(
              //   hospitalImagePath: kiwanjaImagePath,
              //   hospitalName: kiwanjaName,
              //   hospitalLocation: kiwanjaId,
              //   hospitalDescription: kiwanjaMahali,
              //   kiwanjaSnapshot: kiwanjaSnapshot,
              //   kiwanjaId:kiwanjaId,
              //   receptionPhone:receptionPhone,
              //     // user details
              //     userFirstName:userFirstName,
              //     userLastName:userLastName,
              //     userAddress:userAddress,
              //     userGender:userGender,
              //     userPhone:userPhone,
              //     userId:userId
              // ),
            ],
          ),
        ),
      ),
    );
  }

  //bottom sheet
  Widget readMore(context) {
    return Container(
      padding: EdgeInsets.all(25.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            // height: 200,                             //commented
            child: Padding(
              //added
              padding: const EdgeInsets.all(0.0),
              child: Column(
                //ListView -> Column
                // scrollDirection: Axis.vertical,      //commented
                children: [
                  // //picture
                  // ClipRRect(
                  //   borderRadius: BorderRadius.circular(8.0),
                  //   child: Image.network(
                  //     widget.kiwanjaImagePath[0],
                  //     height: 150,
                  //   ),
                  // ),

                  SizedBox(
                    height: 150,
                    width: MediaQuery.of(context).size.width,
                    child: Center(
                      child: GridView.builder(
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            // maxCrossAxisExtent: MediaQuery.of(context).size.width,
                            // mainAxisSpacing:8.0,
                            // crossAxisSpacing:8.0,
                            childAspectRatio: 0.5,
                            crossAxisCount: 1,
                          ),
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          // padding: const EdgeInsets.only(right: 25.0),
                          primary: false,
                          itemCount: widget.kiwanjaImagePath!.length,
                          itemBuilder: (context, index) {
                            return ClipRRect(
                              borderRadius: BorderRadius.circular(8.0),
                              child: Image.network(
                                widget.kiwanjaImagePath.elementAt(index),
                                height: 150,
                              ),
                            );
                          }),
                    ),
                  ),

                  SizedBox(
                    height: 10,
                  ),

                  //kiwanja jina
                  !maongezi && !lipa
                      ? Text(
                          widget.kiwanjaName,
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, overflow: TextOverflow.clip),
                        )
                      : SizedBox(
                          height: 0,
                        ),

                  //hospital location
                  !maongezi && !lipa
                      ? Text(widget.kiwanjaId)
                      : SizedBox(
                          height: 0,
                        ),

                  //bidhaa bei
                  !maongezi && !lipa ? Text(widget.kiwanjaBei) : SizedBox(height: 0),

                  //hospital description
                  !maongezi && !lipa
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Expanded(
                              child: Text(
                                widget.kiwanjaMahali,
                                overflow: TextOverflow.visible,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        )
                      : SizedBox(height: 0),
                  SizedBox(
                    height: 10,
                  ),

                  maongezi
                      ? Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                          decoration: BoxDecoration(
                            color: Theme.of(context).cardColor, //Colors.orangeAccent[200],
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: IntrinsicHeight(
                              child: Column(children: [
                            Row(
                              children: [
                                Container(padding: EdgeInsets.symmetric(horizontal: 3.0, vertical: 2.0), decoration: BoxDecoration(color: Colors.deepOrange.shade100, borderRadius: BorderRadius.only(bottomRight: Radius.circular(8.0), topRight: Radius.circular(8.0), topLeft: Radius.circular(8.0))), child: Text('Mambo..')),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Container(padding: EdgeInsets.symmetric(horizontal: 3.0, vertical: 2.0), decoration: BoxDecoration(color: Colors.deepOrange.shade100, borderRadius: BorderRadius.only(bottomLeft: Radius.circular(8.0), topLeft: Radius.circular(8.0), topRight: Radius.circular(8.0))), child: Text('Poa niaje..?')),
                              ],
                            ),
                            SizedBox(
                              height: 8.0,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Flexible(
                                  child: Container(
                                    height: 40,
                                    padding: EdgeInsets.symmetric(horizontal: 3.0, vertical: 2.0),
                                    decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20)),
                                    child: TextField(
                                      textAlign: TextAlign.justify,
                                      textAlignVertical: TextAlignVertical.bottom,
                                      decoration: InputDecoration(
                                        // prefixIcon: Icon(Icons.emoji_emotions_rounded),
                                        suffixIcon: Icon(Icons.send),
                                        border: InputBorder.none,
                                        hintText: 'andika swali/maoni',
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ])))
                      : SizedBox(
                          height: 0,
                        ),

                  lipa
                      ? Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                          decoration: BoxDecoration(
                            color: Theme.of(context).cardColor, //Colors.orangeAccent[200],
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: IntrinsicHeight(
                            child: Column(children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                      padding: EdgeInsets.symmetric(horizontal: 3.0, vertical: 2.0),
                                      decoration: BoxDecoration(
                                          // color: Colors.deepOrange.shade100,
                                          borderRadius: BorderRadius.only(bottomRight: Radius.circular(8.0), topRight: Radius.circular(8.0), topLeft: Radius.circular(8.0))),
                                      child: Text('Malipo hayajaunganishwa kwasasa..')),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  InkWell(
                                    onTap: () => showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return MakeCall(
                                            receptionPhone: widget.receptionPhone,
                                          );
                                        }),
                                    child: Container(
                                      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                                      decoration: BoxDecoration(
                                        color: Colors.orangeAccent[200],
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: Center(
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              'Piga simu kuwasiliana',
                                              style: TextStyle(
                                                color: Colors.white,
                                              ),
                                            ),
                                            Icon(
                                              Icons.call,
                                              color: Colors.white,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ]),
                          ),
                        )
                      : SizedBox(
                          height: 0,
                        ),
                ],
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                onTap: () => Navigator.pop(context),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  decoration: BoxDecoration(
                    color: Colors.red[100],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Center(
                    child: Text(
                      AppLocalizations.of(context)!.close,
                      style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                decoration: BoxDecoration(
                  color: Colors.orangeAccent[200],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: IntrinsicHeight(
                  child: Row(
                    children: [
                      InkWell(
                        onTap: () => matukioKurasaYaChini('maongezi', widget.kiwanjaId),
                        child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 2.0),
                            child: Icon(
                              maongezi ? Icons.expand_less : Icons.chat_outlined,
                              color: Colors.white,
                            )),
                      ),
                      VerticalDivider(
                        color: Colors.white,
                        thickness: 2,
                        indent: 5,
                        endIndent: 0,
                      ),
                      InkWell(
                        onTap: () => matukioKurasaYaChini('mahali', widget.kiwanjaId),
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 2.0),
                          child: Icon(
                            Icons.location_on_outlined,
                            color: Colors.white,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                decoration: BoxDecoration(
                  color: Colors.orangeAccent[200],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: IntrinsicHeight(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Icon(Icons.money,color: Colors.white,),
                      InkWell(
                        onTap: () => matukioKurasaYaChini('lipa', widget.kiwanjaId),
                        child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 2.0),
                            child: lipa
                                ? Icon(
                                    Icons.expand_less,
                                    color: Colors.white,
                                  )
                                : Text('lipa',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ))),
                      ),
                      VerticalDivider(
                        color: Colors.white,
                        thickness: 2,
                        indent: 5,
                        endIndent: 0,
                      ),
                      InkWell(
                        onTap: () => matukioKurasaYaChini('toroli', widget.kiwanjaId),
                        child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 2.0),
                            child: Icon(
                              Icons.shopping_cart_rounded,
                              color: rangiToroli,
                            )),
                      ),
                      VerticalDivider(
                        color: Colors.white,
                        thickness: 2,
                        indent: 5,
                        endIndent: 0,
                      ),
                      InkWell(
                        onTap: () => matukioKurasaYaChini('penda', widget.kiwanjaId),
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 2.0),
                          child: Icon(
                            Icons.favorite,
                            color: rangiPenda,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
