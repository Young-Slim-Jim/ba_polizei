import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class PersonHitProvider extends ChangeNotifier {
  List<QueryDocumentSnapshot> hits = [];

  void addHit(QueryDocumentSnapshot person) {
    hits.add(person);
    notifyListeners();
  }
}
