import 'package:flutter/material.dart';
import 'package:spotmies/controllers/login_controller/stepperPersonalInfo_controller.dart';
import 'package:spotmies/providers/theme_provider.dart';
import 'package:spotmies/providers/timer_provider.dart';
import 'package:spotmies/utilities/appConfig.dart';

class Step3 extends StatefulWidget {
  final StepperPersonal? stepperController;
  final TimeProvider? timerProvider;
  const Step3({Key? key, this.stepperController, this.timerProvider})
      : super(key: key);

  @override
  _Step3State createState() => _Step3State();
}

class _Step3State extends State<Step3> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: height(context) * 0.72,
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Text(
              'Profile Picture',
              style: TextStyle(fontSize: 25, color: SpotmiesTheme.onBackground),
            ),
            SizedBox(
              height: 10,
            ),
            Center(
              child: Container(
                padding: EdgeInsets.all(10),
                height: 220,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: SpotmiesTheme.background,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30)),
                  // border: Border.all()
                ),
                child: CircleAvatar(
                  child: Center(
                    child: widget.stepperController?.profilepic == null
                        ? Icon(
                            Icons.person,
                            color: SpotmiesTheme.dull,
                            size: width(context) * 0.3,
                          )
                        : Container(
                            height: height(context) * 0.27,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                            ),
                            child: widget.stepperController?.profilepic != null
                                ? CircleAvatar(
                                    backgroundColor: SpotmiesTheme.onBackground,
                                    backgroundImage: FileImage(
                                        widget.stepperController!.profilepic!),
                                    radius: width(context) * 0.2,
                                  )
                                : SizedBox(),
                          ),
                  ),
                  radius: 30,
                  backgroundColor: SpotmiesTheme.onSurface,
                ),
              ),
            ),
            Container(
              height: 40,
              width: double.infinity,
              decoration: BoxDecoration(
                color: SpotmiesTheme.background,
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30)),
                // border: Border.all()
              ),
              child: TextButton(
                  onPressed: () async {
                    await widget.stepperController?.profilePic();
                    setState(() {});
                  },
                  // icon: Icon(Icons.select_all),
                  child: Text(
                    'Choose Image',
                    style: TextStyle(
                        fontSize: 18, color: SpotmiesTheme.onBackground),
                  )),
              // child: FlatButton(color:Colors.blue[700], onPressed: (){}, child: Text('Choose image')),
            ),
            SizedBox(
              height: 65,
            ),
            if (widget.stepperController?.profilepic == null)
              TextButton(
                  onPressed: () {
                    widget.stepperController
                        ?.step3(context, widget.timerProvider);
                  },
                  child: Text('Skip',
                      style:
                          TextStyle(fontSize: 20, color: SpotmiesTheme.equal)))
          ]),
        )
      ],
    );
  }
}
