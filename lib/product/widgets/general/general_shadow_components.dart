  import 'package:flutter/widgets.dart' show BoxShadow, Color, Offset;

BoxShadow generalComponentsShadow() {
    return const BoxShadow(
                blurRadius: 4,
                offset: Offset(0, 4),
                color: Color.fromRGBO(0, 0, 0, 0.25)
              );
  }