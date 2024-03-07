import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:stay_fit/view/login/signed_in_detector.dart';
import '../view/bottom_material_navbar.dart';
import '../view/emotions/emoji_recorder_page.dart';
import '../view/diet/diet_recorder_page.dart';
import '../view/login/firebase_initializer.dart';
import '../view/login/sign_in_up_form.dart';
import '../view/login/sign_up_page.dart';
import '../view/workout/workout_recorder_page.dart';

class RouterNavigation{

   static final GoRouter _router = GoRouter(
    initialLocation: '/leaderboard',
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
          StatefulShellBranch(
            routes: <RouteBase>[
              GoRoute(
                path: '/leaderboard',
                builder: (BuildContext context, GoRouterState state) {
                  return FirebaseInitializer();
                },
              ),
            ],
          ),
        ],
      ),
      GoRoute(
        path: '/signUp',
        pageBuilder: (context, state) => NoTransitionPage(
          child: SignUpPage(),
        ),
      ),
      GoRoute(
        path: '/login',
        pageBuilder: (context, state) => NoTransitionPage(
          child: LoginRegisterForm(),
        ),
      ),
      GoRoute(
        path: '/signIn/detector',
        pageBuilder: (context, state) => NoTransitionPage(
          child: SignedInDetector(),
        ),
      ),
    ],
  );

   static GoRouter getRouter(){
     return _router;
   }

}