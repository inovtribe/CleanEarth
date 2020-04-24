import 'package:flutter/material.dart';
import 'package:flutter_tagging/flutter_tagging.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:provider/provider.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:timwan/providers/create_report_details.dart';
import 'package:timwan/providers/main_event_details.dart';

class CreateReportStart extends StatelessWidget {
  void getImage(
      CreateReportDetails createReportDetails, ImageSource source) async {
    File image = await ImagePicker.pickImage(source: source);
    createReportDetails.updateImage(image);
  }

  @override
  Widget build(BuildContext context) {
    final mainAppDetails = Provider.of<MainAppDetails>(context);
    final createReportDetails = Provider.of<CreateReportDetails>(context);
    return SafeArea(
      child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
        Container(
          color: Colors.white,
          child: Row(
            children: <Widget>[
              IconButton(
                tooltip: 'Back',
                icon: Icon(Icons.arrow_back),
                onPressed: () {
                  mainAppDetails.clearPoints();
                  mainAppDetails.appState = MainAppState.StartState;
                  createReportDetails.updateImage(null);
                },
              ),
              Text("Create Report"),
              Expanded(
                child: Container(),
              ),
              IconButton(
                tooltip: 'Choose Image from Gallery',
                icon: Icon(Icons.photo_library),
                onPressed: () =>
                    getImage(createReportDetails, ImageSource.gallery),
              ),
              IconButton(
                tooltip: 'Take a Picture',
                onPressed: () =>
                    getImage(createReportDetails, ImageSource.camera),
                icon: Icon(Icons.add_a_photo),
              )
            ],
          ),
        ),
        Expanded(
          child: Container(),
        ),
        SlidingUpPanel(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(24.0),
                topRight: Radius.circular(24.0)),
            collapsed: Center(
              child: Text("Swipe up when done!"),
            ),
            panel: Container(
              margin: EdgeInsets.only(top: 50.0),
              padding: EdgeInsets.all(25.0),
              child: Column(
                children: <Widget>[
                  Container(
                    child: Text(
                      "Submit Report",
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                  FlutterTagging<TrashTag>(
                    initialItems: createReportDetails.tags,
                    textFieldConfiguration: TextFieldConfiguration(
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        filled: true,
                        labelText: 'Select Tags',
                        hintText: 'Search Tags',
                      ),
                    ),
                    additionCallback: (value) =>
                        TrashTag(name: value, position: 0),
                    configureChip: (tag) {
                      return ChipConfiguration(
                        label: Text('#${tag.name}'),
                        backgroundColor: Colors.green,
                        labelStyle: TextStyle(color: Colors.white),
                        deleteIconColor: Colors.white,
                      );
                    },
                    configureSuggestion: (tag) {
                      return SuggestionConfiguration(
                        title: Text(tag.name),
                        additionWidget: Chip(
                          avatar: Icon(
                            Icons.add_circle,
                            color: Colors.white,
                          ),
                          label: Text('Add New Tag'),
                          labelStyle: TextStyle(
                            color: Colors.white,
                            fontSize: 14.0,
                            fontWeight: FontWeight.w300,
                          ),
                          backgroundColor: Colors.green,
                        ),
                      );
                    },
                    findSuggestions: (query) {
                      return [
                        TrashTag(name: 'Paper', position: 1),
                        TrashTag(name: 'Plastic', position: 2),
                        TrashTag(name: 'Hazardous', position: 3),
                        TrashTag(name: 'Recyclable', position: 4),
                        TrashTag(name: 'Decomposable', position: 5)
                      ]
                          .where((tag) => tag.name
                              .toLowerCase()
                              .contains(query.toLowerCase()))
                          .toList();
                    },
                  ),
                  Container(
                    height: 200.0,
                    child: createReportDetails.image == null
                        ? Column(
                            children: <Widget>[
                              Icon(
                                Icons.error,
                                size: 90.0,
                              ),
                              Text('Choose a image')
                            ],
                          )
                        : Image.file(
                            createReportDetails.image,
                            fit: BoxFit.scaleDown,
                          ),
                  ),
                  RaisedButton(
                    child: Text('Submit'),
                    color: Colors.blueAccent,
                    onPressed: () => createReportDetails.submitReport(),
                  ),
                ],
              ),
            )),
      ]),
    );
  }
}

class TrashTag extends Taggable {
  final String name;
  final int position;

  /// Creates TrashTag
  TrashTag({this.name, this.position});

  @override
  List<Object> get props => [name];

  /// Converts the class to json string.
  String toJson() => '''  {
    "name": $name,\n
    "position": $position\n
  }''';

  String toString() => '[Trashtag]: {name: $name}';
}
