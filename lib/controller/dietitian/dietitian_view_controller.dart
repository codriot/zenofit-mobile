import 'package:diet_app_mobile/model/dietition/dietition_model.dart';
import 'package:diet_app_mobile/model/dietition/menu_model.dart';
import 'package:get/get.dart';
import 'package:get/state_manager.dart';

class DietitianViewController extends GetxController {
  var isMenuOpen = false.obs; // Menü durumunu tutacak
  var activeFilterIndex = (0).obs; // Aktif filtre indeksi (-1: hiçbiri)
  var selectedIndex = (-1).obs; // Seçili menü indeksi
  var favoriteStates = <bool>[].obs; // Her kart için favori durumları
  var DietitianInfoStates = <bool>[].obs;
  var Dietitians = <DietitianModel>[].obs;

  var menuItems = <MenuModel>[].obs; // Reactive list

  @override
  void onInit() {
    super.onInit();
    _generateMenuItems();
    _initializeDietitianModel();
    _initializeFavoriteStates();
    _initializeDietitianInfoStates();
  }

  void _initializeDietitianModel() {
    Dietitians.value = List.generate(
        10,
        (index) => DietitianModel(
            experienceYears: "5",
            patientCount: 3000,
            name: "Furkan",
            lastName: "Yıldırım",
            isAvaible: index % 2 == 0 ? false : true,
            isliked: index % 2 == 0 ? true : false,
            rating: 4.5,
            workBranch: "Sporcu"));
  }

  void _initializeFavoriteStates() {
    favoriteStates.value = List.generate(Dietitians.length, (index) => false);
  }

  void _initializeDietitianInfoStates() {
    DietitianInfoStates.value =
        List.generate(Dietitians.length, (index) => false);
  }

  void _generateMenuItems() {
    menuItems.value = [
      MenuModel(title: "Kilo Yönetimi", DietitianCount: 24, iconUrl: "task"),
      MenuModel(title: "Sporcu", DietitianCount: 15, iconUrl: "biceps"),
      MenuModel(title: "Çocuk", DietitianCount: 22, iconUrl: "boy"),
      MenuModel(title: "Hamile", DietitianCount: 9, iconUrl: "pregnant-woman"),
      MenuModel(
          title: "Kronik Hastalık",
          DietitianCount: 6,
          iconUrl: "healthy-heart"),
      MenuModel(
          title: "Gıda ve Alerji", DietitianCount: 14, iconUrl: "airborne"),
      MenuModel(
          title: "Yeme Bozukluğu",
          DietitianCount: 14,
          iconUrl: "eating-disorder"),
      MenuModel(title: "Vegan", DietitianCount: 9, iconUrl: "carrot"),
      MenuModel(
          title: "Kanser Beslenme",
          DietitianCount: 4,
          iconUrl: "healthy-heart"),
      MenuModel(title: "Yaşlı", DietitianCount: 2, iconUrl: "man"),
    ];
  }

  void toggleMenuOpen() {
    isMenuOpen.value = !isMenuOpen.value;
  }

  void toggleFilter(int index) {
    if (activeFilterIndex.value == index) {
      activeFilterIndex.value = -1; // Aynı butona tıklanırsa aktifliği kaldır
    } else {
      activeFilterIndex.value = index; // Aktif filtreyi değiştir
    }
  }

  void toggleMenuItem(int index) {
    if (selectedIndex.value != -1) {
      menuItems[selectedIndex.value].isSelected = false;
    }
    if (selectedIndex.value == index) {
      selectedIndex.value = -1;
    } else {
      menuItems[index].isSelected = true;
      selectedIndex.value = index;
    }
    menuItems.refresh(); // Listeyi yenile
  }

  void toggleDietitianInfoStateItem(int index) {
    // Eğer tıklanan index zaten aktifse, onu kapat
    if (DietitianInfoStates[index]) {
      DietitianInfoStates[index] = false;
    } else {
      // Önce tüm diğer indexleri false yap
      for (int i = 0; i < DietitianInfoStates.length; i++) {
        DietitianInfoStates[i] = false;
      }
      // Sonra tıklanan indexi true yap
      DietitianInfoStates[index] = true;
    }
    DietitianInfoStates.refresh();
  }

  void toggleFavorite(int index) {
    favoriteStates[index] = !favoriteStates[index];
  }

  void closeMenuAndDietitianInfoStates() {
    // Menü filter'ı kapat
    isMenuOpen.value = false;
    // Açık olan diyetisyen bilgi menüsünü kapat
    final openIndex = DietitianInfoStates.indexWhere((state) => state);
    if (openIndex != -1) {
      DietitianInfoStates[openIndex] = false;
      DietitianInfoStates.refresh();
    }
  }
}
