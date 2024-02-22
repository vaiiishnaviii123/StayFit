import 'package:stay_fit/models/reward.dart';

abstract class RewardsRepository {
  Future<void> addReward(Reward reward);
  Future<Reward?> getLastRecord();
}