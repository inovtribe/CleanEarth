import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:timwan/ui/widgets/loading_button.dart';
import 'package:timwan/viewmodels/user_details_view_model.dart';

class UserDetailsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
      viewModelBuilder: () => UserDetailsViewModel(),
      builder: (context, model, _) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0.0,
            iconTheme: IconThemeData(
              color: Colors.black,
            ),
          ),
          backgroundColor: Colors.white,
          body: Padding(
            padding: const EdgeInsets.only(
              top: 50,
              left: 15,
              right: 15.0,
            ),
            child: Column(
              children: <Widget>[
                Text(
                  'Hello, ${model.user?.fullName}',
                  style: TextStyle(fontSize: 24),
                ),
                SizedBox(
                  height: 15.0,
                ),
                if (!model.isAnonymous())
                  LoadingButton(
                    title: 'Create Event',
                    onPressed: model.navigateToCreateEvent,
                  ),
                SizedBox(
                  height: 15,
                ),
                LoadingButton(
                  title: 'Sign Out',
                  isLoading: model.isLoading,
                  onPressed: model.signOut,
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
