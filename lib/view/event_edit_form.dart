import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stay_fit/providers/events_view_model.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../models/event.dart';
import '../providers/app_alternative.dart';


class QuantityChangeForm extends StatefulWidget {
  Event event;
  QuantityChangeForm(this.event, {super.key});

  @override
  createState() => _QuantityChangeFormState();
}

class _QuantityChangeFormState extends State<QuantityChangeForm> {
  final TextEditingController _quantityController = TextEditingController();
  late bool isCupertino;

  @override
  initState() {
    isCupertino = context.read<AppAlternative>().getAppAlternative();
    _quantityController.text = '${widget.event.amount}';
    super.initState();
  }

  _onSave() {
    double newQuantity = double.parse(_quantityController.text);
    widget.event.amount = newQuantity;
    context.read<EventsViewModel>().updateDietEvent(widget.event);
  }

  @override
  Widget build(BuildContext context) {
    isCupertino = context.watch<AppAlternative>().getAppAlternative();
    return isCupertino? Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Container(
      //height: 600 * 0.8,
      color: Color.fromRGBO(191, 186, 188, 1),
      child: Expanded(
        child: SingleChildScrollView(
          child: CupertinoActionSheet(
            title: Text(AppLocalizations.of(context)!.quanitity),
            actions: <CupertinoActionSheetAction>[
              CupertinoActionSheetAction(
                isDefaultAction: true,
                onPressed: () {
                  Navigator.pop(context);
                },
                child: CupertinoTextField(
                  controller: _quantityController,
                  keyboardType: TextInputType.number,
                ),
              ),
              CupertinoActionSheetAction(
                isDefaultAction: false,
                onPressed: () {
                  _onSave();
                  Navigator.pop(context);
                },
                child: Text(AppLocalizations.of(context)!.save),
              ),
              CupertinoActionSheetAction(
                isDefaultAction: false,
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(AppLocalizations.of(context)!.cancel),
              ),
            ],
          ),
        ),
      ),
    )
    )
    :Container(
        color: Color.fromRGBO(191, 186, 188, 1),
        child: Column(
        children: [
          Text(AppLocalizations.of(context)!.quanitity),
          TextField(
            controller: _quantityController,
            keyboardType: TextInputType.number,
          ),
          ElevatedButton(
            onPressed: (){
              _onSave();
              Navigator.pop(context);
            },
            child: Text(AppLocalizations.of(context)!.save),
          )
        ]
        ),
    );
  }
}
