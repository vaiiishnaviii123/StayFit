import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stay_fit/providers/reward_points.dart';
import '../models/reward.dart';
import '../providers/app_alternative.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class RewardPointsPage extends StatelessWidget {
  RewardPointsPage({super.key});

  @override
  Widget build(BuildContext context) {
    Future<Reward?> latestRecord = context.select<RewardPoints, Future<Reward?>>(
            (viewModel) => viewModel.getLastRecord()
    );
   String getEventType(String event){
      String eventType = "";
      if(event == 'Emotion'){
        eventType = AppLocalizations.of(context)!.emotion;
      }else if(event == 'Diet'){
        eventType = AppLocalizations.of(context)!.diet;
      }else{
        eventType = AppLocalizations.of(context)!.workout;
      }
      return eventType;
    }
    bool isCupertino = context.watch<AppAlternative>().getAppAlternative();
    return FutureBuilder(
      future: latestRecord,
      builder: (context, snapshot) {
        if(snapshot.hasData) {
          final reward = snapshot.data!;
          return isCupertino? Card(
            color: CupertinoColors.extraLightBackgroundGray,
            child: Column(
              children: [
                Text('${AppLocalizations.of(context)!.yourProgress}', style: TextStyle(color: Color.fromRGBO(82, 7, 39, 2), fontSize: 25,)),
                Text('${AppLocalizations.of(context)!.rewardPoints}: ${reward.rewardPoints}', style: TextStyle(color: Colors.black54, fontSize: 15,),),
                if(reward.event.isNotEmpty)Text('${AppLocalizations.of(context)!.lastRecordedEvent}: ${getEventType(reward.event)}', style: TextStyle(color: Colors.black54, fontSize: 15),),
                Text('${AppLocalizations.of(context)!.dedication}: ${reward.dedication}', style: TextStyle(color: Colors.black54, fontSize: 15),),
                if(reward.event.isNotEmpty)Text('${AppLocalizations.of(context)!.lastRecordedDate}: ${reward.date}', style: TextStyle(color: Colors.black54, fontSize: 15),),
                if(reward.event.isEmpty)Text('${AppLocalizations.of(context)!.noRecordMessage}', style: TextStyle(color: Colors.black54, fontSize: 15),),
                if(reward.event.isNotEmpty)Text('${AppLocalizations.of(context)!.nextLevelMessage(reward.pointForNextLevel)}', style: TextStyle(color: Colors.black54, fontSize: 15),)
              ],
            ),
          ): Card(
            color: Color.fromRGBO(173, 167, 153, 5),
            child: Column(
              children: [
                Text('${AppLocalizations.of(context)!.yourProgress}!', style: TextStyle(color: Color.fromRGBO(82, 7, 39, 2), fontSize: 25,)),
                Text('${AppLocalizations.of(context)!.rewardPoints}: ${reward.rewardPoints}', style: TextStyle(color: Colors.white, fontSize: 15,),),
                if(reward.event.isNotEmpty)Text('${AppLocalizations.of(context)!.lastRecordedEvent}: ${getEventType(reward.event)}', style: TextStyle(color: Colors.white, fontSize: 15),),
                Text('${AppLocalizations.of(context)!.dedication}: ${reward.dedication}', style: TextStyle(color: Colors.white, fontSize: 15),),
                if(reward.event.isNotEmpty)Text('${AppLocalizations.of(context)!.lastRecordedDate}: ${reward.date}', style: TextStyle(color: Colors.white, fontSize: 15),),
                if(reward.event.isEmpty)Text('${AppLocalizations.of(context)!.noRecordMessage}', style: TextStyle(color: Colors.black54, fontSize: 15),),
                if(reward.event.isNotEmpty)Text('${AppLocalizations.of(context)!.nextLevelMessage(reward.pointForNextLevel)}', style: TextStyle(color: Colors.black54, fontSize: 15),)
              ],
            ),
          );
        } else{
          return Card(
            color: Color.fromRGBO(173, 167, 153, 5),
            child: Column(
              children: [
                Text('${AppLocalizations.of(context)!.yourProgress}', style: TextStyle(color: Color.fromRGBO(82, 7, 39, 2), fontSize: 25,)),
                Text('${AppLocalizations.of(context)!.rewardPoints}: 0', style: TextStyle(color: Colors.white, fontSize: 15,),),
                Text('${AppLocalizations.of(context)!.dedication}: 0', style: TextStyle(color: Colors.white, fontSize: 15),),
                Text('${AppLocalizations.of(context)!.noRecordMessage}', style: TextStyle(color: Colors.black54, fontSize: 15),),
              ],
            ),
          );
        }
      },
    );
  }
}