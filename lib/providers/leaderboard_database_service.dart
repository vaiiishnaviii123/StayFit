import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:stay_fit/models/user_points.dart';

class LeaderBoardDatabase{
   FirebaseFirestore database = FirebaseFirestore.instance;
   late CollectionReference userRewardPointsCollection = database.collection('UserRewardPoints');

  Future addUserRewardsToLeaderBoard(UserRewardPoints userRewards) async {
    await userRewardPointsCollection.doc(userRewards.emailId).set({
      'rewardPoints': userRewards?.rewardPoints,
      'emailId':  userRewards?.emailId,
    });
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

   @override
   Future<void> deleteUserPoints(String email) async {
     await userRewardPointsCollection.doc(email).delete().then(
           (doc) => print("Document deleted"),
       onError: (e) => print("Error updating document $e"),
     );
   }
}
