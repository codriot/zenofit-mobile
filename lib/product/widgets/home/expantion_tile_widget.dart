import 'package:diet_app_mobile/product/controller/expand_tile_controller.dart';
import 'package:diet_app_mobile/product/utils/app_utils/app_general.dart';
import 'package:diet_app_mobile/product/utils/app_utils/const_utils/app_colors.dart';
import 'package:diet_app_mobile/product/utils/app_utils/const_utils/app_padding.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ExpantionTileWidget extends StatelessWidget {
  final ExpandTileController controller = Get.put(ExpandTileController());

  final String title;
  final String subtitle;
  final Color color;
  final bool? isLast;

  ExpantionTileWidget({
    super.key,
    required this.title,
    required this.subtitle,
    required this.color,
    this.isLast = false,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Column(
        children: [
          Theme(
            data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
            child: ExpansionTile(
              onExpansionChanged: controller.toggleExpanded,
              childrenPadding: EdgeInsets.zero,
              tilePadding: EdgeInsets.zero,
              title: Text(
                title,
                style: context.appGeneral.textTheme.titleMedium?.copyWith(
                  color: AppColor.white.getColor(),
                  fontWeight: FontWeight.w500,
                ),
              ), 
              trailing: AnimatedRotation(
                turns: controller.isExpanded.value ? 0.5 : 0.0,
                duration: const Duration(milliseconds: 200),
                child: Icon(
                  Icons.keyboard_arrow_down,
                  color: AppColor.white.getColor(),
                ),
              ),
              shape: Border.all(color: Colors.transparent),
              collapsedShape: Border.all(color: Colors.transparent),
              children: [
                Padding(
                  padding: AppPadding.instance.allSmall,
                  child: Text(
                    subtitle,
                    style: context.appGeneral.textTheme.bodyMedium
                        ?.copyWith(color: AppColor.white.getColor()),
                  ),
                ),
              ],
            ),
          ),
          if (isLast == false)
            Divider(
              height: 1,
              color: AppColor.white.getColor(),
            ),
        ],
      );
    });
  }
}
