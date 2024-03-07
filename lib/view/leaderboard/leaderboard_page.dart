import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stay_fit/providers/leader_board_provider.dart';
import 'package:stay_fit/view/event_tracker.dart';
import '../../models/navigation.dart';
import 'leader_board_list.dart';

class LeaderboardPage extends StatefulWidget {
  LeaderboardPage({super.key});

  @override
  _LeaderboardPageState createState() {
    return _LeaderboardPageState();
  }
}

class _LeaderboardPageState extends State<LeaderboardPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  @override
  void initState() {
    super.initState();
  }

  Future deleteUser() async {
    User? user = await _auth.currentUser!;
    context.read<LeaderBoardProvider>().deleteUserPoints(user.email);
    user.delete();
    RouterNavigation.getRouter().go('/signUp');
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return CupertinoPageScaffold(
      backgroundColor: Color.fromRGBO(191, 186, 188, 1),
        child: ListView(
        children: [
          SizedBox(
            height: 20,
          ),
       Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
                onPressed: (){
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text('Delete your Account?'),
                        content: const Text(
                            '''If you select Delete we will delete your account on our server.

Your app data will also be deleted and you won't be able to retrieve it.

Since this is a security-sensitive operation, you eventually are asked to login before your account can be deleted.'''),
                        actions: [
                          TextButton(
                            child: const Text('Cancel'),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                          TextButton(
                            child: const Text(
                              'Delete',
                              style: TextStyle(color: Colors.red),),
                            onPressed: () {
                              deleteUser();
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      );
                    },
                  );
                },
                child: Text("Delete Account"),
            ),
          ],
        ),
          SizedBox(
            height: 20,
          ),
          Center(
            child: Text(
              "Leaderboard",
              style: TextStyle(fontSize: 27, fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          SingleChildScrollView(
            child: LeaderBoardList(),
          )
        ],
        ),
    );
  }
}