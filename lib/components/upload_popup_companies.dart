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
  const UploadPopupCompanies({Key? key,required this.userFirstName,required this.userLastName,required this.userGender,required this.userPhone,required this.userId,required this.userAddress}) : super(key: key);

  @override
  State<UploadPopupCompanies> createState() => _UploadPopupCompaniesState();
}

class _UploadPopupCompaniesState extends State<UploadPopupCompanies> {
  GoogleSignIn _googleSignIn = GoogleSignIn();
  List<Uint8List>? _image = [];
  final TextEditingController nameController = TextEditingController();
  final TextEditingController bioController = TextEditingController();
  final TextEditingController beiController = TextEditingController();
  String kundi = '-Chagua Kundi';
  List orodhaKundi = ['-Chagua Kundi','wanaume','wanawake','umeme','nyumbani','watoto','vifaa','tafrija','ofisi','michezo','mapambo'];
  List wanaume = ['trousers','shirts','shoes','underwear','suit','sport','bags','watches','accessories'];
  List wanawake = ['dresses','skirts','trousers','shirts','tops','bottoms','shoes','underwear','suit','sport','bags','watches','accessories'];
  List umeme = ['computers','phones','watches','cameras','storages & memories','speakers & earphones','gaming','accessories'];
  List nyumbani = ['lights','textiles','cooking','decors','appliances'];
  List watoto = ['boys wear','girls wear','boys toys','girls toys','girls shoes','boys shoes'];
  List tafrija = ['decorations','costumes'];
  List ofisi = ['meza','viti','picha'];
  List michezo = ['jezi','viatu'];
  List mapambo = ['watches','rings','bracelets','necklace','belts'];
  String kundiDogo = '-Chagua Kundi Dogo';
  List orodhaKundiDogo = ['-Chagua Kundi Dogo'];
  String aina = '-aina ya punguzo';
  List orodhaAina = ['-aina ya punguzo','punguzo','zawadi'];

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

  Future<String> hifadhiCompanies() async{
    String name = nameController.text;
    String bio = bioController.text;
    String bei = beiController.text;
    String message = await Companies().saveData(aina: aina, name: name, bio: bio, bei: bei, file: _image!,userFirstName: widget.userFirstName,userLastName: widget.userLastName,userPhone: widget.userPhone,userId: widget.userId,kundi: kundi,kundiDogo: kundiDogo);
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
      title: const Center(child: Text('Upload Company')),
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.min,
          children: [
            _image!.isNotEmpty?
            SizedBox(
              height: 100,
              width: MediaQuery.of(context).size.width,
              child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    // maxCrossAxisExtent: MediaQuery.of(context).size.width,
                    // mainAxisSpacing:8.0,
                    // crossAxisSpacing:8.0,
                    childAspectRatio:1,
                    crossAxisCount: 1,
                  ),
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  // padding: const EdgeInsets.only(right: 25.0),
                  primary: false,
                  itemCount: _image!.length,
                  itemBuilder: (context, index) {
                    return  CircleAvatar(
                        radius: 65,
                        backgroundImage: MemoryImage(_image!.elementAt(index))
                    );
                  }
              ),
            )
                :
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Flexible(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: const Icon(Icons.photo_camera_back,size: 50,),//Image.asset(''),
                  ),
                ),
                Flexible(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: const Icon(Icons.card_giftcard,size: 50,),//Image.asset(''),
                  ),
                )
              ],
            ),
            Center(
              child: IconButton(
                  onPressed: selectImage,
                  icon: const Icon(Icons.add_a_photo,color: Colors.black,)
              ),
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

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: beiController,
                decoration: const InputDecoration(
                  hintText: 'Ingiza bei',
                  contentPadding: EdgeInsets.all(10),
                  border: OutlineInputBorder(),
                ),
              ),
            ),

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

            // aina dropdown
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 25.0),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(color: Theme.of(context).cardColor,width: 1)
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: DropdownButton(
                  hint: Text('Chagua kundi'),
                  isExpanded: true,
                  value: aina,
                  icon: Icon(Icons.arrow_drop_down),
                  iconSize: 36.0,
                  underline: SizedBox(),
                  onChanged: (newValue){
                    setState(() {
                      aina = newValue.toString();
                    });
                  },
                  items: orodhaAina.map((value){
                    // jazaOrodhaKundi();
                    return DropdownMenuItem(
                        value: value,
                        child: Text(value)
                    );
                  }).toList(),
                ),
              ),
            ),

            // kundi dropdown
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 25.0),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(color: Theme.of(context).cardColor,width: 1)
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: DropdownButton(
                  hint: Text('Chagua kundi'),
                  isExpanded: true,
                  value: kundi,
                  icon: Icon(Icons.arrow_drop_down),
                  iconSize: 36.0,
                  underline: SizedBox(),
                  onChanged: (newValue){
                    setState(() {
                      kundi = newValue.toString();
                      kundiDogo = '-Chagua kundi dogo';
                      orodhaKundiDogo = ['-Chagua kundi dogo'];
                      jazaKundiDogo(kundi);
                    });
                  },
                  items: orodhaKundi.map((value){
                    // jazaOrodhaKundi();
                    return DropdownMenuItem(
                        value: value,
                        child: Text(value)
                    );
                  }).toList(),
                ),
              ),
            ),

            // kundidogo dropdown
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 25.0),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(color: Theme.of(context).cardColor,width: 1)
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: DropdownButton(
                  hint: Text('Chagua kundi dogo'),
                  isExpanded: true,
                  value: kundiDogo,
                  icon: Icon(Icons.arrow_drop_down),
                  iconSize: 36.0,
                  underline: SizedBox(),
                  onChanged: (newValue){
                    // get doctor id
                    int index = 0;
                    orodhaKundiDogo.forEach((element) {
                      if(newValue.toString() == element.toString()){
                        kundiDogo = orodhaKundiDogo[index];
                      }
                      index++;
                    });
                    setState(() {
                      kundiDogo = newValue.toString();
                    });
                  },
                  items: orodhaKundiDogo.map((value){
                    return DropdownMenuItem(
                        value: value,
                        child: Text(value)
                    );
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
                await hifadhiCompanies();
                closeDialog();
              },
              child: Container(
                width: 150,
                padding: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                decoration: BoxDecoration(
                  color: Colors.green[100],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Icon(Icons.cloud_upload_rounded,color: Colors.green,),
                      Text(
                        'hifadhi bidhaa',
                        textAlign: TextAlign.center,
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
            SizedBox(height: 8,),

            //close
            InkWell(
              onTap: ()=>Navigator.pop(context),
              child: Container(
                width: 150,
                padding: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                decoration: BoxDecoration(
                  color: Colors.lime[100],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(
                  child: Text(
                    'Close',
                    style: TextStyle(
                        color: Colors.lime[600],
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

  void closeDialog(){
    Navigator.pop(context);
  }

  void jazaKundiDogo(String kundi){
    setState(() {
      if(kundi == "wanaume"){
        orodhaKundiDogo = wanaume;
      }
      if(kundi == "wanawake"){
        orodhaKundiDogo = wanawake;
      }
      if(kundi == "umeme"){
        orodhaKundiDogo = umeme;
      }
      if(kundi == "nyumbani"){
        orodhaKundiDogo = nyumbani;
      }
      if(kundi == "watoto"){
        orodhaKundiDogo = watoto;
      }
      if(kundi == "tafrija"){
        orodhaKundiDogo = tafrija;
      }
      if(kundi == "ofisi"){
        orodhaKundiDogo = ofisi;
      }
      if(kundi == "michezo"){
        orodhaKundiDogo = michezo;
      }
      if(kundi == "mapambo"){
        orodhaKundiDogo = mapambo;
      }
      kundiDogo = orodhaKundiDogo[0];
    });
  }
}
