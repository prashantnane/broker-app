import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ebroker/utils/Extensions/extensions.dart';
import 'package:flutter/material.dart';

import '../Ui/screens/home/Widgets/property_horizontal_card.dart';
import '../Ui/screens/home/home_screen.dart';
import '../Ui/screens/widgets/shimmerLoadingContainer.dart';
import '../data/cubits/category/fetch_category_cubit.dart';
import '../data/model/property_model.dart';
import '../exports/main_export.dart';
import '../utils/helper_utils.dart';
import 'db.dart';
import 'fetch_all_properties.dart';

class ShowCategoryPage extends StatefulWidget {
  const ShowCategoryPage({super.key});

  @override
  State<ShowCategoryPage> createState() => _ShowCategoryPageState();
}

class _ShowCategoryPageState extends State<ShowCategoryPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('All Category')),
      body: BlocBuilder<FetchCategoryCubit, FetchCategoryState>(
        builder: (context, state) {
          if (state is FetchCategoryInitial) {
            // Initial state, maybe show a loading indicator
            return CircularProgressIndicator();
          } else if (state is FetchCategorySuccess) {
            // Categories loaded, display them
            final categories = state.categories;
            return ListView.builder(
              itemCount: categories.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(categories[index].category.toString()),
                  // Additional details or actions...
                );
              },
            );
          } else {
            // Other states (handle as needed)
            return SizedBox.shrink();
          }
        },
      ),

    );
  }
}
