import 'package:diet_app_mobile/controller/profile/profile_view_controller.dart';
import 'package:diet_app_mobile/product/navigator/navigate_route_items.dart';
import 'package:diet_app_mobile/product/navigator/navigator_controller.dart';
import 'package:diet_app_mobile/product/services/icon_and_image_services.dart';
import 'package:diet_app_mobile/product/utils/app_utils/app_general.dart';
import 'package:diet_app_mobile/product/utils/app_utils/app_spaces..dart';
import 'package:diet_app_mobile/product/utils/app_utils/const_utils/app_colors.dart';
import 'package:diet_app_mobile/product/utils/app_utils/const_utils/app_padding.dart';
import 'package:diet_app_mobile/product/utils/app_utils/const_utils/app_radius.dart';
import 'package:diet_app_mobile/product/utils/app_utils/const_utils/app_sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class ProfileView extends StatelessWidget {
  ProfileView({super.key});

  final ProfileViewController controller = Get.put(ProfileViewController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.whiteSolid.getColor(),
      body: ListView(
        padding: EdgeInsets.zero,
        children: [
          _buildAppBarBody(context),
          AppSpaces.instance.vertical10,
          Padding(
            padding: AppPadding.instance.horizontalNormal,
            child: Column(
              children: [
                _buildProfileImage(),
                AppSpaces.instance.vertical10,
                _buildProfilePersonName(context),
                _buildProfileInfoDataComponent(context),
                AppSpaces.instance.vertical10,
                _buildProfileAboutParagraf(),
                AppSpaces.instance.vertical20,
                _buildProfilePageButtonRow(context),
                AppSpaces.instance.vertical20,
                _buildPostTextTitle(context),
                AppSpaces.instance.vertical10,
                _buildPostGridView(),
                AppSpaces.instance.vertical10,
              ],
            ),
          )
        ],
      ),
    );
  }

  GridView _buildPostGridView() {
    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      padding: EdgeInsets.zero,
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 1,
        crossAxisSpacing: 20,
        mainAxisSpacing: 10,
      ),
      itemCount: 6,
      itemBuilder: (context, index) {
        return _buildGridViewItem();
      },
    );
  }

  Container _buildGridViewItem() {
    return Container(
      decoration: BoxDecoration(
        color: AppColor.grey.getColor().withOpacity(0.6),
        borderRadius: AppRadius.instance.halfBorderRadius,
      ),
    );
  }

  Text _buildPostTextTitle(BuildContext context) {
    return Text(
      "Gönderiler",
      style: context.appGeneral.textTheme.titleMedium
          ?.copyWith(fontWeight: FontWeight.bold),
    );
  }

  Row _buildProfilePageButtonRow(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        _buildProfilePageButton(
          context: context,
          onTap: () {},
          buttonText: "Profili Düzenle",
        ),
        _buildProfilePageButton(
          context: context,
          onTap: () {},
          buttonText: "Profili Paylaş",
        ),
      ],
    );
  }

  Widget _buildProfilePageButton(
      {required BuildContext context,
      required String buttonText,
      required void Function() onTap}) {
    return InkWell(
      borderRadius: AppRadius.instance.normalBorderRadius,
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(
          vertical: AppSizes.instance.normalValue,
          horizontal: AppSizes.instance.mediumValue,
        ),
        decoration: BoxDecoration(
          color: AppColor.crystalBell.getColor(),
          borderRadius: AppRadius.instance.normalBorderRadius,
        ),
        child: Text(
          buttonText,
          style: context.appGeneral.textTheme.bodyLarge
              ?.copyWith(fontWeight: FontWeight.w500),
        ),
      ),
    );
  }

  Text _buildProfileAboutParagraf() {
    return const Text(
      "Lorem impus dolar sit amet ,conteratresur adiğicing elit. sed do elusmod tempor edicieiton ut labera to et dolare magna eliqua ut emin ad mini velora.",
    );
  }

  Row _buildProfileInfoDataComponent(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _columnOfPersonProfileInfoData(
            context: context, count: "129", text: "Gönderi"),
        _columnOfPersonProfileInfoData(
            context: context, count: "6.5M", text: "Takipçi"),
        _columnOfPersonProfileInfoData(
            context: context, count: "1080", text: "Takip Edilen"),
      ],
    );
  }

  Column _columnOfPersonProfileInfoData({
    required BuildContext context,
    required String count,
    required String text,
  }) {
    return Column(
      children: [
        Text(
          count,
          style: context.appGeneral.textTheme.bodyLarge
              ?.copyWith(fontWeight: FontWeight.w500),
        ),
        Text(
          text,
          style: context.appGeneral.textTheme.bodyMedium,
        ),
      ],
    );
  }

  Text _buildProfilePersonName(BuildContext context) {
    return Text(
      "Furkan Yıldırım",
      style: context.appGeneral.textTheme.bodyLarge
          ?.copyWith(fontWeight: FontWeight.bold),
    );
  }

  Container _buildProfileImage() {
    return Container(
      width: Get.height * 0.14,
      height: Get.height * 0.14,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        image: DecorationImage(
            image: AssetImage(
              AppImageUtility.getImagePath(
                "person",
              ),
            ),
            fit: BoxFit.contain),
        color: AppColor.crystalBell.getColor(),
      ),
    );
  }

  Container _buildAppBarBody(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: Get.height * 0.03),
      height: Get.height * 0.12,
      color: AppColor.crystalBell.getColor(),
      child: Padding(
        padding: AppPadding.instance.horizontalNormal,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  AppIconUtility.getIconPath("lock-line",
                      format: IconFormat.svg),
                ),
                AppSpaces.instance.horizontal10,
                Text(
                  "Furkan Yıldırım",
                  style: context.appGeneral.textTheme.titleMedium
                      ?.copyWith(fontWeight: FontWeight.bold),
                ),
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  AppIconUtility.getIconPath("add-circle-line",
                      format: IconFormat.svg),
                ),
                AppSpaces.instance.horizontal10,
                InkWell(
                  onTap: () {
                    NavigatorController.instance
                        .pushToPage(NavigateRoutesItems.settings);
                  },
                  child: SvgPicture.asset(
                    AppIconUtility.getIconPath("settings-line",
                        format: IconFormat.svg),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
