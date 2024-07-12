import 'dart:developer';

import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_authenticator/amplify_authenticator.dart';
import 'package:amplify_core/amplify_core.dart';
import 'package:flutter/material.dart';

import '../../../app/app_localization.dart';
import '../../../app/app_theme.dart';
import '../../../app/routes.dart';
import '../../../exports/main_export.dart';
import '../../../main.dart';
import '../../../models/Broker.dart';
import '../../../utils/constant.dart';
import '../widgets/AnimatedRoutes/blur_page_route.dart';

Future<void> saveBrokerData(
    String username, String email, String phone, String address) async {
  try {
    Broker broker = Broker(
      id: username,
      name: username,
      email: email,
      mobile: phone,
      address: address,
      isActive: 1,
      isProfileCompleted: false,
      notification: 0,
      profile: '',
    );
    await Amplify.DataStore.save(broker);
    print('Broker data saved successfully');
  } catch (e) {
    print('Error saving broker data: $e');
  }
}

class AmplifyLoginScreen extends StatefulWidget {
  AmplifyLoginScreen({super.key});

  @override
  State<AmplifyLoginScreen> createState() => _AmplifyLoginScreenState();

  static route(RouteSettings routeSettings) {
    Map? args = routeSettings.arguments as Map?;
    return BlurredRouter(
      builder: (_) => MultiBlocProvider(
        providers: [
          // BlocProvider(create: (context) => SendOtpCubit()),
          // BlocProvider(create: (context) => VerifyOtpCubit()),
        ],
        child: AmplifyLoginScreen(
            // isDeleteAccount: args?['isDeleteAccount'],
            // popToCurrent: args?['popToCurrent'],
            ),
      ),
    );
  }
}

class _AmplifyLoginScreenState extends State<AmplifyLoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _username = '';
  String _email = '';
  String _phone = '';
  String _address = '';
  String _password = '';
  String _confirmPassword = '';
  TextEditingController _otp = TextEditingController();

  String? _validateUsername(UsernameInput? input) {
    final username = input?.username;
    if (username == null || username.isEmpty) {
      return 'Username cannot be empty';
    }
    return null;
  }

  Future<void> _signUp() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      try {
        SignUpResult res = await Amplify.Auth.signUp(
          username: _username,
          password: _password,
          options: SignUpOptions(
            userAttributes: {
              AuthUserAttributeKey.email: _email,
              AuthUserAttributeKey.phoneNumber: _phone,
              AuthUserAttributeKey.address: _address,
            },
          ),
        );
        await _handleSignUpResult(res);
        if (res.isSignUpComplete) {
          await saveBrokerData(_username, _email, _phone, _address);
        } else {
          // handle confirmation step if needed
        }
      } catch (e) {
        print('Sign up failed: $e');
      }
    }
  }

  Future<void> _handleSignUpResult(SignUpResult result) async {
    switch (result.nextStep.signUpStep) {
      case AuthSignUpStep.confirmSignUp:
        final codeDeliveryDetails = result.nextStep.codeDeliveryDetails!;
        _handleCodeDelivery(codeDeliveryDetails);
        break;
      case AuthSignUpStep.done:
        safePrint('Sign up is complete');
        break;
    }
  }

  void _handleCodeDelivery(AuthCodeDeliveryDetails codeDeliveryDetails) {
    safePrint(
      'A confirmation code has been sent to ${codeDeliveryDetails.destination}. '
      'Please check your ${codeDeliveryDetails.deliveryMedium.name} for the code.',
    );
  }

  Future<void> confirmUser({
    required String username,
    required String confirmationCode,
  }) async {
    try {
      log('username : $username and otp : $confirmationCode');
      final result = await Amplify.Auth.confirmSignUp(
        username: username,
        confirmationCode: confirmationCode,
      );
      // Check if further confirmations are needed or if
      // the sign up is complete.
      await _handleSignUpResult(result);
    } on AuthException catch (e) {
      safePrint('Error confirming user: ${e.message}');
    }
  }

  Future<void> signInUser(String username, String password) async {
    try {
      final result = await Amplify.Auth.signIn(
        username: username,
        password: password,
      );
      await _handleSignInResult(result);
    } on AuthException catch (e) {
      safePrint('Error signing in: ${e.message}');
    }
  }
  Future<void> _handleSignInResult(SignInResult result) async {
    switch (result.nextStep.signInStep) {
      case AuthSignInStep.confirmSignInWithSmsMfaCode:
        final codeDeliveryDetails = result.nextStep.codeDeliveryDetails!;
        _handleCodeDelivery(codeDeliveryDetails);
        break;
      case AuthSignInStep.confirmSignInWithNewPassword:
        safePrint('Enter a new password to continue signing in');
        break;
      case AuthSignInStep.confirmSignInWithCustomChallenge:
        final parameters = result.nextStep.additionalInfo;
        final prompt = parameters['prompt']!;
        safePrint(prompt);
        break;
      // case AuthSignInStep.resetPassword:
      //   final resetResult = await Amplify.Auth.resetPassword(
      //     username: _username,
      //   );
      //   await _handleResetPasswordResult(resetResult);
      //   break;
      case AuthSignInStep.confirmSignUp:
      // Resend the sign up code to the registered device.
        final resendResult = await Amplify.Auth.resendSignUpCode(
          username: _username,
        );
        _handleCodeDelivery(resendResult.codeDeliveryDetails);
        break;
      case AuthSignInStep.done:
        safePrint('Sign in is complete');
        break;
    }
  }

  Future<void> signOutCurrentUser() async {
    final result = await Amplify.Auth.signOut();
    if (result is CognitoCompleteSignOut) {
      safePrint('Sign out completed successfully');
    } else if (result is CognitoFailedSignOut) {
      safePrint('Error signing user out: ${result.exception.message}');
    }
  }

  @override
  Widget build(BuildContext context) {
    AppTheme currentTheme = context.watch<AppThemeCubit>().state.appTheme;

    return MaterialApp(
      home: Scaffold(
        body: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'Username'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a username';
                  }
                  return null;
                },
                onSaved: (value) {
                  _username = value!;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Email'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter an email';
                  }
                  return null;
                },
                onSaved: (value) {
                  _email = value!;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Phone'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a phone number';
                  }
                  return null;
                },
                onSaved: (value) {
                  _phone = value!;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Address'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter an address';
                  }
                  return null;
                },
                onSaved: (value) {
                  _address = value!;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Password'),
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a password';
                  }
                  return null;
                },
                onSaved: (value) {
                  _password = value!;
                },
              ),
              // TextFormField(
              //   decoration: InputDecoration(labelText: 'Confirm Password'),
              //   obscureText: true,
              //   validator: (value) {
              //     if (value == null || value.isEmpty) {
              //       return 'Please confirm your password';
              //     } else if (value != _password) {
              //       return 'Passwords do not match';
              //     }
              //     return null;
              //   },
              // ),
              ElevatedButton(
                onPressed: () {
                  _signUp();

                },
                child: Text('Sign Up'),
              ),
              TextFormField(
                controller: _otp,
                decoration: InputDecoration(labelText: 'OTP'),
                // validator: (value) {
                //   if (value == null || value.isEmpty) {
                //     return 'Please enter otp';
                //   }
                //   return null;
                // },
                // onSaved: (value) {
                //   _otp = value!;
                // },
              ),
              ElevatedButton(
                onPressed: () {
                  confirmUser(username: _username, confirmationCode: _otp.text.toString());
                },
                child: Text('Confirm Otp'),
              ),ElevatedButton(
                onPressed: () {
                  signInUser(_username, _password);
                },
                child: Text('Sign In'),
              ),ElevatedButton(
                onPressed: () {
                  signOutCurrentUser();
                },
                child: Text('Sign Out'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
