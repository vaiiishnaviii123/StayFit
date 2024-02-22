import 'package:flutter/foundation.dart';
import 'package:stay_fit/models/reward.dart';
import 'package:stay_fit/repository/rewards_respository.dart';

class RewardPoints with ChangeNotifier {
  RewardsRepository _repository;
  RewardPoints(this._repository);

  void addReward(Reward reward) async {
    await _repository.addReward(reward);
    notifyListeners();
  }

  Future<Reward?> getLastRecord() async {
    return await _repository.getLastRecord();
  }

  void calcDedicationAndPoints(Reward reward){
    DateTime currentTime = DateTime.now();

    // Calculate time difference in minutes
    double timeDifference = currentTime.difference(reward.date).inMinutes.toDouble();

    if (timeDifference > 10) {
      // If last submission was more than 10 minutes ago, reduce 1 point for every 10 mins difference
      double pointsToDeduct = (timeDifference / 10).floorToDouble();
      reward.rewardPoints += (10 - pointsToDeduct);

      // Ensuring points don't go below zero
      if (reward.rewardPoints < 0) {
        reward.rewardPoints = 0.0;
      }
    } else if (timeDifference < 2) {
      // If last submission was within 2 minutes, add 5 extra points
      reward.rewardPoints += 15.0; // 10 base points + 5 extra points
    } else {
      // Otherwise, add 10 base points
      reward.rewardPoints += 10.0;
    }
    // Calculating dedication level -  dedication level is increased by 1 for every 100 points earned
    reward.dedication = (reward.rewardPoints ~/ 100).toInt();
    reward.date = currentTime;
    reward.pointForNextLevel = (reward.dedication + 1) * 100 - reward.rewardPoints;
    addReward(reward);
  }
}