import 'package:amplify_authenticator/amplify_authenticator.dart';
import 'package:ebroker/data/cubits/Personalized/add_update_personalized_interest.dart';
import 'package:ebroker/data/cubits/Personalized/fetch_personalized_properties.dart';
import 'package:ebroker/data/cubits/property/fetch_city_property_list.dart';
import 'package:ebroker/test_page/fetch_all_properties.dart';
import 'package:ebroker/utils/AppIcon.dart';
import 'package:ebroker/utils/Network/apiCallTrigger.dart';
import 'package:ebroker/utils/ui_utils.dart';
import 'package:flutter/material.dart';

import 'data/cubits/category/fetch_category_cubit.dart';
import 'data/Repositories/category_repository.dart';
import 'data/cubits/property/add_property_cubit.dart';
import 'exports/main_export.dart';

/////////////
///V-1.0.9 //
////////////

void main() => initApp();

class EntryPoint extends StatefulWidget {
  const EntryPoint({
    Key? key,
  }) : super(key: key);

  @override
  EntryPointState createState() => EntryPointState();
}

class EntryPointState extends State<EntryPoint> {
  @override
  void initState() {
    super.initState();
    ChatGlobals.init();
  }

  final CategoryRepository categoryRepository = CategoryRepository();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => AuthCubit()),
          BlocProvider(create: (context) => LoginCubit()),
          BlocProvider(create: (context) => SliderCubit()),
          BlocProvider(create: (context) => CompanyCubit()),
          BlocProvider(create: (context) => HouseTypeCubit()),
          BlocProvider(create: (context) => PropertyCubit()),
          BlocProvider(
              create: (context) =>
                  FetchCategoryCubit(categoryRepository: categoryRepository)),
          BlocProvider(
              create: (context) =>
                  AddPropertyCubit(),),
          BlocProvider(create: (context) => SearchPropertyCubit()),
          BlocProvider(create: (context) => DeleteAccountCubit()),
          BlocProvider(create: (context) => TopViewedPropertyCubit()),
          BlocProvider(create: (context) => ProfileSettingCubit()),
          BlocProvider(create: (context) => NotificationCubit()),
          BlocProvider(create: (context) => EnquiryStatusCubit()),
          BlocProvider(create: (context) => AppThemeCubit()),
          BlocProvider(create: (context) => AuthenticationCubit()),
          BlocProvider(create: (context) => FetchHomePropertiesCubit()),
          BlocProvider(create: (context) => FetchTopRatedPropertiesCubit()),
          BlocProvider(create: (context) => FetchMyPropertiesCubit()),
          BlocProvider(create: (context) => FetchMyEnquiryCubit()),
          BlocProvider(create: (context) => FetchPropertyFromCategoryCubit()),
          BlocProvider(create: (context) => SendEnquiryCubit()),
          BlocProvider(create: (context) => FetchNotificationsCubit()),
          BlocProvider(create: (context) => LanguageCubit()),
          BlocProvider(create: (context) => GooglePlaceAutocompleteCubit()),
          BlocProvider(create: (context) => FetchArticlesCubit()),
          BlocProvider(create: (context) => FetchSystemSettingsCubit()),
          BlocProvider(create: (context) => FavoriteIDsCubit()),
          BlocProvider(create: (context) => DeleteEnquiryCubit()),
          BlocProvider(create: (context) => FetchPromotedPropertiesCubit()),
          BlocProvider(create: (context) => FetchMostViewedPropertiesCubit()),
          BlocProvider(create: (context) => FetchFavoritesCubit()),
          BlocProvider(create: (context) => CreatePropertyCubit()),
          BlocProvider(create: (context) => UserDetailsCubit()),
          BlocProvider(create: (context) => FetchLanguageCubit()),
          BlocProvider(create: (context) => LikedPropertiesCubit()),
          BlocProvider(create: (context) => EnquiryIdsLocalCubit()),
          BlocProvider(create: (context) => AddToFavoriteCubitCubit()),
          BlocProvider(create: (context) => RemoveFavoriteCubit()),
          BlocProvider(create: (context) => GetApiKeysCubit()),
          BlocProvider(create: (context) => FetchCityCategoryCubit()),
          BlocProvider(create: (context) => SetPropertyViewCubit()),
          BlocProvider(create: (context) => GetChatListCubit()),
          BlocProvider(
              create: (context) => FetchPropertyReportReasonsListCubit()),
          BlocProvider(create: (context) => FetchMostLikedPropertiesCubit()),
          BlocProvider(create: (context) => FetchNearbyPropertiesCubit()),
          BlocProvider(create: (context) => FetchOutdoorFacilityListCubit()),
          BlocProvider(create: (context) => FetchRecentPropertiesCubit()),
          BlocProvider(create: (context) => FetchAllPropertiesCubit()),
          BlocProvider(create: (context) => PropertyEditCubit()),
          BlocProvider(create: (context) => FetchCityPropertyList()),
          BlocProvider(create: (context) => FetchPersonalizedPropertyList()),
          BlocProvider(create: (context) => AddUpdatePersonalizedInterest()),
        ],
        child: Builder(builder: (BuildContext context) {
          return const App();
        }));
  }
}

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  void initState() {
    ///Here Fetching property report reasons
    context.read<FetchPropertyReportReasonsListCubit>().fetch();
    context.read<LanguageCubit>().loadCurrentLanguage();
    AppTheme currentTheme = HiveUtils.getCurrentTheme();

    ///Initialized notification services
    LocalAwsomeNotification().init(context);
    ///////////////////////////////////////
    NotificationService.init(context);

    /// Initialized dynamic links for share properties feature
    DeepLinkManager.initDeepLinks(context);
    context.read<AppThemeCubit>().changeTheme(currentTheme);
    APICallTrigger.onTrigger(
      () {
        //THIS WILL be CALLED WHEN USER WILL LOGIN FROM ANONYMOUS USER.
        context.read<LikedPropertiesCubit>().emit(LikedPropertiesState(
              liked: {},
              removedLikes: {},
            ));
        context.read<GetApiKeysCubit>().fetch();

        loadInitialData(context, loadWithoutDelay: true);
      },
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //Continuously watching theme change
    AppTheme currentTheme = context.watch<AppThemeCubit>().state.appTheme;
    // currentTheme = AppTheme.dark;
    return BlocListener<FetchLanguageCubit, FetchLanguageState>(
      listener: (context, state) {},
      child: Authenticator(
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
                    SignUpFormField.phoneNumber(
                      required: true,
                    ),
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
      ),
    );
  }

  dynamic loadLocalLanguageIfFail(LanguageState state) {
    if ((state is LanguageLoader)) {
      return Locale(state.languageCode);
    } else if (state is LanguageLoadFail) {
      return const Locale("en");
    }
  }
}

class CustomScaffold extends StatelessWidget {
  const CustomScaffold({
    super.key,
    required this.state,
    required this.body,
    this.footer,
  });

  final AuthenticatorState state;
  final Widget body;
  final Widget? footer;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            children: [
              // App logo
              Align(
                alignment: Alignment.center,
                child: SizedBox(
                    width: 150,
                    height: 150,
                    child: UiUtils.getSvg(
                      AppIcons.homeLogo,
                    )),
              ),
              Container(
                constraints: const BoxConstraints(maxWidth: 600),
                child: body,
              ),
            ],
          ),
        ),
      ),
      persistentFooterButtons: footer != null ? [footer!] : null,
    );
  }
}
