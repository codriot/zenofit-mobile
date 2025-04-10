import 'package:diet_app_mobile/controller/dietition/dietition_vote_view_controller.dart';
import 'package:diet_app_mobile/product/services/chrome_status_bar_service.dart';
import 'package:diet_app_mobile/product/services/icon_and_image_services.dart';
import 'package:diet_app_mobile/product/utils/app_utils/app_general.dart';
import 'package:diet_app_mobile/product/utils/app_utils/app_spaces..dart';
import 'package:diet_app_mobile/product/utils/app_utils/const_utils/app_colors.dart';
import 'package:diet_app_mobile/product/utils/app_utils/const_utils/app_padding.dart';
import 'package:diet_app_mobile/product/utils/app_utils/const_utils/app_radius.dart';
import 'package:diet_app_mobile/product/utils/app_utils/const_utils/app_sizes.dart';
import 'package:diet_app_mobile/product/widgets/general/custom_elevated_button.dart';
import 'package:diet_app_mobile/product/widgets/general/general_page_button.dart';
import 'package:diet_app_mobile/product/widgets/general/general_shadow_components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart' show Get, GetNavigation, Inst;
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart'
    show Obx;

class DietitionVoteView extends StatelessWidget {
  const DietitionVoteView({super.key});

  @override
  Widget build(BuildContext context) {
    final DietitionVoteController controller =
        Get.put(DietitionVoteController());
    ChromeStatusBarService.setDarkStatusBar();

    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            Container(
              height:
                  Get.height - (AppBarTheme.of(context).toolbarHeight ?? 56.0),
              width: Get.width,
              decoration: BoxDecoration(
                color: AppColor.whiteSolid.getColor(),
                borderRadius: AppRadius.instance.largeBorderRadius,
              ),
              padding: AppPadding.instance.allNormal,
              child: Column(
                children: [
                  _buildGetToPageButton(),
                  _buildMakeCommentText(context),
                  AppSpaces.instance.vertical10,
                  _buildHowManyGiveToText(context),
                  AppSpaces.instance.vertical10,
                  _buildStarRow(controller),
                  _buildReComendText(context),
                  _buildPageCommentTextField(),
                  _buildDoneButton(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  GeneralPageButtonWidget _buildDoneButton() {
    return GeneralPageButtonWidget(
      onPressed: () {
        _showSuccessDialog();
      },
      text: "Bitti",
      padding: AppPadding.instance.topMedium,
    );
  }

  void _showSuccessDialog() {
    showDialog(
      context: Get.context!,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Başarılı!",
          style: context.appGeneral.textTheme.titleMedium?.copyWith(
            color: AppColor.noxious.getColor(),
            fontWeight: FontWeight.bold
          ),),
          content: const Text("Yorumunuz başarılı şekilde yapıldı."),
          actions: [
            TextButton(
              style: ButtonStyle(
                backgroundColor: WidgetStatePropertyAll(AppColor.vividBlue.getColor())
              ),
              onPressed: () {
                Get.back();
                Get.back();
              },
              child: Text("Tamam",style: context.appGeneral.textTheme.bodyLarge?.copyWith(
            color: AppColor.white.getColor(),
          ),),
            ),
          ],
        );
      },
    );
  }

  Expanded _buildPageCommentTextField() {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          color: AppColor.white.getColor(),
          borderRadius: AppRadius.instance.halfBorderRadius,
          boxShadow: [
            generalComponentsShadow(),
          ],
        ),
        padding: AppPadding.instance.horizontalNormal,
        // ignore: prefer_const_constructors
        child: TextField(
          maxLines: null,
          minLines: null,
          keyboardType: TextInputType.multiline,
          decoration: const InputDecoration(
            border: InputBorder.none,
            hintText: "Buraya yaz...",
          ),
        ),
      ),
    );
  }

  SizedBox _buildStarRow(DietitionVoteController controller) {
    return SizedBox(
      height: (Get.width - (AppSizes.instance.normalValue * 2)) / 5,
      child: Row(
        children: [
          for (int i = 0; i < 5; i++)
            GestureDetector(
              onTap: () => controller.selectStar(i),
              child: Obx(
                () => SvgPicture.asset(
                  AppIconUtility.getIconPath(
                    i < controller.selectedStars.value
                        ? "star-fill"
                        : "star-line",
                    format: IconFormat.svg,
                  ),
                  color: AppColor.goldenGlam.getColor(),
                  width: (Get.width - (AppSizes.instance.normalValue * 2)) / 5,
                ),
              ),
            ),
        ],
      ),
    );
  }

  Text _buildReComendText(BuildContext context) {
    return Text(
      "Geri bilgirim için yorum yap.",
      style: context.appGeneral.textTheme.titleMedium?.copyWith(
        fontWeight: FontWeight.w500,
      ),
    );
  }

  Text _buildHowManyGiveToText(BuildContext context) {
    return Text(
      "Kaç Yıldız Verirsin?",
      style: context.appGeneral.textTheme.titleMedium?.copyWith(
          color: AppColor.black.getColor(), fontWeight: FontWeight.w500),
    );
  }

  Center _buildMakeCommentText(BuildContext context) {
    return Center(
        child: Text(
      "Dyt. Furkan Yıldırımı oyle ve yorum yap.",
      style: context.appGeneral.textTheme.headlineMedium?.copyWith(
          color: AppColor.black.getColor(), fontWeight: FontWeight.w600),
      textAlign: TextAlign.center,
    ));
  }

  Row _buildGetToPageButton() {
    return Row(
      children: [
        CustomElevatedButton(
          onPressed: Get.back,
          padding: EdgeInsets.zero,
          elevation: 0,
          width: 48,
          backgroundColor: AppColor.transparent.getColor(),
          height: 48,
          child: SvgPicture.asset(AppIconUtility.getIconPath("arrow-left-line",
              format: IconFormat.svg)),
        ),
      ],
    );
  }
}
