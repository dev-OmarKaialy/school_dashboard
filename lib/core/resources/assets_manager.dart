class ImageAssets {
  const ImageAssets._();
  static String get appIcon => 'app_icon'.jpg;
}

class AnimationsAssets {
  const AnimationsAssets._();
}

class IconsAssets {
  const IconsAssets._();
  static String get passwordIcon => 'password'.svg;
  static String get userNameIcon => 'user'.svg;
  static String get editIcon => 'edit'.svg;
  static String get trashIcon => 'trash'.svg;
  static String get detailsIcon => 'assets/icons/details.png';
  static String get idIcon => 'id'.png;
  static String get categoryIcon => 'category'.svg;
  static String get homeIcon => 'home'.svg;
  static String get questionIcon => 'question'.svg;
  static String get quizIcon => 'quiz'.svg;
  static String get levelIcon => 'level'.svg;
  static String get roadmapIcon => 'roadmap'.svg;
}

extension on String {
  String get png => 'assets/images/$this.png';
  String get svg => 'assets/icons/$this.svg';
  String get jpg => 'assets/images/$this.jpg';
}
