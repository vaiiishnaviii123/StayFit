import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stay_fit/models/event.dart';
import 'package:stay_fit/providers/diet_menu.dart';
import 'package:stay_fit/providers/event_diet_list.dart';

import '../providers/reward_points.dart';

class DietManager extends StatefulWidget {
  const DietManager({super.key});

  @override
  _DietManagerState createState() {
    return _DietManagerState();
  }
}

class _DietManagerState extends State<DietManager> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController myQuantityController = TextEditingController();
  final TextEditingController myDietController = TextEditingController();
  late bool _enabled;

  @override
  void initState() {
    if(context.read<DietMenu>().getDietMenu().isEmpty){
      _enabled = false;
    }else{
      _enabled = true;
    }
    super.initState();
  }

  void _onSavePressed(){
    context.read<DietMenu>().addDietToList(myDietController.text);
    setState(() => _enabled = true);
    if(myDietController == null){
      print('Please enter a valid Dish');
    }else if(myQuantityController == null){
      print('Please enter the quantity.');
    }else{
      print("Your Dish has been recorded!");
      String str = 'Dish: '+ myDietController.text + ', Quantity: ' + myQuantityController.text +' grams';
      Event event = Event(
          str,
          DateTime.now()
      );
      context.read<RewardPoints>().setEvent('Diet');
      context.read<RewardPoints>().calcDedicationAndPoints();
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
          Center(child: const Text("Diet Record.", style: TextStyle(color: Colors.black54, fontSize: 35))),
          Row(
            children: <Widget>[
              Expanded(
                  child: TextFormField(
                    key: Key("DietText"),
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
                key: Key("DietMenuButton"),
                icon: const Icon(Icons.arrow_drop_down),
                onSelected: (String value) {
                  myDietController.text = value;
                },
                itemBuilder: (BuildContext context) {
                  return  context.read<DietMenu>().getDietMenu().map<PopupMenuItem<String>>((String value) {
                    return  PopupMenuItem(value: value, child:  Text(value));
                  }).toList();
                },
              ),
            ],
          ),
          TextFormField(
            key: Key("Quantity"),
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
          Center(
            child: ElevatedButton(
              key: Key("DietButton"),
              onPressed: () {
                // Validate returns true if the form is valid, or false otherwise.
                if (_formKey.currentState!.validate()) {
                  // you'd often call a server or save the information in a database.
                  _onSavePressed();
                }
                FocusScope.of(context).unfocus();
              },
              child: const Text('Submit'),
            ),
          ),
        ],
      ),
    );
  }
}