import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

class CreateEventDetails extends StatelessWidget {
  final ScrollController scrollController;

  const CreateEventDetails({Key key, this.scrollController}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 60.0),
      padding: EdgeInsets.all(25.0),
      child: SingleChildScrollView(
        controller: scrollController,
        child: Column(
          children: <Widget>[
            TextField(
              decoration: InputDecoration(
                  border: OutlineInputBorder(), labelText: 'Event Name'),
            ),
            SizedBox(height: 10),
            FlatButton(
              onPressed: () {
                DatePicker.showDateTimePicker(context,
                    currentTime: DateTime.now(),
                    minTime: DateTime.now(),
                    onConfirm: (date) => print('confirm $date'));
              },
              child: Text('Pick event date & time'),
            ),
            RaisedButton(
              child: Text('Create Event'),
              color: Colors.blueAccent,
              onPressed: () => print('create event request'),
            )
          ],
        ),
      ),
    );
  }
}
