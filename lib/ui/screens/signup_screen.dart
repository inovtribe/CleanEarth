import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:timwan/ui/widgets/loading_button.dart';
import 'package:timwan/viewmodels/signup_view_model.dart';

class SignUpScreen extends StatelessWidget {
  final fullNameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Consumer<SignUpViewModel>(
      builder: (context, model, child) {
        return Scaffold(
          backgroundColor: Colors.white,
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50.0),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Sign Up',
                  style: TextStyle(fontSize: 38),
                ),
                TextField(
                  decoration: InputDecoration(
                    labelText: "Full Name",
                  ),
                  controller: fullNameController,
                ),
                TextField(
                  autocorrect: false,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    labelText: "Email",
                  ),
                  controller: emailController,
                ),
                TextField(
                  autocorrect: false,
                  decoration: InputDecoration(
                    labelText: "Password",
                  ),
                  obscureText: true,
                  controller: passwordController,
                ),
                SizedBox(
                  height: 10,
                ),
                SizedBox(
                  height: 35,
                  child: (model.hasErrors
                      ? Text(
                          model.errors,
                          style: TextStyle(color: Colors.red),
                        )
                      : Container()),
                ),
                LoadingButton(
                  title: "Sign Up",
                  isLoading: model.isLoading,
                  onPressed: () async {
                    await model.signUp(
                      fullName: fullNameController.text,
                      email: emailController.text,
                      password: passwordController.text,
                    );
                    if (!model.hasErrors) {
                      Navigator.of(context).pop();
                    }
                  },
                ),
                Divider(
                  height: 24,
                ),
                LoadingButton(
                  title: "Go Back",
                  isLoading: model.isLoading,
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
