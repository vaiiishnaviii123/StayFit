import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:stay_fit/diet_manager.dart';

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
  const WorkoutManager({super.key});

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


  var list = [
    ' You did 20 squats on ',
    ' You did 100 Jumping-Jacks on '
  ];

  void _onSavePressed(){
    if(selectedWorkout == null){
      print('Please select a workout');
    }else if(myQuantityController == null){
      print('Please enter the number of Reps.');
    }else{
      print("Your selected workout is recorded!");
      print('Workout Type: '+ selectedWorkout.label + ',  Reps: ' + myQuantityController.text);
    }
  }

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return Form(
      key: _formKey,
      child: Scaffold(
        backgroundColor: Color.fromRGBO(191, 186, 188, 1),
        resizeToAvoidBottomInset : false,
        body: SingleChildScrollView(
          child: Column(
        children: [
          const Text("Let's Workout!", style: TextStyle(color: Colors.black54, fontSize: 35, fontFamily: 'Calistoga')),
          DropdownMenu<WorkoutLabel>(
            initialSelection: WorkoutLabel.plank,
            controller: myWorkoutController,
            // requestFocusOnTap is enabled/disabled by platforms when it is null.
            // On mobile platforms, this is false by default. Setting this to true will
            // trigger focus request on the text field and virtual keyboard will appear
            // afterward. On desktop platforms however, this defaults to true.
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
        Container(
          child:
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 1, vertical: 10),
          child: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: 5),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: List.generate(
                  list.length, (index) => ItemWidget(text: list.elementAt(index), date: DateTime.now())),
            ),
            ),
          ),
        )
        ),
        ],
        ),
      ),
      ),
    );
  }
}

class ItemWidget extends StatelessWidget {
  const ItemWidget({
    super.key,
    required this.text,
    required this.date,
  });

  final String text;
  final DateTime date;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Color.fromRGBO(173, 167, 153, 5),
      child: SizedBox(
        height: 60,
        child: Center(child: Text('  $text on ${date.day}-${date.month}-${date.year} at ${date.hour}-${date.minute}-${date.second}.')),
      ),
    );
  }
}