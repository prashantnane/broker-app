// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'dart:ui';

import 'package:ebroker/Ui/screens/widgets/like_button_widget.dart';
import 'package:ebroker/Ui/screens/widgets/promoted_widget.dart';
import 'package:ebroker/data/cubits/favorite/add_to_favorite_cubit.dart';
import 'package:ebroker/utils/AppIcon.dart';
import 'package:ebroker/utils/Extensions/extensions.dart';
import 'package:ebroker/utils/responsiveSize.dart';
import 'package:ebroker/utils/string_extenstion.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../../../data/model/property_model.dart';
import '../../../../../../../utils/constant.dart';
import '../../../../../../../utils/helper_utils.dart';
import '../../../../../../../utils/ui_utils.dart';
import '../../../../models/Property.dart';
import '../../widgets/likeButtonWidget.dart';

class PropertyHorizontalCardTest extends StatelessWidget {
  final Property? property;
  final List<Widget>? addBottom;
  final double? additionalHeight;
  final StatusButtonTest? statusButton;
  final Function(FavoriteType type)? onLikeChange;
  final bool? useRow;
  final bool? showDeleteButton;
  final VoidCallback? onDeleteTap;
  final double? additionalImageWidth;
  final bool? showLikeButton;
  const PropertyHorizontalCardTest(
      {super.key,
        required this.property,
        this.useRow,
        this.addBottom,
        this.additionalHeight,
        this.onLikeChange,
        this.statusButton,
        this.showDeleteButton,
        this.onDeleteTap,
        this.showLikeButton,
        this.additionalImageWidth});

  @override
  Widget build(BuildContext context) {
    String rentPrice = (property!.price!
        .priceFormate(
      disabled: Constant.isNumberWithSuffix == false,
    )
        .toString()
        .formatAmount(prefix: true));

    // Map<String, dynamic> decodedTitleImage = jsonDecode(property!.titleImage!);
    // print('decodedTitleImage : $decodedTitleImage');

    Map<String, dynamic> decodedCategory = jsonDecode(property!.category!);
    // print('decodedCategory : $decodedCategory');

    return BlocProvider(
      create: (context) => AddToFavoriteCubitCubit(),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4.5),
        child: GestureDetector(
          onLongPress: () {
            // HelperUtils.share(context, property.id!);
          },
          child: Container(
            height: addBottom == null ? 124 : (124 + (additionalHeight ?? 0)),
            decoration: BoxDecoration(
                border:
                Border.all(width: 1.5, color: context.color.borderColor),
                color: context.color.secondaryColor,
                borderRadius: BorderRadius.circular(18)),
            child: Stack(
              fit: StackFit.expand,
              children: [
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          Column(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(15),
                                child: Stack(
                                  children: [
                                    UiUtils.getImage(
                                      property!.titleImage! ?? "",
                                      height: statusButton != null ? 90 : 120,
                                      width: 100 + (additionalImageWidth ?? 0),
                                      fit: BoxFit.cover,
                                    ),

                                    // PositionedDirectional(
                                    //   bottom: 6,
                                    //   start: 6,
                                    //   child: Container(
                                    //     height: 19,
                                    //     clipBehavior: Clip.antiAlias,
                                    //     decoration: BoxDecoration(
                                    //         color: context.color.secondaryColor
                                    //             .withOpacity(0.7),
                                    //         borderRadius:
                                    //             BorderRadius.circular(4)),
                                    //     child: BackdropFilter(
                                    //       filter: ImageFilter.blur(
                                    //           sigmaX: 2, sigmaY: 3),
                                    //       child: Padding(
                                    //         padding: const EdgeInsets.symmetric(
                                    //             horizontal: 8.0),
                                    //         child: Center(
                                    //           child: Text(
                                    //             'nul'
                                    //           )
                                    //               .color(
                                    //                 context.color.textColorDark,
                                    //               )
                                    //               .bold()
                                    //               .size(context.font.smaller),
                                    //         ),
                                    //       ),
                                    //     ),
                                    //   ),
                                    // ),
                                  ],
                                ),
                              ),
                              if (statusButton != null)
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 3.0, horizontal: 3.0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: statusButton!.color,
                                        borderRadius: BorderRadius.circular(4)),
                                    width: 80,
                                    height: 120 - 90 - 8,
                                    child: Center(
                                        child: Text(statusButton!.lable)
                                            .size(context.font.small)
                                            .bold()
                                            .color(statusButton?.textColor ??
                                            Colors.black)),
                                  ),
                                )
                            ],
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(
                                top: 5,
                                left: 12,
                                bottom: 5,
                                right: 12,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                MainAxisAlignment.spaceEvenly,
                                children: [
                                  Row(
                                    children: [
                                      UiUtils.imageType(
                                          decodedCategory['image'] ?? "",
                                          width: 18,
                                          height: 18,
                                          color: context.color.teritoryColor),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      Expanded(
                                        child:
                                        Text(decodedCategory['category'])
                                            .setMaxLines(lines: 1)
                                            .size(
                                          context.font.small
                                              .rf(context),
                                        )
                                            .bold(
                                          weight: FontWeight.w400,
                                        )
                                            .color(
                                          context.color.textLightColor,
                                        ),
                                      ),
                                      if (showLikeButton ?? true)
                                        Container(
                                          width: 32,
                                          height: 32,
                                          decoration: BoxDecoration(
                                            color: context.color.secondaryColor,
                                            shape: BoxShape.circle,
                                            boxShadow: const [
                                              BoxShadow(
                                                color:
                                                Color.fromARGB(12, 0, 0, 0),
                                                offset: Offset(0, 2),
                                                blurRadius: 15,
                                                spreadRadius: 0,
                                              )
                                            ],
                                          ),
                                          child: LikeButtonWidgetTest(
                                            property: property,
                                            onLikeChanged: onLikeChange,
                                          ),
                                        ),
                                    ],
                                  ),

                                  Text(
                                    property!.price!
                                        .priceFormate(
                                        disabled:
                                        Constant.isNumberWithSuffix ==
                                            false)
                                        .toString()
                                        .formatAmount(
                                      prefix: true,
                                    ),
                                  )
                                      .size(context.font.large)
                                      .color(context.color.teritoryColor)
                                      .bold(weight: FontWeight.w700),

                                  Text(
                                    property!.title!.firstUpperCase(),
                                  )
                                      .setMaxLines(lines: 1)
                                      .size(context.font.large)
                                      .color(context.color.textColorDark),
                                  if (property!.city != "")
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.location_on,
                                          size: 16,
                                          color: context.color.textLightColor,
                                        ),
                                        Expanded(
                                          child: Text(
                                              property!.city?.trim() ?? "")
                                              .setMaxLines(lines: 1)
                                              .color(
                                              context.color.textLightColor),
                                        )
                                      ],
                                    )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    if (useRow == false || useRow == null) ...addBottom ?? [],

                    if (useRow == true) ...{Row(children: addBottom ?? [])}

                    // ...addBottom ?? []
                  ],
                ),
                if (showDeleteButton ?? false)
                  PositionedDirectional(
                    top: 32 * 2,
                    end: 12,
                    child: InkWell(
                      onTap: () {
                        onDeleteTap?.call();
                      },
                      child: Container(
                        width: 32,
                        height: 32,
                        decoration: BoxDecoration(
                          color: context.color.secondaryColor,
                          shape: BoxShape.circle,
                          boxShadow: const [
                            BoxShadow(
                                color: Color.fromARGB(33, 0, 0, 0),
                                offset: Offset(0, 2),
                                blurRadius: 15,
                                spreadRadius: 0)
                          ],
                        ),
                        child: SizedBox(
                          height: 24,
                          width: 24,
                          child: FittedBox(
                            fit: BoxFit.none,
                            child: SvgPicture.asset(
                              AppIcons.bin,
                              color: context.color.teritoryColor,
                              width: 18,
                              height: 18,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class StatusButtonTest {
  final String lable;
  final Color color;
  final Color? textColor;
  StatusButtonTest({
    required this.lable,
    required this.color,
    this.textColor,
  });
}
