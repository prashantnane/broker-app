import 'package:flutter/material.dart';

import '../../../utils/hive_utils.dart';

class ProfileDetailsScreen extends StatefulWidget {
  const ProfileDetailsScreen({super.key});

  @override
  State<ProfileDetailsScreen> createState() => _ProfileDetailsScreenState();
}

class _ProfileDetailsScreenState extends State<ProfileDetailsScreen> {
  String name = (HiveUtils.getUserDetails().name) ?? "";
  String email = HiveUtils.getUserDetails().email ?? "";
  String phone = HiveUtils.getUserDetails().mobile ?? "";
  String address = HiveUtils.getUserDetails().address ?? "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Profile'),),
      body: SafeArea(
        child: Center(
          child: Align(
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 1,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: 20),
                      height: 400,
                      width: double.infinity,
                      decoration: ShapeDecoration(
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50),
                        ),
                        shadows: const [
                          BoxShadow(
                            color: Color(0x3F000000),
                            blurRadius: 17,
                            offset: Offset(0, 11),
                            spreadRadius: 0,
                          )
                        ],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding:
                            const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                // const CircleAvatar(
                                //   backgroundImage: AssetImage(
                                //     'assets/images/user.png',
                                //   ),
                                //   radius: 30,
                                // ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  '$name',
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 25,
                                    fontFamily: 'Jaldi',
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                const SizedBox(height: 10),

                                Column(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'Contact no: ',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 15,
                                        fontFamily: 'Jaldi',
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    Text(
                                      '$phone',
                                      style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 15,
                                        fontFamily: 'Jaldi',
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    const Text(
                                      'Email : ',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 15,
                                        fontFamily: 'Jaldi',
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    Text(
                                      '$email',
                                      style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 15,
                                        fontFamily: 'Jaldi',
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Container(
                            width: 200,
                            padding: const EdgeInsets.all(15.0),
                            child: Directionality(
                              textDirection: TextDirection.rtl,
                              child: ElevatedButton.icon(
                                onPressed: () async {
                                  // await Amplify.Auth.signOut();
                                },
                                label: const Text(
                                  'Logout',
                                  style: TextStyle(fontSize: 15),
                                ),
                                icon: const Icon(
                                  Icons.logout_outlined,
                                  size: 25,
                                ),
                                style: ElevatedButton.styleFrom(
                                  padding: const EdgeInsets.all(15),
                                  backgroundColor: Colors.redAccent,
                                  foregroundColor: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
