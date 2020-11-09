import 'dart:io';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:ba_polizei/results_nach_anfrage/widgets/VivaAppbar.dart';
import 'package:ba_polizei/widgets/androidLoadingSheet.dart';
import 'package:ba_polizei/widgets/cupertinoLoadingSheet.dart';
import 'package:ba_polizei/listsammlung.dart';
import 'package:ba_polizei/personHitsProvider.dart';
import 'package:ba_polizei/screens/resultScreen.dart';
import 'package:ba_polizei/widgets/searchSheetAndroid.dart';
import 'package:ba_polizei/widgets/searchSheetIOS.dart';
import 'package:ba_polizei/widgets/cupertinoDialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import 'package:ba_polizei/icons/IOScons/i_o_s_icons_icons.dart' as IOScons;
import 'package:ba_polizei/icons/AndroidIcons/android_icons_icons.dart'
    as AndroidIcons;

class VivaPerson extends StatefulWidget {
  @override
  _VivaPersonState createState() => _VivaPersonState();
}

class _VivaPersonState extends State<VivaPerson> {
  String abfragegrund;
  bool erweitert = false;
  bool phonetisch = false;
  bool nurFahndungsabfrage = false;
  DateTime bday;

  final nameFocus = FocusNode();
  final vornameFocus = FocusNode();
  final bdayFocus = FocusNode();
  final geburtsortFocus = FocusNode();
  final geburtsnameFocus = FocusNode();
  final spitznameFocus = FocusNode();

  TextEditingController abfragegrundController = TextEditingController(
    text: 'Bitte auswählen',
  );
  TextEditingController nameController = TextEditingController();
  TextEditingController vornameController = TextEditingController();
  TextEditingController bdayController = TextEditingController();
  TextEditingController ergaenzungController = TextEditingController(
    text: 'mobileAbfrage',
  );

  TextEditingController bdayOrtController = TextEditingController();
  TextEditingController bdaynameController = TextEditingController();
  TextEditingController nicknameController = TextEditingController();
  TextEditingController bdaylandController = TextEditingController(text: "...");
  TextEditingController staatsangehoerigkeitController =
      TextEditingController(text: "...");
  TextEditingController geschlechtsController =
      TextEditingController(text: "...");
  TextEditingController rollenController = TextEditingController(text: "...");

  final _formKeyAbfragegrund = GlobalKey<FormState>();
  final _formKeyName = GlobalKey<FormState>();
  final _formKeyVorname = GlobalKey<FormState>();
  final _formKeyBday = GlobalKey<FormState>();
  final _formkeyGeburtsland = GlobalKey<FormState>();
  final _formkeyStaatsangehoerigkeit = GlobalKey<FormState>();
  final _formkeyRolle = GlobalKey<FormState>();
  final _formkeyGeschlecht = GlobalKey<FormState>();
  final _formkeySpitzname = GlobalKey<FormState>();
  final _formkeyGeburtsort = GlobalKey<FormState>();
  final _formkeyGeburtsname = GlobalKey<FormState>();
  void initState() {
    super.initState();
    nameFocus.addListener(() {
      setState(() {});
    });
    login();

    vornameFocus.addListener(() {
      setState(() {});
    });

    geburtsnameFocus.addListener(() {
      setState(() {});
    });

    geburtsortFocus.addListener(() {
      setState(() {});
    });

    spitznameFocus.addListener(() {
      setState(() {});
    });
  }

  Future<void> login() async {
    final user = await FirebaseAuth.instance.signInAnonymously();
    print(user.user.uid);
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Platform.isIOS
            ? Size.fromHeight(height * 0.113)
            : Size.fromHeight(height * 0.14),
        child: AppBar(
          iconTheme: IconThemeData(color: Theme.of(context).accentColor),
          leading: Platform.isIOS
              ? IconButton(
                  icon: Icon(Icons.chevron_left, size: 30),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                )
              : Container(),
          elevation: 0.0,
          automaticallyImplyLeading: Platform.isIOS ? true : false,
          title: Platform.isIOS
              ? Text(
                  "ViVA Person",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white),
                )
              : Text(
                  "SIS Person",
                  textAlign: TextAlign.left,
                  style: TextStyle(color: Colors.white),
                ),
          actions: [
            IconButton(
              icon: Icon(CupertinoIcons.search),
              onPressed: () {
                searchForPerson();
              },
            ),
            IconButton(
                icon: Platform.isIOS
                    ? Icon(IOScons.IOSIcons.doc_text_viewfinder)
                    : Icon(AndroidIcons.AndroidIcons.credit_card_scan_outline),
                onPressed: () => {}),
            IconButton(
                icon: Platform.isIOS
                    ? Icon(IOScons.IOSIcons.xmark_square)
                    : Icon(AndroidIcons.AndroidIcons.eraser),
                onPressed: () {})
          ],
          centerTitle: Platform.isIOS ? true : false,
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(height * 0.05),
            child: Container(
              width: double.infinity,
              color: Platform.isIOS
                  ? Theme.of(context).secondaryHeaderColor
                  : Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Platform.isIOS
                    ? Text("Angemeldet als plxtu62",
                        textAlign: TextAlign.left,
                        style: TextStyle(color: Colors.white, fontSize: 13))
                    : RichText(
                        text: TextSpan(
                          style: TextStyle(
                            fontSize: 14.0,
                            color: Colors.grey,
                          ),
                          children: <TextSpan>[
                            TextSpan(text: 'Angemeldet als'),
                            TextSpan(
                                text: ' plxtu62',
                                style: TextStyle(
                                    color: Theme.of(context).hoverColor)),
                          ],
                        ),
                      ),
              ),
            ),
          ),
        ),
      ),
      backgroundColor: Theme.of(context).backgroundColor,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Scrollbar(
          child: ListView(
            children: [
              searchSheettextfield(
                  "Abfragegrund",
                  Listsammlung().getAbfragegruende(),
                  abfragegrundController,
                  _formKeyAbfragegrund),
              ergaenzungstextTextfield(),
              nameTextfield(),
              vornameTextfield(),
              bdayTextfield(),
              Platform.isIOS
                  ? Padding(
                      padding: const EdgeInsets.only(bottom: 12.0),
                      child: FlatButton(
                        onPressed: () async {
                          searchForPerson();
                        },
                        color: Theme.of(context).accentColor,
                        child: Container(
                          height: height * 0.065,
                          child: Center(
                            child: Text(
                              'Suchen',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20),
                            ),
                          ),
                        ),
                        shape: RoundedRectangleBorder(
                            side: BorderSide(
                                color: Theme.of(context).accentColor,
                                width: 1,
                                style: BorderStyle.solid),
                            borderRadius: BorderRadius.circular(10)),
                      ),
                    )
                  : Container(),
              erweitertToggle(),
              erweitert ? erweiterteTextfields() : Container(),
              phonetischToggle(),
              Platform.isIOS ? nurFahndungsabfrageToggle() : Container()
            ],
          ),
        ),
      ),
    );
  }

  Future<void> searchForPerson() async {
    if (_formKeyAbfragegrund.currentState.validate() &&
        _formKeyName.currentState.validate() &&
        _formKeyBday.currentState.validate() &&
        _formKeyVorname.currentState.validate()) {
      await selectHits();

      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ResultScreen()),
      );

      Platform.isIOS
          ? showCupertinoDialog(
              context: context,
              builder: (_) => CupertinoLoadingSheet(),
            )
          : showDialog(
              context: context,
              builder: (BuildContext context) => AndroidLoadingSheet());
      await selectHits();
      Navigator.of(context, rootNavigator: true).pop('dialog');
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ResultScreen()),
      );
    }
  }

  Future<void> selectHits() async {
    final CollectionReference personCollection =
        FirebaseFirestore.instance.collection('person');

    final downloaded = await personCollection.get();
    for (var person in downloaded.docs) {
      final data = person.data().entries.toList();
      bool hit = true;
      final personalieMap =
          data.where((element) => element.key == "personalie").toList();
      final String vornameFB = personalieMap.first.value["Rufname"];
      final String nachnameFB = personalieMap.first.value["nachname"]["name"];
      final String bdayFB = personalieMap.first.value["geburtsdatum"]["bis"];
      final hits = Provider.of<PersonHitProvider>(context, listen: false);

      if (vornameFB.toLowerCase() ==
              vornameController.text.toLowerCase().trim() &&
          nachnameFB.toLowerCase() ==
              nameController.text.toLowerCase().trim() &&
          bdayFB.toLowerCase().trim() == formatbday()) {
        if (erweitert == false) {
          hits.addHit(person);
        } else {
          if (bdayOrtController.text.isNotEmpty) {
            if (bdayOrtController.text.toLowerCase() !=
                personalieMap.first.value["geburtsort"].toLowerCase()) {
              hit = false;
            }
          }

          if (bdaynameController.text.isNotEmpty) {
            final value =
                personalieMap.first.value["geburtsname"]["name"].toLowerCase();
            if (bdaynameController.text.toLowerCase().trim() != value) {
              hit = false;
            }
          }

          if (nicknameController.text.isNotEmpty) {
            List nicknames = personalieMap.first.value["weitereNamen"];
            for (var namen in nicknames)
              if (nicknameController.text.toLowerCase().trim() !=
                  namen["name"].toLowerCase()) {
                hit = false;
              } else {
                hit = true;
                break;
              }
          }

          if (bdaylandController.text != "...") {
            if (bdaylandController.text.toLowerCase().trim() !=
                personalieMap.first.value["geburtsstaat"]["value"]
                    .toLowerCase()) {
              hit = false;
            }
          }

          if (staatsangehoerigkeitController.text != "...") {
            List staaten = personalieMap.first.value["staatsangehörigkeit"];
            for (var staat in staaten)
              if (staatsangehoerigkeitController.text.toLowerCase().trim() !=
                  staat["value"].toLowerCase()) {
                hit = false;
              } else {
                hit = true;
                break;
              }
          }

          if (geschlechtsController.text != "...") {
            if (geschlechtsController.text.toLowerCase().trim() !=
                personalieMap.first.value["geschlecht"]["value"]
                    .toLowerCase()) {
              hit = false;
            }
          }

          if (hit == true) {
            hits.addHit(person);
          }
        }
      }
    }
  }

  String formatbday() {
    String day = bdayController.text.substring(0, 2);
    String month = bdayController.text.substring(3, 5);
    String year = bdayController.text.substring(6, 10);
    String formatted = year + "-" + month + "-" + day;
    return formatted;
  }

  erweiterteTextfields() {
    return Column(
      children: [
        floatingLabelTextfield(
            title: "Geburtsort",
            controller: bdayOrtController,
            key: _formkeyGeburtsort,
            node: geburtsortFocus),
        floatingLabelTextfield(
            title: "Geburtsname",
            controller: bdaynameController,
            key: _formkeyGeburtsname,
            node: geburtsnameFocus),
        floatingLabelTextfield(
            title: "Spitzname",
            controller: nicknameController,
            key: _formkeySpitzname,
            node: spitznameFocus),
        searchSheettextfield("Geburtsland", Listsammlung().getlaenderNamen(),
            bdaylandController, _formkeyGeburtsland),
        searchSheettextfield(
            "Staatsangehörigkeit",
            Listsammlung().getStaatsangehoerigkeiten(),
            staatsangehoerigkeitController,
            _formkeyStaatsangehoerigkeit),
        searchSheettextfield("Geschlecht", Listsammlung().getGeschlecht(),
            geschlechtsController, _formkeyGeschlecht),
        searchSheettextfield("Rolle", Listsammlung().getRollen(),
            rollenController, _formkeyRolle),
      ],
    );
  }

  Widget floatingLabelTextfield({
    String title,
    TextEditingController controller,
    GlobalKey<FormState> key,
    FocusNode node,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Stack(alignment: Alignment.centerRight, children: [
        Form(
          key: key,
          child: TextFormField(
            focusNode: node,
            autocorrect: false,
            controller: controller,
            validator: (value) {
              if (checkForDigits(value)) {
                return "keine Zahlen eingeben";
              }
              return "";
            },
            decoration: InputDecoration(
              labelText: title,
              filled: Platform.isIOS ? false : true,
              fillColor: Platform.isIOS
                  ? Colors.transparent
                  : Theme.of(context).secondaryHeaderColor,
              floatingLabelBehavior: FloatingLabelBehavior.always,
              contentPadding: EdgeInsets.symmetric(
                horizontal: 8,
                vertical: 5,
              ),
            ),
          ),
        ),
        node.hasFocus
            ? IconButton(
                icon: Icon(Icons.close, color: Theme.of(context).hoverColor),
                onPressed: () => controller.clear())
            : Container(),
      ]),
    );
  }

  Widget searchSheettextfield(String title, List<String> auswahl,
      TextEditingController controller, GlobalKey<FormState> formkey) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Form(
        key: formkey,
        child: TextFormField(
          readOnly: true,
          autofocus: false,
          onTap: () {
            Platform.isIOS
                ? Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SearchSheetIOS(
                        auswahl: auswahl,
                        title: title,
                      ),
                    ),
                  ).then(
                    (value) {
                      setState(
                        () {
                          controller.text = value;
                        },
                      );
                    },
                  )
                : showDialog(
                    context: context,
                    builder: (context) => SearchSheetAndroid(
                      auswahl: auswahl,
                      title: title,
                    ),
                  ).then(
                    (value) {
                      setState(
                        () {
                          controller.text = value;
                        },
                      );
                    },
                  );
          },
          controller: controller,
          validator: (value) {
            if (value == "Bitte auswählen") {
              return title + " auswählen!";
            }
            return null;
          },
          autocorrect: false,
          decoration: InputDecoration(
            labelText: title,
            filled: Platform.isIOS ? false : true,
            fillColor: Platform.isIOS
                ? Colors.transparent
                : Theme.of(context).secondaryHeaderColor,
            contentPadding: EdgeInsets.symmetric(
              horizontal: 8,
              vertical: 5,
            ),
            suffixIcon: SizedBox(
              height: 15,
              child: Icon(
                Icons.arrow_drop_down,
                color: Theme.of(context).hoverColor,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget nurFahndungsabfrageToggle() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Container(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: Platform.isIOS ? 8 : 0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "nur Fahndungsabfrage",
                    style: TextStyle(fontSize: 20),
                  ),
                  CupertinoSwitch(
                    value: nurFahndungsabfrage,
                    activeColor: Theme.of(context).accentColor,
                    onChanged: (bool value) {
                      setState(() {
                        nurFahndungsabfrage = value;
                      });
                    },
                  ),
                ],
              ),
            ),
            Container(color: Colors.grey, height: 1)
          ],
        ),
      ),
    );
  }

  Widget phonetischToggle() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Container(
        color: Platform.isIOS
            ? Theme.of(context).backgroundColor
            : Theme.of(context).secondaryHeaderColor,
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: Platform.isIOS ? 8 : 0,
              ),
              child: Platform.isIOS
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Phonetische Suche",
                          style: TextStyle(fontSize: 20),
                        ),
                        CupertinoSwitch(
                          value: phonetisch,
                          activeColor: Theme.of(context).accentColor,
                          onChanged: (bool value) {
                            setState(() {
                              phonetisch = value;
                            });
                          },
                        ),
                      ],
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Checkbox(
                            value: phonetisch,
                            activeColor: Colors.green,
                            onChanged: (bool newValue) {
                              setState(() {
                                phonetisch = newValue;
                              });
                            }),
                        Text('Phonetische Suche'),
                      ],
                    ),
            ),
            Container(color: Colors.grey, height: 1),
          ],
        ),
      ),
    );
  }

  Widget erweitertToggle() {
    return Padding(
      padding: EdgeInsets.only(bottom: 12.0),
      child: Container(
        color: Platform.isIOS
            ? Theme.of(context).backgroundColor
            : Theme.of(context).secondaryHeaderColor,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: Platform.isIOS ? 8 : 0,
              ),
              child: Platform.isIOS
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Erweitert",
                          style: TextStyle(fontSize: 20),
                        ),
                        CupertinoSwitch(
                          value: erweitert,
                          activeColor: Theme.of(context).accentColor,
                          onChanged: (bool value) {
                            setState(() {
                              erweitert = value;
                            });
                          },
                        ),
                      ],
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Checkbox(
                            value: erweitert,
                            activeColor: Theme.of(context).hoverColor,
                            onChanged: (bool newValue) {
                              setState(() {
                                erweitert = newValue;
                              });
                            }),
                        Text('Erweitert'),
                      ],
                    ),
            ),
            Container(color: Colors.grey, height: 1)
          ],
        ),
      ),
    );
  }

  Widget bdayTextfield() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Stack(
        alignment: Alignment.centerRight,
        children: <Widget>[
          Form(
            key: _formKeyBday,
            child: TextFormField(
              autocorrect: false,
              validator: (value) {
                if (checkForWords(value)) {
                  return "Datum darf nicht als Buchstaben bestehen!";
                }
                if (value.isEmpty) {
                  return "Geburtsdatum angeben!";
                }
                return null;
              },
              controller: bdayController,
              focusNode: bdayFocus,
              autofocus: false,
              decoration: InputDecoration(
                labelText: "Geburtsdatum",
                hintText: "01.01.2001",
                filled: Platform.isIOS ? false : true,
                fillColor: Platform.isIOS
                    ? Colors.transparent
                    : Theme.of(context).secondaryHeaderColor,
                floatingLabelBehavior: FloatingLabelBehavior.always,
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 5,
                ),
              ),
            ),
          ),
          bdayFocus.hasFocus
              ? IconButton(
                  icon: Icon(Icons.close, color: Theme.of(context).hoverColor),
                  onPressed: () => bdayController.clear())
              : IconButton(
                  icon: Platform.isIOS
                      ? Icon(IOScons.IOSIcons.calendar,
                          color: Theme.of(context).hoverColor)
                      : Icon(AndroidIcons.AndroidIcons.calendar,
                          color: Theme.of(context).hoverColor),
                  onPressed: () async {
                    Platform.isAndroid
                        ? showAndroidDatePicker()
                        : showIOSDatePicker();
                  },
                ),
        ],
      ),
    );
  }

  Future<void> showIOSDatePicker() async {
    showCupertinoDialog(
      context: context,
      builder: (_) => CupertinoDateDialog(),
    ).then(
      (value) => setState(
        () {
          bdayController.text = DateFormat('dd.MM.yyyy').format(value);
        },
      ),
    );
  }

  Future<void> showAndroidDatePicker() async {
    await showDatePicker(
      context: context,
      locale: const Locale("de", "DE"),
      initialDate: DateTime.now(),
      firstDate: DateTime(1900, 1),
      lastDate: DateTime.now(),
      builder: (BuildContext context, Widget child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme:
                ColorScheme.light(primary: Theme.of(context).primaryColor),
          ),
          child: child,
        );
      },
    ).then(
      (value) {
        setState(() {
          bdayController.text = DateFormat('dd.MM.yyyy').format(value);
        });
      },
    );
  }

  Widget nameTextfield() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Container(
        child: Stack(
          alignment: Alignment.centerRight,
          children: <Widget>[
            Form(
              key: _formKeyName,
              child: TextFormField(
                autocorrect: false,
                validator: (value) {
                  if (value.isEmpty) {
                    return "Bitte einen Nachnamen eingeben";
                  }
                  if (checkForDigits(value)) {
                    return "Der Name darf keine Zahlen enthalten";
                  }
                  if (value.length < 2) {
                    return "Der Name ist zu kurz";
                  }
                  return null;
                },
                autofocus: false,
                controller: nameController,
                focusNode: nameFocus,
                decoration: InputDecoration(
                  labelText: "Name",
                  filled: Platform.isIOS ? false : true,
                  fillColor: Platform.isIOS
                      ? Colors.transparent
                      : Theme.of(context).secondaryHeaderColor,
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 5,
                  ),
                ),
              ),
            ),
            nameFocus.hasFocus
                ? IconButton(
                    icon:
                        Icon(Icons.close, color: Theme.of(context).hoverColor),
                    onPressed: () => nameController.clear())
                : IconButton(
                    icon: Icon(
                      IOScons.IOSIcons.arrow_up_arrow_down,
                      color: Theme.of(context).hoverColor,
                    ),
                    onPressed: () {
                      String savetext;
                      savetext = nameController.text;
                      nameController.text = vornameController.text;
                      vornameController.text = savetext;
                      nameController.selection = TextSelection.fromPosition(
                          TextPosition(offset: nameController.text.length));
                    })
          ],
        ),
      ),
    );
  }

  Widget vornameTextfield() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Container(
        child: Form(
          key: _formKeyVorname,
          child: Stack(
            alignment: Alignment.centerRight,
            children: <Widget>[
              TextFormField(
                autocorrect: false,
                autofocus: false,
                validator: (value) {
                  if (value.isEmpty) {
                    return "Bitte einen Nachnamen eingeben";
                  }
                  if (checkForDigits(value)) {
                    return "Der Name darf keine Zahlen enthalten";
                  }
                  if (value.length < 2) {
                    return "Der Name ist zu kurz";
                  }
                  return null;
                },
                controller: vornameController,
                focusNode: vornameFocus,
                decoration: InputDecoration(
                  labelText: "Voramen",
                  filled: Platform.isIOS ? false : true,
                  fillColor: Platform.isIOS
                      ? Colors.transparent
                      : Theme.of(context).secondaryHeaderColor,
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 5,
                  ),
                ),
              ),
              vornameFocus.hasFocus
                  ? IconButton(
                      icon: Icon(Icons.close,
                          color: Theme.of(context).hoverColor),
                      onPressed: () => vornameController.clear())
                  : IconButton(
                      icon: Icon(IOScons.IOSIcons.arrow_up_arrow_down,
                          color: Theme.of(context).hoverColor),
                      onPressed: () {
                        // nameFocus.unfocus();
                        // vornameFocus.unfocus();
                        String savetext;
                        savetext = nameController.text;
                        nameController.text = vornameController.text;
                        vornameController.text = savetext;
                        vornameController.selection =
                            TextSelection.fromPosition(TextPosition(
                                offset: vornameController.text.length));
                      })
            ],
          ),
        ),
      ),
    );
  }

  Widget ergaenzungstextTextfield() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: TextField(
        autofocus: false,
        autocorrect: false,
        controller: ergaenzungController,
        decoration: InputDecoration(
          filled: Platform.isIOS ? false : true,
          fillColor: Platform.isIOS
              ? Colors.transparent
              : Theme.of(context).secondaryHeaderColor,
          labelText: "Ergänzungstext",
          contentPadding: EdgeInsets.symmetric(
            horizontal: 8,
            vertical: 5,
          ),
        ),
      ),
    );
  }

  bool checkForWords(String input) {
    RegExp _letter = RegExp(r'[a-z]');
    return _letter.hasMatch(input);
  }

  bool checkForDigits(String input) {
    RegExp _numeric = RegExp(r'\d');
    return _numeric.hasMatch(input);
  }
}
