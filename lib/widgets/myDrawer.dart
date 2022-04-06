import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:firstapplicationsqyavril2022/fonctions/firestoreHelper.dart';
import 'package:firstapplicationsqyavril2022/library/constants.dart';
import 'package:flutter/material.dart';

class myDrawer extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return myDrawerState();
  }

}

class myDrawerState extends State<myDrawer>{
  //variable
  String? cheminImage;
  String? nomImage;
  Uint8List? dataImage;


  recuperImage() async{
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.image,
      withData: true
    );
    if(result!=null){
      print("J'ai récupérer une image");
      setState(() {
        nomImage = result.files.first.name;
        dataImage = result.files.first.bytes;
        FirestoreHelper().stockage(nomImage!, dataImage!).then((value){
          cheminImage = value;
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(20),
        child:  bodyPage(),
      )

    );
  }


  Widget bodyPage(){
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        //image récupéré

        (dataImage==null)?Container(): Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: MemoryImage(dataImage!)
            )
          ),
        ),

        //logo
        InkWell(
          child: Container(
            height: 150,
            width: 150,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: (monProfil.logo!=null)?NetworkImage(monProfil.logo!):NetworkImage("https://firebasestorage.googleapis.com/v0/b/projetsqyavril2022.appspot.com/o/noImage.png?alt=media&token=dc26627a-5c9f-491b-8529-c8b44bfad00a"),
                  fit: BoxFit.fill,
                )
            ),
          ),
          onTap: (){

          },
        ),

        SizedBox(height: 10,),


        //Nom et le prénom
        Text("${monProfil.prenom} ${monProfil.nom}")
      ],
    );
  }

}