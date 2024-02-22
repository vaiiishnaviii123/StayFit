import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/event.dart';
import '../providers/app_alternative.dart';
import '../providers/events_view_model.dart';
import 'event_edit_form.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class EventTrackerCard extends StatefulWidget {
  Event _event;
  String type;

  EventTrackerCard(this._event, this.type, {super.key});

  @override
  _EventTrackerCardState createState() => _EventTrackerCardState();
}

class _EventTrackerCardState extends State<EventTrackerCard> {
  late bool enabled;
  late bool isCupertino;

  @override
  void initState() {
    isCupertino = context.read<AppAlternative>().getAppAlternative();
    if (widget.type == 'DIET') {
      enabled = true;
    } else {
      enabled = false;
    }
    super.initState();
  }

  void deleteEvent(Event event) {
    print('delete pressed');
    context.read<EventsViewModel>().deleteEvent(event);
  }

  void updateItem(Event event) {
    print('edit pressed');
    print(event.eventType);
  }

  @override
  Widget build(BuildContext context) {
    isCupertino = context.watch<AppAlternative>().getAppAlternative();
    String str = '';
    if (widget._event.eventType == 'WORKOUT') {
      str = '${AppLocalizations.of(context)!.workoutType}: ' +
          widget._event.iformation +
          ',  ${AppLocalizations.of(context)!.reps}: ' +
          widget._event.amount.toString();
    } else if (widget._event.eventType == 'DIET') {
      str = '${AppLocalizations.of(context)!.dish}: ' +
          widget._event.iformation +
          ', ${AppLocalizations.of(context)!.quanitity}: ' +
          widget._event.amount.toString() +
          ' ${AppLocalizations.of(context)!.grams}';
    } else {
      str = widget._event.iformation;
    }
    return Card(
      color: Color.fromRGBO(173, 167, 153, 5),
      child: SizedBox(
          key: Key("card"),
          height: 60,
          child: isCupertino
              ? Center(child: CupertinoListTile(
                  leadingToTitle: 0,
                  title: Text('$str ', style: TextStyle(fontSize: 12)),
                  subtitle: Wrap(children: [Text(
                    '${AppLocalizations.of(context)!.date}: ${widget._event.occurredOn}',
                    style: TextStyle(color: CupertinoColors.black, fontSize: 12),
                  )]),
                  trailing: Row(children: [
                    CupertinoButton(
                      child: Icon(
                        CupertinoIcons.delete_solid,
                        color: CupertinoColors.black,
                      ),
                      onPressed: () {
                        print('delete pressed');
                        deleteEvent(widget._event);
                      },
                    ),
                    if(enabled)CupertinoButton(
                            child: Icon(
                              CupertinoIcons.pen,
                              color: CupertinoColors.black,
                            ),
                            onPressed: () {
                              showCupertinoModalPopup<void>(
                                context: context,
                                builder: (context) {
                                  return QuantityChangeForm(widget._event);
                                },
                              );
                            },
                          )
                  ])))
              : ListTile(
                  leading: enabled
                      ? IconButton(
                          icon: Icon(Icons.edit),
                          onPressed: () {
                            showModalBottomSheet(
                              context: context,
                              builder: (context) {
                                return QuantityChangeForm(widget._event);
                              },
                            );
                          },
                        )
                      : null,
                  title: Text(
                    '$str ${AppLocalizations.of(context)!.on} ${widget._event.occurredOn}',
                    style: TextStyle(fontSize: 12),
                  ),
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      print('delete pressed');
                      deleteEvent(widget._event);
                    },
                  ),
                )),
    );
  }
}
