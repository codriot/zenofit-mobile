import 'package:flutter/material.dart'
    show BuildContext, MediaQueryData, ThemeData, MediaQuery, Theme, TextTheme;

class ContextAppGeneralExtension {
  ContextAppGeneralExtension(BuildContext context) : _context = context;
  final BuildContext _context;

  MediaQueryData get mediaQuery => MediaQuery.of(_context);
  ThemeData get theme => Theme.of(_context);
  TextTheme get textTheme => Theme.of(_context).textTheme;
}

extension AppGeneralExtension on BuildContext {
  ContextAppGeneralExtension get appGeneral => ContextAppGeneralExtension(this);
}
