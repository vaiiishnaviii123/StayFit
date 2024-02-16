import 'package:flutter/foundation.dart';
import 'package:stay_fit/models/event.dart';

class DietMenu with ChangeNotifier {
  var list = <String>{};

  DietMenu(this.list);

  List<String> getDietMenu() {
    return this.list.toList();
  }

  void addDietToList(String menu) {
    list.add(menu);
    notifyListeners();
  }
}