import 'dart:typed_data';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:health_ai_test/components/utils.dart';
import 'package:image_picker/image_picker.dart';

// import '../firebase/add_data_categories.dart';
// import '../firebase/add_data_bidhaa.dart';
// import '../firebase/add_data_discounts.dart';
import 'add_data_companies.dart';
import 'add_data_deals.dart';

class UploadPopupCompanies extends StatefulWidget {
  // user details
  final userFirstName;
  final userLastName;
  final userAddress;
  final userGender;
  final userPhone;
  final userId;
  const UploadPopupCompanies({Key? key, required this.userFirstName, required this.userLastName, required this.userGender, required this.userPhone, required this.userId, required this.userAddress}) : super(key: key);

  @override
  State<UploadPopupCompanies> createState() => _UploadPopupCompaniesState();
}

class _UploadPopupCompaniesState extends State<UploadPopupCompanies> {
  GoogleSignIn _googleSignIn = GoogleSignIn();
  List<Uint8List>? _image = [];
  final TextEditingController nameController = TextEditingController();
  final TextEditingController bioController = TextEditingController();
  final TextEditingController beiController = TextEditingController();
  String nchi = '-Chagua Nchi';
  List orodhaKundi = ['-Chagua Nchi', 'Tanzania', 'wanawake', 'umeme', 'nyumbani', 'watoto', 'vifaa', 'tafrija', 'ofisi', 'michezo', 'mapambo'];
  List Tanzania = [
    '-Chagua Mkoa',
    'Arusha',
    'Dar es salaam',
    'Dodoma',
    'Kilimanjaro',
    'Mwanza',
  ];
  List wanawake = ['dresses', 'skirts', 'trousers', 'shirts', 'tops', 'bottoms', 'shoes', 'underwear', 'suit', 'sport', 'bags', 'watches', 'accessories'];
  List umeme = ['computers', 'phones', 'watches', 'cameras', 'storages & memories', 'speakers & earphones', 'gaming', 'accessories'];
  List nyumbani = ['lights', 'textiles', 'cooking', 'decors', 'appliances'];
  List watoto = ['boys wear', 'girls wear', 'boys toys', 'girls toys', 'girls shoes', 'boys shoes'];
  List tafrija = ['decorations', 'costumes'];
  List ofisi = ['meza', 'viti', 'picha'];
  List michezo = ['jezi', 'viatu'];
  List mapambo = ['watches', 'rings', 'bracelets', 'necklace', 'belts'];
  String mkoa = '-Chagua Mkoa';
  String wilaya = '-Chagua Wilaya';
  List orodhaKundiDogo = ['-Chagua Mkoa'];
  String matumizi = '-Aina Ya Matumizi';
  List orodhaAina = [
    '-Aina Ya Matumizi',
    'Ujenzi',
    'Shamba',
    'Biashara',
    'Michezo',
    'Starehe',
  ];
  List orodhaWilaya = ['-Chagua Wilaya', 'Kinondoni', 'Ilala', 'Temeke', 'Ubungo', 'Kawe', 'Arumeru', 'Arusha', 'Moshi', 'Hai', 'Kia', 'Same'];
  bool loading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  void selectImage() async {
    List<Uint8List> img = await pickImage(ImageSource.gallery);
    setState(() {
      _image = img;
    });
  }

  Future<String> hifadhiCompanies() async {
    String name = nameController.text;
    String bio = bioController.text;
    String bei = beiController.text;
    String message = await Companies().saveData(name: name, bio: bio, bei: bei, nchi: nchi, mkoa: mkoa, wilaya: wilaya, matumizi: matumizi, file: _image!, userFirstName: widget.userFirstName, userLastName: widget.userLastName, userPhone: widget.userPhone, userId: widget.userId, context: context);
    return message;
  }

  // sign user out method
  Future<void> signUserOut() async {
    // await _googleSignIn.disconnect();
    await _googleSignIn.signOut();
    await FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    // return showDialog(context: context, builder: (BuildContext context) { return SimpleDialog(title: Text(''),children: [],); });
    return SimpleDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      title: const Center(child: Text('Register Company')),
      children: [
        loading
            ? Center(child: CircularProgressIndicator())
            : Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.min,
                children: [
                  _image!.isNotEmpty
                      ? SizedBox(
                          height: 100,
                          width: MediaQuery.of(context).size.width,
                          child: GridView.builder(
                              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                // maxCrossAxisExtent: MediaQuery.of(context).size.width,
                                // mainAxisSpacing:8.0,
                                // crossAxisSpacing:8.0,
                                childAspectRatio: 1,
                                crossAxisCount: 1,
                              ),
                              scrollDirection: Axis.horizontal,
                              shrinkWrap: true,
                              // padding: const EdgeInsets.only(right: 25.0),
                              primary: false,
                              itemCount: _image!.length,
                              itemBuilder: (context, index) {
                                return CircleAvatar(radius: 65, backgroundImage: MemoryImage(_image!.elementAt(index)));
                              }),
                        )
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Flexible(
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: const Icon(
                                  Icons.photo_camera_back,
                                  size: 50,
                                ), //Image.asset(''),
                              ),
                            ),
                            Flexible(
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: const Icon(
                                  Icons.card_giftcard,
                                  size: 50,
                                ), //Image.asset(''),
                              ),
                            )
                          ],
                        ),
                  Center(
                    child: IconButton(
                        onPressed: selectImage,
                        icon: const Icon(
                          Icons.add_a_photo,
                          color: Colors.black,
                        )),
                  ),
                  const SizedBox(
                    height: 0,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      controller: nameController,
                      decoration: const InputDecoration(
                        hintText: 'Ingiza jina',
                        contentPadding: EdgeInsets.all(10),
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),

                  // Padding(
                  //   padding: const EdgeInsets.all(8.0),
                  //   child: TextField(
                  //     controller: beiController,
                  //     decoration: const InputDecoration(
                  //       hintText: 'Ingiza bei',
                  //       contentPadding: EdgeInsets.all(10),
                  //       border: OutlineInputBorder(),
                  //     ),
                  //   ),
                  // ),

                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      controller: bioController,
                      decoration: const InputDecoration(
                        hintText: 'Ingiza maelezo',
                        contentPadding: EdgeInsets.all(10),
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),

                  // // matumizi dropdown
                  // Container(
                  //   margin: const EdgeInsets.symmetric(horizontal: 25.0),
                  //   decoration: BoxDecoration(
                  //       borderRadius: BorderRadius.circular(15),
                  //       border: Border.all(color: Theme.of(context).cardColor,width: 1)
                  //   ),
                  //   child: Padding(
                  //     padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  //     child: DropdownButton(
                  //       hint: Text('Chagua kundi'),
                  //       isExpanded: true,
                  //       value: matumizi,
                  //       icon: Icon(Icons.arrow_drop_down),
                  //       iconSize: 36.0,
                  //       underline: SizedBox(),
                  //       onChanged: (newValue){
                  //         setState(() {
                  //           matumizi = newValue.toString();
                  //         });
                  //       },
                  //       items: orodhaAina.map((value){
                  //         // jazaOrodhaKundi();
                  //         return DropdownMenuItem(
                  //             value: value,
                  //             child: Text(value)
                  //         );
                  //       }).toList(),
                  //     ),
                  //   ),
                  // ),

                  // nchi dropdown
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 25.0),
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(15), border: Border.all(color: Theme.of(context).cardColor, width: 1)),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: DropdownButton(
                        hint: Text('Chagua kundi'),
                        isExpanded: true,
                        value: nchi,
                        icon: Icon(Icons.arrow_drop_down),
                        iconSize: 36.0,
                        underline: SizedBox(),
                        onChanged: (newValue) {
                          setState(() {
                            nchi = newValue.toString();
                            mkoa = '-Chagua Mkoa';
                            orodhaKundiDogo = ['-Chagua Mkoa'];
                            jazaKundiDogo(nchi);
                          });
                        },
                        items: orodhaKundi.map((value) {
                          // jazaOrodhaKundi();
                          return DropdownMenuItem(value: value, child: Text(value));
                        }).toList(),
                      ),
                    ),
                  ),

                  // mikoa dropdown
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 25.0),
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(15), border: Border.all(color: Theme.of(context).cardColor, width: 1)),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: DropdownButton(
                        hint: Text('Chagua kundi dogo'),
                        isExpanded: true,
                        value: mkoa,
                        icon: Icon(Icons.arrow_drop_down),
                        iconSize: 36.0,
                        underline: SizedBox(),
                        onChanged: (newValue) {
                          // get doctor id
                          int index = 0;
                          orodhaKundiDogo.forEach((element) {
                            if (newValue.toString() == element.toString()) {
                              mkoa = orodhaKundiDogo[index];
                            }
                            index++;
                          });
                          setState(() {
                            mkoa = newValue.toString();
                          });
                        },
                        items: orodhaKundiDogo.map((value) {
                          return DropdownMenuItem(value: value, child: Text(value));
                        }).toList(),
                      ),
                    ),
                  ),

                  // wilaya dropdown
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 25.0),
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(15), border: Border.all(color: Theme.of(context).cardColor, width: 1)),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: DropdownButton(
                        hint: Text('Chagua Wilaya'),
                        isExpanded: true,
                        value: wilaya,
                        icon: Icon(Icons.arrow_drop_down),
                        iconSize: 36.0,
                        underline: SizedBox(),
                        onChanged: (newValue) {
                          setState(() {
                            wilaya = newValue.toString();
                          });
                        },
                        items: orodhaWilaya.map((value) {
                          // jazaOrodhaKundi();
                          return DropdownMenuItem(value: value, child: Text(value));
                        }).toList(),
                      ),
                    ),
                  ),

                  const SizedBox(
                    height: 8,
                  ),

                  // hifadhi punguzo
                  InkWell(
                    onTap: () async {
                      setState(() {
                        loading = true;
                      });
                      await hifadhiCompanies();
                      setState(() {
                        loading = false;
                      });
                      closeDialog();
                    },
                    child: Container(
                      width: 150,
                      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      decoration: BoxDecoration(
                        color: Colors.green[100],
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Icon(
                              Icons.cloud_upload_rounded,
                              color: Colors.green,
                            ),
                            Text(
                              'Register',
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),

                  //close
                  InkWell(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      width: 150,
                      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      decoration: BoxDecoration(
                        color: Colors.lime[100],
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Center(
                        child: Text(
                          'Close',
                          style: TextStyle(color: Colors.lime[600], fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
      ],
    );
  }

  void closeDialog() {
    Navigator.pop(context);
  }

  void jazaKundiDogo(String nchi) {
    setState(() {
      if (nchi == "Tanzania") {
        orodhaKundiDogo = Tanzania;
      }
      if (nchi == "wanawake") {
        orodhaKundiDogo = wanawake;
      }
      if (nchi == "umeme") {
        orodhaKundiDogo = umeme;
      }
      if (nchi == "nyumbani") {
        orodhaKundiDogo = nyumbani;
      }
      if (nchi == "watoto") {
        orodhaKundiDogo = watoto;
      }
      if (nchi == "tafrija") {
        orodhaKundiDogo = tafrija;
      }
      if (nchi == "ofisi") {
        orodhaKundiDogo = ofisi;
      }
      if (nchi == "michezo") {
        orodhaKundiDogo = michezo;
      }
      if (nchi == "mapambo") {
        orodhaKundiDogo = mapambo;
      }
      mkoa = orodhaKundiDogo[0];
    });
  }
}
