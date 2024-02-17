import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stay_fit/providers/events_view_model.dart';

import 'models/event.dart';


class BankBalanceForm extends StatefulWidget {
  Event event;
  BankBalanceForm(this.event, {super.key});

  @override
  createState() => _BankBalanceFormState();
}

class _BankBalanceFormState extends State<BankBalanceForm> {
  final TextEditingController _balanceController = TextEditingController();

  @override
  initState() {
    super.initState();
    print('initializing bank balance form');
    _balanceController.text = '${widget.event.amount}';
  }

  _onSave() {
    double newBalance = double.parse(_balanceController.text);
    print('updating bank balance to $newBalance');
    widget.event.amount = newBalance;
    context.read<EventsViewModel>().updateDietEvent(widget.event);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Color.fromRGBO(191, 186, 188, 1),
        child: Column(
        children: [
          TextField(
            controller: _balanceController,
            keyboardType: TextInputType.number,
          ),
          ElevatedButton(
            onPressed: (){
              _onSave();
              Navigator.pop(context);
            },
            child: const Text('Save'),
          )
        ]
        ),
    );
  }
}
