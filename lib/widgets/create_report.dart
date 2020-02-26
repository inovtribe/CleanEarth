import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

// import 'package:provider/provider.dart';
// import 'package:sliding_up_panel/sliding_up_panel.dart';
// import 'package:timwan/providers/main_event_details.dart';
// import 'package:timwan/widgets/create_event_details.dart';
// import 'package:timwan/screens/home_screen.dart';
// import 'package:timwan/main.dart';
enum SingingCharacter { lafayette, jefferson }

class CreateReportState extends StatefulWidget {
  @override
  _CreateReport createState() => _CreateReport();
}

class _CreateReport extends State<CreateReportState> {
  @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //       appBar: AppBar(
  //         title: Text("Create Report"),
  //       ),
  //       body: Container(
  //           child: Column(
  //         mainAxisAlignment: MainAxisAlignment.spaceAround,
  //         children: <Widget>[
  //           Text("No image is selected"),
  //         ],
  //       )));
  // }
  File _image;
  int selectedRadio;

  //making radio buttons unselected at initial state
  @override
  void initState() {
    super.initState();
    selectedRadio = 0;
  }

  setSelectedRadio(int val) {
    setState(() {
      selectedRadio = val;
    });
  }

  Future getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.camera);

    setState(() {
      _image = image;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Create report'),
        ),
        body: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
          Container(
            height: 320,
            width: 180,
            padding: const EdgeInsets.all(8.0),
            child: _image == null
                ? Text('No image selected.')
                : Image.file(_image),
          ),

          Text("Number of volunteers required to clean the area:- "),
          // RadioListTile(
          //   value: 1,
          //   groupValue: 1,
          //   title: Text("1-4"),
          //   onChanged: (val) {
          //     print("radio tile pressed $val");
          //   },
          //   activeColor: Colors.red,
          // ),
          Divider(
            height: 20,
            color: Colors.green,
          ),
          ButtonBar(
            alignment: MainAxisAlignment.center,
            children: <Widget>[
              Radio(
                value: 1,
                groupValue: selectedRadio,
                activeColor: Colors.green,
                onChanged: (val) {
                  setSelectedRadio(val);
                },
              ),
              Radio(
                value: 2,
                groupValue: selectedRadio,
                activeColor: Colors.green,
                onChanged: (val) {
                  setSelectedRadio(val);
                },
              ),
            ],
          )

          //
        ]),
        floatingActionButton: FloatingActionButton(
          onPressed: getImage,
          tooltip: 'Pick Image',
          child: Icon(Icons.add_a_photo),
        ),
      ),
    );
  }
}
