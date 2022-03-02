class OnboardingModel {
  String image;
  String text;
  String title;

  OnboardingModel(
      {required this.image, required this.text, required this.title});
  static List<OnboardingModel> list = [
    OnboardingModel(
        image: "assets/step1.svg",
        title: "Take A Picture",
        text:
            "Capture the issue your facing and \nlet the solution come to you"),
    OnboardingModel(
        image: "assets/step2.svg",
        title: "Add Your Location",
        text: "Share your location and \nwe share our service"),
    OnboardingModel(
        image: "assets/step3.svg",
        title: "Get Instant Quotes",
        text: "Choice of cost is yours and \nservice is ours"),
    OnboardingModel(
        image: "assets/step4.svg",
        title: "Precise & Quick Service",
        text: "We deliver the right service at the right service")
  ];
}
