import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:stay_fit/models/user_points.dart';
import 'leader_board_provider.dart';

class LeaderBoardDatabase extends ChangeNotifier {
   FirebaseFirestore database = FirebaseFirestore.instance;
   late CollectionReference userRewardPointsCollection = database.collection('UserRewardPoints');

  Future addUserRewardsToLeaderBoard(UserRewardPoints userRewards) async {
    await userRewardPointsCollection.doc(userRewards.emailId).set({
      'rewardPoints': userRewards?.rewardPoints,
      'emailId':  userRewards?.emailId,
    });
    notifyListeners();
  }

  Future<List<UserRewardPoints>> fetchLeaderboardData() async {
    try {
      QuerySnapshot querySnapshot = await userRewardPointsCollection.orderBy('rewardPoints', descending: true).get();
      List<UserRewardPoints> users = [];
      for (var doc in querySnapshot.docs) {
        users.add(UserRewardPoints(
          rewardPoints: doc['rewardPoints'],
          emailId: doc['emailId']
        ));
      }
      return users.toList();
    } catch (error) {
      print("Error fetching community posts: $error");
      throw error;
    }
  }
}
