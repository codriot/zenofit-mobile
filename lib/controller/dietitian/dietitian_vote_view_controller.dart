import 'package:get/get.dart';

class DietitianVoteController extends GetxController {
  var selectedStars = 0.obs; // Seçilen yıldız sayısı

  void selectStar(int index) {
    selectedStars.value = index + 1; // Seçilen yıldızın indeksine göre güncelle
  }
}
