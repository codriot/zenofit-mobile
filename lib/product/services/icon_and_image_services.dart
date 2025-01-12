enum ImageFormat { png, jpg, jpeg,svg}

class AppImageUtility {
  static String getImagePath(String imageName, {ImageFormat format = ImageFormat.png}) {
    String extension;
    switch (format) {
      case ImageFormat.jpg:
        extension = 'jpg';
        break;
      case ImageFormat.jpeg:
        extension = 'jpeg';
        break;
      case ImageFormat.svg:
        extension = "svg";
        break;
      default:
        extension = 'png';
    }
    return "assets/images/$imageName.$extension";
  }
}

enum IconFormat { png , svg }

class AppIconUtility {
  static String getIconPath(String imageName, {IconFormat format = IconFormat.png}) {
    String extension;
    switch (format) {
      case IconFormat.png:
        extension = 'png';
        break;
      case IconFormat.svg:
        extension = "svg";
        break;
      }
    return 'assets/icons/$imageName.$extension';
  }
}
