import 'package:ba_polizei/results_nach_anfrage/ChipProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DisplayDropdown extends StatelessWidget {
  final String text;
  final Widget pushWidget;
  final Widget chip;

  DisplayDropdown({this.text, this.pushWidget, this.chip});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 12.0),
      child: Stack(
        alignment: Alignment.centerRight,
        children: <Widget>[
          TextField(
            onTap: () {
              final chips = Provider.of<ChipProvider>(context, listen: false);
              chips.addChip(key: text, chip: chip);

              Navigator.push(
                context,
                MaterialPageRoute(
                  settings: RouteSettings(name: text),
                  builder: (context) => pushWidget,
                ),
              );
            },
            controller: TextEditingController()..text = text,
            autofocus: false,
            readOnly: true,
            decoration: InputDecoration(
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.grey[200]),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.grey[200]),
              ),
              labelStyle: TextStyle(color: Colors.grey[600]),
              contentPadding: EdgeInsets.symmetric(
                horizontal: 8,
                vertical: 5,
              ),
            ),
          ),
          Icon(Icons.arrow_downward, color: Theme.of(context).primaryColor),
        ],
      ),
    );
  }
}
