import 'package:flutter/material.dart';
import 'package:stay_fit/models/user_points.dart';
import 'package:stay_fit/providers/leaderboard_database_service.dart';

class LeaderBoardProvider extends ChangeNotifier {
  List<UserRewardPoints> _userRewardPoints = [];
  LeaderBoardDatabase database = LeaderBoardDatabase();

  List<UserRewardPoints> get leaderboard => _userRewardPoints;

  Future<List<UserRewardPoints>> getLeaderboard() {
    return database.fetchLeaderboardData();
  }

  void addUserPoints(UserRewardPoints userRewards){
    database.addUserRewardsToLeaderBoard(userRewards);
    notifyListeners();
  }

  Future<void> deleteUserPoints(String? email) async {
    await database.deleteUserPoints(email!);
    notifyListeners();
  }
}
