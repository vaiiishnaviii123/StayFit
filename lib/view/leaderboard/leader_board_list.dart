import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stay_fit/models/user_points.dart';
import 'package:stay_fit/providers/leader_board_provider.dart';
import '../../providers/leaderboard_database_service.dart';
import 'leader_board_card.dart';

class LeaderBoardList extends StatelessWidget {
  const LeaderBoardList({super.key});

  @override
  Widget build(BuildContext context) {
    Future<List<UserRewardPoints>> futureEvents = context.select<LeaderBoardProvider, Future<List<UserRewardPoints>>>(
            (viewModel) => viewModel.getLeaderboard()
    );
    return FutureBuilder(
      future: futureEvents,
      builder: (context, snapshot) {
        if(snapshot.hasData) {
          final events = snapshot.data!;
          return Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: List.generate(
                events.length, (index) => LeaderBoardCard(events.elementAt(index), index+1)
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