import 'package:diet_app_mobile/product/navigator/navigator_controller.dart';
import 'package:diet_app_mobile/product/services/icon_and_image_services.dart';
import 'package:diet_app_mobile/product/utils/app_utils/app_general.dart';
import 'package:diet_app_mobile/product/utils/app_utils/app_spaces..dart';
import 'package:diet_app_mobile/product/utils/app_utils/const_utils/app_colors.dart';
import 'package:diet_app_mobile/product/utils/app_utils/const_utils/app_padding.dart';
import 'package:diet_app_mobile/product/utils/app_utils/const_utils/app_radius.dart';
import 'package:diet_app_mobile/product/widgets/general/general_page_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class AbonedView extends StatelessWidget {
  const AbonedView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Get.height * 0.8,
      padding: AppPadding.instance.allNormal,
      decoration: BoxDecoration(
        color: AppColor.crystalBell.getColor(),
        borderRadius: AppRadius.instance.largeBorderRadius,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          AppSpaces.instance.vertical20,
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
                color: AppColor.grey.getColor().withOpacity(0.2),
                shape: BoxShape.circle,
                image: DecorationImage(
                    image: AssetImage(AppImageUtility.getImagePath("person")))),
          ),
          AppSpaces.instance.vertical10,
          Text("Furkan Yıldırım Engellensin mi?",
              style: context.appGeneral.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              )),
          AppSpaces.instance.vertical10,
          Text(
            "Engellediğin kişi aşağıdaki işlemleri yapamaz.",
            style: context.appGeneral.textTheme.bodyMedium,
          ),
          AppSpaces.instance.vertical20,
          Divider(
            color: AppColor.black12.getColor(),
            height: 2,
          ),
          AppSpaces.instance.vertical20,
          _buildListTileAbonedContent(
            context: context,
            icon: "chat",
            text:
                "Engellediğin kişi sana mesaj gönderemez ve senin içeriklerine erişemez",
          ),
          _buildListTileAbonedContent(
            context: context,
            icon: "notification-off-line",
            text:
                "Engellediğin kişi bildirim alamaz ve ondan gelen bildirimleri alamazsın",
          ),
          _buildListTileAbonedContent(
            context: context,
            icon: "forbid-line",
            text:
                "İstediğin zaman engellediğin kişinin engelini kaldırabilirsin.",
          ),
          AppSpaces.instance.space,
          GeneralPageButtonWidget(
            onPressed: () {NavigatorController.instance.pop();},
            text: "Engelle",
            height: 48,
          ),
          AppSpaces.instance.vertical20,
        ],
      ),
    );
  }

  ListTile _buildListTileAbonedContent(
      {required BuildContext context,
      required String icon,
      required String text}) {
    return ListTile(
      leading: SvgPicture.asset(
        AppIconUtility.getIconPath(icon, format: IconFormat.svg),
        color: AppColor.red.getColor(),
      ),
      title: Text(
        text,
        style: context.appGeneral.textTheme.bodyMedium,
      ),
    );
  }
}
