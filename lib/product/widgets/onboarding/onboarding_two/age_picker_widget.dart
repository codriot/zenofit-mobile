import 'package:diet_app_mobile/product/controller/age_picker_controller.dart';
import 'package:diet_app_mobile/product/utils/app_utils/const_utils/app_colors.dart';
import 'package:diet_app_mobile/product/utils/app_utils/const_utils/app_padding.dart';
import 'package:diet_app_mobile/product/utils/app_utils/const_utils/app_radius.dart';
import 'package:diet_app_mobile/product/widgets/general/general_shadow_components.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class AgePickerWidget extends StatelessWidget {
  AgePickerWidget({super.key});

  final AgePickerController controller = Get.put(AgePickerController());

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: AppPadding.instance.verticalLarge,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              // ListView (Yaşlar)
              Container(
                height: 350,
                width: 145,
                decoration: BoxDecoration(
                  color: AppColor.crystalBell.getColor(),
                  borderRadius: AppRadius.instance.largeBorderRadius,
                  boxShadow: [generalComponentsShadow()],
                ),
                child: NotificationListener<ScrollNotification>(
                  onNotification: (scrollNotification) {
                    if (scrollNotification is ScrollUpdateNotification) {
                      controller.onScrollUpdate();
                    } else if (scrollNotification is ScrollEndNotification) {
                      controller.onScrollEnd();
                    }
                    return true;
                  },
                  child: ListView.builder(
                    controller: controller.scrollController,
                    itemCount: 100,
                    itemExtent: controller.itemHeight,
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (context, index) {
                      return Obx(() {
                        // TextStyle'ı controller'dan al
                        final textStyle = controller.getTextStyleForAge(index);
                        final fontSize = textStyle['fontSize'];
                        final fontWeight = textStyle['fontWeight'];
                        final isSelected = index == controller.selectedAge.value;
                        final textColor = isSelected
                            ? AppColor.vividBlue.getColor()
                            : AppColor.black.getColor();

                        return Center(
                          child: Text(
                            "$index",
                            style: TextStyle(
                              fontSize: fontSize,
                              fontWeight: fontWeight,
                              color: textColor,
                            ),
                          ),
                        );
                      });
                    },
                  ),
                ),
              ),
              Positioned(
                top: 150,
                left: 0,
                right: 0,
                child: Container(
                  height: 2,
                  color: AppColor.black.getColor(),
                ),
              ),
              Positioned(
                bottom: 150,
                left: 0,
                right: 0,
                child: Container(
                  height: 2,
                  color: AppColor.black.getColor(),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

