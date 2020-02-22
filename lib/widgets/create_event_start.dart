import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:timwan/models/main_event_details.dart';

class CreateEventStart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final mainAppDetails = Provider.of<MainAppDetails>(context);
    final size = MediaQuery.of(context).size;

    return SafeArea(
      child: Column(
        children: <Widget>[
          Container(
            color: Colors.white,
            child: Row(
              children: <Widget>[
                IconButton(
                  icon: Icon(Icons.arrow_back),
                  onPressed: () {
                    mainAppDetails.clearPoints();
                    mainAppDetails.appState = MainAppState.StartState;
                  },
                ),
                Text("Select Cleanup Area"),
                Expanded(
                  child: Container(),
                ),
                IconButton(
                  icon: Icon(Icons.clear),
                  onPressed: () => mainAppDetails.clearPoints(),
                ),
                IconButton(
                  icon: mainAppDetails.createEventState ==
                          CreateEventState.DrawState
                      ? Icon(Icons.pause)
                      : Icon(Icons.play_arrow),
                  onPressed: () => mainAppDetails.toggleDrawState(),
                )
              ],
            ),
          ),
          Container(
            // TODO: fix the position of this widget
            child: Icon(
              Icons.place,
              color: Colors.green,
              size: 40,
            ),
          ),
        ],
      ),
    );
  }
}
