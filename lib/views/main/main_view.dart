import 'package:diet_app_mobile/controller/main/main_controller.dart';
import 'package:diet_app_mobile/product/services/icon_and_image_services.dart';
import 'package:diet_app_mobile/product/utils/app_utils/const_utils/app_colors.dart';
import 'package:diet_app_mobile/product/utils/app_utils/const_utils/app_duration.dart';
import 'package:diet_app_mobile/views/dietitian/dietitian_view.dart';
import 'package:diet_app_mobile/views/discover/discover_view.dart';
import 'package:diet_app_mobile/views/home/home_view.dart';
import 'package:diet_app_mobile/views/profile/profile_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class MainView extends GetView<MainController> {
  const MainView({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        body: PageView(
          controller: controller.pageController,
          onPageChanged: (index) {
            controller.currentIndex.value = index;
          },
          physics:
              const NeverScrollableScrollPhysics(), // Kaydırma animasyonu için
          children: [
            const HomeView(), // Ana sayfa
            const DiscoverView(), // Keşfet sayfası
            DietitianView(),
            ProfileView(),
          ],
        ),
        bottomNavigationBar: AnimatedBottomNavigationBar(
          currentIndex: controller.currentIndex.value,
          onTap: controller.changeIndex,
        ),
      );
    });
  }
}

class AnimatedBottomNavigationBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const AnimatedBottomNavigationBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Get.height * 0.1,
      decoration: BoxDecoration(
        color: AppColor.white.getColor(),
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(32),
          bottomRight: Radius.circular(32),
        ),
        boxShadow: const [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 10,
            offset: Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildNavItem("home-line", 'Ana Sayfa', 0),
          _buildNavItem("search-line", 'Keşfet', 1),
          _buildNavItem("group-line", 'Diyetisyenler', 2),
          _buildNavItem("user", 'Profil', 3),
        ],
      ),
    );
  }

  Widget _buildNavItem(String icon, String label, int index) {
    final isSelected = currentIndex == index;
    return InkWell(
      onTap: () => onTap(index),
      child: SizedBox(
        width: Get.width * 0.25,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AnimatedContainer(
              duration: AppDuration.instance.durationFast,
              padding: EdgeInsets.symmetric(
                  vertical: isSelected ? Get.height * 0.01 : 0),
              child: SvgPicture.asset(
                AppIconUtility.getIconPath(icon, format: IconFormat.svg),
                color: isSelected
                    ? AppColor.vividBlue.getColor()
                    : AppColor.black.getColor(),
              ),
            ),
            AnimatedContainer(
              duration: AppDuration.instance.durationFast,
              child: Text(
                label,
                style: TextStyle(
                  color: isSelected
                      ? AppColor.vividBlue.getColor()
                      : AppColor.black.getColor(),
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
