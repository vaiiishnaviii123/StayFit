import 'package:stay_fit/databse/event_db.dart';
import 'package:stay_fit/entity/reward_entity.dart';
import 'package:stay_fit/repository/rewards_respository.dart';
import '../models/reward.dart';

class FloorRewardsRepository implements RewardsRepository {
  EventDatabase _database;

  FloorRewardsRepository(this._database);

  EventDatabase get database => _database;

  @override
  Future<void> addReward(Reward reward) async {
    RewardEntity entity = RewardEntity(
        null,
        reward.rewardPoints,
        reward.dedication,
        reward.event,
        reward.date.millisecondsSinceEpoch,
        reward.pointForNextLevel,
    );
    await _database.rewardsDao.addReward(entity);
  }

  @override
  Future<Reward?> getLastRecord() async {
    final record = await _database.rewardsDao.getLastRecord();
    if(record!=null){
      return _convertFromDatabase(record);
    }else{
      return null;
    }
  }

  Reward _convertFromDatabase(RewardEntity entity) => Reward(
      entity.rewardPoints,
      entity.dedication,
      entity.event,
      DateTime.fromMillisecondsSinceEpoch(entity.occuredOn),
      entity.pointForNextLevel,
  );

}