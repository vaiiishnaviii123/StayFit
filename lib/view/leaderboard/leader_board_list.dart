import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stay_fit/models/user_points.dart';
import 'package:stay_fit/providers/leader_board_provider.dart';
import '../../providers/leaderboard_database_service.dart';
import 'leader_board_card.dart';

class LeaderBoardList extends StatefulWidget {
  const LeaderBoardList({super.key});
  @override
  _LeaderBoardListState createState() {
    return _LeaderBoardListState();
  }
}

class _LeaderBoardListState extends State<LeaderBoardList> {
  late Future<List<UserRewardPoints>> leaderBoard;
  @override
  void initState() {
    this.fetchData();
    super.initState();
  }

  Future<void> fetchData() async {
    Future<List<UserRewardPoints>> list = context.watch<LeaderBoardDatabase>().fetchLeaderboardData();
    setState(() {
      leaderBoard = list;
    });
  }
  @override
  Widget build(BuildContext context) {
    fetchData();
    return FutureBuilder(
      future: leaderBoard,
      builder: (context, snapshot) {
        if(snapshot.hasData) {
          final events = snapshot.data!;
          return Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: List.generate(
                events.length, (index) => LeaderBoardCard(events.elementAt(index),index+1)
            ),
          );
        } else if(snapshot.hasError) {
          return const Text('An error occurred trying to load your data and we have no idea what to do about it. Sorry.');
        } else {
          return const CircularProgressIndicator();
        }
      },
    );
  }
}
