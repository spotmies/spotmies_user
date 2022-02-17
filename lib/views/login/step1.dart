import 'package:flutter/material.dart';
import 'package:spotmies/controllers/login_controller/stepperPersonalInfo_controller.dart';
import 'package:spotmies/providers/theme_provider.dart';
import 'package:spotmies/utilities/appConfig.dart';
import 'package:spotmies/utilities/textWidget.dart';

class Step1 extends StatefulWidget {
  final List? termsAndConditions;
  final StepperPersonal? stepperController;
  final ScrollController? scrollController;
  const Step1(
      {Key? key,
      this.termsAndConditions,
      this.stepperController,
      this.scrollController})
      : super(key: key);

  @override
  _Step1State createState() => _Step1State();
}

// final StepperPersonal _stepperPersonalInfo = StepperPersonal();

class _Step1State extends State<Step1> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(5),
          decoration: BoxDecoration(
              color: SpotmiesTheme.background,
              borderRadius: BorderRadius.circular(10)),
          height: height(context) * 0.72,
          child: widget.termsAndConditions?.length != 0
              ? Container(
                  height: height(context) * 0.7,
                  child: ListView.builder(
                      controller: widget.stepperController?.scrollController,
                      itemCount: widget.termsAndConditions?.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Column(
                          children: [
                            TextWidget(
                              text: "${index + 1}.  " +
                                  widget.termsAndConditions![index].toString(),
                              size: width(context) * 0.06,
                              flow: TextOverflow.visible,
                              color: SpotmiesTheme.onBackground,
                            ),
                            if (index != 7)
                              Divider(
                                color: SpotmiesTheme.equal,
                                indent: width(context) * 0.1,
                                endIndent: width(context) * 0.1,
                              ),
                            if (index ==
                                (widget.termsAndConditions?.length)! - 1)
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Checkbox(
                                      activeColor: Colors.teal,
                                      checkColor: Colors.white,
                                      value: widget.stepperController?.accept,
                                      shape: CircleBorder(),
                                      onChanged: (value) {
                                        setState(() {
                                          widget.stepperController?.accept =
                                              value;
                                          if (widget
                                                  .stepperController?.accept ==
                                              true) {
                                            widget.stepperController?.tca =
                                                'accepted';
                                          }
                                        });
                                        widget.stepperController?.refresh();
                                      }),
                                  Text(
                                    'I agree to accept the terms and Conditions',
                                    style: TextStyle(
                                        fontSize: width(context) * 0.03,
                                        color: SpotmiesTheme.onBackground),
                                  ),
                                ],
                              ),
                          ],
                        );
                      }),
                )
              : CircularProgressIndicator(),
        ),
      ],
    );
  }
}
