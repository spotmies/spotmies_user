import 'package:flutter/material.dart';

class PageSlider extends StatefulWidget {
  PageSlider({
    @required this.pages,
    this.duration,
    this.initialPage,
    this.onFinished,
    @required Key key
  }) : super(key: key);

  final List<Widget> pages;
  final Duration duration;
  final int initialPage;
  final VoidCallback onFinished;

  PageSliderState createState() => PageSliderState();
}

class PageSliderState extends State<PageSlider> with TickerProviderStateMixin {
  int _currentPage = 0;
  int get currentPage => _currentPage;

  List<Animation<Offset>> _positions;
  List<AnimationController> _controllers;

  @override
  void initState() { 
    super.initState();
    _currentPage = widget.initialPage ?? 0;

    _controllers = List.generate(
      widget.pages.length, 
      (i) => AnimationController(
        vsync: this,
        duration: widget.duration ?? Duration(milliseconds: 300),
        lowerBound: 0,
        upperBound: 1,
        value: i == _currentPage
          ? 0.5
          : (i > _currentPage ? 1 : 0),
      )
    );

    _positions = _controllers
      .map((controller) =>
        Tween(
          begin: Offset(-1, 0), 
          end: Offset(1, 0)
        )
        //.chain(CurveTween(curve: Curves.easeInCubic))
        .animate(controller)
      ).toList();
  }

  bool get hasNext => (_currentPage < widget.pages.length - 1);
  bool get hasPrevious => (_currentPage > 0);


  void setPage(int page) {
    assert(page >= 0 || page < widget.pages.length);
    while (_currentPage < page) next();
    while (_currentPage > page) previous();
  }

  void next() {
    if (!hasNext) {
      widget.onFinished();
      return;
    }

    _controllers[_currentPage].animateTo(0);
    _controllers[_currentPage + 1].animateTo(0.5);
    setState(() {
      _currentPage += 1;
    });
  }

  void previous() {
    if (!hasPrevious) return;

    _controllers[_currentPage].animateTo(1);
    _controllers[_currentPage - 1].animateTo(0.5);
    setState(() {
      _currentPage -= 1;
    });
  }

  @override
  void dispose() {
    _controllers.forEach((controller) => controller.dispose());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: widget.pages.asMap().map((i, page) =>
        MapEntry(
          i, 
          SlideTransition(
            position: _positions[i],
            child: Center(child: page),
          )
        )
      ).values.toList(),
    );
  }
}



//Theme(
          //       data: ThemeData(
          //         colorScheme: Theme.of(context)
          //             .colorScheme
          //             .copyWith(primary: Colors.indigo[900]),
          //       ),
          //       child: Stepper(
          //           type: StepperType.horizontal,
          //           onStepTapped: (int step) =>
          //               setState(() => _adController.currentStep = step),
          //           controlsBuilder: (BuildContext context,
          //               {VoidCallback onStepContinue,
          //               VoidCallback onStepCancel}) {
          //             return Padding(
          //               padding: const EdgeInsets.only(top: 16.0),
          //               child: Row(
          //                 mainAxisSize: MainAxisSize.max,
          //                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          //                 children: <Widget>[
          //                   Container(
          //                       width: _width * 0.3,
          //                       child: ElevatedButtonWidget(
          //                         onClick: () {
          //                           onStepCancel();
          //                         },
          //                         buttonName: 'Back',
          //                         bgColor: _adController.currentStep > 0
          //                             ? Colors.indigo[50]
          //                             : Colors.white,
          //                         textColor: Colors.indigo[900],
          //                         height: _hight * 0.05,
          //                         textSize: _hight * 0.02,
          //                         leadingIcon: Icon(
          //                           Icons.arrow_back_ios,
          //                           size: _hight * 0.015,
          //                           color: Colors.indigo[900],
          //                         ),
          //                         borderRadius: 10.0,
          //                       )),
          //                   _adController.currentStep ==
          //                           2 // this is the last step
          //                       ? Container(
          //                           width: _width * 0.5,
          //                           child: ElevatedButtonWidget(
          //                             onClick: () {
          //                               onStepContinue();
          //                               CircularProgressIndicator();
          //                               // await _adController.step3();
          //                               // await Navigator.pushAndRemoveUntil(
          //                               //     context,
          //                               //     MaterialPageRoute(
          //                               //         builder: (_) => GoogleNavBar()),
          //                               //     (route) => false);
          //                             },
          //                             buttonName: 'Finish',
          //                             bgColor: Colors.indigo[900],
          //                             textColor: Colors.white,
          //                             height: _hight * 0.05,
          //                             textSize: _hight * 0.02,
          //                             trailingIcon: Icon(
          //                               Icons.arrow_forward_ios,
          //                               size: _hight * 0.015,
          //                             ),
          //                             borderRadius: 10.0,
          //                           ))
          //                       : Container(
          //                           width: _width * 0.5,
          //                           child: ElevatedButtonWidget(
          //                             onClick: () {
          //                               onStepContinue();
          //                             },
          //                             buttonName: 'Next',
          //                             bgColor: Colors.indigo[900],
          //                             textColor: Colors.white,
          //                             height: _hight * 0.05,
          //                             textSize: _hight * 0.02,
          //                             trailingIcon: Icon(
          //                               Icons.arrow_forward_ios,
          //                               size: _hight * 0.015,
          //                             ),
          //                             borderRadius: 10.0,
          //                           )),
          //                 ],
          //               ),
          //             );
          //           },
          //           onStepContinue: _adController.currentStep != 2
          //               ? () => setState(() => _adController.currentStep += 1)
          //               : null,
          //           //    _adController.currentStep == 0
          //           // ? () => setState(() => _adController.step1())
          //           // : _adController.currentStep == 1
          //           //     ? () => setState(() => _adController.step2())
          //           //     : _adController.currentStep == 2
          //           //         ? () => setState(() => print('object'))
          //           //         : null,
          //           onStepCancel: _adController.currentStep > 0
          //               ? () => setState(() => _adController.currentStep -= 1)
          //               : null,
          //           steps: [
          //             Step(
          //               title: Text(''),
          //               subtitle: Text(''),
          //               content: Text('data'),
          //               isActive: _adController.currentStep >= 0,
          //               state: _adController.currentStep >= 0
          //                   ? StepState.complete
          //                   : StepState.disabled,
          //             ),
          //             Step(
          //               title: Text(''),
          //               subtitle: Text(''),
          //               content: Text('data'),
          //               isActive: _adController.currentStep >= 1,
          //               state: _adController.currentStep >= 1
          //                   ? StepState.complete
          //                   : StepState.disabled,
          //             ),
          //             Step(
          //               title: Text(''),
          //               subtitle: Text(''),
          //               content: Text('data'),
          //               isActive: _adController.currentStep >= 2,
          //               state: _adController.currentStep >= 2
          //                   ? StepState.complete
          //                   : StepState.disabled,
          //             ),
          //           ])),
          // )