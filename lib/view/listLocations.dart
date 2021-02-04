import 'dart:async';
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
            builder: (context, snapshot){

            }
        ),
      ),
    );
  }
}
