import 'package:ebroker/data/model/property_model.dart';
import 'package:ebroker/utils/Extensions/extensions.dart';
import 'package:flutter/material.dart';

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
              buildTextField('Title', TextInputType.text, titleController),
              buildTextField('Price', TextInputType.number, priceController),
              buildTextField('Name', TextInputType.text, customerNameController),
              buildTextField('customerEmail', TextInputType.emailAddress, customerEmailController),
              buildTextField('customerProfile', TextInputType.text, customerProfileController),
              buildTextField('customerNumber', TextInputType.number, customerNumberController),
              buildTextField('rentDuration', TextInputType.text, rentDurationController),
              buildTextField('category', TextInputType.text, categoryController),
              buildTextField('description', TextInputType.text, descriptionController),
              buildTextField('address', TextInputType.text, addressController),
              buildTextField('clientAddress', TextInputType.text, clientAddressController),
              buildTextField('propertyType', TextInputType.text, propertyTypeController),
              buildTextField('titleImage', TextInputType.text, titleImageController),
              buildTextField('postCreated', TextInputType.text, postCreatedController),
              buildTextField('totalView', TextInputType.text, totalViewController),
              buildTextField('status', TextInputType.text, statusController),
              buildTextField('state', TextInputType.text, state),
              buildTextField('city', TextInputType.text, cityController),
              buildTextField('country', TextInputType.text, countryController),
              buildTextField('addedBy', TextInputType.text, addedByController),
              buildTextField('isFavourite', TextInputType.text, isFavouriteController),
              buildTextField('latitude', TextInputType.text, latitudeController),
              buildTextField('longitude', TextInputType.text, longitudeController),
              buildTextField('threeDImag', TextInputType.text, threeDImageController),
              buildTextField('video', TextInputType.text, videoController),
              ElevatedButton(
                  onPressed: () async {
                    await addSampleProperty(
                        PropertyModel(
                          title: titleController.text,
                            price : priceController.text,
                             customerName : customerNameController.text,
                         customerEmail : customerEmailController.text,
                     customerProfile: customerProfileController.text,
                     customerNumber : customerNumberController.text,
                     rentduration : rentDurationController.text,
                     // category : categoryController.text,
                     description : descriptionController.text,
                     address:addressController.text,
                     clientAddress : clientAddressController.text,
                          properyType : propertyTypeController.text,
                     titleImage : titleImageController.text,
                     titleimagehash :titleimagehashController.text,
                     postCreated : postCreatedController.text,
                     // totalView : totalViewController.text,
                     // status : statusController.text,
                     state : state.text,
                     city: cityController.text,
                     country : countryController.text,
                     // addedBy : addedByController.text,
                     // isFavourite : isFavouriteController.text,
                     latitude :latitudeController.text,
                     longitude: longitudeController.text,
                     threeDImage : threeDImageController.text,
                     video : videoController.text,
                        ));
                  },
                  child: Text('Add')),
            ],
          ),
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
