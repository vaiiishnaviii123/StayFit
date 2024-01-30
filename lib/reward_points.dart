import 'package:flutter/foundation.dart';
import 'package:stay_fit/Models/reward.dart';

class RewardPoints with ChangeNotifier {
  Reward reward;

  RewardPoints(this.reward);

  Reward getRewardPoints() { return reward; }

  void setRewardPoints(Reward newReward) {
    reward = newReward;
    notifyListeners();
  }

  void setEvent(String event) {
    reward.event = event;
    notifyListeners();
  }

  void setDate(DateTime date) {
    reward.date = date;
    notifyListeners();
  }

  void setPoints(double points) {
    reward.rewardPoints = points;
    notifyListeners();
  }

  void setDedication(int points) {
    reward.dedication = points;
    notifyListeners();
  }

  void calcDedicationAndPoints(){
    DateTime currentTime = DateTime.now();

    // Calculate time difference in minutes
    double timeDifference = currentTime.difference(reward.date).inMinutes.toDouble();

    if (timeDifference > 10) {
      // If last submission was more than 2 minutes ago, reduce 1 point for every 2 mins difference
      double pointsToDeduct = (timeDifference / 10).floorToDouble();
      reward.rewardPoints += (10 - pointsToDeduct);

      // Ensure points don't go below zero
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
    // Calculate dedication level
    reward.dedication = (reward.rewardPoints ~/ 100).toInt();
    reward.date = currentTime;
    reward.pointForNextLevel = (reward.dedication + 1) * 100 - reward.rewardPoints;
  }
}