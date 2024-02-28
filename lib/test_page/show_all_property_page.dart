import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../Ui/screens/home/Widgets/property_horizontal_card.dart';
import '../Ui/screens/home/home_screen.dart';
import '../Ui/screens/widgets/shimmerLoadingContainer.dart';
import '../data/model/property_model.dart';
import '../exports/main_export.dart';
import '../utils/helper_utils.dart';
import 'db.dart';
import 'fetch_all_properties.dart';

class ShowAllPropertyPage extends StatefulWidget {
  const ShowAllPropertyPage({super.key});

  @override
  State<ShowAllPropertyPage> createState() => _ShowAllPropertyPageState();
}

class _ShowAllPropertyPageState extends State<ShowAllPropertyPage> {
  TextEditingController emailController = TextEditingController();

  @override
  void initState() {
    fetchData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('All Properties')),
        body:

            // Use the data to build your UI
            // return Column(
            //
            //   children: [
            //     ListView.builder(
            //       shrinkWrap: true,
            //       itemCount: snapshot.data!.docs.length,
            //       itemBuilder: (context, index) {
            //         var user = snapshot.data!.docs[index];
            //         return ListTile(
            //           title: Text(user['title']),
            //           subtitle: Text(user['customerEmail']),
            //         );
            //       },
            //     ),
            //   ],
            // );
            LayoutBuilder(builder: (context, c) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: sidePadding),
            child: BlocBuilder<FetchRecentPropertiesCubit,
                FetchRecentPropertiesState>(builder: (context, state) {
              log("STATE IS $state");
              if (state is FetchRecentPropertiesInProgress) {
                return ListView.builder(
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Row(
                        children: [
                          const ClipRRect(
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            borderRadius: BorderRadius.all(Radius.circular(15)),
                            child: CustomShimmer(height: 90, width: 90),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                const SizedBox(
                                  height: 10,
                                ),
                                CustomShimmer(
                                  height: 10,
                                  width: c.maxWidth - 100,
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                const CustomShimmer(
                                  height: 10,
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                CustomShimmer(
                                  height: 10,
                                  width: c.maxWidth / 1.2,
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                CustomShimmer(
                                  height: 10,
                                  width: c.maxWidth / 4,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                  shrinkWrap: true,
                  itemCount: 5,
                );
              }

              if (state is FetchRecentPropertiesSuccess) {
                return ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    PropertyModel modal = state.properties[index];
                    modal = context.watch<PropertyEditCubit>().get(modal);
                    return GestureDetector(
                        onTap: () {
                          HelperUtils.goToNextPage(
                            Routes.propertyDetails,
                            context,
                            false,
                            args: {
                              'propertyData': modal,
                              'propertiesList': state.properties,
                              'fromMyProperty': false,
                            },
                          );
                        },
                        child: PropertyHorizontalCard(
                          property: modal,
                          additionalImageWidth: 10,
                        ));
                  },
                  itemCount: state.properties.length.clamp(0, 4),
                  shrinkWrap: true,
                );
              }
              if (state is FetchRecentPropertiesFailur) {
                return Container();
              }

              return Container();
            }),
          );
        }));
  }
}
