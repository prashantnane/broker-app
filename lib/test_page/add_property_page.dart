import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:ebroker/data/model/property_model.dart';
import 'package:ebroker/utils/Extensions/extensions.dart';
import 'package:ebroker/utils/responsiveSize.dart';
import 'package:flutter/material.dart';

import '../Ui/screens/main_activity.dart';
import '../Ui/screens/proprties/AddProperyScreens/add_property_details.dart';
import '../Ui/screens/widgets/AnimatedRoutes/blur_page_route.dart';
import '../Ui/screens/widgets/panaroma_image_view.dart';
import '../data/model/category.dart';
import '../exports/main_export.dart';
import '../utils/AppIcon.dart';
import '../utils/helper_utils.dart';
import '../utils/imagePicker.dart';
import '../utils/ui_utils.dart';
import 'db.dart';

class AddPropertyPage extends StatefulWidget {
  const AddPropertyPage({super.key});

  @override
  State<AddPropertyPage> createState() => _AddPropertyPageState();
}

class _AddPropertyPageState extends State<AddPropertyPage> {
  TextEditingController titleController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController customerNameController = TextEditingController();
  TextEditingController customerEmailController = TextEditingController();
  TextEditingController customerProfileController = TextEditingController();
  TextEditingController customerNumberController = TextEditingController();
  TextEditingController rentDurationController = TextEditingController();
  TextEditingController categoryController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController clientAddressController = TextEditingController();
  TextEditingController propertyTypeController = TextEditingController();
  TextEditingController titleImageController = TextEditingController();
  TextEditingController titleimagehashController = TextEditingController();
  TextEditingController postCreatedController = TextEditingController();
  TextEditingController totalViewController = TextEditingController();
  TextEditingController statusController = TextEditingController();
  TextEditingController state = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController countryController = TextEditingController();
  TextEditingController addedByController = TextEditingController();
  TextEditingController isFavouriteController = TextEditingController();
  TextEditingController latitudeController = TextEditingController();
  TextEditingController longitudeController = TextEditingController();
  TextEditingController threeDImageController = TextEditingController();
  TextEditingController videoController = TextEditingController();
  int? selectedIndex;
  final PickImage _pickTitleImage = PickImage();
  final PickImage _propertisImagePicker = PickImage();
  final PickImage _pick360deg = PickImage();
  List<dynamic> mixedPropertyImageList = [];
  String titleImageURL = "";
  List removedImageId = [];
  Map properyDetails ={};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Property Page'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsetsDirectional.only(
                    start: 20.0, end: 20, top: 20),
                child:
                    Text(UiUtils.getTranslatedLabel(context, "typeOfProperty"))
                        .color(context.color.textColorDark),
              ),
              BlocBuilder<FetchCategoryCubit, FetchCategoryState>(
                builder: (context, state) {
                  if (state is FetchCategoryInProgress) {}
                  if (state is FetchCategoryFailure) {
                    return Center(
                      child: Text(state.errorMessage),
                    );
                  }
                  if (state is FetchCategorySuccess) {
                    return GridView.builder(
                      itemCount: state.categories.length,
                      shrinkWrap: true,
                      padding: const EdgeInsets.all(20.0),
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              mainAxisSpacing: 10,
                              crossAxisSpacing: 10,
                              crossAxisCount: 3),
                      itemBuilder: (context, index) {
                        return buildTypeCard(
                            index, context, state.categories[index]);
                      },
                    );
                  }
                  return Container();
                },
              ),
              buildTextField('Title', TextInputType.text, titleController),
              buildTextField('Price', TextInputType.number, priceController),
              buildTextField(
                  'Name', TextInputType.text, customerNameController),
              buildTextField('customerEmail', TextInputType.emailAddress,
                  customerEmailController),
              buildTextField('customerProfile', TextInputType.text,
                  customerProfileController),
              buildTextField('customerNumber', TextInputType.number,
                  customerNumberController),
              buildTextField(
                  'rentDuration', TextInputType.text, rentDurationController),
              buildTextField(
                  'category', TextInputType.text, categoryController),
              buildTextField(
                  'description', TextInputType.text, descriptionController),
              buildTextField('address', TextInputType.text, addressController),
              buildTextField(
                  'clientAddress', TextInputType.text, clientAddressController),
              buildTextField(
                  'propertyType', TextInputType.text, propertyTypeController),
              buildTextField(
                  'titleImage', TextInputType.text, titleImageController),
              buildTextField(
                  'postCreated', TextInputType.text, postCreatedController),
              buildTextField(
                  'totalView', TextInputType.text, totalViewController),
              buildTextField('status', TextInputType.text, statusController),
              buildTextField('state', TextInputType.text, state),
              buildTextField('city', TextInputType.text, cityController),
              buildTextField('country', TextInputType.text, countryController),
              buildTextField('addedBy', TextInputType.text, addedByController),
              buildTextField(
                  'isFavourite', TextInputType.text, isFavouriteController),
              buildTextField(
                  'latitude', TextInputType.text, latitudeController),
              buildTextField(
                  'longitude', TextInputType.text, longitudeController),
              buildTextField(
                  'threeDImag', TextInputType.text, threeDImageController),
              buildTextField('video', TextInputType.text, videoController),
              SizedBox(
                height: 10.rh(context),
              ),
              Row(
                children: [
                  Text(UiUtils.getTranslatedLabel(context, "uploadPictures")),
                  const SizedBox(
                    width: 3,
                  ),
                  Text("maxSize".translate(context))
                      .italic()
                      .size(context.font.small),
                ],
              ),
              SizedBox(
                height: 10.rh(context),
              ),
              Wrap(
                children: [
                  if (_pickTitleImage.pickedFile != null) ...[] else ...[],
                  titleImageListener(),
                ],
              ),
              SizedBox(
                height: 10.rh(context),
              ),
              Text(UiUtils.getTranslatedLabel(context, "otherPictures")),
              SizedBox(
                height: 10.rh(context),
              ),
              SizedBox(
                height: 10.rh(context),
              ),
              propertyImagesListener(),
              SizedBox(
                height: 10.rh(context),
              ),
              Text(UiUtils.getTranslatedLabel(context, "additionals")),
              SizedBox(
                height: 10.rh(context),
              ),
              // CustomTextFormField(
              //   // prefix: Text("${Constant.currencySymbol} "),
              //   controller: _videoLinkController,
              //   // isReadOnly: widget.properyDetails != null,
              //   hintText: "http://example.com/video.mp4",
              // ),
              SizedBox(
                height: 10.rh(context),
              ),
              DottedBorder(
                color: context.color.textLightColor,
                borderType: BorderType.RRect,
                radius: const Radius.circular(12),
                child: GestureDetector(
                  onTap: () {
                    _pick360deg.pick(pickMultiple: false);
                  },
                  child: Container(
                    clipBehavior: Clip.antiAlias,
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(10)),
                    alignment: Alignment.center,
                    height: 48.rh(context),
                    child: Text(UiUtils.getTranslatedLabel(
                        context, "add360degPicture")),
                  ),
                ),
              ),
              _pick360deg.listenChangesInUI((context, image) {
                if (image != null) {
                  return Stack(
                    children: [
                      Container(
                          width: 100,
                          height: 100,
                          margin: const EdgeInsets.all(5),
                          clipBehavior: Clip.antiAlias,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10)),
                          child: Image.file(
                            image,
                            fit: BoxFit.cover,
                          )),
                      Positioned.fill(
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(context, BlurredRouter(
                              builder: (context) {
                                return PanaromaImageScreen(
                                  imageUrl: image.path,
                                  isFileImage: true,
                                );
                              },
                            ));
                          },
                          child: Container(
                            width: 100,
                            margin: const EdgeInsets.all(5),
                            height: 100,
                            decoration: BoxDecoration(
                                color: context.color.teritoryColor.withOpacity(
                                  0.68,
                                ),
                                borderRadius: BorderRadius.circular(10)),
                            child: FittedBox(
                              fit: BoxFit.none,
                              child: Container(
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: context.color.secondaryColor,
                                ),
                                width: 60.rw(context),
                                height: 60.rh(context),
                                child: Center(
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      SizedBox(
                                          height: 30.rh(context),
                                          width: 40.rw(context),
                                          child: UiUtils.getSvg(
                                              AppIcons.v360Degree,
                                              color:
                                                  context.color.textColorDark)),
                                      Text(UiUtils.getTranslatedLabel(
                                              context, "view"))
                                          .color(context.color.textColorDark)
                                          .size(context.font.small)
                                          .bold()
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                }
              }),
              ElevatedButton(
                  onPressed: () async {
                    await addSampleProperty(PropertyModel(
                      title: titleController.text,
                      price: priceController.text,
                      customerName: customerNameController.text,
                      customerEmail: customerEmailController.text,
                      customerProfile: customerProfileController.text,
                      customerNumber: customerNumberController.text,
                      rentduration: rentDurationController.text,
                      // category : categoryController.text,
                      description: descriptionController.text,
                      address: addressController.text,
                      clientAddress: clientAddressController.text,
                      properyType: propertyTypeController.text,
                      titleImage: titleImageController.text,
                      titleimagehash: titleimagehashController.text,
                      postCreated: postCreatedController.text,
                      // totalView : totalViewController.text,
                      // status : statusController.text,
                      state: state.text,
                      city: cityController.text,
                      country: countryController.text,
                      // addedBy : addedByController.text,
                      // isFavourite : isFavouriteController.text,
                      latitude: latitudeController.text,
                      longitude: longitudeController.text,
                      threeDImage: threeDImageController.text,
                      video: videoController.text,
                    ));
                  },
                  child: Text('Add')),
            ],
          ),
        ),
      ),
    );
  }

  Widget titleImageListener() {
    return _pickTitleImage.listenChangesInUI((context, file) {
      Widget currentWidget = Container();
      if (titleImageURL != "") {
        currentWidget = GestureDetector(
          onTap: () {
            UiUtils.showFullScreenImage(context,
                provider: NetworkImage(titleImageURL));
          },
          child: Container(
            width: 100,
            height: 100,
            margin: const EdgeInsets.all(5),
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
            child: Image.network(
              titleImageURL,
              fit: BoxFit.cover,
            ),
          ),
        );
      }
      if (file is File) {
        currentWidget = GestureDetector(
          onTap: () {
            UiUtils.showFullScreenImage(context, provider: FileImage(file));
          },
          child: Column(
            children: [
              Container(
                  width: 100,
                  height: 100,
                  margin: const EdgeInsets.all(5),
                  clipBehavior: Clip.antiAlias,
                  decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(10)),
                  child: Image.file(
                    file,
                    fit: BoxFit.cover,
                  )),
            ],
          ),
        );
      }

      return Wrap(
        children: [
          if (file == null && titleImageURL == "")
            DottedBorder(
              color: context.color.textLightColor,
              borderType: BorderType.RRect,
              radius: const Radius.circular(12),
              child: GestureDetector(
                onTap: () {
                  _pickTitleImage.resumeSubscription();
                  _pickTitleImage.pick(pickMultiple: false);
                  _pickTitleImage.pauseSubscription();
                  titleImageURL = "";
                  setState(() {});
                },
                child: Container(
                  clipBehavior: Clip.antiAlias,
                  decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(10)),
                  alignment: Alignment.center,
                  height: 48.rh(context),
                  child: Text(
                      UiUtils.getTranslatedLabel(context, "addMainPicture")),
                ),
              ),
            ),
          Stack(
            children: [
              currentWidget,
              closeButton(context, () {
                _pickTitleImage.clearImage();
                titleImageURL = "";
                setState(() {});
              })
            ],
          ),
          if (file != null || titleImageURL != "")
            uploadPhotoCard(context, onTap: () {
              _pickTitleImage.resumeSubscription();
              _pickTitleImage.pick(pickMultiple: false);
              _pickTitleImage.pauseSubscription();
              titleImageURL = "";
              setState(() {});
            })
          // GestureDetector(
          //   onTap: () {
          //     _pickTitleImage.resumeSubscription();
          //     _pickTitleImage.pick(pickMultiple: false);
          //     _pickTitleImage.pauseSubscription();
          //     titleImageURL = "";
          //     setState(() {});
          //   },
          //   child: Container(
          //     width: 100,
          //     height: 100,
          //     margin: const EdgeInsets.all(5),
          //     clipBehavior: Clip.antiAlias,
          //     decoration:
          //         BoxDecoration(borderRadius: BorderRadius.circular(10)),
          //     child: DottedBorder(
          //         borderType: BorderType.RRect,
          //         radius: Radius.circular(10),
          //         child: Container(
          //           alignment: Alignment.center,
          //           child: Text("Upload \n Photo"),
          //         )),
          //   ),
          // ),
        ],
      );
    });
  }

  Widget propertyImagesListener() {
    return _propertisImagePicker.listenChangesInUI((context, file) {
      Widget current = Container();

      current = Wrap(
          children: mixedPropertyImageList
              .map((image) {
                return Stack(
                  children: [
                    GestureDetector(
                      onTap: () {
                        HelperUtils.unfocus();
                        if (image is String) {
                          UiUtils.showFullScreenImage(context,
                              provider: NetworkImage(image));
                          // } else {
                          //   UiUtils.showFullScreenImage(context,
                          //       provider: FileImage(image));
                        }
                      },
                      child: Container(
                          width: 100,
                          height: 100,
                          margin: const EdgeInsets.all(5),
                          clipBehavior: Clip.antiAlias,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: ImageAdapter(
                            image: image,
                          )),
                    ),

                    // Positioned(
                    //   right: 5,
                    //   top: 5,
                    //   child: Container(
                    //       width: 100,
                    //       height: 100,
                    //       margin: const EdgeInsets.all(5),
                    //       clipBehavior: Clip.antiAlias,
                    //       decoration: BoxDecoration(
                    //           borderRadius: BorderRadius.circular(10)),
                    //       child: Icon(Icons.close)),
                    // ),
                    closeButton(context, () {
                      mixedPropertyImageList.remove(image);

                      if (image is String) {
                        List<Gallery> properyDetail =
                            properyDetails['gallary_with_id']
                                as List<Gallery>;
                        var id = properyDetail
                            .where((element) => element.imageUrl == image)
                            .first
                            .id;

                        removedImageId.add(id);
                      }
                      setState(() {});
                    }),

                    // child: GestureDetector(
                    //   onTap: () {
                    //     mixedPropertyImageList.remove(image);
                    //     // removedImageId.add();
                    //
                    //     setState(() {});
                    //   },
                    //   child: Icon(
                    //     Icons.close,
                    //     color: context.color.secondaryColor,
                    //   ),
                    // ),
                    // )
                  ],
                );
              })
              .toList()
              .cast<Widget>());

      // if (propertyImageList.isEmpty && editPropertyImageList.isNotEmpty) {
      //   current = Wrap(
      //       children: editPropertyImageList
      //           .map((image) {
      //             log(image.runtimeType.toString());
      //             return Stack(
      //               children: [
      //                 GestureDetector(
      //                   onTap: () {
      //                     HelperUtils.unfocus();
      //                     UiUtils.showFullScreenImage(context,
      //                         provider: FileImage(image));
      //                   },
      //                   child: Container(
      //                       width: 100,
      //                       height: 100,
      //                       margin: const EdgeInsets.all(5),
      //                       clipBehavior: Clip.antiAlias,
      //                       decoration: BoxDecoration(
      //                           borderRadius: BorderRadius.circular(10)),
      //                       child: Image.network(
      //                         image,
      //                         fit: BoxFit.cover,
      //                       )),
      //                 ),
      //                 Positioned(
      //                   right: 5,
      //                   top: 5,
      //                   child: GestureDetector(
      //                     onTap: () {
      //                       editPropertyImageList.remove(image);
      //                       // removedImageId.add();
      //
      //                       setState(() {});
      //                     },
      //                     child: Icon(
      //                       Icons.close,
      //                       color: context.color.secondaryColor,
      //                     ),
      //                   ),
      //                 )
      //               ],
      //             );
      //           })
      //           .toList()
      //           .cast<Widget>());
      // }
      //
      // if (file is List<File>) {
      //   current = Wrap(
      //       children: propertyImageList
      //           .map((image) {
      //             return Stack(
      //               children: [
      //                 GestureDetector(
      //                   onTap: () {
      //                     HelperUtils.unfocus();
      //                     UiUtils.showFullScreenImage(context,
      //                         provider: FileImage(image));
      //                   },
      //                   child: Container(
      //                       width: 100,
      //                       height: 100,
      //                       margin: const EdgeInsets.all(5),
      //                       clipBehavior: Clip.antiAlias,
      //                       decoration: BoxDecoration(
      //                           borderRadius: BorderRadius.circular(10)),
      //                       child: Image.file(
      //                         image,
      //                         fit: BoxFit.cover,
      //                       )),
      //                 ),
      //                 closeButton(context, () {
      //                   propertyImageList.remove(image);
      //                   setState(() {});
      //                 })
      //               ],
      //             );
      //           })
      //           .toList()
      //           .cast<Widget>());
      // }

      return Wrap(
        runAlignment: WrapAlignment.start,
        children: [
          if (file == null && mixedPropertyImageList.isEmpty)
            DottedBorder(
              color: context.color.textLightColor,
              borderType: BorderType.RRect,
              radius: const Radius.circular(12),
              child: GestureDetector(
                onTap: () {
                  _propertisImagePicker.pick(pickMultiple: true);
                },
                child: Container(
                  clipBehavior: Clip.antiAlias,
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(10)),
                  alignment: Alignment.center,
                  height: 48.rh(context),
                  child: Text(
                      UiUtils.getTranslatedLabel(context, "addOtherPicture")),
                ),
              ),
            ),
          current,
          if (file != null || titleImageURL != "")
            uploadPhotoCard(context, onTap: () {
              _propertisImagePicker.pick(pickMultiple: true);
            })
        ],
      );
    });
  }

  Widget buildTypeCard(int index, BuildContext context, Category category) {
    return GestureDetector(
      onTap: () {
        selectedCategory = category;
        selectedIndex = index;
        setState(() {});
      },
      child: Container(
        decoration: BoxDecoration(
            color: (selectedIndex == index)
                ? context.color.teritoryColor
                : context.color.secondaryColor,
            borderRadius: BorderRadius.circular(10),
            boxShadow: (selectedIndex == index)
                ? [
                    BoxShadow(
                        offset: const Offset(1, 2),
                        blurRadius: 5,
                        color: context.color.teritoryColor)
                  ]
                : null,
            border: (selectedIndex == index)
                ? null
                : Border.all(color: context.color.borderColor, width: 1.5)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Icon(
            //   Icons.house,
            //   color: selectedIndex == index
            //       ? context.color.secondaryColor
            //       : context.color.teritoryColor,
            // ),
            SizedBox(
              height: 25.rh(context),
              width: 25.rw(context),
              child: UiUtils.imageType(category.image!,
                  color: selectedIndex == index
                      ? context.color.secondaryColor
                      : context.color.teritoryColor),
            ),

            Padding(
              padding: const EdgeInsets.all(2.0),
              child: Text(
                category.category!,
                textAlign: TextAlign.center,
              ).color(selectedIndex == index
                  ? context.color.secondaryColor
                  : context.color.teritoryColor),
            )
          ],
        ),
      ),
    );
  }

  Widget buildTextField(String label, TextInputType keyboardType,
      TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: TextFormField(
        keyboardType: keyboardType, //
        decoration: InputDecoration(
          labelText: label,
          //
          fillColor: context.color.textLightColor.withOpacity(00.01),
          focusedBorder: OutlineInputBorder(
              borderSide:
                  BorderSide(width: 1.5, color: context.color.teritoryColor),
              borderRadius: BorderRadius.circular(10)),
          enabledBorder: OutlineInputBorder(
              borderSide:
                  BorderSide(width: 1.5, color: context.color.borderColor),
              borderRadius: BorderRadius.circular(10)),
          border: OutlineInputBorder(
              borderSide:
                  BorderSide(width: 1.5, color: context.color.borderColor),
              borderRadius: BorderRadius.circular(10)),
        ),
        controller: controller, //
      ),
    );
  }
}
