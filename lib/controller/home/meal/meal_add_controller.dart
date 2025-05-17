import 'package:get/get.dart';

class MealAddController extends GetxController {
  // Seçili gün için RxInt (0'dan başlayarak)
  final RxInt selectedDayIndex = 3.obs;
  
  // Günlerin listesi
  final RxList<DateTime> days = <DateTime>[].obs;

  @override
  void onInit() {
    super.onInit();
    // Bugünün tarihinden başlayarak 7 günlük liste oluştur
    final now = DateTime.now();
    days.value = List.generate(
      7,
      (index) => now.add(Duration(days: index - 3)), // 3 gün önceden başla
    );
  }

  // Gün seçme fonksiyonu
  void selectDay(int index) {
    selectedDayIndex.value = index;
  }

  // Seçili günün tarihini döndüren getter
  DateTime get selectedDate => days[selectedDayIndex.value];

  // Tarih formatını döndüren fonksiyon
  String getFormattedDate(DateTime date) {
    if (date.day == DateTime.now().day &&
        date.month == DateTime.now().month &&
        date.year == DateTime.now().year) {
      return 'Bugün, ${date.day} ${getMonthName(date.month)}';
    }
    return '${date.day} ${getMonthName(date.month)}';
  }

  // Ay ismini döndüren fonksiyon
  String getMonthName(int month) {
    const months = [
      'Ocak',
      'Şubat',
      'Mart',
      'Nisan',
      'Mayıs',
      'Haziran',
      'Temmuz',
      'Ağustos',
      'Eylül',
      'Ekim',
      'Kasım',
      'Aralık'
    ];
    return months[month - 1];
  }
} 