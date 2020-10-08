import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class PersonHitProvider extends ChangeNotifier {
  Map<QueryDocumentSnapshot, bool> hits = {};

  void addHit(QueryDocumentSnapshot person) {
    hits.putIfAbsent(person, () => false);
    notifyListeners();
  }

  void changeSelection(QueryDocumentSnapshot person) {
    hits.updateAll((key, value) => false);
    hits.update(person, (value) => true);
    notifyListeners();
  }

  bool isSelected(QueryDocumentSnapshot person) {
    return hits[person];
  }

  String getVorname(QueryDocumentSnapshot person) {
    final data = person.data().entries.toList();

    final personalieMap =
        data.where((element) => element.key == "personalie").toList();

    return personalieMap.first.value["Rufname"];
  }

  String getNachname(QueryDocumentSnapshot person) {
    final data = person.data().entries.toList();

    final personalieMap =
        data.where((element) => element.key == "personalie").toList();

    return personalieMap.first.value["nachname"]["name"];
  }

  String getBday(QueryDocumentSnapshot person) {
    final data = person.data().entries.toList();

    final personalieMap =
        data.where((element) => element.key == "personalie").toList();

    return personalieMap.first.value["geburtsdatum"]["bis"];
  }

  bool isDangerous(QueryDocumentSnapshot person) {
    final selectedPerson =
        hits.keys.where((element) => element == person).toList();
    final dataForPerson = selectedPerson[0].data().entries.toList();
    final danger =
        dataForPerson.where((element) => element.key == "Fahndung").toList();
    if (danger != null) {
      return true;
    } else {
      return false;
    }
  }
}
