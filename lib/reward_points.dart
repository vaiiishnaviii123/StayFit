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
    reward.rewardPoints += points;
    notifyListeners();
  }
}