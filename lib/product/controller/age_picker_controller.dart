import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AgePickerController extends GetxController {
  final ScrollController scrollController = ScrollController();
  var selectedAge = 25.obs; // Varsayılan yaş
  final double itemHeight = 50; // Her bir öğenin yüksekliği

  // Sabit oranlar (345’e göre hesaplandı)
  final double _topRatio = 150 / 345;
  final double _bottomRatio = 200 / 345;

  late double ageContainerHeight;
  late double visibleRangeTop;
  late double visibleRangeBottom;

  @override
  void onInit() {
    super.onInit();

    // Gerçek yüksekliğe göre hesaplama
    ageContainerHeight = Get.height * 0.48;
    visibleRangeTop = ageContainerHeight * _topRatio;
    visibleRangeBottom = ageContainerHeight * _bottomRatio;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      onScrollUpdate(); // Scroll güncellemesini başlat
    });
  }

  TextStyle getTextStyleForAge(BuildContext context, int index) {
    final textTheme = Theme.of(context).textTheme;

    if (index == selectedAge.value) {
      return textTheme.headlineLarge!.copyWith(fontWeight: FontWeight.bold);
    } else if ((index - selectedAge.value).abs() == 1) {
      return textTheme.headlineMedium!.copyWith(fontWeight: FontWeight.w600);
    } else if ((index - selectedAge.value).abs() == 2) {
      return textTheme.titleLarge!.copyWith(fontWeight: FontWeight.w500);
    } else if ((index - selectedAge.value).abs() == 3) {
      return textTheme.titleMedium!.copyWith(fontWeight: FontWeight.w400);
    } else if ((index - selectedAge.value).abs() == 4) {
      return textTheme.headlineSmall!.copyWith(fontWeight: FontWeight.w300);
    } else {
      return textTheme.bodySmall!.copyWith(fontWeight: FontWeight.w200);
    }
  }

void onScrollUpdate() {
  final offset = scrollController.offset;
  final double listViewCenter = (visibleRangeTop + visibleRangeBottom) / 2;

  int index = ((offset + listViewCenter - (itemHeight / 2)) / itemHeight).round();

  // Clamp index between 0 and 99
  index = index.clamp(0, 99);

  selectedAge.value = index;
}

void onScrollEnd() {
  if (!scrollController.hasClients) return;

  final double listViewCenter = (visibleRangeTop + visibleRangeBottom) / 2;
  int index = ((scrollController.offset + listViewCenter - (itemHeight / 2)) / itemHeight).round();
  index = index.clamp(0, 125);

  final double targetOffset = index * itemHeight - listViewCenter + (itemHeight / 2);

  if ((scrollController.offset - targetOffset).abs() > 0.5) {
    scrollController.animateTo(
      targetOffset,
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeOut,
    );
  }

  selectedAge.value = index;
}

  @override
  void onClose() {
    scrollController.dispose();
    super.onClose();
  }
}
