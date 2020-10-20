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

  void resetSelection() {
    selected.updateAll((key, value) => false);
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

  List getStaatsangehoerigkeiten(String id) {
    final selectedPerson = hits[id];
    final data = selectedPerson.data().entries.toList();
    final personalieMap =
        data.where((element) => element.key == "personalie").toList();
    return personalieMap.first.value["staatsangehörigkeit"];
  }

  String getGeburstsname(String id) {
    final selectedPerson = hits[id];
    final data = selectedPerson.data().entries.toList();
    final personalieMap =
        data.where((element) => element.key == "personalie").toList();

    return personalieMap.first.value["geburtsname"]["name"];
  }

  String getGeburstsland(String id) {
    final selectedPerson = hits[id];
    final data = selectedPerson.data().entries.toList();
    final personalieMap =
        data.where((element) => element.key == "personalie").toList();

    return personalieMap.first.value["geburtsstaat"]["value"];
  }

  String getSchengen(String id) {
    final selectedPerson = hits[id];
    final data = selectedPerson.data().entries.toList();
    final personalieMap = data
        .where((element) => element.key == "personenfahndungsnotierung")
        .toList();

    return personalieMap.first.value["schengen"] == true ? "ja" : "nein";
  }

  String getereignisbezeichnung(String id) {
    final selectedPerson = hits[id];
    final data = selectedPerson.data().entries.toList();
    final personalieMap = data
        .where((element) => element.key == "personenfahndungsnotierung")
        .toList();

    return personalieMap.first.value["ereignisbezeichnung"];
  }

  String getAuschreibungsanlass(String id) {
    final selectedPerson = hits[id];
    final data = selectedPerson.data().entries.toList();
    final personalieMap = data
        .where((element) => element.key == "personenfahndungsnotierung")
        .toList();

    return personalieMap.first.value["ausschreibungsanlass"];
  }

  String getBesitzendeBehoerde(String id) {
    final selectedPerson = hits[id];
    final data = selectedPerson.data().entries.toList();
    final personalieMap = data
        .where((element) => element.key == "personenfahndungsnotierung")
        .toList();

    return personalieMap.first.value["behörde"];
  }

  String getAuschreibungszweck(String id) {
    final selectedPerson = hits[id];
    final data = selectedPerson.data().entries.toList();
    final personalieMap = data
        .where((element) => element.key == "personenfahndungsnotierung")
        .toList();

    return personalieMap.first.value["ausschreibungszweck"];
  }

  String getAuschreibendeBehoerde(String id) {
    final selectedPerson = hits[id];
    final data = selectedPerson.data().entries.toList();
    final personalieMap = data
        .where((element) => element.key == "personenfahndungsnotierung")
        .toList();

    return personalieMap.first.value["ausschreibendeBehörde"];
  }

  String getAzAb(String id) {
    final selectedPerson = hits[id];
    final data = selectedPerson.data().entries.toList();
    final personalieMap = data
        .where((element) => element.key == "personenfahndungsnotierung")
        .toList();

    return personalieMap.first.value["azBehörde"];
  }

  String getFahndungsregion(String id) {
    final selectedPerson = hits[id];
    final data = selectedPerson.data().entries.toList();
    final personalieMap = data
        .where((element) => element.key == "personenfahndungsnotierung")
        .toList();

    return personalieMap.first.value["fahndungsregion"];
  }

  String getStatusfahndung(String id) {
    final selectedPerson = hits[id];
    final data = selectedPerson.data().entries.toList();
    final personalieMap = data
        .where((element) => element.key == "personenfahndungsnotierung")
        .toList();

    return personalieMap.first.value["Status"];
  }

  String getDienstelle(String id) {
    final selectedPerson = hits[id];
    final data = selectedPerson.data().entries.toList();
    final personalieMap = data
        .where((element) => element.key == "personenfahndungsnotierung")
        .toList();

    return personalieMap.first.value["dienststelle"];
  }

  String getAzAs(String id) {
    final selectedPerson = hits[id];
    final data = selectedPerson.data().entries.toList();
    final personalieMap = data
        .where((element) => element.key == "personenfahndungsnotierung")
        .toList();

    return personalieMap.first.value["azDienststelle"];
  }

  String getPlz(String id) {
    final selectedPerson = hits[id];
    final data = selectedPerson.data().entries.toList();
    final personalieMap =
        data.where((element) => element.key == "anschrift").toList();

    return personalieMap.first.value["plz"];
  }

  String getOrt(String id) {
    final selectedPerson = hits[id];
    final data = selectedPerson.data().entries.toList();
    final personalieMap =
        data.where((element) => element.key == "anschrift").toList();

    return personalieMap.first.value["ort"];
  }

  String getNation(String id) {
    final selectedPerson = hits[id];
    final data = selectedPerson.data().entries.toList();
    final personalieMap =
        data.where((element) => element.key == "anschrift").toList();

    return personalieMap.first.value["nation"];
  }

  String getOrtsbezeichnung(String id) {
    final selectedPerson = hits[id];
    final data = selectedPerson.data().entries.toList();
    final personalieMap =
        data.where((element) => element.key == "anschrift").toList();

    return personalieMap.first.value["ortsbezeichnung"];
  }

  String getHausnummer(String id) {
    final selectedPerson = hits[id];
    final data = selectedPerson.data().entries.toList();
    final personalieMap =
        data.where((element) => element.key == "anschrift").toList();

    return personalieMap.first.value["hausnummer"];
  }

  String getLetztesAenderungsdatum(String id) {
    final selectedPerson = hits[id];
    final data = selectedPerson.data().entries.toList();
    final personalieMap =
        data.where((element) => element.key == "anschrift").toList();

    return personalieMap.first.value["änderungsdatum"];
  }

  String getVerfasser(String id) {
    final selectedPerson = hits[id];
    final data = selectedPerson.data().entries.toList();
    final personalieMap =
        data.where((element) => element.key == "anschrift").toList();

    return personalieMap.first.value["verfasser"];
  }

  String getArtderOrtsbezeichnung(String id) {
    final selectedPerson = hits[id];
    final data = selectedPerson.data().entries.toList();
    final personalieMap =
        data.where((element) => element.key == "anschrift").toList();

    return personalieMap.first.value["ArtDerortsbezeichnung"];
  }

  String getAngelegtDurch(String id) {
    final selectedPerson = hits[id];
    final data = selectedPerson.data().entries.toList();
    final personalieMap =
        data.where((element) => element.key == "anschrift").toList();

    return personalieMap.first.value["angelegtDurch"];
  }

  String getArtDerAnschrift(String id) {
    final selectedPerson = hits[id];
    final data = selectedPerson.data().entries.toList();
    final personalieMap =
        data.where((element) => element.key == "anschrift").toList();

    return personalieMap.first.value["art"];
  }

  String getLetzterAenderer(String id) {
    final selectedPerson = hits[id];
    final data = selectedPerson.data().entries.toList();
    final personalieMap =
        data.where((element) => element.key == "anschrift").toList();

    return personalieMap.first.value["letzterÄnderer"];
  }

  String getLoeschtermin(String id) {
    final selectedPerson = hits[id];
    final data = selectedPerson.data().entries.toList();
    final personalieMap =
        data.where((element) => element.key == "anschrift").toList();

    return personalieMap.first.value["löschtermin"];
  }

  String getPrueftermin(String id) {
    final selectedPerson = hits[id];
    final data = selectedPerson.data().entries.toList();
    final personalieMap =
        data.where((element) => element.key == "anschrift").toList();

    return personalieMap.first.value["prüftermin"];
  }

  String getStatusLoeschtermin(String id) {
    final selectedPerson = hits[id];
    final data = selectedPerson.data().entries.toList();
    final personalieMap =
        data.where((element) => element.key == "anschrift").toList();

    return personalieMap.first.value["status"];
  }

  String getAngelegtAm(String id) {
    final selectedPerson = hits[id];
    final data = selectedPerson.data().entries.toList();
    final personalieMap = data
        .where((element) => element.key == "personenfahndungsnotierung")
        .toList();

    return personalieMap.first.value["angelegt"];
  }

  String getAusschreibungsanlass(String id) {
    final selectedPerson = hits[id];
    final data = selectedPerson.data().entries.toList();
    final personalieMap = data
        .where((element) => element.key == "personenfahndungsnotierung")
        .toList();

    return personalieMap.first.value["ausschreibungsanlass"];
  }

  String getGeschlecht(String id) {
    final selectedPerson = hits[id];
    final data = selectedPerson.data().entries.toList();
    final personalieMap =
        data.where((element) => element.key == "personalie").toList();

    return personalieMap.first.value["geschlecht"]["value"];
  }

  String getBdayOrt(String id) {
    final selectedPerson = hits[id];
    final data = selectedPerson.data().entries.toList();
    final personalieMap =
        data.where((element) => element.key == "personalie").toList();

    return personalieMap.first.value["geburtsort"];
  }

  String getStaatsangehoerigkeit(String id) {
    String staatsangehoerigkeit = "";

    final selectedPerson = hits[id];
    final data = selectedPerson.data().entries.toList();
    final personalieMap =
        data.where((element) => element.key == "personalie").toList();

    final List angehoerigkeiten =
        personalieMap.first.value["staatsangehörigkeit"];
    if (angehoerigkeiten.length > 1) {
      staatsangehoerigkeit =
          angehoerigkeiten[0]["value"] + ", " + angehoerigkeiten[1]["value"];
    } else {
      staatsangehoerigkeit = angehoerigkeiten[0]["value"];
    }

    return staatsangehoerigkeit;
  }

  String getStatusderPersonalie(String id) {
    final selectedPerson = hits[id];
    final data = selectedPerson.data().entries.toList();
    final personalieMap =
        data.where((element) => element.key == "personalie").toList();

    return personalieMap.first.value["art"]["value"];
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
