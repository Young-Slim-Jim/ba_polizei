import 'dart:io';

import 'package:ba_polizei/listsammlung.dart';
import 'package:ba_polizei/resultScreen.dart';
import 'package:ba_polizei/searchSheetAndroid.dart';
import 'package:ba_polizei/searchSheetIOS.dart';
import 'package:ba_polizei/cupertinoDialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class VivaPerson extends StatefulWidget {
  @override
  _VivaPersonState createState() => _VivaPersonState();
}

class _VivaPersonState extends State<VivaPerson> {
  String abfragegrund;
  bool erweitert = false;
  bool phonetisch = false;
  bool nurFahndungsabfrage = false;

  final nameFocus = FocusNode();
  final vornameFocus = FocusNode();
  final bdayFocus = FocusNode();

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

  void initState() {
    super.initState();
    nameFocus.addListener(() {
      setState(() {});
    });
    vornameFocus.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(height * 0.113),
        child: AppBar(
          iconTheme: IconThemeData(color: Theme.of(context).accentColor),
          leading: IconButton(
            icon: Icon(Icons.chevron_left, size: 30),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          elevation: 0.0,
          title: Row(
            children: [
              Expanded(
                flex: 45,
                child: Text(
                  Platform.isIOS ? "ViVA Person" : "SIS Person",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white),
                ),
              ),
              Expanded(
                  flex: 13,
                  child:
                      IconButton(icon: Icon(Icons.cancel), onPressed: () {})),
              Expanded(
                  flex: 13,
                  child: IconButton(
                      icon: Icon(Icons.scatter_plot), onPressed: () => {})),
              Expanded(
                  flex: 13,
                  child: IconButton(
                      icon: Icon(CupertinoIcons.search), onPressed: () => {})),
            ],
          ),
          centerTitle: true,
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
                                    color:
                                        Theme.of(context).textSelectionColor)),
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
              searchSheettextfield("Abfragegrund",
                  Listsammlung().getAbfragegruende(), abfragegrundController),
              ergaenzungstextTextfield(),
              nameTextfield(),
              vornameTextfield(),
              bdayTextfield(),
              Platform.isIOS
                  ? Padding(
                      padding: const EdgeInsets.only(bottom: 12.0),
                      child: FlatButton(
                        onPressed: () => {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ResultScreen()),
                          )
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

  erweiterteTextfields() {
    return Column(
      children: [
        floatingLabelTextfield("Geburtsort", bdayOrtController),
        floatingLabelTextfield("Geburtsname", bdaynameController),
        floatingLabelTextfield("Spitzname", nicknameController),
        searchSheettextfield("Geburtsland", Listsammlung().getlaenderNamen(),
            bdaylandController),
        searchSheettextfield(
            "Staatsangehörigkeit",
            Listsammlung().getStaatsangehoerigkeiten(),
            staatsangehoerigkeitController),
        searchSheettextfield("Geschlecht", Listsammlung().getGeschlecht(),
            geschlechtsController),
        searchSheettextfield(
            "Rolle", Listsammlung().getRollen(), rollenController),
      ],
    );
  }

  Widget floatingLabelTextfield(
    String title,
    TextEditingController controller,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: TextField(
        controller: controller,
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
    );
  }

  Widget searchSheettextfield(
    String title,
    List<String> auswahl,
    TextEditingController controller,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: TextField(
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
                );
        },
        controller: controller,
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
              color: Theme.of(context).textSelectionColor,
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
                            activeColor: Colors.green,
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
          TextField(
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
          IconButton(
            icon: Icon(Icons.calendar_today,
                color: Theme.of(context).textSelectionColor),
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
          bdayFocus.requestFocus();
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
    ).then(
      (value) {
        setState(() {
          bdayController.text = DateFormat('dd.MM.yyyy').format(value);
          bdayFocus.requestFocus();
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
            TextField(
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
            nameFocus.hasFocus
                ? IconButton(
                    icon: Icon(Icons.close,
                        color: Theme.of(context).textSelectionColor),
                    onPressed: () => nameController.clear())
                : IconButton(
                    icon: Icon(
                      Icons.switch_camera,
                      color: Theme.of(context).textSelectionColor,
                    ),
                    onPressed: () {
                      String savetext;
                      savetext = nameController.text;
                      nameController.text = vornameController.text;
                      vornameController.text = savetext;
                      nameController.selection = TextSelection.fromPosition(
                          TextPosition(offset: nameController.text.length));
                    }),
          ],
        ),
      ),
    );
  }

  Widget vornameTextfield() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Container(
        child: Stack(
          alignment: Alignment.centerRight,
          children: <Widget>[
            TextField(
              autofocus: false,
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
                        color: Theme.of(context).textSelectionColor),
                    onPressed: () => vornameController.clear())
                : IconButton(
                    icon: Icon(Icons.switch_camera,
                        color: Theme.of(context).textSelectionColor),
                    onPressed: () {
                      // nameFocus.unfocus();
                      // vornameFocus.unfocus();
                      String savetext;
                      savetext = nameController.text;
                      nameController.text = vornameController.text;
                      vornameController.text = savetext;
                      vornameController.selection = TextSelection.fromPosition(
                          TextPosition(offset: vornameController.text.length));
                    }),
          ],
        ),
      ),
    );
  }

  Widget ergaenzungstextTextfield() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: TextField(
        autofocus: false,
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
}
