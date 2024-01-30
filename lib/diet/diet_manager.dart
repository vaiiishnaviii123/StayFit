import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stay_fit/Models/event.dart';
import 'package:stay_fit/event_diet_list.dart';

import '../reward_points.dart';

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
  final TextEditingController _controller = new TextEditingController();
  late bool _enabled;
  var country = <String>{};

  @override
  void initState() {
    _enabled = false;
    super.initState();
  }

  void _onSavePressed(){
    country.add(myDietController.text);
    setState(() => _enabled = true);
    //_controller.clear();
    print(country);
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
      context.read<RewardPoints>().setEvent('Diet');
      context.read<RewardPoints>().setDate(DateTime.now());
      context.read<RewardPoints>().setPoints(1.0);
      context.read<DietList>().addDietToList(event);
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
          Row(
            children: <Widget>[
              Expanded(
                  child: TextFormField(
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
              ),
              if(this._enabled)PopupMenuButton<String>(
                icon: const Icon(Icons.arrow_drop_down),
                onSelected: (String value) {
                  myDietController.text = value;
                },
                itemBuilder: (BuildContext context) {
                  return country.map<PopupMenuItem<String>>((String value) {
                    return  PopupMenuItem(value: value, child:  Text(value));
                  }).toList();
                },
              ),
            ],
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