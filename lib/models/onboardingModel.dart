class OnboardingModel {
  String image;
  String text;
  String title;

  OnboardingModel({this.image, this.text, this.title});
  static List<OnboardingModel> list = [
    OnboardingModel(
        image: "lib/assets/1.png",
        title: "take picture",
        text:
            "You can do this. Step up to the cutting board, the oven, or the stovetop with full confidence in your abilities"),
    OnboardingModel(
        image: "lib/assets/2.png",
        title: "add location",
        text:
            "You can do this. Step up to the cutting board, the oven, or the stovetop with full confidence in your abilities"),
    OnboardingModel(
        image: "lib/assets/3.png",
        title: "get quotes from technicians",
        text:
            "You can do this. Step up to the cutting board, the oven, or the stovetop with full confidence in your abilities"),
    OnboardingModel(
        image: "lib/assets/4.png",
        title: "get service instantly",
        text:
            "You can do this. Step up to the cutting board, the oven, or the stovetop with full confidence in your abilities")
  ];
}