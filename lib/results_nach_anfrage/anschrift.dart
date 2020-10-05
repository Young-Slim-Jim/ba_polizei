import 'package:ba_polizei/results_nach_anfrage/ChipNavigator.dart';
import 'package:ba_polizei/results_nach_anfrage/ChipProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Anschrift extends StatelessWidget {
  final String ident;
  Anschrift(this.ident);
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        final chips = Provider.of<ChipProvider>(context, listen: false);
        chips.removeChipOnPop(ident);
        return Future.value(true);
      },
      child: Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: Theme.of(context).accentColor),
          title: Text("ViVA Person"),
          actions: [Icon(Icons.share)],
        ),
        body: ChipNavigator(),
      ),
    );
  }
}
