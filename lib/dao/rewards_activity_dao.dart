import 'package:floor/floor.dart';
import 'package:stay_fit/entity/reward_entity.dart';

@dao
abstract class RewardsDao {
  @insert
  Future<void> addReward(RewardEntity reward);

  @Query('SELECT * FROM Rewards ORDER BY id DESC LIMIT 1')
  Future<RewardEntity?> getLastRecord();
}