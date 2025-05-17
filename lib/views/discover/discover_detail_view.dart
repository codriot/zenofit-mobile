import 'package:diet_app_mobile/controller/discover/discover_detail_controller.dart';
import 'package:diet_app_mobile/model/discover/discover_item_model.dart';
import 'package:diet_app_mobile/product/services/icon_and_image_services.dart';
import 'package:diet_app_mobile/product/utils/app_utils/app_general.dart';
import 'package:diet_app_mobile/product/utils/app_utils/app_spaces..dart';
import 'package:diet_app_mobile/product/utils/app_utils/const_utils/app_colors.dart';
import 'package:diet_app_mobile/product/utils/app_utils/const_utils/app_duration.dart';
import 'package:diet_app_mobile/product/utils/app_utils/const_utils/app_padding.dart';
import 'package:diet_app_mobile/product/utils/app_utils/const_utils/app_sizes.dart';
import 'package:diet_app_mobile/product/widgets/general/custom_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class DiscoverDetailView extends StatelessWidget {
  DiscoverDetailView({
    super.key,
  });
  final DiscoverDetailController controller =
      Get.put(DiscoverDetailController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.whiteSolid.getColor(),
      appBar: _buildPageAppBar(context),
      body: SizedBox(
        height: Get.height,
        child: Obx(
          () => ListView.builder(
            padding: EdgeInsets.zero,
            itemCount: controller.itemsLenght.value,
            itemBuilder: (context, index) => Padding(
              padding: AppPadding.instance.bottomMedium,
              child: controller.item.type == "post"
                  ? _buildPagePostComponent(context, controller.item, index)
                  : _buildPageVideoComponent(context, controller.item, index),
            ),
          ),
        ),
      ),
    );
  }

  AppBar _buildPageAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: AppColor.whiteSolid.getColor(),
      title: Text(
        'Keşfet',
        style: context.appGeneral.textTheme.headlineMedium
            ?.copyWith(fontWeight: FontWeight.bold),
      ),
      leading: IconButton(
        icon: SvgPicture.asset(AppIconUtility.getIconPath("arrow-left-line",
            format: IconFormat.svg)),
        onPressed: () => Navigator.pop(context),
      ),
    );
  }

  Column _buildPagePostComponent(
      BuildContext context, DiscoverItemModel item, int index) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: AppPadding.instance.bottomSmall,
          child: Row(
            children: [
              CircleAvatar(
                radius: 24,
                backgroundColor: AppColor.white.getColor(),
                child: Image.asset(
                  AppImageUtility.getImagePath("avatar"),
                  width: 40,
                  height: 40,
                ),
              ),
              Column(
                children: [
                  Text(
                    "Furkan Yıldırım",
                    style: context.appGeneral.textTheme.bodyMedium
                        ?.copyWith(fontWeight: FontWeight.bold),
                  ),
                ],
              )
            ],
          ),
        ),
        // Resim
        Image.network(
          item.imageUrl,
          fit: BoxFit.cover,
          width: Get.width,
          height: Get.width,
        ),
        AppSpaces.instance.vertical10,

        // Başlık ve Açıklama
        Padding(
          padding: AppPadding.instance.horizontalMedium,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  SvgPicture.asset(AppIconUtility.getIconPath("heart-line",
                      format: IconFormat.svg)),
                  AppSpaces.instance.horizontal5,
                  Text('${item.likeCount}'),
                ],
              ),
              AppSpaces.instance.horizontal30,
              GestureDetector(
                onTap: () {
                  controller.showCommentsBottomSheet(context, item); // Yorumları gösteren BottomSheet'i aç
                },
                child: Row(
                  children: [
                    SvgPicture.asset(AppIconUtility.getIconPath("chat",
                        format: IconFormat.svg)),
                    AppSpaces.instance.horizontal5,
                    Text('${item.commentCount}'),
                  ],
                ),
              ),
              AppSpaces.instance.space,
              SvgPicture.asset(
                AppIconUtility.getIconPath("save", format: IconFormat.svg),
              ),
            ],
          ),
        ),
        // Açıklama
        AppSpaces.instance.vertical5,
        Padding(
          padding: AppPadding.instance.horizontalMedium,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AnimatedContainer(
                duration: AppDuration.instance.durationFast,
                child: Obx(() => Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Furkan Yıldırım",
                          style: context.appGeneral.textTheme.labelLarge
                              ?.copyWith(fontWeight: FontWeight.bold),
                        ),
                        AppSpaces.instance.horizontal10,
                        Text(
                          item.description,
                          maxLines: controller.isExpandedList[index] ? null : 1,
                          overflow: controller.isExpandedList[index]
                              ? TextOverflow.visible
                              : TextOverflow.ellipsis,
                          style: context.appGeneral.textTheme.labelLarge,
                        ),
                      ],
                    )),
              ),
              InkWell(
                  onTap: () {
                    controller.toggleExpand(index);
                  },
                  child: Obx(() => Text(
                        controller.isExpandedList[index] ? 'Kapat' : 'Devamı',
                        style: context.appGeneral.textTheme.bodyMedium
                            ?.copyWith(color: AppColor.vividBlue.getColor()),
                      ))),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildPageVideoComponent(
      BuildContext context, DiscoverItemModel item, int index) {
    return Column(
      children: [
        Stack(
          clipBehavior: Clip.none,
          children: [
            Image.network(
              item.imageUrl,
              fit: BoxFit.cover,
              width: Get.width,
              height: _buildGetDynamicVideoImageHeight,
            ),
            Padding(
              padding: AppPadding.instance.allSmall,
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 24,
                    backgroundColor: AppColor.white.getColor(),
                    child: Image.asset(
                      AppImageUtility.getImagePath("avatar"),
                      width: 40,
                      height: 40,
                    ),
                  ),
                  AppSpaces.instance.horizontal10,
                  Text(
                    "Furkan Yıldırım",
                    style: context.appGeneral.textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: AppColor.white.getColor(),
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              bottom: 0,
              right: 0,
              child: Padding(
                padding: AppPadding.instance.allMedium,
                child: CustomElevatedButton(
                  onPressed: () {
                    controller.toggleSound(); // Ses açma/kapatma işlemi
                  },
                  width: 40,
                  height: 40,
                  elevation: 0,
                  backgroundColor: AppColor.white.getColor(),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  child: Obx(
                    () => SvgPicture.asset(
                      controller.isSoundOn.value // Ses durumu kontrolü
                          ? AppIconUtility.getIconPath("volume-down",
                              format: IconFormat.svg) // Ses açık ikonu
                          : AppIconUtility.getIconPath("volume-mute",
                              format: IconFormat.svg), // Ses kapalı ikonu
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        // Başlık ve Açıklama
        Container(
          margin: AppPadding.instance.verticalNormal,
          height: Get.height * 0.034,
          child: Padding(
            padding: AppPadding.instance.horizontalMedium,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    SvgPicture.asset(AppIconUtility.getIconPath("heart-line",
                        format: IconFormat.svg)),
                    AppSpaces.instance.horizontal5,
                    Text('${item.likeCount}'),
                  ],
                ),
                AppSpaces.instance.horizontal30,
                GestureDetector(
                  onTap: (){
                    controller.showCommentsBottomSheet(context, item);
                  },
                  child: Row(
                    children: [
                      SvgPicture.asset(AppIconUtility.getIconPath("chat",
                          format: IconFormat.svg)),
                      AppSpaces.instance.horizontal5,
                      Text('${item.commentCount}'),
                    ],
                  ),
                ),
                AppSpaces.instance.space,
                SvgPicture.asset(
                  AppIconUtility.getIconPath("save", format: IconFormat.svg),
                ),
              ],
            ),
          ),
        ),
        // Açıklama
        Padding(
          padding: AppPadding.instance.horizontalMedium,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AnimatedContainer(
                duration: AppDuration.instance.durationFast,
                child: Obx(() => Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Furkan Yıldırım",
                          style: context.appGeneral.textTheme.labelLarge
                              ?.copyWith(fontWeight: FontWeight.bold),
                        ),
                        AppSpaces.instance.horizontal10,
                        Text(
                          item.description,
                          maxLines: controller.isExpandedList[index] ? null : 1,
                          overflow: controller.isExpandedList[index]
                              ? TextOverflow.visible
                              : TextOverflow.ellipsis,
                          style: context.appGeneral.textTheme.labelLarge,
                        ),
                      ],
                    )),
              ),
              InkWell(
                  onTap: () {
                    controller.toggleExpand(index);
                  },
                  child: Obx(() => Text(
                        controller.isExpandedList[index] ? 'Kapat' : 'Devamı',
                        style: context.appGeneral.textTheme.bodyMedium
                            ?.copyWith(color: AppColor.vividBlue.getColor()),
                      ))),
            ],
          ),
        ),
      ],
    );
  }

  double get _buildGetDynamicVideoImageHeight =>
      Get.height -
      AppBar().preferredSize.height -
      AppSizes.instance.mediumValue -
      Get.height * 0.034 -
      2 * AppSizes.instance.normalValue;
}
