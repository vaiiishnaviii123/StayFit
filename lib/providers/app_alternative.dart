import 'package:flutter/cupertino.dart';

class AppAlternative with ChangeNotifier {
  bool _isCupertino = false;

  bool getAppAlternative(){
    return this._isCupertino;
  }

  void setCupertinoValue(){
    this._isCupertino = !this._isCupertino;
    notifyListeners();
  }
}