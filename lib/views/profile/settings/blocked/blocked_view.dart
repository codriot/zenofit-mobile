import 'dart:math';

import 'package:diet_app_mobile/product/services/icon_and_image_services.dart';
import 'package:diet_app_mobile/product/utils/app_utils/const_utils/app_colors.dart';
import 'package:flutter/material.dart';

class BlockedView extends StatelessWidget {
  const BlockedView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Engellenen Hesaplar",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w700,
            )),
        backgroundColor: AppColor.orochimaru.getColor(),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 16.0,
        ),
        child: ListView.builder(
          itemCount: 10,
          itemBuilder: (context, index) {
            return _buildGridViewItem();
          },
        ),
      ),
    );
  }

  Widget _buildGridViewItem() {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            _buildProfileImage(),
            const Spacer(),
            Text(
              "Dyt. ${Random().nextInt(100)}",
              style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
            ),
            const Spacer(
              flex: 4,
            ),
            ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColor.orochimaru.getColor(),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text("Engellemeyi Kaldır",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ))),
          ],
        ),
      ),
    );
  }

  Container _buildProfileImage() {
    return Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        image: DecorationImage(
            image: AssetImage(
              AppImageUtility.getImagePath(
                "person",
              ),
            ),
            fit: BoxFit.contain),
        color: AppColor.crystalBell.getColor(),
      ),
    );
  }
}
