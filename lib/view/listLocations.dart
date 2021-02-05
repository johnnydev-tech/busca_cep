import 'dart:async';
import 'package:busca_cep/model/viaCEP.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class ListLocations extends StatefulWidget {
  @override
  _ListLocationsState createState() => _ListLocationsState();
}

class _ListLocationsState extends State<ListLocations> {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  final _controller = StreamController<QuerySnapshot>.broadcast();
  FirebaseFirestore _db = FirebaseFirestore.instance;

  _locations() async {
    final stream = _db.collection("locations").orderBy("data").snapshots();
    stream.listen((dados) {
      _controller.add(dados);
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _locations();
    Firebase.initializeApp().whenComplete(() {
      print("completed");
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Histórico de Buscas"),
      ),
      body: Container(
        padding: EdgeInsets.all(8),
        child: StreamBuilder<QuerySnapshot>(
            stream: _controller.stream,
            // ignore: missing_return
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.none:

                case ConnectionState.waiting:
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                  break;
                case ConnectionState.active:
                case ConnectionState.done:
                  QuerySnapshot querySnapshot = snapshot.data;
                  List<DocumentSnapshot> locations =
                      querySnapshot.docs.toList();

                  return ListView.builder(
                      padding: EdgeInsets.only(bottom: 75),
                      itemCount: locations.length,
                      itemBuilder: (context, index) {
                        DocumentSnapshot item = locations[index];
                        String cep = item["cep"].toString();
                        String logradouro = item["logradouro"];
                        String bairro = item["bairro"];
                        String localidade = item["localidade"];
                        String uf = item["uf"];
                        return logradouro != null
                            ? Padding(
                                padding: EdgeInsets.symmetric(vertical: 5),
                                child: ListTile(
                                  title: Text(cep),
                                  subtitle: Text(logradouro),
                                ),
                              )
                            : Container();
                      });
                  break;
              }
            }),
      ),
    );
  }
}
