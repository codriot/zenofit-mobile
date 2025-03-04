import 'package:diet_app_mobile/model/discover/discover_item_model.dart';
import 'package:diet_app_mobile/product/controller/comments_bottom_sheet_controller.dart';
import 'package:diet_app_mobile/product/services/icon_and_image_services.dart';
import 'package:diet_app_mobile/product/utils/app_utils/app_general.dart';
import 'package:diet_app_mobile/product/utils/app_utils/app_spaces..dart';
import 'package:diet_app_mobile/product/utils/app_utils/const_utils/app_colors.dart';
import 'package:diet_app_mobile/product/utils/app_utils/const_utils/app_padding.dart';
import 'package:diet_app_mobile/product/utils/app_utils/const_utils/app_radius.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class CommentsBottomSheet extends StatelessWidget {
  final DiscoverItemModel item;
  final CommentsBottomSheetController controller =
      Get.put(CommentsBottomSheetController()); // Controller'ı kaydet
  CommentsBottomSheet({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: AppPadding.instance.topNormal,
        height: Get.height * 0.95,
        decoration: BoxDecoration(
          color: AppColor.whiteSolid.getColor(),
          borderRadius: const BorderRadius.vertical(top: Radius.circular(32)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildTitleCommentText(context),
            AppSpaces.instance.vertical5,
            _buildTopDivider(),
            _buildPageListView(),
            _buildBottomDivider(),
            _buildAddComment(),
          ],
        ),
      ),
    );
  }

  Container _buildAddComment() {
    return Container(
      margin: AppPadding.instance.bottomNormal,
      padding: AppPadding.instance.horizontalNormal,
      decoration: BoxDecoration(
        borderRadius: AppRadius.instance.largeBorderRadius, // Kenar yuvarlama
      ),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: AppColor.orochimaru.getColor(),
            radius: 24,
            foregroundImage: NetworkImage(item.imageUrl),
          ),
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Yorumunuzu yazın...',
                hintStyle: TextStyle(
                    color: AppColor.grey.getColor()), // Placeholder rengi
                border: InputBorder.none, // Kenar çizgilerini kaldır
                contentPadding: const EdgeInsets.symmetric(
                    horizontal: 20, vertical: 15), // İç boşluk
              ),
            ),
          ),
        ],
      ),
    );
  }

  Divider _buildBottomDivider() {
    return Divider(color: AppColor.grey.getColor().withAlpha(24), thickness: 2);
  }

  Expanded _buildPageListView() {
    return Expanded(
      child: ListView.builder(
        itemCount: item.comments.length,
        itemBuilder: (context, index) {
          return _buildListViewCommentContainer(index, context);
        },
      ),
    );
  }

  Container _buildListViewCommentContainer(int index, BuildContext context) {
    return Container(
      padding: AppPadding.instance.horizontalNormal,
      margin: AppPadding.instance.bottomSmall,
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: AppColor.orochimaru.getColor(),
            radius: 24,
            foregroundImage:
                NetworkImage(item.comments[index].userProfileUrl ?? ""),
          ),
          AppSpaces.instance.horizontal10,
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    item.comments[index].userName ?? "",
                    style: context.appGeneral.textTheme.labelLarge
                        ?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  AppSpaces.instance.horizontal10,
                  Text(
                    //todo: burda knk kaç saat önce atıldığını göstericez.
                    controller.formatDate(item.comments[index].date ?? ""),
                    style: context.appGeneral.textTheme.labelLarge
                        ?.copyWith(color: AppColor.grey.getColor()),
                  ),
                ],
              ),
              Text(
                item.comments[index].comment ?? "",
                style: context.appGeneral.textTheme.labelLarge
                    ?.copyWith(fontWeight: FontWeight.w400),
              ),
            ],
          ),
          AppSpaces.instance.space,
          Column(
            children: [
              SvgPicture.asset(
                AppIconUtility.getIconPath("heart-line",
                    format: IconFormat.svg),
              ),
              Text(item.comments[index].likeCount ?? ""),
            ],
          ),
        ],
      ),
    );
  }

  Divider _buildTopDivider() {
    return Divider(color: AppColor.grey.getColor().withAlpha(24), thickness: 2);
  }

  Center _buildTitleCommentText(BuildContext context) {
    return Center(
      child: Text(
        'Yorumlar',
        style: context.appGeneral.textTheme.headlineMedium
            ?.copyWith(fontWeight: FontWeight.bold),
      ),
    );
  }
}
