import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stay_fit/models/reward.dart';

import '../../models/emoji_list.dart';
import '../../providers/reward_points.dart';

class EmojiGrid extends StatefulWidget {
  final void Function(String, Future<Reward?>) _onSavePressed;
  EmojiGrid(this._onSavePressed, {super.key});

  @override
  _EmojiGridState createState() {
    return _EmojiGridState();
  }
}

class _EmojiGridState extends State<EmojiGrid> {
  Map<String, String> eMap = new Map<String, String>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var rps = (context.watch<RewardPoints>().getLastRecord());
    eMap = EmojiList.getList(context);
    // TODO: implement build
    return GridView.count(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      primary: false,
      padding: const EdgeInsets.all(30),
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
      crossAxisCount: 5,
      children: eMap.keys.map((String key){
        return Container(
          color: Colors.blueGrey,
          child: Center(
            child:GestureDetector(
              key: Key(key),
              onTap: () {
                 widget._onSavePressed('$key, ${eMap[key]}', rps);
              },
              child: Text(key, style: TextStyle(fontSize: 35)),
            ),
          ),
        );
      }).toList(),
    );
  }
}