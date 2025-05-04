import 'dart:math';
import 'package:diet_app_mobile/model/discover/discover_item_model.dart';
import 'package:diet_app_mobile/model/general/comment_model.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class DiscoverController extends GetxController {
  var allItems = <DiscoverItemModel>[];      // Tüm öğeler (sabit veri)
  var items = <DiscoverItemModel>[].obs;     // Görüntülenecek filtrelenmiş veri
  var searchText = ''.obs;

  var isLoading = false.obs;
  var hasMoreItems = true.obs;
  var isMenuOpen = false.obs;
  var activeFilterIndex = (0).obs;

  final TextEditingController discoverTextEditingController =
      TextEditingController();

  @override
  void onInit() {
    super.onInit();
    loadInitialItems();
  }

  void loadInitialItems() {
    final List<DiscoverItemModel> initialItems = List.generate(10, (index) {
      String type = index % 2 == 0 ? 'post' : 'video';
      String imageUrl = 'https://picsum.photos/200?random=${Random().nextInt(1000)}';
      return DiscoverItemModel(
        type: type,
        imageUrl: imageUrl,
        description:
            "Lorem ipsum dolor sit amet, consectetur adipiscing elit. $index",
        likeCount: Random().nextInt(1000),
        commentCount: Random().nextInt(100),
        comments: List.generate(
          10,
          (index) => CommentModel(
            userProfileUrl: 'https://picsum.photos/50?random=${Random().nextInt(1000)}',
            userName: 'Kullanıcı ${index + 1}',
            date: DateTime.now().subtract(Duration(days: index)).toString(),
            likeCount: Random().nextInt(100).toString(),
            comment: "Bu bir yorumdur. ${index + 1}",
          ),
        ),
      );
    });

    allItems = initialItems;
    items.assignAll(allItems);
  }

  void loadMoreItems() async {
    if (isLoading.value || !hasMoreItems.value) return;

    isLoading.value = true;
    await Future.delayed(Duration(seconds: 2));

    if (allItems.length < 100) {
      final newItems = List.generate(10, (index) {
        String type = (allItems.length + index) % 2 == 0 ? 'post' : 'video';
        String imageUrl = 'https://picsum.photos/200?random=${Random().nextInt(1000)}';
        return DiscoverItemModel(
          type: type,
          imageUrl: imageUrl,
          description: "Açıklama ${allItems.length + index + 1}",
          likeCount: Random().nextInt(1000),
          commentCount: Random().nextInt(100),
          comments: List.generate(
            10,
            (index) => CommentModel(
              userProfileUrl: 'https://picsum.photos/50?random=${Random().nextInt(1000)}',
              userName: 'Kullanıcı ${index + 1}',
              date: DateTime.now().subtract(Duration(days: index)).toString(),
              likeCount: Random().nextInt(100).toString(),
              comment: "Bu bir yorumdur. ${index + 1}",
            ),
          ),
        );
      });

      allItems.addAll(newItems);
      items.assignAll(allItems.where((item) =>
        item.description.toLowerCase().contains(searchText.value.toLowerCase())));
    } else {
      hasMoreItems.value = false;
    }

    isLoading.value = false;
  }

  bool onNotification(ScrollNotification scrollInfo) {
    if (!isLoading.value && scrollInfo.metrics.pixels == scrollInfo.metrics.maxScrollExtent) {
      loadMoreItems();
    }
    return true;
  }

  void toggleMenuOpen() {
    isMenuOpen.value = !isMenuOpen.value;
  }

  void makeMenuOpenVal() {
    isMenuOpen.value = false;
  }

  void toggleFilter(int index) {
    if (activeFilterIndex.value == index) {
      activeFilterIndex.value = -1;
    } else {
      activeFilterIndex.value = index;
    }
  }

  void searchItems(String query) {
    searchText.value = query;

    if (query.isEmpty) {
      items.assignAll(allItems);
    } else {
      items.assignAll(
        allItems.where((item) =>
            item.description.toLowerCase().contains(query.toLowerCase())),
      );
    }
  }

  void clearSearch() {
    searchText.value = "";
    discoverTextEditingController.clear();
    items.assignAll(allItems);
  }
}
