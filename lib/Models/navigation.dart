import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import '../view/bottom_material_navbar.dart';
import '../view/emotions/emoji_recorder_page.dart';
import '../view/diet/diet_recorder_page.dart';
import '../view/workout/workout_recorder_page.dart';

class RouterNavigation{

   static final GoRouter _router = GoRouter(
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
        ],
      ),
    ],
  );

   static GoRouter getRouter(){
     return _router;
   }

}