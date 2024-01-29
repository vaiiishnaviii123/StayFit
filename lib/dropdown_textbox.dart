import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:flutter/material.dart';

class DropdownTextBox extends StatefulWidget {
   const DropdownTextBox({super.key});

  @override
  _DropdownTextBoxState createState() {
    return _DropdownTextBoxState();
  }
}

class _DropdownTextBoxState extends State<DropdownTextBox> {
  final TextEditingController _controller = new TextEditingController();
  late bool _enabled;
  List<String> country = [
  ];

  @override
  void initState() {
    _enabled = false;
    super.initState();
  }

  void _onSavePressed(){
    country.add(_controller.text);
    setState(() => _enabled = true);
    //_controller.clear();
    print(country);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(title: const Text('Drop List Example')),
      body: Center(
        child:  Container(
          child:  Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(24.0),
                child:  Row(
                  children: <Widget>[
                    Expanded(
                        child: TextField(controller: _controller)
                    ),
                     if(this._enabled)PopupMenuButton<String>(
                      icon: const Icon(Icons.arrow_drop_down),
                      onSelected: (String value) {
                        _controller.text = value;
                      },
                      itemBuilder: (BuildContext context) {
                        return country.map<PopupMenuItem<String>>((String value) {
                          return  PopupMenuItem(value: value, child:  Text(value));
                        }).toList();
                      },
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 120),
                child: ElevatedButton(
                  onPressed: () {
                      _onSavePressed();
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
