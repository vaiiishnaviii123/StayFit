import 'package:flutter/foundation.dart';
import 'package:stay_fit/Models/event.dart';

class EmotionList with ChangeNotifier {
  late List<Event> list;

  EmotionList(this.list);

  List<Event> getEmotionsList() {
    return this.list.toList();
  }

  void addEmotionsToList(Event event) {
    list.add(event);
    notifyListeners();
  }
}