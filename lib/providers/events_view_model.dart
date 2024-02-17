
import 'package:flutter/foundation.dart';

import '../models/event.dart';
import '../repository/events_repository.dart';

class EventsViewModel with ChangeNotifier {
  EventsRepository _repository;
  List<String> list = [];
  EventsViewModel(this._repository);

  void addEvent(Event event) async {
    await _repository.addEvent(event);
    notifyListeners();
  }

  Future<List<Event>> listAllEvents(String eventType) {
    return _repository.listByEventType(eventType);
  }

  void deleteEvent(Event event) async {
    await _repository.deleteEvent(event);
    notifyListeners();
  }

  Future<List<String>> getMenuList(String eventType) async {
   return await _repository.getMenuList(eventType);
  }

  void updateDietEvent(Event event) async {
    await _repository.updateDietEvent(event);
    notifyListeners();
  }

  Future<int> getCountOfAllEvents(String eventType) async {
    return await _repository.getCountOfAllEvents(eventType);
  }

}