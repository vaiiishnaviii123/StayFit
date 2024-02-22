import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stay_fit/models/reward.dart';

import '../../models/emoji_list.dart';
import '../../providers/reward_points.dart';

class EmojiSilverGrid extends StatefulWidget {
  final void Function(String, Future<Reward?>) _onSavePressed;
  EmojiSilverGrid(this._onSavePressed, {super.key});

  @override
  _EmojiSilverGridState createState() {
    return _EmojiSilverGridState();
  }
}

class _EmojiSilverGridState extends State<EmojiSilverGrid> {
  Map<String, String> eMap = new Map<String, String>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var rps = (context.watch<RewardPoints>().getLastRecord());
    eMap = EmojiList.getList(context);
    return CustomScrollView(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        slivers: <Widget>[
          SliverPadding(padding: const EdgeInsets.all(30),
          sliver: SliverGrid(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 5,
                mainAxisSpacing: 10.0,
                crossAxisSpacing: 10.0,
                mainAxisExtent: 60.0,
              ),
              delegate: SliverChildBuilderDelegate(
                      (BuildContext context, int index) =>Container(
                    color: CupertinoColors.systemGrey,
                    child: Center(
                      child:GestureDetector(
                        key: Key(eMap.keys.elementAt(index)),
                        onTap: () {
                          widget._onSavePressed('${eMap.keys.elementAt(index)}, ${eMap.values.elementAt(index)}', rps);
                        },
                        child: Text(eMap.keys.elementAt(index), style: TextStyle(fontSize: 35)),
                      ),
                    ),
                  ),
                  childCount: eMap.length
              )
          ),
          ),
        ]
    );
  }
}

// TODO: implement build
// return CustomScrollView(
//       scrollDirection: Axis.vertical,
//         shrinkWrap: true,
//         slivers: <Widget>[
//            SliverGrid(
//               gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                   crossAxisCount: 5,
//                   mainAxisSpacing: 10.0,
//                   crossAxisSpacing: 10.0,
//                   mainAxisExtent: 60.0,
//               ),
//               delegate: SliverChildBuilderDelegate(
//                       (BuildContext context, int index) =>Container(
//                         color: Colors.blueGrey,
//                         child: Center(
//                           child:GestureDetector(
//                             key: Key(eMap.keys.elementAt(index)),
//                             onTap: () {
//                               widget._onSavePressed('${eMap.keys.elementAt(index)}, ${eMap.values.elementAt(index)}', rps);
//                             },
//                             child: Text(eMap.keys.elementAt(index), style: TextStyle(fontSize: 35)),
//                           ),
//                         ),
//                       ),
//                   childCount: eMap.length
//               )
//           ),
//         ]
// );