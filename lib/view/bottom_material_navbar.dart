import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:stay_fit/login/sign_in_up_form.dart';
import 'package:stay_fit/providers/app_alternative.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../models/navigation.dart';


class BottomNavBar extends StatefulWidget {
  final StatefulNavigationShell navigationShell;
  BottomNavBar(this.navigationShell, {super.key});

  @override
  _BottomNavBarState createState() => _BottomNavBarState();

}

class _BottomNavBarState extends State<BottomNavBar> {
  late bool isCupertino;

  @override
  void initState() {
     isCupertino = context.read<AppAlternative>().getAppAlternative();
    super.initState();
    // getDatabase();
  }
  var dietMenu = <String>{};

  _onChange(){
    context.read<AppAlternative>().setCupertinoValue();
    setState(() {
     isCupertino = context.read<AppAlternative>().getAppAlternative();
    });
    print('pressed');
    print(isCupertino);
    // context.watch<AppAlternative>().setCupertinoValue();
  }
  @override
  Widget build(BuildContext context) {
    isCupertino = context.watch<AppAlternative>().getAppAlternative();
    return Scaffold(
      body: widget.navigationShell,
      backgroundColor: Color.fromRGBO(191, 186, 188, 1),
      appBar: AppBar(
          backgroundColor: isCupertino?CupertinoColors.inactiveGray: Color.fromRGBO(82, 7, 39, 2),
          leading: IconButton(
            icon: Icon(Icons.logout, color: Colors.white,),
            onPressed: (){
              RouterNavigation.getRouter().go('/leaderboard');
            },
          ),
          title: Row(
            children: [
              Text(AppLocalizations.of(context)!.stayFit, style: TextStyle(color: Colors.white)),
              //const SizedBox(width: 100),
              isCupertino? CupertinoSwitch(
                  value: isCupertino,
                  onChanged: (bool? value) {
                    _onChange();
                  },
              ) :Checkbox(
                value: !isCupertino,
                onChanged: (bool? value) {
                  _onChange();
                },
              ),
              isCupertino? Text(AppLocalizations.of(context)!.cupertino, style: TextStyle(color: Colors.white, fontSize: 15)) :
              Text(AppLocalizations.of(context)!.materialApp, style: TextStyle(color: Colors.white, fontSize: 15)),
              // RewardPointsPage(),
            ],
          )
      ),
      bottomNavigationBar: isCupertino? CupertinoNavigationBar(
        backgroundColor: CupertinoColors.extraLightBackgroundGray,
        // This Cupertino segmented control has the enum "Sky" as the type.
        middle: CupertinoSlidingSegmentedControl<int>(
          backgroundColor: CupertinoColors.systemGrey2,
          // This represents the currently selected segmented control.
          groupValue: widget.navigationShell.currentIndex,
          thumbColor: Color(0xff007ba7), //0xff40826d
          // Callback that sets the selected segmented control.
          onValueChanged: (int? tappedIndex) {
              widget.navigationShell.goBranch(tappedIndex!);
            },
          children: <int, Widget>{
             0: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                    AppLocalizations.of(context)!.emotion,
                    style: TextStyle(color: CupertinoColors.white, fontSize: 10),
              ),
            ),
             1: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                AppLocalizations.of(context)!.diet,
                style: TextStyle(color: CupertinoColors.white, fontSize: 10),
              ),
            ),
            2: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                AppLocalizations.of(context)!.workout,
                    style: TextStyle(color: CupertinoColors.white, fontSize: 10),
              ),
            ),
            3: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                AppLocalizations.of(context)!.leaderBoard,
                style: TextStyle(color: CupertinoColors.white, fontSize: 10),
              ),
            ),
          },
        ),
      ):
      BottomNavigationBar(
        backgroundColor:Colors.black,
        selectedItemColor: Colors.greenAccent,
        unselectedItemColor: Colors.white,
        currentIndex: widget.navigationShell.currentIndex,

        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.emoji_emotions), label: AppLocalizations.of(context)!.emotion, backgroundColor:Color.fromRGBO(82, 7, 39, 2)),
          BottomNavigationBarItem(icon: Icon(Icons.fastfood), label: AppLocalizations.of(context)!.diet,backgroundColor:Color.fromRGBO(82, 7, 39, 2)),
          BottomNavigationBarItem(icon: Icon(Icons.run_circle), label: AppLocalizations.of(context)!.workout, backgroundColor:Color.fromRGBO(82, 7, 39, 2)),
          BottomNavigationBarItem(icon: Icon(Icons.leaderboard), label: AppLocalizations.of(context)!.leaderBoard, backgroundColor: Color.fromRGBO(82, 7, 39, 2)),
        ],
        onTap: (int tappedIndex) {
          widget.navigationShell.goBranch(tappedIndex);
        },
      ),
    );
  }
}