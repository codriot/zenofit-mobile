import 'package:diet_app_mobile/product/utils/app_utils/app_general.dart';
import 'package:diet_app_mobile/product/utils/app_utils/app_spaces..dart';
import 'package:diet_app_mobile/product/utils/app_utils/const_utils/app_colors.dart';
import 'package:diet_app_mobile/product/utils/app_utils/const_utils/app_padding.dart';
import 'package:diet_app_mobile/product/utils/app_utils/const_utils/app_radius.dart';
import 'package:diet_app_mobile/product/widgets/general/custom_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:diet_app_mobile/product/services/icon_and_image_services.dart';

mixin HomeViewMixin {
  Widget buildHeader(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 56,
          height: 56,
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
        Container(
          decoration: BoxDecoration(
              color: AppColor.crystalBell.getColor(), shape: BoxShape.circle),
          padding: AppPadding.instance.allSmall,
          child: SvgPicture.asset(
            AppIconUtility.getIconPath("message", format: IconFormat.svg),
            height: 32,
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
            AppSpaces.instance.vertical10,
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
            AppSpaces.instance.vertical10,
            Expanded(
              child: buildNutritionCard('Yağ', '2500 Cal',
                  AppColor.vaporwaweBlue.getColor(), context),
            ),
          ],
        ),
        AppSpaces.instance.vertical15,
        CustomElevatedButton(
          onPressed: () {},
          width: double.infinity,
          height: 56,
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
                width: 48,
                height: 48,
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
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Günde 12 bardak su iç',
                      style: context.appGeneral.textTheme.bodyMedium?.copyWith(
                        color: AppColor.grey.getColor(),
                      )),
                  Padding(
                    padding: AppPadding.instance.leftNormal,
                    child: Row(
                      children: [
                        Text('1.5L',
                            style: context.appGeneral.textTheme.titleMedium
                            ?.copyWith(color: AppColor.vaporwaweBlue.getColor())),
                        Text(' / 2.5L',
                            style: context.appGeneral.textTheme.titleMedium?.copyWith(
                              color: AppColor.grey.getColor(),
                            )),
                      ],
                    ),
                  ),
                  Row(
                    children: List.generate(
                      5,
                      (index) => const Padding(
                        padding: EdgeInsets.only(right: 8),
                        child: Icon(Icons.water_drop,
                            color: Colors.blue, size: 30),
                      ),
                    ),
                  ),
                ],
              ),
              const Spacer(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  SvgPicture.asset(AppIconUtility.getIconPath("water-glass",
                  format: IconFormat.svg,),height: 56,),
                  CustomElevatedButton(child: Icon(Icons.add,), onPressed: (){},
                  elevation: 0,
                  height: 48,
                  width: 48,
                  backgroundColor: AppColor.noxious.getColor(),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28  )),)
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget buildDietPlanSection() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.orange[300],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(Icons.restaurant_menu, color: Colors.white),
              SizedBox(width: 8),
              Text(
                'Kişisel Diyet Planı',
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ],
          ),
          const SizedBox(height: 16),
          buildDietPlanItem('Sporcu Diyeti'),
          buildDietPlanItem('Sporcu diyeti nedir?'),
          buildDietPlanItem('Dikkat edilmesi gerekenler'),
          buildDietPlanItem('Neler daha çok yenilmeli?'),
          buildDietPlanItem('Nelerden daha çok kaçınılmalı?'),
        ],
      ),
    );
  }

  Widget buildDietPlanItem(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: const TextStyle(color: Colors.white)),
          const Icon(Icons.chevron_right, color: Colors.white),
        ],
      ),
    );
  }
}
