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
          backgroundColor: Colors.white,
          body: Column(
            children: <Widget>[
              if (!model.isAnonynomous())
                LoadingButton(
                  title: 'Create Event',
                  onPressed: model.navigateToCreateEvent,
                ),
              LoadingButton(
                title: 'Sign Out',
                isLoading: model.isLoading,
                onPressed: model.signOut,
              )
            ],
          ),
        );
      },
    );
  }
}
