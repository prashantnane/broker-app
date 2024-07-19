import 'dart:convert';
import 'dart:developer';

import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_core/amplify_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/src/widgets/editable_text.dart';

import '../../models/Broker.dart';
import '../../utils/api.dart';
import '../../utils/constant.dart';
import '../../utils/hive_utils.dart';

class AuthRepository {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  static int? forceResendingToken;

  Future<Map<String, dynamic>> loginWithApi(
      {required String phone, required String uid}) async {
    Map<String, String> parameters = {
      Api.mobile: phone.replaceAll(" ", "").replaceAll("+", ""),
      Api.firebaseId: uid,
      Api.type: Constant.logintypeMobile,
    };

    Map<String, dynamic> response = await Api.post(
        url: Api.apiLogin, parameter: parameters, useAuthToken: false);

    return {"token": response['token'], "data": response['data']};
  }

  Future<void> sendOTP(
      {required String phoneNumber,
      required Function(String verificationId) onCodeSent,
      Function(dynamic e)? onError}) async {
    await FirebaseAuth.instance.verifyPhoneNumber(
      timeout: Duration(
        seconds: Constant.otpTimeOutSecond,
      ),
      phoneNumber: phoneNumber,
      verificationCompleted: (PhoneAuthCredential credential) {},
      verificationFailed: (FirebaseAuthException e) {
        // onError?.call(ApiException(e.code));
      },
      codeSent: (String verificationId, int? resendToken) {
        forceResendingToken = resendToken;
        onCodeSent.call(verificationId);
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
      forceResendingToken: forceResendingToken,
    );
  }

  Future<void> verifyOTP({
    required String username,
    required String otp,
  }) async {
    // PhoneAuthCredential credential = PhoneAuthProvider.credential(
    //     verificationId: otpVerificationId, smsCode: otp);
    // UserCredential userCredential =
    //     await _auth.signInWithCredential(credential);
    // return userCredential;

    try {
      log('username : $username and otp : $otp');
      final result = await Amplify.Auth.confirmSignUp(
        username: "+91$username",
        confirmationCode: otp,
      );
      // Check if further confirmations are needed or if
      // the sign up is complete.
      await _handleSignUpResult(result);
    } on AuthException catch (e) {
      safePrint('Error confirming user: ${e.message}');
    }

    // return result;
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
      'A confirmation code has been sent to ${codeDeliveryDetails.destination}.'
      'Please check your ${codeDeliveryDetails.deliveryMedium.name} for the code.',
    );
  }

  Future<void> saveBrokerData({
    required String name,
    required String email,
    required String phone,
    required String address,
    required String rera,
  }) async {
    try {
      print('listening to saveBrokerData');
      Broker broker = Broker(
        name: name,
        email: email,
        mobile: phone,
        address: address,
        isActive: 1,
        isProfileCompleted: false,
        notification: 0,
        profile: '',
        rera: rera,
      );

      final request = ModelMutations.create(broker);
      final response = await Amplify.API.mutate(request: request).response;
      final BrokerData = response.data!.toJson();
      // Map<dynamic, dynamic> responseData = jsonDecode(response.data.toJson());
      HiveUtils.setUserData(response.data!.toJson());
      print('this is BrokerData: $BrokerData');

      print('Broker data saved successfully');
    } catch (e) {
      print('Error saving broker data: $e');
    }
  }

  Future<Map<String, dynamic>> fetchUserDetailsByPhone(String phone) async {
    print('listening to fetchUserDetailsByPhone');
    try {
      // final request = GraphQLRequest<String>(
      //   document: '''
      //     query fetchCategoryById {
      //       getCategory(id: "$id") {
      //         category
      //         image
      //       }
      //     }
      //   ''',
      // );
      final request = ModelQueries.list(Broker.classType,where:Broker.MOBILE.eq(phone));

      final response = await Amplify.API.query(request: request).response;
      print('this is response from broker repo: ${response.data}');

      final patientPhoneNumbeList = response.data?.items;
      if (patientPhoneNumbeList == null) {
        safePrint('errors: ${response.errors}');
        return const {};
      }
      return {};
    } catch (e) {
      safePrint('Query failed: $e');
      return const {};
    }
  }
}
