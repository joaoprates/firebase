import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

void main() async {

  /*WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  FirebaseFirestore db = FirebaseFirestore.instance;
  *//*db.collection("usuarios").doc("001").set({"nome": "Fulano"});*//*

  *//*Firestore db = Firestore.instance;*//*

  QuerySnapshot querySnapshot = await db.collection("usuarios")
  //.where("nome", isEqualTo: "jamilton")
  //.where("idade", isEqualTo: 31)
      .where("idade", isGreaterThan: 15)//< menor, > maior, >= maior ou igual, <= menor ou igual
  //.where("idade", isLessThan: 30)
  //descendente (do maior para o menor) ascendente (do menor para o maior)
      .orderBy("idade", descending: true )
      .orderBy("nome", descending: false )
      .limit(1)
      .get();

  for( DocumentSnapshot item in querySnapshot.docs ){
    var dados = item.data;
    print("filtro nome: ${dados()["nome"]} idade: ${dados()["idade"]}");
  }*/




  runApp(MaterialApp(
    home: Home(),
    debugShowCheckedModeBanner: false,
  )

  );

}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  File _imagem;

  Future _recuperarImagem(bool daCamera) async {

    File imagemSelecionada;
    if( daCamera ){//camera
      imagemSelecionada = await ImagePicker.pickImage(source: ImageSource.camera);
    }else{//galeria
      imagemSelecionada = await ImagePicker.pickImage(source: ImageSource.gallery);
    }

    setState(() {
      _imagem = imagemSelecionada;
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Selecionar imagem"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            RaisedButton(
              child: Text("Camera"),
              onPressed: (){
                _recuperarImagem(true);
              },
            ),
            RaisedButton(
              child: Text("Galeria"),
              onPressed: (){
                _recuperarImagem(false);
              },
            ),
            _imagem == null
                ? Container()
                : Image.file(_imagem)
          ],
        ),
      ),
    );
  }
}
