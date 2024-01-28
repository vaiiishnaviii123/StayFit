import 'package:flutter/material.dart';

import '../event.dart';

class DietManager extends StatefulWidget {
  final void Function(Event event) addDietEvent;
  const DietManager(this.addDietEvent, {super.key});

  @override
  _DietManagerState createState() {
    return _DietManagerState();
  }
}

class _DietManagerState extends State<DietManager> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController myQuantityController = TextEditingController();
  final TextEditingController myDietController = TextEditingController();

  void _onSavePressed(){
    if(myDietController == null){
      print('Please enter a valid Dish');
    }else if(myQuantityController == null){
      print('Please enter the quantity.');
    }else{
      print("Your Dish has been recorded!");
      String str = 'Dish: '+ myDietController.text + ',  Quantity: ' + myQuantityController.text;
      Event event = Event(
          str,
          DateTime.now()
      );
      widget.addDietEvent(event);
    }
  }


  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Diet Record.", style: TextStyle(color: Colors.black54, fontSize: 35)),
          TextFormField(
            controller: myDietController,
            decoration: InputDecoration(
              labelText: 'Enter the dish.',
            ),
            // The validator receives the text that the user has entered.
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter a valid positive quan ';
              }
              return null;
            },
          ),
          TextFormField(
            keyboardType: TextInputType.numberWithOptions(decimal: true, signed: true),
            controller: myQuantityController,
            decoration: InputDecoration(
              labelText: 'Quantity in Grams.',
            ),
            // The validator receives the text that the user has entered.
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter a valid positive number';
              }
              return null;
            },
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
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
    );
  }
}