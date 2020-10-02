import 'package:flutter/material.dart';

class ChipProvider extends ChangeNotifier {
  List<Widget> chips = [];

  addChip(Widget chip) {
    chips.add(chip);
    notifyListeners();
  }

  removeCip(Widget chip) {
    chips.remove(chip);
    notifyListeners();
  }

  List<Widget> getChips() {
    return chips;
  }
}
