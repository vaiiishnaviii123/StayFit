import 'package:flutter/material.dart';
import 'package:stay_fit/models/user_points.dart';

class LeaderBoardProvider extends ChangeNotifier {
  List<UserRewardPoints> _userRewardPoints = [];

  List<UserRewardPoints> get leaderboard => _userRewardPoints;

  void setLeaderboard(List<UserRewardPoints> list) {
    _userRewardPoints = list;
    notifyListeners();
  }
}
