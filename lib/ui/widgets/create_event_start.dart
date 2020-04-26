import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:timwan/providers/main_event_details.dart';
import 'package:timwan/ui/widgets/create_event_details.dart';

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
                  tooltip: 'Back',
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
                  tooltip: 'Clear',
                  icon: Icon(Icons.clear),
                  onPressed: () => mainAppDetails.clearPoints(),
                ),
                IconButton(
                  tooltip: mainAppDetails.createEventState ==
                          CreateEventState.DrawState
                      ? 'Pause Drawing'
                      : 'Continue Drawing',
                  icon: mainAppDetails.createEventState ==
                          CreateEventState.DrawState
                      ? Icon(Icons.pause)
                      : Icon(Icons.play_arrow),
                  onPressed: () => mainAppDetails.toggleDrawState(),
                )
              ],
            ),
          ),
          Expanded(
            // TODO: fix the position of this widget
            child: Icon(
              Icons.place,
              color: Colors.green,
              size: 40,
            ),
          ),
          SlidingUpPanel(
            minHeight: 75.0,
            maxHeight: 300.0,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(24.0),
                topRight: Radius.circular(24.0)),
            panelBuilder: (ScrollController sc) => CreateEventDetails(scrollController: sc),
            collapsed: Center(
              child: Text("Swipe up when done!"),
            ),
          ),
        ],
      ),
    );
  }
}
