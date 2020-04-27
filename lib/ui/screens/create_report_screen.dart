import 'package:flutter/material.dart';
import 'package:flutter_tagging/flutter_tagging.dart';
import 'package:stacked/stacked.dart';
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
          body: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Container(
                child: Text(
                  "Submit Report",
                  style: TextStyle(fontSize: 20),
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
                additionCallback: (value) => TrashTag(name: value, position: 0),
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
            ],
          ),
        );
      },
    );
  }
}
