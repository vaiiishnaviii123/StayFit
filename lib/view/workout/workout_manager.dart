import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:stay_fit/models/event.dart';
import 'package:stay_fit/models/reward.dart';
import '../../providers/app_alternative.dart';
import '../../providers/events_view_model.dart';
import '../../providers/reward_points.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
const double _kItemExtent = 32.0;
const List<String> _workoutListNames = <String>[
  'Push-ups',
  'Plank',
  'Squats',
  'Lunges',
  'Skipping',
  'Running',
  'High knees',
  'Jumping Jacks'
];

const List<String> _workoutListNamesSpanish = <String>[
  'Hacer subir',
  'Tablón',
  'sentadillas',
  'Estocadas',
  'Salto a la comba',
  'correr',
  'Rodillas altas',
  'Saltos de tijera'
];

enum WorkoutLabel {
  pushups('Push-ups'),
  plank('Plank'),
  squats('Squats'),
  lunges('Lunges'),
  skipping('Skipping'),
  running('Running'),
  highknees('High knees'),
  jumpingjacks('Jumping Jacks');

  const WorkoutLabel(this.label);
  final String label;
}

enum WorkoutLabelSpanish {
  pushups('Hacer subir'),
  plank('Tablón'),
  squats('sentadillas'),
  lunges('Estocadas'),
  skipping('Salto a la comba'),
  running('correr'),
  highknees('Rodillas altas'),
  jumpingjacks('Saltos de tijera');

  const WorkoutLabelSpanish(this.label);
  final String label;
}

class WorkoutManager extends StatefulWidget {
  WorkoutManager({super.key});

  @override
  _WorkoutManagerState createState() {
    return _WorkoutManagerState();
  }
}

class _WorkoutManagerState extends State<WorkoutManager> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController myQuantityController = TextEditingController();
  final TextEditingController myWorkoutController = TextEditingController();
  var selectedWorkout = WorkoutLabel.plank;
  var selectedWorkoutSpanish = WorkoutLabelSpanish.plank;
  int _selectedWorkout = 0;
  late Reward? reward;
  late bool isCupertino;

  Future<void> getLastRecord() async {
    reward = (await context.read<RewardPoints>().getLastRecord());
  }

  @override
  void initState() {
    isCupertino = context.read<AppAlternative>().getAppAlternative();
    getLastRecord();
    super.initState();
  }

  Future<void> _onSavePressed(Future<Reward?> rewardPoints) async {
    if(selectedWorkout == null){
      print('Please select a workout');
    }else if(myQuantityController == null){
      print('Please enter the number of Reps.');
    }else{
      print("Your selected workout is recorded!");
      Event event = Event(
        null,
        myWorkoutController.text,
          DateTime.now(),
          'WORKOUT',
           double.parse(myQuantityController.text),
      );
      getLastRecord();
      var points = await rewardPoints;
      print(points?.rewardPoints);

      if(points == null){
        Reward rp = new Reward(0, 0, "Workout", DateTime.now(), 100.0);
        context.read<RewardPoints>().calcDedicationAndPoints(rp);
      }else{
        points?.event = 'Workout';
        context.read<RewardPoints>().calcDedicationAndPoints(points!);
      }
      context.read<EventsViewModel>().addEvent(event);
      _formKey.currentState!.reset();
      myQuantityController.clear();
    }
  }

  void _showDialog(Widget child) {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => Container(
        height: 216,
        padding: const EdgeInsets.only(top: 6.0),
        // The Bottom margin is provided to align the popup above the system navigation bar.
        margin: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        // Provide a background color for the popup.
        color: CupertinoColors.systemBackground.resolveFrom(context),
        // Use a SafeArea widget to avoid system overlaps.
        child: SafeArea(
          top: false,
          child: child,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Locale appLocale = Localizations.localeOf(context);
    bool isEnglish(){
      return appLocale.toString() == 'en' ? true : false;
    }
    print(appLocale);
    isCupertino = context.watch<AppAlternative>().getAppAlternative();
    var rps = (context.watch<RewardPoints>().getLastRecord());
    // Build a Form widget using the _formKey created above.
    return Form(
      key: _formKey,
      child: SafeArea(
        child: SingleChildScrollView(
        // backgroundColor: Color.fromRGBO(191, 186, 188, 1),
        // resizeToAvoidBottomInset : false,
          child: Column(
        children: [
           Text("${AppLocalizations.of(context)!.workoutRecord}!", style: TextStyle(color: Colors.black54, fontSize: 28, fontFamily: 'Calistoga')),
          const SizedBox(height: 10),
          isCupertino? DefaultTextStyle(
           style: TextStyle(
             color: CupertinoColors.label.resolveFrom(context),
             fontSize: 22.0,
           ),
           child: Center(
             child: Row(
               mainAxisAlignment: MainAxisAlignment.center,
               children: <Widget>[
                 Text('${AppLocalizations.of(context)!.selectWorkout}: ', style: TextStyle(color: CupertinoColors.secondaryLabel),),
                 CupertinoButton(
                   padding: EdgeInsets.zero,
                   // Display a CupertinoPicker with list of fruits.
                   onPressed: () => _showDialog(
                     CupertinoPicker(
                       magnification: 1.22,
                       squeeze: 1.2,
                       useMagnifier: true,
                       itemExtent: _kItemExtent,
                       // This sets the initial item.
                       scrollController: FixedExtentScrollController(
                         initialItem: _selectedWorkout,
                       ),
                       // This is called when selected item is changed.
                       onSelectedItemChanged: (int selectedItem) {
                         myWorkoutController.text = isEnglish() ? WorkoutLabel.values.elementAt(selectedItem).label : WorkoutLabelSpanish.values.elementAt(selectedItem).label;
                         setState(() {
                           _selectedWorkout = selectedItem;
                         });
                       },
                       children: isEnglish() ?
                       List<Widget>.generate(WorkoutLabel.values.length, (int index) {
                         return Center(child: Text(WorkoutLabel.values.elementAt(index).label));
                       }) : List<Widget>.generate(WorkoutLabelSpanish.values.length, (int index) {
                         return Center(child: Text(WorkoutLabelSpanish.values.elementAt(index).label));
                       }),
                     ),
                   ),
                   // This displays the selected fruit name.
                   child: isEnglish() ? Text(
                     WorkoutLabel.values.elementAt(_selectedWorkout).label,
                     style: const TextStyle(
                       fontSize: 22.0,
                     ),
                   ): Text(
                     WorkoutLabelSpanish.values.elementAt(_selectedWorkout).label,
                     style: const TextStyle(
                       fontSize: 22.0,
                     ),
                   ),
                 ),
               ],
             ),
           ),
         )
         :isEnglish() ?DropdownMenu<WorkoutLabel>(
            key: Key("Workout"),
            initialSelection: WorkoutLabel.plank,
            controller: myWorkoutController,
            //requestFocusOnTap: true,
            label: Text(AppLocalizations.of(context)!.selectWorkout),
            onSelected: (WorkoutLabel? workout) {
              selectedWorkout = workout!;
              _selectedWorkout = workout.index;
              myWorkoutController.text = workout!.label;
            },
            dropdownMenuEntries: WorkoutLabel.values
                .map<DropdownMenuEntry<WorkoutLabel>>(
                    (WorkoutLabel workout) {
                  return DropdownMenuEntry<WorkoutLabel>(
                    value: workout,
                    label: workout.label,
                  );
                }).toList(),
          ): DropdownMenu<WorkoutLabelSpanish>(
            key: Key("Workout"),
            initialSelection: WorkoutLabelSpanish.plank,
            controller: myWorkoutController,
            //requestFocusOnTap: true,
            label: Text(AppLocalizations.of(context)!.selectWorkout),
            onSelected: (WorkoutLabelSpanish? workoutS) {
              selectedWorkoutSpanish = workoutS!;
              _selectedWorkout = workoutS.index;
              myWorkoutController.text = workoutS!.label;
            },
            dropdownMenuEntries: WorkoutLabelSpanish.values
                .map<DropdownMenuEntry<WorkoutLabelSpanish>>(
                    (WorkoutLabelSpanish workoutS) {
                  return DropdownMenuEntry<WorkoutLabelSpanish>(
                    value: workoutS,
                    label: workoutS.label,
                  );
                }).toList(),
          ),
          isCupertino ? CupertinoTextFormFieldRow(
            prefix: Text(AppLocalizations.of(context)!.enterReps, style: TextStyle(color: CupertinoColors.secondaryLabel),),
            keyboardType: TextInputType.numberWithOptions(decimal: false),
            controller: myQuantityController,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly
            ],
            decoration: BoxDecoration(border: Border.all(color: CupertinoColors.inactiveGray)),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return AppLocalizations.of(context)!.validDishName;
              }
              return null;
            },
          )
          : TextFormField(
            key: Key("Reps"),
            keyboardType: TextInputType.numberWithOptions(decimal: false),
            controller: myQuantityController,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly
            ],
            decoration: InputDecoration(
              labelText: '${AppLocalizations.of(context)!.enterReps}',
            ),
            // The validator receives the text that the user has entered.
            validator: (value) {
              if (value == null || value.isEmpty) {
                return AppLocalizations.of(context)!.validDishName;
              }
              return null;
            },
          ),
          SizedBox(height: 10),
          Center(
            child: isCupertino ? CupertinoButton(
              color: CupertinoColors.systemIndigo,
              child: Text(AppLocalizations.of(context)!.save, style: TextStyle(color: CupertinoColors.white),),
              onPressed: () {
                // Validate returns true if the form is valid, or false otherwise.
                if (_formKey.currentState!.validate()) {
                  _onSavePressed(rps);
                }
                FocusScope.of(context).unfocus();
              },
            )
            : ElevatedButton(
              key: Key("SubmitWorkout"),
              onPressed: () {
                // Validate returns true if the form is valid, or false otherwise.
                if (_formKey.currentState!.validate()) {
                  _onSavePressed(rps);
                }
                FocusScope.of(context).unfocus();
              },
              child: Text(AppLocalizations.of(context)!.save),
            ),
          ),
          SizedBox(height: 10),
        ],
        ),
      ),
      ),
    );
  }
}