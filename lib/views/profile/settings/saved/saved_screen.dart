import 'package:diet_app_mobile/product/navigator/navigator_controller.dart';
import 'package:diet_app_mobile/product/utils/app_utils/const_utils/app_colors.dart';
import 'package:diet_app_mobile/product/utils/app_utils/const_utils/app_padding.dart';
import 'package:diet_app_mobile/product/utils/app_utils/const_utils/app_radius.dart';
import 'package:flutter/material.dart';

class SavedScreen extends StatelessWidget {
  const SavedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Kaydedilenler",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w700,
            )),
        backgroundColor: AppColor.orochimaru.getColor(),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            NavigatorController.instance.pop();
          },
        ),
      ),
      body: Padding(
        padding: AppPadding.instance.horizontalMedium,
        child: GridView.builder(
          padding: const EdgeInsets.symmetric(vertical: 16),
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
        ),
      ),
    );
  }

  Widget _buildGridViewItem() {
    return Container(
      decoration: BoxDecoration(
        color: AppColor.grey.getColor().withOpacity(0.6),
        borderRadius: AppRadius.instance.halfBorderRadius,
      ),
    );
  }
}
