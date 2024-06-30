import 'dart:convert';
import 'dart:io';

import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_core/amplify_core.dart';
import 'package:amplify_storage_s3/amplify_storage_s3.dart';
import 'package:ebroker/exports/main_export.dart';
import 'package:aws_common/vm.dart';
import 'package:ebroker/main.dart';
import 'package:ebroker/test_page/add_property_page.dart';
import 'package:ebroker/test_page/db.dart';
import 'package:ebroker/Ui/screens/home/show_all_property_page.dart';
import 'package:ebroker/test_page/show_category_page.dart';
import 'package:ebroker/test_page/verification_screen.dart';
import 'package:flutter/material.dart';

import '../app/routes.dart';
import '../data/cubits/category/fetch_category_cubit.dart';
import '../data/Repositories/category_repository.dart';
import '../data/cubits/property/add_property_cubit.dart';
import '../models/Property.dart';
import '../utils/convertJsonToAwsJson.dart';

class TestPage extends StatefulWidget {
  const TestPage({super.key});

  @override
  State<TestPage> createState() => _TestPageState();
}

Future<void> publishSNSMessage() async {
  try {
    // Replace 'your-topic-arn' with the ARN of your SNS topic
    final topicArn = 'arn:aws:sns:ap-south-1:381492011065:propertyKar.fifo';
    final message = 'Hello from Flutter!';

    final response = await Amplify.API.mutate(
      request: GraphQLRequest<String>(
        document: '''
            mutation PublishSNSMessage(\$topicArn: String!, \$message: String!) {
              publishSNSMessage(topicArn: \$topicArn, message: \$message)
            }
          ''',
        variables: {'topicArn': topicArn, 'message': message},
      ),
    );

    print('SNS Message published successfully. Response: $response');
  } catch (e) {
    print('Error publishing SNS message: $e');
  }
}

// Future<void> uploadFileToS3(String filePath, String s3Key) async {
//   try {
//     final localFile = File(filePath);
//
//     // Upload file to S3
//     final result = await Amplify.Storage.uploadFile(
//       key: s3Key, // Unique key for your S3 object
//       localFile: AWSFilePlatform.fromFile(localFile),
//     );
//
//     print('File uploaded to S3 successfully.');
//   } catch (e) {
//     print('Error uploading file to S3: $e');
//   }
// }

class _TestPageState extends State<TestPage> {
  final CategoryRepository categoryRepository = CategoryRepository();
  final TextEditingController phoneNumberController = TextEditingController();
  String? imageUrl;

  @override
  void initState() {
    super.initState();
    fetchImageUrl();
  }

  Future<void> fetchImageUrl() async {
    String? url =
        await context.read<AddPropertyCubit>().getDownloadUrl('acbaf_262');
    setState(() {
      imageUrl = url;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Test Page'),
      ),
      body: Column(
        children: [
          Container(child: Center(child: Text('This is a test page'))),
          SizedBox(height: 10),
          ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  Routes.selectPropertyTypeScreen,
                );
              },
              child: Text('Add Sample Property')),
          SizedBox(height: 10),
          ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) =>
                            ShowAllPropertyPage()));
              },
              child: Text('Show all Properties')),
          SizedBox(height: 10),
          ElevatedButton(
              onPressed: () {
                // uploadFileToS3(
                //     '/data/user/0/com.ebroker.wrteam/cache/9c1d9c99-dcc6-4cc9-84f7-855a2e607a83/1000060214.jpg',
                //     'upload/file.png');
              },
              child: Text('Show all Categories')),
          SizedBox(height: 10),
          Center(
            child: ElevatedButton(
              onPressed: () async {
                await publishSNSMessage();
              },
              child: Text('Publish SNS Message'),
            ),
          ),
          TextField(
            controller: phoneNumberController,
            decoration: InputDecoration(labelText: 'Phone Number'),
          ),
          SizedBox(height: 16),
          ElevatedButton(
            onPressed: () async {
              final CategoryRepository _categoryRepository =
                  CategoryRepository();
              Map<String, dynamic> categoryJson = await _categoryRepository
                  .fetchCategoryById("9fec9628-4375-4c3a-b79c-8a27915b6865");
              // String categoryAwsJson = mapToEscapedJson(categoryJson);

              print('this is category data: $categoryJson');

              final newData = Property(
                title: "parameters['title']",
                price: "parameters['price']",
                brokerName: "parameters['title']",
                brokerEmail: "parameters['title']",
                brokerProfile: "parameters['title']",
                brokerNumber: "parameters['title']",
                category: json.encode(categoryJson),
                // unitType: UnitType.fromMap(
                //   {"id": 13, "measurement": "land"},
                // ),
                description: "parameters['description']",
                address: "parameters['address']",
                clientAddress: "parameters['client_address']",
                titleImage: "titleImage",
                postCreated: "parameters['title']",
                gallery: ["parameters[gallery_images]"],

                state: "parameters['state']",
                city: "parameters['city']",
                country: "parameters['country']",
                addedBy: 10,
                isFavourite: false,
                isInterested: false,
                // parameters: [
                //   Parameter.fromMap(
                //     {
                //       "id": 13,
                //       "name": "Land",
                //       "typeOfParameter": "land",
                //       "typeValues": '',
                //       "image": "",
                //       "value": 5,
                //     },
                //   )
                // ],
                // assignedOutdoorFacility: [
                //   AssignedOutdoorFacility.fromJson(
                //     {
                //       "id": 13,
                //       "name": "Land",
                //       "propertyId": 0,
                //       "facilityId": 0,
                //       "distance": 0,
                //       "image": "",
                //       "createdAt": "",
                //       "updatedAt": "",
                //     },
                //   )
                // ],
                video: "parameters['video_link']",
              );
              context.read<AddPropertyCubit>().addProperty(context, newData);
            },
            child: Text('add data'),
          ),
          // imageUrl != null
          //     ? Center(child: Image.network(imageUrl!))
          //     : CircularProgressIndicator(),
        ],
      ),
    );
  }

  Future<void> signUpWithPhoneNumber(String phoneNumber) async {
    try {
      // Start the sign-up process
      final SignUpResult res = await Amplify.Auth.signUp(
        username: phoneNumber,
        password: 'prashant',
        options: SignUpOptions(
          userAttributes: {
            CognitoUserAttributeKey.email: 'naneprashant99@gmail.com',
            CognitoUserAttributeKey.phoneNumber: phoneNumber
          },
        ),
      );

      // If signUp is successful, navigate to the verification screen
      if (res.isSignUpComplete) {
        // Navigate to the verification screen
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => VerificationScreen(phoneNumber: phoneNumber),
          ),
        );
      }
    } catch (e) {
      print('Error signing up: $e');
    }
  }
}
