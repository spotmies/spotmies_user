class OnboardingModel {
  String image;
  String text;
  String title;

  OnboardingModel(
      {required this.image, required this.text, required this.title});
  static List<OnboardingModel> list = [
    OnboardingModel(
        image: "assets/step1.svg",
        title: "take picture",
        text: "Capture the issue your facing and let the solution come to you"),
    OnboardingModel(
        image: "assets/step2.svg",
        title: "add location",
        text: "Share your location and we share our \nservice"),
    OnboardingModel(
        image: "assets/step3.svg",
        title: "get quotes",
        text: "Choice of cost is yours and \nservice is ours"),
    OnboardingModel(
        image: "assets/step4.svg",
        title: "get service",
        text: "We deliver the right service at the \nright time")
  ];
}
