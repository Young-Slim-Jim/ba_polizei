import 'package:ba_polizei/abfragegrund.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class VivaPerson extends StatefulWidget {
  @override
  _VivaPersonState createState() => _VivaPersonState();
}

class _VivaPersonState extends State<VivaPerson> {
  String abfragegrund;

  TextEditingController abfragegrundController = TextEditingController(
    text: 'Bitte auswählen',
  );

  final nameFocus = FocusNode();
  final vornameFocus = FocusNode();

  TextEditingController nameController = TextEditingController();

  TextEditingController vornameController = TextEditingController();

  TextEditingController ergaenzungController = TextEditingController(
    text: 'mobileAbfrage',
  );

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
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
          title: Row(
            children: [
              Expanded(
                flex: 45,
                child: Text(
                  "ViVA Person",
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
              color: Theme.of(context).secondaryHeaderColor,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("Angemeldet als plxtu62",
                    textAlign: TextAlign.left,
                    style: TextStyle(color: Colors.white, fontSize: 13)),
              ),
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: [
            abfragegrundTextfield(),
            ergaenzungstextTextfield(),
            nameTextfield(),
            vornameTextfield()
          ],
        ),
      ),
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
                floatingLabelBehavior: FloatingLabelBehavior.always,
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 8,
                ),
              ),
            ),
            nameFocus.hasFocus
                ? IconButton(
                    icon: Icon(Icons.close),
                    onPressed: () => nameController.clear())
                : IconButton(
                    icon: Icon(Icons.switch_camera),
                    onPressed: () {
                      nameFocus.unfocus();
                      vornameFocus.unfocus();
                      String savetext;
                      savetext = nameController.text;
                      nameController.text = vornameController.text;
                      vornameController.text = savetext;
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
                floatingLabelBehavior: FloatingLabelBehavior.always,
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 8,
                ),
              ),
            ),
            vornameFocus.hasFocus
                ? IconButton(
                    icon: Icon(Icons.close),
                    onPressed: () => vornameController.clear())
                : IconButton(
                    icon: Icon(Icons.switch_camera),
                    onPressed: () {
                      nameFocus.unfocus();
                      vornameFocus.unfocus();
                      String savetext;
                      savetext = nameController.text;
                      nameController.text = vornameController.text;
                      vornameController.text = savetext;
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
          labelText: "Ergänzungstext",
          contentPadding: EdgeInsets.symmetric(
            horizontal: 8,
          ),
        ),
      ),
    );
  }

  Widget abfragegrundTextfield() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: TextField(
        readOnly: true,
        autofocus: false,
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => Abfragegrund(),
            ),
          ).then(
            (value) {
              setState(
                () {
                  abfragegrundController.text = value;
                },
              );
            },
          );
        },
        controller: abfragegrundController,
        decoration: InputDecoration(
          labelText: "Abfragegrund",
          contentPadding: EdgeInsets.symmetric(
            horizontal: 8,
          ),
          suffixIcon: SizedBox(
            height: 15,
            child: Icon(
              Icons.arrow_drop_down,
              color: Theme.of(context).accentColor,
            ),
          ),
        ),
      ),
    );
  }
}
