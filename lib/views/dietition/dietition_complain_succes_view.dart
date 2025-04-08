import 'package:diet_app_mobile/product/navigator/navigate_route_items.dart';
import 'package:diet_app_mobile/product/navigator/navigator_controller.dart';
import 'package:diet_app_mobile/product/services/icon_and_image_services.dart';
import 'package:diet_app_mobile/product/utils/app_utils/app_general.dart';
import 'package:diet_app_mobile/product/utils/app_utils/app_spaces..dart';
import 'package:diet_app_mobile/product/utils/app_utils/const_utils/app_colors.dart';
import 'package:diet_app_mobile/product/utils/app_utils/const_utils/app_padding.dart';
import 'package:diet_app_mobile/product/utils/app_utils/const_utils/app_radius.dart';
import 'package:diet_app_mobile/product/widgets/general/custom_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart' show SvgPicture;

class DietitionComplainSuccesView extends StatelessWidget {
  const DietitionComplainSuccesView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.whiteSolid.getColor(),
      body: SafeArea(
          child: Padding(
        padding: AppPadding.instance.horizontalNormal,
        child: ListView(
          children: [
            SvgPicture.asset(
              AppIconUtility.getIconPath("shield-check-line",
                  format: IconFormat.svg),
              color: AppColor.noxious.getColor(),
              width: 80,
              height: 80,
            ),
            AppSpaces.instance.vertical15,
            Center(
              child: Text(
                "Bize Güvenip görüşlerinizi ilettiğiniz için teşekkrü ederiz.",
                style: context.appGeneral.textTheme.titleMedium,
                textAlign: TextAlign.center,
              ),
            ),
            AppSpaces.instance.vertical15,
            Center(
                child: Text(
              "Bu bildirim sayesinde hem kendinizi hem kendinize hem de diğer kullanıcılara faydanız dokunmuştur.",
              style: context.appGeneral.textTheme.bodyMedium,
              textAlign: TextAlign.center,
            )),
            AppSpaces.instance.vertical30,
            _buildComplainCauseButton(
                context: context, title: "Farklı Bir Diyetisyen Önerisi"),
            _buildComplainCauseButton(
                context: context, title: "Şikayet Durumu Takibi Hakkında"),
            _buildComplainCauseButton(
                context: context,
                title: "Standart Diyetisyen kuralları Hakkında"),
            _buildComplainCauseButton(
                context: context,
                title: "Topluluk Kuralları Hakkında Bilgi Alma"),
            _buildComplainCauseButton(
                context: context,
                title: "Destek Kanalları ve İletişim Bilgileri"),
            _buildDoneButton(context),
          ],
        ),
      )),
    );
  }

  Widget _buildDoneButton(BuildContext context) {
    return Padding(
      padding: AppPadding.instance.topNormal,
      child: CustomElevatedButton(
        shape: RoundedRectangleBorder(
            borderRadius: AppRadius.instance.normalBorderRadius),
        height: 48,
        onPressed: () {
          NavigatorController.instance
              .pushAndRemoveUntil(NavigateRoutesItems.main);
        },
        backgroundColor: AppColor.noxious.getColor(),
        width: double.infinity,
        child: Text(
          "Bitti",
          style: context.appGeneral.textTheme.titleLarge?.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _buildComplainCauseButton({
    required BuildContext context,
    required String title,
  }) {
    return Padding(
      padding: AppPadding.instance.bottomNormal,
      child: InkWell(
        onTap: () {
          NavigatorController.instance
              .pushToPage(NavigateRoutesItems.dietitionComplainSucces);
        },
        child: Container(
          padding: AppPadding.instance.horizontalNormal,
          decoration: BoxDecoration(
            color: AppColor.white.getColor(),
            borderRadius: AppRadius.instance.normalBorderRadius,
          ),
          width: double.infinity,
          height: 48,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: context.appGeneral.textTheme.bodyLarge
                    ?.copyWith(fontWeight: FontWeight.bold),
              ),
              SvgPicture.asset(
                AppIconUtility.getIconPath("arrow-right",
                    format: IconFormat.svg),
                color: AppColor.black.getColor(),
              )
            ],
          ),
        ),
      ),
    );
  }
}
