import 'package:amplify_authenticator/amplify_authenticator.dart';
import 'package:flutter/material.dart';

import '../../../app/app_localization.dart';
import '../../../app/app_theme.dart';
import '../../../app/routes.dart';
import '../../../exports/main_export.dart';
import '../../../main.dart';
import '../../../utils/constant.dart';
import '../widgets/AnimatedRoutes/blur_page_route.dart';

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
  @override
  Widget build(BuildContext context) {
    AppTheme currentTheme = context.watch<AppThemeCubit>().state.appTheme;

    return Authenticator(
      authenticatorBuilder: (BuildContext context, AuthenticatorState state) {
        switch (state.currentStep) {
          case AuthenticatorStep.signIn:
            return CustomScaffold(
              state: state,
              // A prebuilt Sign In form from amplify_authenticator
              body: SignInForm(),
              // A custom footer with a button to take the user to sign up
              footer: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Don\'t have an account?'),
                  TextButton(
                    onPressed: () => state.changeStep(
                      AuthenticatorStep.signUp,
                    ),
                    child: const Text('Sign Up'),
                  ),
                ],
              ),
            );
          case AuthenticatorStep.signUp:
            return CustomScaffold(
              state: state,
              // A prebuilt Sign Up form from amplify_authenticator
              body: SignUpForm.custom(
                fields: [
                  SignUpFormField.name(),
                  SignUpFormField.email(required: true),
                  // SignUpFormField.phoneNumber(
                  //   required: true,
                  // ),
                  SignUpFormField.password(),
                  SignUpFormField.passwordConfirmation(),
                ],
              ),
              // A custom footer with a button to take the user to sign in
              footer: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Already have an account?'),
                  TextButton(
                    onPressed: () => state.changeStep(
                      AuthenticatorStep.signIn,
                    ),
                    child: const Text('Sign In'),
                  ),
                ],
              ),
            );
          case AuthenticatorStep.confirmSignUp:
            return CustomScaffold(
              state: state,
              // A prebuilt Confirm Sign Up form from amplify_authenticator
              body: ConfirmSignUpForm(),
            );
          case AuthenticatorStep.resetPassword:
            return CustomScaffold(
              state: state,
              // A prebuilt Reset Password form from amplify_authenticator
              body: ResetPasswordForm(),
            );
          case AuthenticatorStep.confirmResetPassword:
            return CustomScaffold(
              state: state,
              // A prebuilt Confirm Reset Password form from amplify_authenticator
              body: const ConfirmResetPasswordForm(),
            );
          default:
            // Returning null defaults to the prebuilt authenticator for all other steps
            return null;
        }
      },
      child: MaterialApp(
        initialRoute: Routes.main,
        // App will start from here splash screen is first screen,
        navigatorKey: Constant.navigatorKey,
        //This navigator key is used for Navigate users through notification
        title: Constant.appName,
        debugShowCheckedModeBanner: false,
        onGenerateRoute: Routes.onGenerateRouted,
        theme: appThemeData[currentTheme],
        // builder: (context, child) {
        //   TextDirection direction;
        //   //here we are languages direction locally
        //   if (languageState is LanguageLoader) {
        //     if (Constant.totalRtlLanguages
        //         .contains((languageState).languageCode)) {
        //       direction = TextDirection.rtl;
        //     } else {
        //       direction = TextDirection.ltr;
        //     }
        //   } else {
        //     direction = TextDirection.ltr;
        //   }
        //   return MediaQuery(
        //     data: MediaQuery.of(context).copyWith(
        //       textScaleFactor:
        //           1.0, //set text scale factor to 1 so that this will not resize app's text while user change their system settings text scale
        //     ),
        //     child: Directionality(
        //       textDirection: direction,
        //       //This will convert app direction according to language
        //       child: DevicePreview(
        //         enabled: false,
        //
        //         /// Turn on this if you want to test the app in different screen sizes
        //         builder: (context) {
        //           return child!;
        //         },
        //       ),
        //     ),
        //   );
        // },
        builder: Authenticator.builder(),
        localizationsDelegates: const [
          AppLocalization.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        // locale: loadLocalLanguageIfFail(languageState),
      ),
    );
  }
}
