import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:stay_fit/diet/diet_manager.dart';

import '../event.dart';

enum WorkoutLabel {
  pushups('Push-ups'),
  plank('Plank'),
  squats('Squats'),
  lunges('Lunges'),
  skipping('Skipping'),
  burpees('Burpees'),
  highknees('High knees'),
  jumpingjacks('Jumping Jacks');

  const WorkoutLabel(this.label);
  final String label;
}

class WorkoutManager extends StatefulWidget {
  final void Function(Event event) addWorkoutEvent;
  const WorkoutManager(this.addWorkoutEvent, {super.key});

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

  void _onSavePressed(){
    if(selectedWorkout == null){
      print('Please select a workout');
    }else if(myQuantityController == null){
      print('Please enter the number of Reps.');
    }else{
      print("Your selected workout is recorded!");
      String str = 'Workout Type: '+ selectedWorkout.label + ',  Reps: ' + myQuantityController.text;
      Event event = Event(
          str,
          DateTime.now()
      );
      widget.addWorkoutEvent(event);
    }
  }

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return Form(
      key: _formKey,
      child: SafeArea(
        child: SingleChildScrollView(
        // backgroundColor: Color.fromRGBO(191, 186, 188, 1),
        // resizeToAvoidBottomInset : false,
          child: Column(
        children: [
          const Text("Let's Workout!", style: TextStyle(color: Colors.black54, fontSize: 35, fontFamily: 'Calistoga')),
          DropdownMenu<WorkoutLabel>(
            initialSelection: WorkoutLabel.plank,
            controller: myWorkoutController,
            requestFocusOnTap: true,
            label: const Text('Select a workout'),
            onSelected: (WorkoutLabel? workout) {
              selectedWorkout = workout!;
            },
            dropdownMenuEntries: WorkoutLabel.values
                .map<DropdownMenuEntry<WorkoutLabel>>(
                    (WorkoutLabel workout) {
                  return DropdownMenuEntry<WorkoutLabel>(
                    value: workout,
                    label: workout.label,
                  );
                }).toList(),
          ),
          TextFormField(
            keyboardType: TextInputType.numberWithOptions(decimal: false),
            controller: myQuantityController,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly
            ],
            decoration: InputDecoration(
              labelText: 'Enter Reps',
            ),
            // The validator receives the text that the user has entered.
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter a valid positive non-decimal number';
              }
              return null;
            },
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 120),
            child: ElevatedButton(
              onPressed: () {
                // Validate returns true if the form is valid, or false otherwise.
                if (_formKey.currentState!.validate()) {
                  // If the form is valid, display a snackbar. In the real world,
                  // you'd often call a server or save the information in a database.
                  _onSavePressed();
                }
              },
              child: const Text('Submit'),
            ),
          ),
        ],
        ),
      ),
      ),
    );
  }
}