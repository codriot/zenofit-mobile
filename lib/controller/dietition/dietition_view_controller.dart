import 'package:diet_app_mobile/model/dietition/dietition_model.dart';
import 'package:diet_app_mobile/model/dietition/menu_model.dart';
import 'package:get/get.dart';
import 'package:get/state_manager.dart';

class DietitionViewController extends GetxController {
  var isMenuOpen = false.obs; // Menü durumunu tutacak
  var activeFilterIndex = (0).obs; // Aktif filtre indeksi (-1: hiçbiri)
  var selectedIndex = (-1).obs; // Seçili menü indeksi
  var favoriteStates = <bool>[].obs; // Her kart için favori durumları
  var dietitionInfoStates = <bool>[].obs;
  var dietitions = <DietitionModel>[].obs;

  var menuItems = <MenuModel>[].obs; // Reactive list


  @override
  void onInit() {
    super.onInit();
    _generateMenuItems();
    _initializeDietitionModel();
    _initializeFavoriteStates();
    _initializeDietitionInfoStates();
  }



  void _initializeDietitionModel() {
    dietitions.value = List.generate(
        10,
        (index) => DietitionModel(
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
    favoriteStates.value = List.generate(dietitions.length, (index) => false);
  }

  void _initializeDietitionInfoStates() {
    dietitionInfoStates.value = List.generate(dietitions.length, (index) => false);
  }

  void _generateMenuItems() {
    menuItems.value = [
      MenuModel(title: "Kilo Yönetimi", dietitionCount: 24, iconUrl: "task"),
      MenuModel(title: "Sporcu", dietitionCount: 15, iconUrl: "biceps"),
      MenuModel(title: "Çocuk", dietitionCount: 22, iconUrl: "boy"),
      MenuModel(title: "Hamile", dietitionCount: 9, iconUrl: "pregnant-woman"),
      MenuModel(
          title: "Kronik Hastalık",
          dietitionCount: 6,
          iconUrl: "healthy-heart"),
      MenuModel(
          title: "Gıda ve Alerji", dietitionCount: 14, iconUrl: "airborne"),
      MenuModel(
          title: "Yeme Bozukluğu",
          dietitionCount: 14,
          iconUrl: "eating-disorder"),
      MenuModel(title: "Vegan", dietitionCount: 9, iconUrl: "carrot"),
      MenuModel(
          title: "Kanser Beslenme",
          dietitionCount: 4,
          iconUrl: "healthy-heart"),
      MenuModel(title: "Yaşlı", dietitionCount: 2, iconUrl: "man"),
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

  void toggleDietitionInfoStateItem(int index) {
    // Eğer tıklanan index zaten aktifse, onu kapat
    if (dietitionInfoStates[index]) {
      dietitionInfoStates[index] = false;
    } else {
      // Önce tüm diğer indexleri false yap
      for (int i = 0; i < dietitionInfoStates.length; i++) {
        dietitionInfoStates[i] = false;
      }
      // Sonra tıklanan indexi true yap
      dietitionInfoStates[index] = true;
    }
    dietitionInfoStates.refresh();
  }

  void toggleFavorite(int index) {
    favoriteStates[index] = !favoriteStates[index];
  }

  void closeMenuAndDietitionInfoStates() {
    // Menü filter'ı kapat
    isMenuOpen.value = false;
    // Açık olan diyetisyen bilgi menüsünü kapat
    final openIndex = dietitionInfoStates.indexWhere((state) => state);
    if (openIndex != -1) {
      dietitionInfoStates[openIndex] = false;
      dietitionInfoStates.refresh();
    }
  }
} 