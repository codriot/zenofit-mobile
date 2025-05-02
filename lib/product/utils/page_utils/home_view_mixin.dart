import 'package:diet_app_mobile/controller/home/home_view_controller.dart'
    show ExpansionSection, HomeViewController;
import 'package:diet_app_mobile/product/navigator/navigate_route_items.dart';
import 'package:diet_app_mobile/product/navigator/navigator_controller.dart';
import 'package:diet_app_mobile/product/utils/app_utils/app_general.dart';
import 'package:diet_app_mobile/product/utils/app_utils/app_spaces..dart';
import 'package:diet_app_mobile/product/utils/app_utils/const_utils/app_colors.dart';
import 'package:diet_app_mobile/product/utils/app_utils/const_utils/app_padding.dart';
import 'package:diet_app_mobile/product/utils/app_utils/const_utils/app_radius.dart';
import 'package:diet_app_mobile/product/widgets/general/custom_elevated_button.dart';
import 'package:diet_app_mobile/product/widgets/home/expantion_tile_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:diet_app_mobile/product/services/icon_and_image_services.dart';
import 'package:get/get.dart';

mixin HomeViewMixin {
  Widget buildHeader(BuildContext context) {
    return Row(
      children: [
        Container(
          width: Get.height * 0.07,
          decoration: BoxDecoration(
              shape: BoxShape.circle, color: AppColor.crystalBell.getColor()),
          margin: AppPadding.instance.rightNormal,
          child: Image.asset(AppImageUtility.getImagePath("avatar")),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                SvgPicture.asset(
                    AppIconUtility.getIconPath("hand", format: IconFormat.svg)),
                Padding(
                  padding: AppPadding.instance.leftSmall,
                  child: Text('Selam Furkan',
                      style: context.appGeneral.textTheme.titleSmall
                          ?.copyWith(fontWeight: FontWeight.w500)),
                ),
              ],
            ),
            Text('Bugünkü Diyetini kontrol et!',
                style: context.appGeneral.textTheme.bodyLarge),
          ],
        ),
        const Spacer(),
        InkWell(
          borderRadius: BorderRadius.circular(32),
          onTap: () {
            NavigatorController.instance.pushToPage(NavigateRoutesItems.chat);
          },
          child: Container(
            decoration: BoxDecoration(
                color: AppColor.crystalBell.getColor(), shape: BoxShape.circle),
            padding: AppPadding.instance.allSmall,
            child: SvgPicture.asset(
              AppIconUtility.getIconPath("message", format: IconFormat.svg),
            ),
          ),
        ),
      ],
    );
  }

  Widget buildNutritionSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: AppPadding.instance.bottomNormal,
          child: Text('Alınan Besin',
              style: context.appGeneral.textTheme.titleLarge
                  ?.copyWith(fontWeight: FontWeight.bold)),
        ),
        Container(
          padding: AppPadding.instance.allNormal,
          decoration: BoxDecoration(
            color: AppColor.white.getColor(),
            borderRadius: AppRadius.instance.halfBorderRadius,
            boxShadow: [
              BoxShadow(
                color: AppColor.crystalBell.getColor(),
                spreadRadius: 1,
                blurRadius: 2,
                offset: const Offset(0, 1),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Bugün, 8 Haziran',
                style: context.appGeneral.textTheme.bodyLarge
                    ?.copyWith(color: AppColor.grey.getColor()),
              ),
              Row(
                children: [
                  Text(
                    '30',
                    style: context.appGeneral.textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: AppColor.vividBlue.getColor()),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8),
                    child: Text(
                      '% 100',
                      style: context.appGeneral.textTheme.titleLarge
                          ?.copyWith(color: AppColor.grey.getColor()),
                    ),
                  ),
                ],
              ),
              LinearProgressIndicator(
                value: 0.3,
                backgroundColor: AppColor.bleachedSilk.getColor(),
                valueColor: AlwaysStoppedAnimation<Color>(
                    AppColor.vividBlue.getColor()),
                minHeight: 8,
                borderRadius: BorderRadius.circular(4),
              ),
            ],
          ),
        ),
        AppSpaces.instance.vertical20,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: buildNutritionCard(
                  'Kalori', '2500 Cal', AppColor.noxious.getColor(), context),
            ),
            AppSpaces.instance.horizontal10,
            Expanded(
              child: buildNutritionCard('Protein', '2500 Cal',
                  AppColor.sweetPatato.getColor(), context),
            ),
          ],
        ),
        AppSpaces.instance.vertical10,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: buildNutritionCard('Karbonhidrat', '2500 Cal',
                  AppColor.vividBlue.getColor(), context),
            ),
            AppSpaces.instance.horizontal10,
            Expanded(
              child: buildNutritionCard('Yağ', '2500 Cal',
                  AppColor.vaporwaweBlue.getColor(), context),
            ),
          ],
        ),
        AppSpaces.instance.vertical15,
        CustomElevatedButton(
          onPressed: () {
            NavigatorController.instance
                .pushToPage(NavigateRoutesItems.addMeal);
          },
          width: double.infinity,
          height: Get.height * 0.07,
          elevation: 0,
          backgroundColor: AppColor.noxious.getColor(),
          shape: RoundedRectangleBorder(
            borderRadius: AppRadius.instance.halfBorderRadius,
          ),
          child: Text(
            "+ Öğün Ekle",
            style: context.appGeneral.textTheme.titleLarge?.copyWith(
                color: AppColor.white.getColor(), fontWeight: FontWeight.bold),
          ),
        )
      ],
    );
  }

  Widget buildNutritionCard(
      String title, String value, Color color, BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 4,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 4),
          Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: color,
                    width: 4,
                  ),
                ),
              ),
              AppSpaces.instance.horizontal10,
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: context.appGeneral.textTheme.titleSmall
                        ?.copyWith(color: AppColor.grey.getColor()),
                  ),
                  Text(
                    value,
                    style: context.appGeneral.textTheme.titleMedium
                        ?.copyWith(color: color, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildWaterIntakeSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Alınan Su',
            style: context.appGeneral.textTheme.titleLarge
                ?.copyWith(fontWeight: FontWeight.bold)),
        AppSpaces.instance.vertical10,
        Container(
          padding: AppPadding.instance.allNormal,
          decoration: BoxDecoration(
            color: AppColor.white.getColor(),
            borderRadius: AppRadius.instance.halfBorderRadius,
            boxShadow: [
              BoxShadow(
                color: AppColor.crystalBell.getColor(),
                spreadRadius: 1,
                blurRadius: 2,
                offset: const Offset(0, 1),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Günde 12 bardak su iç',
                    style: context.appGeneral.textTheme.bodyLarge
                        ?.copyWith(color: AppColor.grey.getColor()),
                  ),
                  AppSpaces.instance.vertical10,
                  Row(
                    children: [
                      Text(
                        '1.5L',
                        style:
                            context.appGeneral.textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: AppColor.vaporwaweBlue.getColor(),
                        ),
                      ),
                      Text(
                        ' / 2.5L',
                        style: context.appGeneral.textTheme.titleLarge
                            ?.copyWith(color: AppColor.grey.getColor()),
                      ),
                    ],
                  ),
                  AppSpaces.instance.vertical15,
                  SizedBox(
                    height: 64,
                    width: Get.width - 120,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) => Padding(
                        padding: const EdgeInsets.only(right: 4),
                        child: Column(
                          children: [
                            Image.asset(
                              AppIconUtility.getIconPath(
                                "water-circle",
                                format: IconFormat.png,
                              ),
                              height: 40,
                            ),
                            Padding(
                              padding: AppPadding.instance.leftSmall,
                              child: Text(
                                '500 ml',
                                style: context.appGeneral.textTheme.bodyMedium
                                    ?.copyWith(
                                        color: AppColor.black.getColor()),
                              ),
                            ),
                          ],
                        ),
                      ),
                      itemCount: 5,
                    ),
                  )
                ],
              ),
              Padding(
                padding: AppPadding.instance.bottomNormal,
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Positioned(
                      top: -80,
                      right: -15,
                      child: SvgPicture.asset(
                        AppIconUtility.getIconPath(
                          "water-glass",
                          format: IconFormat.svg,
                        ),
                        height: 56,
                      ),
                    ),
                    CustomElevatedButton(
                      padding: EdgeInsets.zero,
                      onPressed: () {
                        NavigatorController.instance
                            .pushToPage(NavigateRoutesItems.addWater);
                      },
                      width: Get.height * 0.07,
                      height: Get.height * 0.07,
                      elevation: 0,
                      backgroundColor: AppColor.noxious.getColor(),
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(Get.height * 0.07 / 2),
                      ),
                      child: const Icon(Icons.add, color: Colors.white),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ],
    );
  }

  Widget buildDietPlanSection(
      BuildContext context, HomeViewController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Kişisel Diyet Planı',
          style: context.appGeneral.textTheme.titleLarge
              ?.copyWith(fontWeight: FontWeight.bold),
        ),
        AppSpaces.instance.vertical10,
        Container(
          margin: AppPadding.instance.bottomNormal,
          padding: AppPadding.instance.allNormal,
          decoration: BoxDecoration(
            color: AppColor.sweetPatato.getColor(),
            borderRadius: AppRadius.instance.halfBorderRadius,
            boxShadow: [
              BoxShadow(
                color: AppColor.crystalBell.getColor(),
                spreadRadius: 1,
                blurRadius: 2,
                offset: const Offset(0, 1),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Günde 12 bardak su iç',
                        style: context.appGeneral.textTheme.bodyLarge
                            ?.copyWith(color: AppColor.white.getColor()),
                      ),
                      Text(
                        'Sporcu Diyeti',
                        style: context.appGeneral.textTheme.titleLarge
                            ?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: AppColor.white.getColor()),
                      ),
                    ],
                  ),
                  Image.asset(
                    AppIconUtility.getIconPath("bowl", format: IconFormat.png),
                    height: 48,
                  ),
                ],
              ),
              AppSpaces.instance.vertical10,
              ExpantionTileWidget(
                controller: controller,
                section: ExpansionSection.diet,
                title: 'Sporcu diyeti nedir?',
                color: AppColor.noxious.getColor(),
                subtitle: "Bu bölümde diyet bilgisi bulunucaktır.",
              ),
              AppSpaces.instance.vertical10,
              ExpantionTileWidget(
                controller: controller,
                section: ExpansionSection.attention,
                title: 'Dikkat edilmesi gerekenler',
                color: AppColor.noxious.getColor(),
                subtitle: "Bu bölümde diyet bilgisi bulunucaktır.",
              ),
              AppSpaces.instance.vertical10,
              ExpantionTileWidget(
                controller: controller,
                section: ExpansionSection.shouldEat,
                title: 'Neler daha çok yenilmeli?',
                color: AppColor.noxious.getColor(),
                subtitle: 'Bu bölümde diyet bilgisi bulunucaktır.',
              ),
              AppSpaces.instance.vertical10,
              ExpantionTileWidget(
                controller: controller,
                section: ExpansionSection.shouldAvoid,
                subtitle: "Bu bölümde diyet bilgisi bulunucaktır.",
                title: 'Nelerden daha çok kaçınılmalı?',
                color: AppColor.noxious.getColor(),
                isLast: true,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
