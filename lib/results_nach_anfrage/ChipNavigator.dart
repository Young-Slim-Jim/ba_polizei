import 'package:ba_polizei/results_nach_anfrage/ChipProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChipNavigator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final chips = Provider.of<ChipProvider>(context);
    return Container(
      height: MediaQuery.of(context).size.height * 0.06,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 5,
            child: Wrap(
              children: List.generate(chips.getChips().length, (index) {
                final contentList = chips.getChips();
                final content = contentList[index];
                return content;
              }),
            ),
          ),
          Expanded(
            child: Divider(
              color: Colors.grey[200],
            ),
          ),
        ],
      ),
    );
  }

  buildRow(ChipProvider chips) {
    final content = chips.getChips();
    return content;
  }
}
