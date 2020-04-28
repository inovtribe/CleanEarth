import 'package:flutter/material.dart';
import 'package:flutter_tagging/flutter_tagging.dart';
import 'package:stacked/stacked.dart';
import 'package:timwan/ui/widgets/loading_button.dart';
import 'package:timwan/viewmodels/create_report_view_model.dart';

class CreateReportScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<CreateReportViewModel>.reactive(
      viewModelBuilder: () => CreateReportViewModel(),
      onModelReady: (model) => model.selectImageFromCamera(),
      builder: (context, model, _) {
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0.0,
            iconTheme: IconThemeData(
              color: Colors.black,
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.only(
              top: 30.0,
              left: 15,
              right: 15,
            ),
            child: ListView(
              children: <Widget>[
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  child: Text(
                    "Submit Report",
                    style: TextStyle(fontSize: 24),
                  ),
                ),
                FlutterTagging<TrashTag>(
                  initialItems: model.tags,
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
                  findSuggestions: model.findSuggestions,
                ),
                Container(
                  height: 200.0,
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  child: model.image == null
                      ? Column(
                          children: <Widget>[
                            Icon(
                              Icons.error,
                              size: 90.0,
                            ),
                            Text('Choose a image'),
                            Row(
                              children: <Widget>[
                                IconButton(
                                  onPressed: model.selectImageFromGallery,
                                  icon: Icon(Icons.photo_library),
                                ),
                                IconButton(
                                  onPressed: model.selectImageFromCamera,
                                  icon: Icon(Icons.camera_alt),
                                ),
                              ],
                            )
                          ],
                        )
                      : Image.file(
                          model.image,
                          fit: BoxFit.scaleDown,
                        ),
                ),
                Container(
                  width: 150,
                  child: LoadingButton(
                    title: "Submit",
                    isLoading: model.isLoading,
                    onPressed: model.createReport,
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
