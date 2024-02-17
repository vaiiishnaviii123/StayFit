import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:stay_fit/providers/events_view_model.dart';
import 'package:stay_fit/repository/FloorEventsRepository.dart';
import 'package:stay_fit/databse/event_db.dart';
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

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  EventDatabase database = await $FloorEventDatabase.databaseBuilder('event.db').build();
  runApp(MyApp(database));
}

class MyApp extends StatelessWidget {
  EventDatabase database;
  MyApp(this.database, {super.key});

  final GoRouter _router = GoRouter(
    initialLocation: '/emoji/tracker',
    routes: <RouteBase>[
      StatefulShellRoute.indexedStack(
        builder: (BuildContext context, GoRouterState state,
            StatefulNavigationShell navigationShell) {
          return BottomNavBar(
            navigationShell
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
          // StatefulShellBranch(
          //   routes: <RouteBase>[
          //     GoRoute(
          //       path: '/emotion/list',
          //       builder: (BuildContext context, GoRouterState state) {
          //         return SingleChildScrollView(
          //          child: ShowEmotionList('EMOTION'),
          //         );
          //       },
          //     ),
          //   ],
          // ),
        ],
      ),
    ],
  );

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => EventsViewModel(FloorEventsRepository(database)),
      child: MaterialApp.router(
        title: 'Go_router Complex Demo',
        theme: ThemeData(
          primarySwatch: Colors.orange,
        ),
        routerConfig: _router,
      ),
    );
  }
}

class BottomNavBar extends StatefulWidget {
  final StatefulNavigationShell navigationShell;
  BottomNavBar(this.navigationShell, {super.key});

  @override
  _BottomNavBarState createState() => _BottomNavBarState();

}

class _BottomNavBarState extends State<BottomNavBar> {
  // late final EventDatabase database;
  // Future<void> getDatabase() async {
  //   database = await $FloorEventDatabase.databaseBuilder('event_db').build();
  // }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // getDatabase();
  }

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
        // ChangeNotifierProvider(
        //   create: (context) => EventsViewModel(FloorEventsRepository(widget.database)),
        // ),
      ],
      child: Scaffold(
        body: widget.navigationShell,
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
          currentIndex: widget.navigationShell.currentIndex,

          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(icon: Icon(Icons.emoji_emotions), label: 'Emotion Tracker'),
            BottomNavigationBarItem(icon: Icon(Icons.fastfood), label: 'Diet Tracker'),
            BottomNavigationBarItem(icon: Icon(Icons.run_circle), label: 'Workout Tracker'),
            // BottomNavigationBarItem(icon: Icon(Icons.list), label: 'List'),
          ],
          onTap: (int tappedIndex) {
            widget.navigationShell.goBranch(tappedIndex);
          },
        ),
      ),
    );
  }
}