import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:stay_fit/models/event.dart';
import '../../models/reward.dart';
import '../../models/user_points.dart';
import '../../providers/app_alternative.dart';
import '../../providers/events_view_model.dart';
import '../../providers/leader_board_provider.dart';
import '../../providers/reward_points.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
const double _kItemExtent = 32.0;

class DietManager extends StatefulWidget {
  DietManager({super.key});

  @override
  _DietManagerState createState() {
    return _DietManagerState();
  }
}

class _DietManagerState extends State<DietManager> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController myQuantityController = TextEditingController();
  final TextEditingController myDietController = TextEditingController();
  List<String> menu = [];
  late Reward? reward;
  Set<String> menuSet = {" ",};
  late bool isCupertino;
  int _selectedWorkout = 0;
  FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> setMenuItem() async {
      menu =  await context.read<EventsViewModel>().getMenuList('DIET');
      menuSet = menu.toSet();
  }

  Future<void> setLastRecord() async {
    reward = await context.read<RewardPoints>().getLastRecord();
  }

  @override
  void initState() {
    isCupertino = context.read<AppAlternative>().getAppAlternative();
    setMenuItem();
    setLastRecord();
    super.initState();
  }

  Future<void> getMenuItems() async {
    var menuL = await context.watch<EventsViewModel>().getMenuList('DIET');
    setState(() {
      menu = menuL;
    });
    menuSet = menu.toSet();
  }

  Future<void> _onSavePressed(Future<Reward?> rewardPoints) async {
      print("Your Dish has been recorded!");
      Event event = Event(
          null,
          myDietController.text,
          DateTime.now(),
          'DIET',
          double.parse(myQuantityController.text)
      );
      var points = await rewardPoints;
      print(points?.rewardPoints);

      if(points == null){
        Reward rp = new Reward(0, 0, "Diet", DateTime.now(), 100.0);
        context.read<RewardPoints>().calcDedicationAndPoints(rp);
      }else{
        points?.event = 'Diet';
        context.read<RewardPoints>().calcDedicationAndPoints(points!);
      }
      context.read<EventsViewModel>().addEvent(event);
      if(_auth.currentUser != null){
        var pts = await context.read<RewardPoints>().getLastRecord();
        print('points');
        print(pts?.rewardPoints);
        addRewardPointsToFirebase(pts!.rewardPoints);
      }
      setMenuItem();
    _formKey.currentState!.reset();
    myDietController.clear();
    myQuantityController.clear();
  }

  addRewardPointsToFirebase(double points){
    UserRewardPoints userRewards = UserRewardPoints(
        rewardPoints: points,
        emailId: _auth.currentUser!.email
    );
    context.read<LeaderBoardProvider>().addUserPoints(userRewards);
  }

  void _showDialog() {
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
          child: showDialogContent(),
        ),
      ),
    );
  }

  showDialogContent(){
    return  CupertinoPicker(
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
        setState(() {
          _selectedWorkout = selectedItem;
          myDietController.text = menuSet.elementAt(_selectedWorkout);
        });
      },
      children: List<Widget>.generate(menuSet.length, (int index) {
        return Center(child: Text(menuSet.elementAt(index)));
      }),
    );
  }
  @override
  Widget build(BuildContext context) {
    isCupertino = context.watch<AppAlternative>().getAppAlternative();
    var rps = (context.watch<RewardPoints>().getLastRecord());
    getMenuItems();
    // Build a Form widget using the _formKey created above.
    return Form(
      key: _formKey,
        child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(child: Text("${AppLocalizations.of(context)!.dietRecord}.", style: TextStyle(color: Colors.black54, fontSize: 35))),
          Row(
            children: <Widget>[
              Expanded(
                  child: isCupertino? CupertinoTextFormFieldRow(
                    key: Key("DietText"),
                    prefix: Text(AppLocalizations.of(context)!.dishName, style: TextStyle(color: CupertinoColors.secondaryLabel),),
                    controller: myDietController,
                    decoration: BoxDecoration(border: Border.all(color: CupertinoColors.inactiveGray)),
                    // The validator receives the text that the user has entered.
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return AppLocalizations.of(context)!.validDishName;
                      }
                      return null;
                    },
                  ): TextFormField(
                    key: Key("DietText"),
                    controller: myDietController,
                    decoration: InputDecoration(
                      labelText: '${AppLocalizations.of(context)!.dishName}.',
                    ),
                    // The validator receives the text that the user has entered.
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return AppLocalizations.of(context)!.validDishName;
                      }
                      return null;
                    },
                  ),
              ),
              if(menu.isNotEmpty && !isCupertino) PopupMenuButton<String>(
                key: Key("DietMenuButton"),
                icon: const Icon(Icons.arrow_drop_down),
                onSelected: (String value) {
                  myDietController.text = value;
                },
                itemBuilder: (BuildContext context) {
                  return  menuSet.map<PopupMenuItem<String>>((String value) {
                    return  PopupMenuItem(value: value, child:  Text(value));
                  }).toList();
                },
              ),
              if(menu.isNotEmpty && isCupertino) DefaultTextStyle(
                style: TextStyle(
                  color: CupertinoColors.label.resolveFrom(context),
                  fontSize: 22.0,
                ),
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      CupertinoButton(
                        padding: EdgeInsets.zero,
                        // Display a CupertinoPicker with list of fruits.
                        onPressed: (){
                          myDietController.text = menuSet.elementAt(_selectedWorkout);
                          _showDialog();
                        },
                        // This displays the selected fruit name.
                        child: Icon(CupertinoIcons.arrowtriangle_down_fill),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          isCupertino? CupertinoTextFormFieldRow(
            prefix: Text(AppLocalizations.of(context)!.quantityInGrams, style: TextStyle(color: CupertinoColors.secondaryLabel),),
            keyboardType: TextInputType.numberWithOptions(decimal: true, signed: true),
            controller: myQuantityController,
            decoration: BoxDecoration(border: Border.all(color: CupertinoColors.inactiveGray)),
            // The validator receives the text that the user has entered.
            validator: (value) {
              if (value == null || value.isEmpty) {
                return AppLocalizations.of(context)!.validQuanitity;
              }
              return null;
            },
          )
          :TextFormField(
            key: Key("Quantity"),
            keyboardType: TextInputType.numberWithOptions(decimal: true, signed: true),
            controller: myQuantityController,
            decoration: InputDecoration(
              labelText: AppLocalizations.of(context)!.quantityInGrams,
            ),
            // The validator receives the text that the user has entered.
            validator: (value) {
              if (value == null || value.isEmpty) {
                return AppLocalizations.of(context)!.validQuanitity;
              }
              return null;
            },
          ),
          SizedBox(height: 10),
          Center(
            child: isCupertino? CupertinoButton(
              color: CupertinoColors.systemIndigo,
              child: Text(AppLocalizations.of(context)!.save, style: TextStyle(color: CupertinoColors.white),),
              onPressed: () {
                // Validate returns true if the form is valid, or false otherwise.
                if (_formKey.currentState!.validate()) {
                  // you'd often call a server or save the information in a database.
                  _onSavePressed(rps);
                }
                FocusScope.of(context).unfocus();
              },
            )
            :ElevatedButton(
              key: Key("DietButton"),
              onPressed: () {
                // Validate returns true if the form is valid, or false otherwise.
                if (_formKey.currentState!.validate()) {
                  // you'd often call a server or save the information in a database.
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
    );
  }
}