import 'package:flutter/material.dart';
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
            // minHeight: 75.0,
            // maxHeight: 300.0,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(24.0),
                topRight: Radius.circular(24.0)),
            collapsed: Center(
              child: Text("Swipe up when done!"),
            ),
            panel: Column(
              children: <Widget>[
                Container(
                  height: 100.0,
                  child: createReportDetails.image == null
                      ? Icon(
                          Icons.error,
                          size: 90.0,
                        )
                      : Image.file(
                          createReportDetails.image,
                          fit: BoxFit.scaleDown,
                        ),
                ),
              ],
            )),
      ]),
    );
  }
}
