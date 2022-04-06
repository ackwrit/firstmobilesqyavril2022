import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firstapplicationsqyavril2022/fonctions/firestoreHelper.dart';
import 'package:firstapplicationsqyavril2022/model/utilisateur.dart';
import 'package:flutter/material.dart';

class DashBoard extends StatefulWidget{
  String uid;
  
  DashBoard({required  this.uid});
  
  
  @override
  State<StatefulWidget> createState() {
  
    return DashBoardState();
  }

}

class DashBoardState extends State<DashBoard>{
  @override
  Widget build(BuildContext context) {
    print(widget.uid);
   
    return Scaffold(
      appBar: AppBar(
        title: const Text("Ma Nouvelle page"),
      ),
      body: bodyPage(),
    );
  }


  Widget bodyPage(){
    return StreamBuilder<QuerySnapshot>(
      stream: FirestoreHelper().fire_user.where("UID",isEqualTo: widget.uid).snapshots(),
      builder: (context, snapshot){
        if(!snapshot.hasData){
          return const CircularProgressIndicator();
        }
        else{
          List documents = snapshot.data!.docs;
          return ListView.builder(
            itemCount: documents.length,
            itemBuilder: (context,index){
              Utilisateur user = Utilisateur(documents[index]);
              return Card(
                elevation: 5.0,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                child: ListTile(

                title: Text("${user.prenom} ${user.nom}")

              ),

              );
              
              

            }
            );
        }
      }
      );
  }

}