import 'package:floor/floor.dart';

@Entity(tableName: "Rewards")
class RewardEntity {
  @primaryKey
  final int? id;
  final double rewardPoints;
  final int dedication;
  final String event;
  final int occuredOn;
  final double pointForNextLevel;

  RewardEntity(this.id, this.rewardPoints, this.dedication, this.event, this.occuredOn, this.pointForNextLevel);
}