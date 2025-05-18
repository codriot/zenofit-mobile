import 'package:diet_app_mobile/controller/dietitian/dietitian_detail_controller.dart';
import 'package:diet_app_mobile/product/services/chrome_status_bar_service.dart';
import 'package:diet_app_mobile/product/services/icon_and_image_services.dart';
import 'package:diet_app_mobile/product/utils/app_utils/app_general.dart';
import 'package:diet_app_mobile/product/utils/app_utils/app_spaces..dart';
import 'package:diet_app_mobile/product/utils/app_utils/const_utils/app_colors.dart';
import 'package:diet_app_mobile/product/utils/app_utils/const_utils/app_duration.dart';
import 'package:diet_app_mobile/product/utils/app_utils/const_utils/app_padding.dart';
import 'package:diet_app_mobile/product/utils/app_utils/const_utils/app_radius.dart';
import 'package:diet_app_mobile/product/widgets/general/custom_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class DietitianDetailView extends StatelessWidget {
  final DietitianDetailController controller =
      Get.put(DietitianDetailController());
  DietitianDetailView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    ChromeStatusBarService.setDarkStatusBar();

    return Scaffold(
      backgroundColor: AppColor.whiteSolid.getColor(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              _buildTopProfileAndAppBarComponent(),
              _build90PxSizedBox(),
              AppSpaces.instance.vertical10,
              _buildDytName(context),
              _buildDytWorkBranchText(context),
              _buildStatsSection(context),
              _buildStatsDivider(),
              _buildAccordionSection(context),
              _buildCommunicateButton(context),
            ],
          ),
        ),
      ),
    );
  }

  Padding _buildStatsDivider() {
    return Padding(
      padding: AppPadding.instance.horizontalSmall,
      child: Divider(
        color: AppColor.grey.getColor(),
        height: 2,
      ),
    );
  }

  Text _buildDytWorkBranchText(BuildContext context) {
    return Text(
      controller.Dietitian.workBranch == "Sporcu"
          ? "Sporcu Beslenme Diyetisyeni"
          : "Girilmedi",
      style: context.appGeneral.textTheme.titleSmall?.copyWith(
        color: AppColor.grey.getColor(),
      ),
    );
  }

  Text _buildDytName(BuildContext context) {
    return Text(
      "Dyt. ${controller.Dietitian.name} ${controller.Dietitian.lastName}",
      style: context.appGeneral.textTheme.titleLarge?.copyWith(
        fontWeight: FontWeight.bold,
      ),
    );
  }

  SizedBox _build90PxSizedBox() {
    return const SizedBox(
      height: 90,
    );
  }

  Stack _buildTopProfileAndAppBarComponent() {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          height: 200,
          color: AppColor.crystalBell.getColor(),
        ),
        _buildBodyPageAppBar(),
        Positioned(
          bottom: -90,
          right: (Get.width - 180) / 2,
          child: Container(
            decoration: BoxDecoration(
              color: AppColor.white.getColor(),
              borderRadius: AppRadius.instance.largeBorderRadius,
            ),
            width: 180,
            height: 180,
          ),
        ),
        Positioned(
          bottom: -80,
          right: (Get.width - 160) / 2,
          child: Container(
            decoration: BoxDecoration(
              color: AppColor.crystalBell.getColor(),
              borderRadius: AppRadius.instance.mediumBorderRadius,
            ),
            width: 160,
            height: 160,
            child: Image.asset(
              AppImageUtility.getImagePath("person"),
              fit: BoxFit.contain,
            ),
          ),
        ),
      ],
    );
  }

  Container _buildBodyPageAppBar() {
    return Container(
      color: AppColor.crystalBell.getColor(),
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => Get.back(),
          ),
          Row(
            children: [
              IconButton(
                icon: SvgPicture.asset(
                  AppIconUtility.getIconPath("share-line",
                      format: IconFormat.svg),
                ),
                onPressed: controller.onSharePressed,
              ),
              IconButton(
                icon: SvgPicture.asset(
                  AppIconUtility.getIconPath("heart-line",
                      format: IconFormat.svg),
                ),
                onPressed: controller.onFavoritePressed,
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildStatsSection(BuildContext context) {
    return Padding(
      padding: AppPadding.instance.verticalNormal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildStatItem(context, "3000+", "Hasta", "checkbox-circle-fill",
              AppColor.lucentLime.getColor()),
          _buildStatItem(context, "+5 yıl", "Deneyim", "suitcase-line",
              AppColor.vaporwaweBlue.getColor()),
          _buildStatItem(context, "4.7", "Oran", "star-fill",
              AppColor.goldenGlam.getColor()),
        ],
      ),
    );
  }

  Widget _buildStatItem(
    BuildContext context,
    String value,
    String label,
    String icon,
    Color color,
  ) {
    return Column(
      children: [
        Row(
          children: [
            SvgPicture.asset(
              AppIconUtility.getIconPath(icon, format: IconFormat.svg),
              color: color,
            ),
            AppSpaces.instance.horizontal5,
            Text(
              value,
              style: context.appGeneral.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        Text(
          label,
          style: context.appGeneral.textTheme.bodyLarge?.copyWith(
            color: AppColor.grey.getColor(),
          ),
        ),
      ],
    );
  }

  Widget _buildAccordionSection(BuildContext context) {
    return Padding(
      padding: AppPadding.instance.allNormal,
      child: Column(
        children: [
          _buildAccordionItem(
            context,
            "Diyetisyen Hakkında",
            "Lorem ipsum dolor sit amet, consectetur adipiscing elit...",
            controller.isAboutExpanded,
            controller.toggleAbout,
            "user",
            AppColor.goldenGlam.getColor(),
          ),
          _buildAccordionItem(
            context,
            "Tecrübeleri",
            "Deneyim bilgileri...",
            controller.isExperienceExpanded,
            controller.toggleExperience,
            "suitcase-line",
            AppColor.vaporwaweBlue.getColor(),
          ),
          _buildAccordionItem(
            context,
            "Seans Takvimi",
            "Eğitim bilgileri...",
            controller.isEducationExpanded,
            controller.toggleEducation,
            "calendar-line",
            AppColor.noxious.getColor(),
          ),
          _buildAccordionItem(
            context,
            "Hakkındaki Yorumlar",
            "Yorumlar...",
            controller.isCommentsExpanded,
            controller.toggleComments,
            "chat",
            AppColor.vividBlue.getColor(),
          ),
        ],
      ),
    );
  }

  Widget _buildAccordionItem(
    BuildContext context,
    String title,
    String content,
    RxBool isExpanded,
    VoidCallback onTap,
    String iconName,
    Color iconColor,
  ) {
    return Column(
      children: [
        ListTile(
          contentPadding: EdgeInsets.zero,
          leading: CircleAvatar(
            backgroundColor: AppColor.white.getColor(),
            child: SvgPicture.asset(
              AppIconUtility.getIconPath(iconName, format: IconFormat.svg),
              color: iconColor,
            ),
          ),
          title: Text(
            title,
            style: context.appGeneral.textTheme.titleMedium,
          ),
          trailing: AnimatedCrossFade(
            duration: AppDuration.instance.durationFast,
            firstChild: SvgPicture.asset(AppIconUtility.getIconPath(
                "arrow-down-s-fill",
                format: IconFormat.svg)),
            secondChild: SvgPicture.asset(AppIconUtility.getIconPath(
                "arrow-up-s-fill",
                format: IconFormat.svg)),
            crossFadeState: CrossFadeState.showFirst,
          ),
          onTap: onTap,
        ),
        Obx(
          () => AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            height: isExpanded.value ? null : 0,
            child: isExpanded.value
                ? Padding(
                    padding: AppPadding.instance.verticalSmall,
                    child: Text(
                      content,
                      style: context.appGeneral.textTheme.bodyMedium,
                    ),
                  )
                : const SizedBox(),
          ),
        ),
        const Divider(),
      ],
    );
  }

  Widget _buildCommunicateButton(BuildContext context) {
    return Padding(
      padding: AppPadding.instance.allNormal,
      child: CustomElevatedButton(
        shape: RoundedRectangleBorder(
            borderRadius: AppRadius.instance.normalBorderRadius),
        height: 48,
        onPressed: controller.onCommunicatePressed,
        backgroundColor: AppColor.noxious.getColor(),
        width: double.infinity,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
                AppIconUtility.getIconPath("chat", format: IconFormat.svg),
                color: AppColor.white.getColor()),
            AppSpaces.instance.horizontal10,
            Text(
              "İletişime Geç",
              style: context.appGeneral.textTheme.titleMedium?.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
