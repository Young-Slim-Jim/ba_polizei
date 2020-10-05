import 'package:flutter/material.dart';

class ChipProvider extends ChangeNotifier {
  Map<String, Widget> chips = {};

  addChip({String key, Widget chip}) {
    chips.putIfAbsent(key, () => chip);
    notifyListeners();
  }

  removeChipFromChip(String keySend) {
    chips.removeWhere((key, value) {
      if (keySend != key && key != "MainScreenSelectedResult") {
        return true;
      } else {
        return false;
      }
    });
    notifyListeners();
  }

  removeChipOnPop(String keySend) {
    chips.remove(keySend);
    notifyListeners();
  }

  List<Widget> getChips() {
    return chips.values.toList();
  }
}
