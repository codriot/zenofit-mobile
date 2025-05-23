import 'dart:math';
import 'package:get/get.dart';

class ProfileViewController extends GetxController {
  final RxBool isLoading = false.obs;
  final RxList<String> postImages = <String>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadImages();
  }

  Future<void> loadImages() async {
    isLoading.value = true;
    
    // Simüle edilmiş yükleme gecikmesi
    await Future.delayed(const Duration(seconds: 1));
    
    // Rastgele resimler oluştur
    final random = Random();
    final images = List.generate(
      12,
      (index) => 'https://picsum.photos/200?random=${random.nextInt(1000)}',
    );
    
    postImages.assignAll(images);
    isLoading.value = false;
  }
} 