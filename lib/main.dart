import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:stay_fit/models/event.dart';
import 'package:stay_fit/diet/diet_recorder_page.dart';
import 'package:stay_fit/providers/diet_menu.dart';
import 'package:stay_fit/emotions/emoji_recorder_page.dart';
import 'package:stay_fit/providers/event_diet_list.dart';
import 'package:stay_fit/providers/event_emotions_list.dart';
import 'package:stay_fit/providers/event_workout_list.dart';
import 'package:stay_fit/providers/reward_points.dart';
import 'package:stay_fit/workout/workout_recorder_page.dart';
import 'package:stay_fit/models/reward.dart';

void main() {
  runApp(StatefulShellRouteExampleApp());
}

class ScaffoldBottomNavigationBar extends StatelessWidget {
   ScaffoldBottomNavigationBar({
    required this.navigationShell,
    Key? key,
  }) : super(key: key ?? const ValueKey<String>('ScaffoldBottomNavigationBar'));

  final StatefulNavigationShell navigationShell;
  Reward rp = new Reward(0, 0, "", DateTime.now(), 100.0);
  List<Event> list = [];
  List<Event> dietList = [];
  List<Event> workoutList = [];
  var dietMenu = <String>{};

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider( create: (context) => RewardPoints(rp)),
        ChangeNotifierProvider(create: (context) => EmotionList(list)),
        ChangeNotifierProvider(create: (context) => DietList(dietList)),
        ChangeNotifierProvider(create: (context) => WorkoutList(workoutList)),
        ChangeNotifierProvider(create: (context) => DietMenu(dietMenu)),
      ],
      child: Scaffold(
      body: navigationShell,
        backgroundColor: Color.fromRGBO(191, 186, 188, 1),
        appBar: AppBar(
            backgroundColor: const Color.fromRGBO(82, 7, 39, 2),
            title: Column(
              children: [
                Text('Stay Fit', style: TextStyle(color: Colors.white),),
                // RewardPointsPage(),
              ],
            )
        ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Color.fromRGBO(82, 7, 39, 2),
        selectedItemColor: Colors.greenAccent,
        unselectedItemColor: Colors.white,
        currentIndex: navigationShell.currentIndex,

        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.emoji_emotions), label: 'Emotion Tracker'),
          BottomNavigationBarItem(icon: Icon(Icons.fastfood), label: 'Diet Tracker', backgroundColor: Colors.white),
          BottomNavigationBarItem(icon: Icon(Icons.run_circle), label: 'Workout Tracker', backgroundColor: Colors.white),
        ],
        onTap: (int tappedIndex) {
          navigationShell.goBranch(tappedIndex);
        },
      ),
      ),
    );
  }
}

class StatefulShellRouteExampleApp extends StatelessWidget {
  StatefulShellRouteExampleApp({super.key});

  final GoRouter _router = GoRouter(
    initialLocation: '/emoji/tracker',
    routes: <RouteBase>[
      // GoRoute(
      //   path: '/login',
      //   builder: (BuildContext context, GoRouterState state) {
      //     return const LoginScreen();
      //   },
      // ),
      StatefulShellRoute.indexedStack(
        builder: (BuildContext context, GoRouterState state,
            StatefulNavigationShell navigationShell) {
          return ScaffoldBottomNavigationBar(
            navigationShell: navigationShell,
          );
        },
        branches: <StatefulShellBranch>[
          StatefulShellBranch(
            routes: <RouteBase>[
              GoRoute(
                path: '/emoji/tracker',
                builder: (BuildContext context, GoRouterState state) {
                  return EmojiRecorderPage();
                },
              ),
            ],
          ),
          StatefulShellBranch(
            routes: <RouteBase>[
              GoRoute(
                path: '/diet/tracker',
                builder: (BuildContext context, GoRouterState state) {
                  return DietRecorderPage();
                },
              ),
            ],
          ),
          StatefulShellBranch(
            routes: <RouteBase>[
              GoRoute(
                path: '/workout/tracker',
                builder: (BuildContext context, GoRouterState state) {
                  return WorkoutRecorderPage();
                },
              ),
            ],
          ),
        ],
      ),
    ],
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Go_router Complex Demo',
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      routerConfig: _router,
    );
  }
}


class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login Screen')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                context.go('/emoji/tracker');
              },
              child: const Text('Go to the Details Login screen'),
            ),
          ],
        ),
      ),
    );
  }
}