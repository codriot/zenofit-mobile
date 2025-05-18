import 'package:diet_app_mobile/product/navigator/navigate_route_items.dart';
import 'package:diet_app_mobile/product/navigator/navigator_controller.dart';
import 'package:diet_app_mobile/product/services/icon_and_image_services.dart';
import 'package:diet_app_mobile/product/utils/app_utils/app_general.dart';
import 'package:diet_app_mobile/product/utils/app_utils/app_spaces..dart';
import 'package:diet_app_mobile/product/utils/app_utils/const_utils/app_colors.dart';
import 'package:diet_app_mobile/product/utils/app_utils/const_utils/app_padding.dart';
import 'package:diet_app_mobile/product/utils/app_utils/const_utils/app_radius.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DietitianComplainView extends StatelessWidget {
  const DietitianComplainView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.whiteSolid.getColor(),
      appBar: AppBar(
        backgroundColor: AppColor.transparent.getColor(),
        centerTitle: true,
        title: Text(
          "Şikayet Et",
          style: context.appGeneral.textTheme.titleMedium,
        ),
      ),
      body: SafeArea(
          child: Padding(
        padding: AppPadding.instance.horizontalNormal,
        child: ListView(
          children: [
            Divider(
              height: 5,
              color: AppColor.crystalBell.getColor(),
            ),
            Center(
                child: Text(
              "Diyetisyeni şikayet etme nedenini belirt.",
              style: context.appGeneral.textTheme.titleMedium,
            )),
            AppSpaces.instance.vertical15,
            Center(
                child: Text(
              "DŞikayetin sonucunda bilgilerin ve şikayetinin içeriği güvenli şekilde bize teslim edilicektir. İçiniz rahat bir şekilde şikayetinizi belirtebilir ve dilerseniz bizimle iletişime geçebilirsiniz.",
              style: context.appGeneral.textTheme.bodyMedium,
              textAlign: TextAlign.center,
            )),
            AppSpaces.instance.vertical30,
            _buildComplainCauseButton(
                context: context, title: "Genel Memnuniyetsizlik"),
            _buildComplainCauseButton(
                context: context, title: "Zaman Yönetimi ve Randevu Sorunları"),
            _buildComplainCauseButton(
                context: context, title: "Gizlilik ve Güvenlik İhlalleri"),
            _buildComplainCauseButton(
                context: context, title: "Ücret ve Ödeme Sorunları"),
            _buildComplainCauseButton(
                context: context, title: "Yanlış ve Zararlı Tavsiyeler"),
            _buildComplainCauseButton(
                context: context, title: "Yetersiz Hizmet ve Destek"),
            _buildComplainCauseButton(
                context: context, title: "İletişim Problemleri"),
            _buildComplainCauseButton(context: context, title: "Diğer"),
          ],
        ),
      )),
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
              .pushToPage(NavigateRoutesItems.dietitianComplainSucces);
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
