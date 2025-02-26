// lib/views/discover/discover_view.dart
import 'package:diet_app_mobile/controller/discover/discover_controller.dart';
import 'package:diet_app_mobile/product/services/icon_and_image_services.dart';
import 'package:diet_app_mobile/product/utils/app_utils/const_utils/app_colors.dart';
import 'package:diet_app_mobile/product/utils/app_utils/const_utils/app_padding.dart';
import 'package:diet_app_mobile/product/utils/app_utils/const_utils/app_radius.dart';
import 'package:diet_app_mobile/product/widgets/general/custom_elevated_button.dart';
import 'package:diet_app_mobile/product/widgets/general/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class DiscoverView extends StatelessWidget {
  final DiscoverController discoverController = Get.put(DiscoverController());

  DiscoverView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.whiteSolid.getColor(),
      appBar: _buildAppBar(),
      body: Obx(() {
        return NotificationListener<ScrollNotification>(
          onNotification: discoverController.onNotification,
          child: ListView(
            children: [
              _buildPageGridViewBuilder(),
              if (discoverController.isLoading.value)
                _buildPageCircleProgressBar(),
            ],
          ),
        );
      }),
    );
  }

  GridView _buildPageGridViewBuilder() {
    return GridView.builder(
      padding: AppPadding.instance.verticalNormal,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
      ),
      itemCount: discoverController.items.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return Container(
          decoration: BoxDecoration(
            color: AppColor.orochimaru.getColor(),
            borderRadius: AppRadius.instance.normalBorderRadius,
          ),
          child: Center(child: Text(discoverController.items[index])),
        );
      },
    );
  }

  Padding _buildPageCircleProgressBar() {
    return Padding(
      padding: AppPadding.instance.bottomNormal,
      child: const SizedBox(
        height: 56,
        width: double.infinity,
        child: Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      elevation: 0,
      backgroundColor: AppColor.transparent.getColor(),
      automaticallyImplyLeading: false,
      title: CustomTextField(
        hintText: "Arama yapın",
        controller: TextEditingController(),
        showSearchIcon: true,
        height: 40,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Lütfen bir değer girin';
          }
          return null;
        },
        onSaved: (value) {
          // Değer kaydedildiğinde yapılacak işlemler
        },
        onSubmit: (value) {
          // Metin alanında "enter" tuşuna basıldığında yapılacak işlemler
        },
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 20, top: 8),
          child: CustomElevatedButton(
              backgroundColor: AppColor.transparent.getColor(),
              elevation: 0,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              height: 40,
              width: 40,
              child: SvgPicture.asset(
                AppIconUtility.getIconPath("more", format: IconFormat.svg),
              ),
              onPressed: () {}),
        )
      ],
    );
  }
}
