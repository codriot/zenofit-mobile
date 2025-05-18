import 'package:diet_app_mobile/API/services/auth/auth_service.dart';
import 'package:diet_app_mobile/product/navigator/navigate_route_items.dart';
import 'package:diet_app_mobile/product/navigator/navigator_controller.dart';
import 'package:diet_app_mobile/product/services/icon_and_image_services.dart';
import 'package:diet_app_mobile/product/utils/app_utils/app_spaces..dart';
import 'package:diet_app_mobile/product/utils/app_utils/const_utils/app_colors.dart';
import 'package:diet_app_mobile/product/utils/app_utils/const_utils/app_padding.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Ayarlar",
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
      body: SingleChildScrollView(
        padding: AppPadding.instance.bottomLarge,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionTitle(context, "Kullanıcı Ayarları"),
            _buildAccountSettings(),
            _buildSectionTitle(context, "Cihaz Ayarları"),
            _buildAppSettings(),
            AppSpaces.instance.vertical30,
            _buildCompanyInfo(),
          ],
        ),
      ),
    );
  }

  Padding _buildSectionTitle(BuildContext context, String title) {
    return Padding(
      padding:
          AppPadding.instance.horizontalMedium.copyWith(bottom: 16, top: 16),
      child: Text(
        title,
        style: TextStyle(
          fontWeight: FontWeight.w400,
          fontSize: 16,
        ),
      ),
    );
  }

  Widget _buildAccountSettings() {
    return Container(
      margin: AppPadding.instance.horizontalMedium,
      decoration: BoxDecoration(
        color: AppColor.orochimaru.getColor().withOpacity(0.3),
        borderRadius: BorderRadius.circular(32),
      ),
      padding: AppPadding.instance.allNormal,
      child: Column(
        children: [
          _buildSettingItem(
            icon: "bookmark-line",
            title: "Kaydedilenler",
            onTap: () {
              NavigatorController.instance
                  .pushToPage(NavigateRoutesItems.savedScreen);
            },
          ),
          Divider(
            color: AppColor.black12.getColor(),
            height: 1,
            endIndent: 4,
            indent: 4,
          ),
          _buildSettingItemWithToggle(
            icon: "notification-2-line",
            title: "Bildirimler",
            value: true,
            onChanged: (value) {
              Get.snackbar(
                  'Bilgi', 'Şifre değiştirme sayfası geliştirme aşamasındadır.',
                  snackPosition: SnackPosition.BOTTOM);
            },
          ),
          Divider(
            color: AppColor.black12.getColor(),
            height: 1,
            endIndent: 4,
            indent: 4,
          ),
          _buildSettingItem(
            icon: "group-line",
            title: "Geçmiş Diyetisyenler",
            onTap: () {
              NavigatorController.instance
                  .pushToPage(NavigateRoutesItems.formerDietitian);
            },
          ),
          Divider(
            color: AppColor.black12.getColor(),
            height: 1,
            endIndent: 4,
            indent: 4,
          ),
          _buildSettingItem(
            icon: "forbid-line",
            title: "Engellenenler",
            onTap: () {
              NavigatorController.instance
                  .pushToPage(NavigateRoutesItems.blocked);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildAppSettings() {
    return Container(
      margin: AppPadding.instance.horizontalMedium,
      decoration: BoxDecoration(
        color: AppColor.orochimaru.getColor().withOpacity(0.3),
        borderRadius: BorderRadius.circular(32),
      ),
      padding: AppPadding.instance.allNormal,
      child: Column(
        children: [
          _buildSettingItemWithToggle(
            icon: "moon-line",
            title: "Tema Ayarları",
            value: false,
            onChanged: (value) {
              Get.snackbar(
                  'Bilgi', 'Tema ayarları sayfası geliştirme aşamasındadır.',
                  snackPosition: SnackPosition.BOTTOM);
            },
          ),
          _buildSettingItem(
            icon: "question-line",
            title: "Yardım",
            onTap: () {
              Get.snackbar('Bilgi',
                  'Bildirim ayarları sayfası geliştirme aşamasındadır.',
                  snackPosition: SnackPosition.BOTTOM);
            },
          ),
          _buildSettingItem(
            icon: "information-line",
            title: "Hakkında",
            onTap: () {
              Get.snackbar('Bilgi',
                  'Bildirim ayarları sayfası geliştirme aşamasındadır.',
                  snackPosition: SnackPosition.BOTTOM);
            },
          ),
          _buildSettingItem(
            icon: "logout-box-r-line",
            title: "Çıkış Yap",
            onTap: () {
              try {
                Get.dialog(
                  AlertDialog(
                    title: const Text('Çıkış'),
                    content: const Text(
                        'Hesabınızdan çıkış yapmak istediğinize emin misiniz?'),
                    actions: [
                      TextButton(
                        onPressed: () => Get.back(),
                        child: const Text('İptal'),
                      ),
                      TextButton(
                        onPressed: () async {
                          Get.back();
                          await AuthService().signOut();
                          NavigatorController.instance
                              .pushAndRemoveUntil(NavigateRoutesItems.login);
                        },
                        child: const Text('Çıkış Yap'),
                      ),
                    ],
                  ),
                );
              } catch (e) {
                Get.snackbar('Hata', 'Çıkış yaparken hata oluştu: $e',
                    snackPosition: SnackPosition.BOTTOM);
              }
            },
          ),
        ],
      ),
    );
  }

  Widget _buildSettingItem({
    required String icon,
    required String title,
    required VoidCallback onTap,
    String? subtitle,
  }) {
    return ListTile(
      leading: SvgPicture.asset(
        AppIconUtility.getIconPath(icon, format: IconFormat.svg),
      ),
      title: Text(
        title,
        style: const TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 16,
        ),
      ),
      subtitle: subtitle != null
          ? Text(
              subtitle,
              style: TextStyle(
                color: AppColor.grey.getColor(),
                fontSize: 12,
              ),
            )
          : null,
      trailing: Icon(
        Icons.arrow_forward_ios,
        size: 16,
        color: AppColor.grey.getColor(),
      ),
      onTap: onTap,
    );
  }

  Widget _buildSettingItemWithToggle({
    required String icon,
    required String title,
    required bool value,
    required Function(bool) onChanged,
  }) {
    return ListTile(
      leading: SvgPicture.asset(
        AppIconUtility.getIconPath(icon, format: IconFormat.svg),
        width: 24,
        height: 24,
      ),
      title: Text(
        title,
        style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
      ),
      trailing: Switch(
        value: value,
        onChanged: onChanged,
        activeColor: AppColor.orochimaru.getColor(),
      ),
    );
  }

  Widget _buildCompanyInfo() {
    return Center(
      child: Column(
        children: [
          Image.asset(
            AppImageUtility.getImagePath("bitirme-logo"),
            width: 80,
            height: 80,
          ),
          AppSpaces.instance.vertical5,
          Text(
            "Diet App v1.0.0",
            style: TextStyle(
              color: AppColor.grey.getColor(),
              fontSize: 12,
            ),
          ),
          AppSpaces.instance.vertical5,
          Text(
            "© 2025 WidgetWizard. Tüm hakları saklıdır.",
            style: TextStyle(
              color: AppColor.grey.getColor(),
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}
