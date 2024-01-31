import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stay_fit/providers/reward_points.dart';

class RewardPointsPage extends StatefulWidget {
  const RewardPointsPage({super.key});

  @override
  _RewardPointsPageState createState() {
    return _RewardPointsPageState();
  }
}

class _RewardPointsPageState extends State<RewardPointsPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Card(
      color: Color.fromRGBO(173, 167, 153, 5),
      child: Column(
       children: [
         Text('Your Progress!', style: TextStyle(color: Color.fromRGBO(82, 7, 39, 2), fontSize: 25,)),
         Text('Reward Points: ${context.watch<RewardPoints>().getRewardPoints().rewardPoints}', style: TextStyle(color: Colors.white, fontSize: 15,),),
         if(context.watch<RewardPoints>().getRewardPoints().event.isNotEmpty)Text('Last Event Recorded: ${context.watch<RewardPoints>().getRewardPoints().event}', style: TextStyle(color: Colors.white, fontSize: 15),),
         Text('Dedication Level: ${context.watch<RewardPoints>().getRewardPoints().dedication}', style: TextStyle(color: Colors.white, fontSize: 15),),
         if(context.watch<RewardPoints>().getRewardPoints().event.isNotEmpty)Text('Last Recorded on: ${context.watch<RewardPoints>().getRewardPoints().date}', style: TextStyle(color: Colors.white, fontSize: 15),),
         if(context.watch<RewardPoints>().getRewardPoints().event.isEmpty)Text('Log your first record to earn points!', style: TextStyle(color: Colors.black54, fontSize: 15),),
         if(context.watch<RewardPoints>().getRewardPoints().event.isNotEmpty)Text('Earn ${context.watch<RewardPoints>().getRewardPoints().pointForNextLevel} points to reach next level, hurry up!', style: TextStyle(color: Colors.black54, fontSize: 15),)

       ],
      ),
    );
  }
}