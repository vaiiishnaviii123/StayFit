import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../models/user_points.dart';
import '../../providers/app_alternative.dart';

class LeaderBoardCard extends StatefulWidget {
  UserRewardPoints _userRewardPoints;
  int _rank;

  LeaderBoardCard(this._userRewardPoints, this._rank, {super.key});

  @override
  _LeaderBoardCardState createState() => _LeaderBoardCardState();
}

class _LeaderBoardCardState extends State<LeaderBoardCard> {
  late bool isCupertino;

  @override
  void initState() {
    isCupertino = context.read<AppAlternative>().getAppAlternative();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    isCupertino = context.watch<AppAlternative>().getAppAlternative();
    return Card(
      color: Color.fromRGBO(173, 167, 153, 5),
      child: SizedBox(
        key: Key("card"),
        height: 60,
        child: isCupertino
            ? Center(
            child: CupertinoListTile(
              leadingToTitle: 0,
              trailing: Center(child:Text("${widget._rank}")),
              title: Column(
                children: [
                  Text(
                    'User: ${widget._userRewardPoints.emailId}',
                    style: TextStyle(fontSize: 12),
                  ),
                  Text('${AppLocalizations.of(
                      context)!.rewardPoints}: ${widget._userRewardPoints
                      .rewardPoints}',
                    style: TextStyle(fontSize: 12),),
                ],
              ),
            ))
            : ListTile(
            trailing: Text('${widget._rank}'),
            title: Column(
              children: [
                Text(
                  'User: ${widget._userRewardPoints.emailId}',
                  style: TextStyle(fontSize: 12),
                ),
                Text('${AppLocalizations.of(
                context)!.rewardPoints}: ${widget._userRewardPoints
                    .rewardPoints}',
                    style: TextStyle(fontSize: 12),),
              ],
            )
        ),
      ),
    );
  }
}
