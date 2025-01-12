import 'package:flutter/material.dart' show SizedBox, Spacer;

class AppSpaces {

  static AppSpaces? _instance;
  static AppSpaces get instance => _instance ?? AppSpaces();

  get shrinkSpace => const SizedBox.shrink();

  get space => const Spacer(flex: 1);
  get space2 => const Spacer(flex: 2);
  get space3 => const Spacer(flex: 3);
  get space4 => const Spacer(flex: 4);
  get space5 => const Spacer(flex: 5);
  get space6 => const Spacer(flex: 6);
  get space7 => const Spacer(flex: 7);
  get space8 => const Spacer(flex: 8);
  get space9 => const Spacer(flex: 9);
  get space10 => const Spacer(flex: 10);
  get horizontal5 => const SizedBox(width: 5);
  get horizontal8 => const SizedBox(width: 8);
  get horizontal10 => const SizedBox(width: 10);
  get horizontal15 => const SizedBox(width: 15);
  get horizontal20 => const SizedBox(width: 20);
  get horizontal25 => const SizedBox(width: 25);
  get horizontal30 => const SizedBox(width: 30);
  get horizontal35 => const SizedBox(width: 35);
  get horizontal40 => const SizedBox(width: 40);
  get horizontal45 => const SizedBox(width: 45);
  get horizontal50 => const SizedBox(width: 50);
  get vertical5 => const SizedBox(height: 5);
  get vertical10 => const SizedBox(height: 10);
  get vertical15 => const SizedBox(height: 15);
  get vertical20 => const SizedBox(height: 20);
  get vertical25 => const SizedBox(height: 25);
  get vertical30 => const SizedBox(height: 30);
  get vertical35 => const SizedBox(height: 35);
  get vertical40 => const SizedBox(height: 40);
  get vertical45 => const SizedBox(height: 45);
  get vertical50 => const SizedBox(height: 50);
}