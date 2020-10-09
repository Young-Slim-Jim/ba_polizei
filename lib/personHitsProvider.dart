import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class PersonHitProvider extends ChangeNotifier {
  Map<String, QueryDocumentSnapshot> hits = {};
  Map<String, bool> selected = {};

  void addHit(QueryDocumentSnapshot person) {
    hits.putIfAbsent(person.id, () => person);
    selected.putIfAbsent(person.id, () => false);
    notifyListeners();
  }

  void changeSelection(String id) {
    selected.updateAll((key, value) => false);
    selected.update(id, (value) => true);
    notifyListeners();
  }

  bool isSelected(String id) {
    return selected[id];
  }

  String getVorname(String id) {
    final selectedPerson = hits[id];
    final data = selectedPerson.data().entries.toList();

    final personalieMap =
        data.where((element) => element.key == "personalie").toList();

    return personalieMap.first.value["Rufname"];
  }

  String getNachname(String id) {
    final selectedPerson = hits[id];
    final data = selectedPerson.data().entries.toList();

    final personalieMap =
        data.where((element) => element.key == "personalie").toList();

    return personalieMap.first.value["nachname"]["name"];
  }

  String getBday(String id) {
    final selectedPerson = hits[id];
    final data = selectedPerson.data().entries.toList();

    final personalieMap =
        data.where((element) => element.key == "personalie").toList();

    return personalieMap.first.value["geburtsdatum"]["bis"];
  }

  bool isDangerous(String id) {
    final selectedPerson = hits[id];
    final dataForPerson = selectedPerson.data().entries.toList();
    final danger =
        dataForPerson.where((element) => element.key == "Fahndung").toList();
    if (danger != null) {
      return true;
    } else {
      return false;
    }
  }
}
