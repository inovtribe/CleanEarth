import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:provider/provider.dart';
import 'package:timwan/ui/widgets/loading_button.dart';
import 'package:timwan/viewmodels/create_event_view_model.dart';

class CreateEventScreen extends StatelessWidget {
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();

  // TODO: make new widget to select radius
  final radiusController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Consumer<CreateEventViewModel>(
      builder: (context, model, child) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0.0,
          ),
          backgroundColor: Colors.white,
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: ListView(
              children: <Widget>[
                Text(
                  'Create Event',
                  style: TextStyle(fontSize: 24),
                ),
                TextField(
                  decoration: InputDecoration(
                    labelText: "Title",
                  ),
                  controller: titleController,
                ),
                TextField(
                  decoration: InputDecoration(
                    labelText: "Description",
                  ),
                  controller: descriptionController,
                ),
                TextField(
                  decoration: InputDecoration(
                    labelText: "Radius",
                  ),
                  controller: radiusController,
                  keyboardType: TextInputType.number,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Text('Start Time: '),
                    FlatButton(
                      onPressed: () {
                        DatePicker.showDateTimePicker(context,
                            currentTime: DateTime.now(),
                            minTime: DateTime.now(),
                            onConfirm: (date) => model.setTime(true, date));
                      },
                      child: Text(model.startTime.toString()),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Text('End Time: '),
                    FlatButton(
                      onPressed: () {
                        DatePicker.showDateTimePicker(context,
                            currentTime: DateTime.now(),
                            minTime: model.startTime,
                            onConfirm: (date) => model.setTime(false, date));
                      },
                      child: Text(model.endTime.toString()),
                    ),
                  ],
                ),
                Divider(
                  height: 24,
                ),
                LoadingButton(
                  title: "Submit",
                  isLoading: model.isLoading,
                  onPressed: () async {
                    model.createEvent(
                      title: titleController.text,
                      description: descriptionController.text,
                      radius: int.tryParse(radiusController.text) ?? 3,
                    );
                  },
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
