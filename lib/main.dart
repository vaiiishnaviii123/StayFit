import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stay_fit/providers/app_alternative.dart';
import 'package:stay_fit/providers/events_view_model.dart';
import 'package:stay_fit/repository/floor_events_repository.dart';
import 'package:stay_fit/databse/event_db.dart';
import 'package:stay_fit/providers/reward_points.dart';
import 'package:stay_fit/repository/floor_rewards_repository.dart';
import 'models/navigation.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  EventDatabase database = await $FloorEventDatabase.databaseBuilder('tracker.db').build();
  runApp(MyApp(database));
}

class MyApp extends StatelessWidget {
  EventDatabase database;
  MyApp(this.database, {super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
        create: (context) => EventsViewModel(FloorEventsRepository(database)),
        ),
        ChangeNotifierProvider(
        create: (context) => RewardPoints(FloorRewardsRepository(database)),
        ),
        ChangeNotifierProvider(
          create: (context) => AppAlternative(),
        ),
    ],
      child: MaterialApp.router(
        localizationsDelegates: [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: [
          Locale('en'), // English
          Locale('es'), // Spanish
        ],
      locale: const Locale('en'),
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
        routerConfig: RouterNavigation.getRouter(),
        // localizationsDelegates: AppLocalizations.localizationsDelegates,
        // supportedLocales: AppLocalizations.supportedLocales,
    ),
    );
  }
}
