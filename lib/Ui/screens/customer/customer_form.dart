import 'dart:io';

import 'package:ebroker/Ui/screens/Personalized/personalized_property_screen.dart';
import 'package:ebroker/Ui/screens/widgets/custom_text_form_field.dart';
import 'package:ebroker/Ui/screens/widgets/image_cropper.dart';
import 'package:ebroker/data/cubits/auth/auth_cubit.dart';
import 'package:ebroker/data/cubits/property/fetch_most_viewed_properties_cubit.dart';
import 'package:ebroker/data/cubits/property/fetch_nearby_property_cubit.dart';
import 'package:ebroker/data/cubits/property/fetch_promoted_properties_cubit.dart';
import 'package:ebroker/data/cubits/slider_cubit.dart';
import 'package:ebroker/data/cubits/system/user_details.dart';
import 'package:ebroker/data/helper/custom_exception.dart';
import 'package:ebroker/data/helper/designs.dart';
import 'package:ebroker/data/model/user_model.dart';
import 'package:ebroker/utils/AppIcon.dart';
import 'package:ebroker/utils/Extensions/extensions.dart';
import 'package:ebroker/utils/constant.dart';
import 'package:ebroker/utils/hive_utils.dart';
import 'package:ebroker/utils/responsiveSize.dart';
import 'package:ebroker/utils/ui_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

import '../../../app/routes.dart';
import '../../../data/helper/widgets.dart';
import '../../../data/model/google_place_model.dart';
import '../../../database.dart';
import '../../../utils/helper_utils.dart';
import '../widgets/AnimatedRoutes/blur_page_route.dart';
import '../widgets/BottomSheets/choose_location_bottomsheet.dart';

class AddCustomer extends StatefulWidget {
  const AddCustomer();

  @override
  State<AddCustomer> createState() => AddCustomerState();

  static Route route(RouteSettings routeSettings) {
    return BlurredRouter(
      builder: (_) => AddCustomer(),
    );
  }
}

class AddCustomerState extends State<AddCustomer> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController minBudgetController = TextEditingController();
  final TextEditingController maxBudgetController = TextEditingController();
  final TextEditingController unitTypeController = TextEditingController();
  final TextEditingController unitConfigurationsController =
      TextEditingController();
  final TextEditingController propertyStatusController =
      TextEditingController();
  bool isMinBudgetSelected = false;
  bool isMaxBudgetSelected = false;
  dynamic size;
  dynamic city, _state, country, placeid;
  String? name, email, address;
  File? fileUserimg;
  bool isNotificationsEnabled = true;
  List<String> budget = [
    '5.00 Lac',
    '10.00 Lac',
    '15.00 Lac',
    '20.00 Lac',
    '25.00 Lac',
    '30.00 Lac',
    '35.00 Lac',
    '40.00 Lac',
    '45.00 Lac',
    '50.00 Lac',
    '60.00 Lac',
    '70.00 Lac',
    '80.00 Lac',
    '90.00 Lac',
    '1.00 Cr',
    '1.25 Cr',
    '1.50 Cr',
    '1.75 Cr',
    '2.50 Cr',
    '3.00 Cr',
    '3.50 Cr',
    '4.00 Cr',
    '4.50 Cr',
    '5.00 Cr'
  ];

  List<String> unitType = [
    'Apartment',
    'Plot',
    'Villa',
    'Penthouse',
    'Duplex',
    'Studio'
  ];
  List<String> unitConfigurations = [
    '1 RK',
    '2 RK',
    '1 BHK',
    '2 BHK',
    '3 BHK',
    '4 BHK',
    '5 BHK',
    '6 BHK',
    '7 BHK',
    '8 BHK',
    '9 BHK',
    '10 BHK',
    '10+ BHK',
    '2.5 BHK',
    '3.5 BHK',
    '4.5 BHK',
    '1.5 BHK',
  ];
  List<String> propertyStatus = [
    'Ready To Move',
    'Under Construction',
    'Pre-Launch'
  ];
  List<String> selectedUnitType = [];
  List<String> selectedUnitConfigurations = [];
  List<Widget> choices = [];

  String _saperateNumber() {
    // FirebaseAuth.instance.currentUser.sendEmailVerification();
    String? mobile = HiveUtils.getUserDetails().mobile;

    String? countryCode = HiveUtils.getCountryCode();

    int countryCodeLength = (countryCode?.length ?? 0);

    String mobileNumber = mobile!.substring(countryCodeLength, mobile.length);

    mobileNumber = "+${countryCode!} $mobileNumber";
    return mobileNumber;
  }

  @override
  void dispose() {
    super.dispose();
    phoneController.dispose();
    nameController.dispose();
    emailController.dispose();
    addressController.dispose();
  }

  void _onTapChooseLocation() async {
    FocusManager.instance.primaryFocus?.unfocus();

    if (!const bool.fromEnvironment("force-disable-demo-mode",
        defaultValue: false)) {
      if (Constant.isDemoModeOn) {
        HelperUtils.showSnackBarMessage(context, "Not valid in demo mode");

        return;
      }
    }

    var result = await showModalBottomSheet(
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20))),
      context: context,
      builder: (context) {
        return const ChooseLocatonBottomSheet();
      },
    );
    if (result != null) {
      GooglePlaceModel place = (result as GooglePlaceModel);

      city = place.city;
      country = place.country;
      _state = place.state;
      placeid = place.placeId;
    }
  }

  void _onTapChooseBudget(TextEditingController controller) async {
    var result = await showModalBottomSheet(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20))),
      context: context,
      builder: (context) {
        return SizedBox(
          height: MediaQuery.of(context).size.height * 0.7,
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Min Budget',
                  style: TextStyle(fontSize: context.font.larger),
                ),
                SizedBox(height: 15.0),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: budget.map((option) {
                        return Card(
                          margin: EdgeInsets.symmetric(vertical: 5.0),
                          child: ListTile(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                              side: BorderSide(
                                color: context.color.borderColor,
                                width: 1.5,
                              ),
                            ),
                            tileColor: controller.text == option
                                ? Color(0xFFb4d7d7)
                                : Colors.grey.shade200,
                            titleTextStyle: TextStyle(
                              color: controller.text == option
                                  ? Colors.black
                                  : Colors.black45,
                              fontSize: context.font.large,
                              fontWeight: controller.text == option
                                  ? FontWeight.bold
                                  : FontWeight.normal,
                            ),
                            title: Text(
                              option,
                            ),
                            onTap: () {
                              controller.text = option;
                              print('Selected: $option');
                              Navigator.pop(context);
                            },
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _onTapChooseUnit(TextEditingController controller, List<String> unitList,
      List<String> selectUnit, String title) async {
    var result = await showModalBottomSheet(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20))),
      context: context,
      builder: (context) {
        return StatefulBuilder(builder: (BuildContext context,
            StateSetter setState /*You can rename this!*/) {
          return SizedBox(
            height: MediaQuery.of(context).size.height * 0.3,
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    title,
                    style: TextStyle(fontSize: context.font.larger),
                  ),
                  SizedBox(height: 15.0),
                  Expanded(
                    child: GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        childAspectRatio: 2 / 1,
                      ),
                      itemCount: unitList.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              selectUnit.contains(unitList[index])
                                  ? selectUnit.remove(unitList[index])
                                  : selectUnit.add(unitList[index]);
                              controller.text = selectUnit.join(',');
                            });
                          },
                          child: Card(
                            elevation: 2,
                            color: selectUnit.contains(unitList[index])
                                ? Color(0xFFb4d7d7)
                                : Colors.grey.shade200,
                            shadowColor: Colors.black,
                            child: Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Center(
                                child: Text(unitList[index],
                                    style: selectUnit.contains(unitList[index])
                                        ? TextStyle(
                                            color: Color(0xFF087c7c),
                                            fontWeight: FontWeight.bold)
                                        : TextStyle(color: Colors.black45)),
                              ),
                            ), //Text
                          ), //Chip
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
        });
      },
    );
  }

  void _onTapChoosePropertyStatus() async {
    var result = await showModalBottomSheet(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20))),
        context: context,
        builder: (context) {
          return SizedBox(
            height: MediaQuery.of(context).size.height * 0.4,
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Property Status',
                    style: TextStyle(fontSize: context.font.larger),
                  ),
                  SizedBox(height: 15.0),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: propertyStatus.map((option) {
                          return Card(
                            margin: EdgeInsets.symmetric(vertical: 5.0),
                            child: ListTile(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                                side: BorderSide(
                                  color: context.color.borderColor,
                                  width: 1.5,
                                ),
                              ),
                              leading: Icon(
                                  size: 20,
                                  option == 'Ready To Move'
                                      ? Icons.check_circle
                                      : option == 'Under Construction'
                                          ? Icons.construction
                                          : Icons.library_add_check),
                              titleTextStyle: TextStyle(
                                color: Colors.black,
                                fontSize: context.font.normal,
                                fontWeight: FontWeight.normal,
                              ),
                              title: Text(
                                option,
                              ),
                              onTap: () {
                                propertyStatusController.text = option;
                                print('Selected: $option');
                                Navigator.pop(context);
                              },
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: safeAreaCondition(
        child: Scaffold(
          backgroundColor: context.color.primaryColor,
          appBar: UiUtils.buildAppBar(context,
              title: UiUtils.getTranslatedLabel(
                context,
                "Add Customer",
              ),
              showBackButton: true),
          body: ScrollConfiguration(
            behavior: RemoveGlow(),
            child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                keyboardDismissBehavior:
                    ScrollViewKeyboardDismissBehavior.onDrag,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                      key: _formKey,
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            TextFormField(
                              keyboardType: TextInputType.text,
                              decoration: InputDecoration(
                                labelText: 'Full Name',
                                fillColor: context.color.textLightColor
                                    .withOpacity(00.01),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 1.5,
                                        color: context.color.teritoryColor),
                                    borderRadius: BorderRadius.circular(10)),
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 1.5,
                                        color: context.color.borderColor),
                                    borderRadius: BorderRadius.circular(10)),
                                border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 1.5,
                                        color: context.color.borderColor),
                                    borderRadius: BorderRadius.circular(10)),
                              ),
                              controller: nameController,
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            TextFormField(
                              keyboardType: TextInputType.emailAddress,
                              decoration: InputDecoration(
                                labelText: 'Email',
                                fillColor: context.color.textLightColor
                                    .withOpacity(00.01),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 1.5,
                                        color: context.color.teritoryColor),
                                    borderRadius: BorderRadius.circular(10)),
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 1.5,
                                        color: context.color.borderColor),
                                    borderRadius: BorderRadius.circular(10)),
                                border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 1.5,
                                        color: context.color.borderColor),
                                    borderRadius: BorderRadius.circular(10)),
                              ),
                              controller: emailController,
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            TextFormField(
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                labelText: 'Phone Number',
                                fillColor: context.color.textLightColor
                                    .withOpacity(00.01),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 1.5,
                                        color: context.color.teritoryColor),
                                    borderRadius: BorderRadius.circular(10)),
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 1.5,
                                        color: context.color.borderColor),
                                    borderRadius: BorderRadius.circular(10)),
                                border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 1.5,
                                        color: context.color.borderColor),
                                    borderRadius: BorderRadius.circular(10)),
                              ),
                              controller: phoneController,
                            ),
                            // buildTextField(
                            //   context,
                            //   title: "fullName",
                            //   controller: nameController,
                            //   validator: CustomTextFieldValidator.nullCheck,
                            // ),
                            // buildTextField(
                            //   context,
                            //   title: "companyEmailLbl",
                            //   controller: emailController,
                            //   validator: CustomTextFieldValidator.email,
                            // ),
                            // buildTextField(
                            //   context,
                            //   title: "phoneNumber",
                            //   controller: phoneController,
                            //   validator: CustomTextFieldValidator.nullCheck,
                            // ),
                            SizedBox(
                              height: 25.rh(context),
                            ),
                            Text('Project Preferences (Optional)',
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            const SizedBox(
                              height: 15,
                            ),
                            buildAddressTextField(
                              context,
                              title: "addressLbl",
                              controller: addressController,
                              validator: CustomTextFieldValidator.nullCheck,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text("enablesNewSection".translate(context))
                                .size(context.font.small)
                                .bold(weight: FontWeight.w300)
                                .color(
                                  context.color.textColorDark.withOpacity(0.8),
                                ),
                            const SizedBox(
                              height: 15,
                            ),
                            Row(
                              children: [
                                Flexible(
                                  child: TextFormField(
                                    showCursor: false,
                                    readOnly: true,
                                    onTap: () =>
                                        _onTapChooseBudget(minBudgetController),
                                    decoration: InputDecoration(
                                      suffixIcon: Icon(Icons.arrow_drop_down),
                                      labelText: 'Min Budget',
                                      labelStyle: TextStyle(fontSize: 14),
                                      fillColor: context.color.textLightColor
                                          .withOpacity(00.01),
                                      focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              width: 1.5,
                                              color:
                                                  context.color.teritoryColor),
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              width: 1.5,
                                              color: context.color.borderColor),
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      border: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              width: 1.5,
                                              color: context.color.borderColor),
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                    ),
                                    controller: minBudgetController,
                                  ),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Flexible(
                                  child: TextFormField(
                                    showCursor: false,
                                    readOnly: true,
                                    onTap: () =>
                                        _onTapChooseBudget(maxBudgetController),
                                    decoration: InputDecoration(
                                      suffixIcon: Icon(Icons.arrow_drop_down),
                                      labelText: 'Max Budget',
                                      labelStyle: TextStyle(fontSize: 14),
                                      fillColor: context.color.textLightColor
                                          .withOpacity(00.01),
                                      focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              width: 1.5,
                                              color:
                                                  context.color.teritoryColor),
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              width: 1.5,
                                              color: context.color.borderColor),
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      border: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              width: 1.5,
                                              color: context.color.borderColor),
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                    ),
                                    controller: maxBudgetController,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 15),
                            TextFormField(
                              showCursor: false,
                              readOnly: true,
                              onTap: () => _onTapChooseUnit(unitTypeController,
                                  unitType, selectedUnitType, 'Unit Type'),
                              decoration: InputDecoration(
                                suffixIcon: Icon(Icons.arrow_drop_down),
                                labelText: 'Unit Type',
                                labelStyle: TextStyle(fontSize: 14),
                                fillColor: context.color.textLightColor
                                    .withOpacity(00.01),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 1.5,
                                        color: context.color.teritoryColor),
                                    borderRadius: BorderRadius.circular(10)),
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 1.5,
                                        color: context.color.borderColor),
                                    borderRadius: BorderRadius.circular(10)),
                                border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 1.5,
                                        color: context.color.borderColor),
                                    borderRadius: BorderRadius.circular(10)),
                              ),
                              controller: unitTypeController,
                            ),
                            SizedBox(height: 15),

                            TextFormField(
                              showCursor: false,
                              readOnly: true,
                              onTap: () => _onTapChooseUnit(
                                  unitConfigurationsController,
                                  unitConfigurations,
                                  selectedUnitConfigurations,
                                  'Unit Configurations'),
                              decoration: InputDecoration(
                                suffixIcon: Icon(Icons.arrow_drop_down),
                                labelText: 'Unit Configurations',
                                labelStyle: TextStyle(fontSize: 14),
                                fillColor: context.color.textLightColor
                                    .withOpacity(00.01),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 1.5,
                                        color: context.color.teritoryColor),
                                    borderRadius: BorderRadius.circular(10)),
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 1.5,
                                        color: context.color.borderColor),
                                    borderRadius: BorderRadius.circular(10)),
                                border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 1.5,
                                        color: context.color.borderColor),
                                    borderRadius: BorderRadius.circular(10)),
                              ),
                              controller: unitConfigurationsController,
                            ),
                            SizedBox(height: 15),
                            TextFormField(
                              showCursor: false,
                              readOnly: true,
                              onTap: () => _onTapChoosePropertyStatus(),
                              decoration: InputDecoration(
                                suffixIcon: Icon(Icons.arrow_drop_down),
                                labelText: 'Property Status',
                                labelStyle: TextStyle(fontSize: 14),
                                fillColor: context.color.textLightColor
                                    .withOpacity(00.01),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 1.5,
                                        color: context.color.teritoryColor),
                                    borderRadius: BorderRadius.circular(10)),
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 1.5,
                                        color: context.color.borderColor),
                                    borderRadius: BorderRadius.circular(10)),
                                border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 1.5,
                                        color: context.color.borderColor),
                                    borderRadius: BorderRadius.circular(10)),
                              ),
                              controller: propertyStatusController,
                            ),
                            SizedBox(
                              height: 20.rh(context),
                            ),
                            UiUtils.buildButton(
                              context,
                              onPressed: () {
                                if (city != null && city != "") {
                                  HiveUtils.setLocation(
                                      city: city,
                                      state: _state,
                                      country: country,
                                      placeId: placeid);
                                  context
                                      .read<FetchNearbyPropertiesCubit>()
                                      .fetch(forceRefresh: true);

                                  context
                                      .read<FetchMostViewedPropertiesCubit>()
                                      .fetch();
                                  context
                                      .read<FetchPromotedPropertiesCubit>()
                                      .fetch();
                                  context
                                      .read<SliderCubit>()
                                      .fetchSlider(context);
                                } else {
                                  HiveUtils.clearLocation();
                                  context
                                      .read<FetchMostViewedPropertiesCubit>()
                                      .fetch();
                                  context
                                      .read<FetchNearbyPropertiesCubit>()
                                      .fetch(forceRefresh: true);

                                  context
                                      .read<FetchPromotedPropertiesCubit>()
                                      .fetch();
                                  context
                                      .read<SliderCubit>()
                                      .fetchSlider(context);
                                }
                                validateData();
                              },
                              height: 48.rh(context),
                              buttonTitle: UiUtils.getTranslatedLabel(
                                  context, "Add Customer"),
                            )
                          ])),
                )),
          ),
        ),
      ),
    );
  }

  Widget locationWidget(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 10.0,
      ),
      child: Row(
        children: [
          Expanded(
            child: Container(
              height: 55,
              decoration: BoxDecoration(
                  color: context.color.textLightColor.withOpacity(00.01),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: context.color.borderColor,
                    width: 1.5,
                  )),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsetsDirectional.only(start: 10.0),
                    child: Align(
                        alignment: Alignment.centerLeft,
                        child: (city != "" && city != null)
                            ? Text("$city,$_state,$country")
                            : Text(UiUtils.getTranslatedLabel(
                                context, "selectLocationOptional"))),
                  ),
                  const Spacer(),
                  if (city != "" && city != null)
                    Padding(
                      padding: const EdgeInsetsDirectional.only(end: 10.0),
                      child: GestureDetector(
                        onTap: () {
                          city = "";
                          _state = "";
                          country = "";
                          setState(() {});
                        },
                        child: Icon(
                          Icons.close,
                          color: context.color.textColorDark,
                        ),
                      ),
                    )
                ],
              ),
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          GestureDetector(
            onTap: _onTapChooseLocation,
            child: Container(
              height: 55,
              width: 55,
              decoration: BoxDecoration(
                  color: context.color.textLightColor.withOpacity(00.01),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: context.color.borderColor,
                    width: 1.5,
                  )),
              child: Icon(
                Icons.location_searching_sharp,
                color: context.color.teritoryColor,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget safeAreaCondition({required Widget child}) {
    return child;
  }

  Widget buildAddressTextField(BuildContext context,
      {required String title,
      required TextEditingController controller,
      CustomTextFieldValidator? validator,
      bool? readOnly}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 10.rh(context),
        ),
        Text(UiUtils.getTranslatedLabel(context, title)),
        SizedBox(
          height: 10.rh(context),
        ),
        CustomTextFormField(
          controller: controller,
          maxLine: 5,
          action: TextInputAction.newline,
          isReadOnly: readOnly,
          validator: validator,
          fillColor: context.color.textLightColor.withOpacity(00.01),
        ),
        const SizedBox(
          width: 10,
        ),
        locationWidget(context),
      ],
    );
  }

  Future<void> validateData() async {
    if (_formKey.currentState!.validate()) {
      bool checkinternet = await HelperUtils.checkInternet();
      if (!checkinternet) {
        Future.delayed(
          Duration.zero,
          () {
            HelperUtils.showSnackBarMessage(context,
                UiUtils.getTranslatedLabel(context, "lblchecknetwork"));
          },
        );

        return;
      }
      // customerAddProcess();
    }
  }

  // customerAddProcess() async {
  //   bool success = await DatabaseMethods().addCustomer({
  //     "phone": phoneController.text,
  //     "name": nameController.text,
  //     "email": emailController.text,
  //     "address": addressController.text,
  //     "min_budget": minBudgetController.text,
  //     "max_budget": maxBudgetController.text,
  //     "unit_type": unitTypeController.text,
  //     "unit_configurations": unitConfigurationsController.text,
  //     "property_status": propertyStatusController.text
  //   });
  //
  //   if (success) {
  //     Widgets.showLoader(context);
  //     HelperUtils.showSnackBarMessage(
  //         context, UiUtils.getTranslatedLabel(context, "Customer Added Successfully"),
  //         type: MessageType.success, onClose: () {
  //       Navigator.of(context).pop();
  //       Navigator.of(context).pop();
  //     });
  //   } else if (!success) {
  //     // Widgets.hideLoder(context);
  //     HelperUtils.showSnackBarMessage(context, 'Failed to add Customer',
  //         type: MessageType.error);
  //   }
  // }
}
