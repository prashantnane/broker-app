
import 'package:amplify_core/amplify_core.dart';
import 'package:flutter/material.dart';
import 'dart:async';


class VerificationScreen extends StatelessWidget {
  final TextEditingController confirmationCodeController = TextEditingController();
  final String phoneNumber;

  VerificationScreen({required this.phoneNumber});
  Future<void> confirmSignUp(String phoneNumber, String confirmationCode) async {
    try {
      // Confirm the sign-up process
      final SignUpResult res = await Amplify.Auth.confirmSignUp(
        username: phoneNumber,
        confirmationCode: confirmationCode,
      );

      // If confirmation is successful, the user is now signed up
      if (res.isSignUpComplete) {
        print('Sign up successful. User is now confirmed.');
      }
    } catch (e) {
      print('Error confirming sign up: $e');
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Verification'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: confirmationCodeController,
                decoration: InputDecoration(labelText: 'Confirmation Code'),
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () async {
                  final confirmationCode = confirmationCodeController.text.trim();
                  await confirmSignUp(phoneNumber, confirmationCode);
                },
                child: Text('Confirm Sign Up'),
              ),
            ],
          ),
        ),
      ),
    );
  }}