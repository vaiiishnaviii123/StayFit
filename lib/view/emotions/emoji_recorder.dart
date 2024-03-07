import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stay_fit/models/emoji_list.dart';
import 'package:stay_fit/models/event.dart';
import 'package:stay_fit/providers/leader_board_provider.dart';
import 'package:stay_fit/providers/reward_points.dart';
import 'package:stay_fit/view/emotions/emoji_grid.dart';
import '../../models/reward.dart';
import '../../models/user_points.dart';
import '../../providers/app_alternative.dart';
import '../../providers/events_view_model.dart';
import 'emoji_cupertino_grid.dart';

class EmojiRecorder extends StatefulWidget {
  EmojiRecorder({super.key});

  @override
  _EmojiRecorderState createState() {
    return _EmojiRecorderState();
  }
}

class _EmojiRecorderState extends State<EmojiRecorder> {
  late Reward? reward;
  final TextEditingController emojiController = TextEditingController();
  double points = 0.0;
  int dedicationLevel = 0;
  late bool isCupertino;
  FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> setLastRecord() async {
    reward = (await context.read<RewardPoints>().getLastRecord());
  }

  @override
  void initState() {
    setLastRecord();
    isCupertino = context.read<AppAlternative>().getAppAlternative();
    super.initState();
  }

  _onSavePressed(String str, Future<Reward?> rps) async {
     Event event = Event(
          null,
          str,
          DateTime.now(),
          'EMOTION',
          0.00
     );
     var points = await rps;
     print(points?.rewardPoints);

     if(points == null){
       Reward rp = new Reward(0, 0, "Emotion", DateTime.now(), 100.0);
       context.read<RewardPoints>().calcDedicationAndPoints(rp);
     }else{
       points?.event = 'Emotion';
       context.read<RewardPoints>().calcDedicationAndPoints(points!);
     }
     context.read<EventsViewModel>().addEvent(event);
     if(_auth.currentUser != null){
       var pts = await context.read<RewardPoints>().getLastRecord();
       print('points');
       print(pts?.rewardPoints);
       addRewardPointsToFirebase(pts!.rewardPoints);
     }  }

  addRewardPointsToFirebase(double points){
    UserRewardPoints userRewards = UserRewardPoints(
        rewardPoints: points,
        emailId: _auth.currentUser!.email
    );
    context.read<LeaderBoardProvider>().addUserPoints(userRewards);
  }

  @override
  Widget build(BuildContext context) {
    isCupertino = context.watch<AppAlternative>().getAppAlternative();
    return SingleChildScrollView(
      child: isCupertino? EmojiSilverGrid(_onSavePressed): EmojiGrid(_onSavePressed),
    );
  }
}