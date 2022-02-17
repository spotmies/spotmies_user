import 'package:flutter/material.dart';
import 'package:spotmies/controllers/login_controller/stepperPersonalInfo_controller.dart';
import 'package:spotmies/providers/theme_provider.dart';
import 'package:spotmies/utilities/appConfig.dart';

class Step2 extends StatefulWidget {
  final StepperPersonal? stepperController;
  const Step2({Key? key, this.stepperController}) : super(key: key);

  @override
  _Step2State createState() => _Step2State();
}

class _Step2State extends State<Step2> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: height(context) * 0.72,
          child: ListView(
            children: [
              Container(
                // padding: EdgeInsets.all(10),
                height: height(context) * 0.1,
                width: width(context) * 1,
                decoration: BoxDecoration(
                    color: SpotmiesTheme.background,
                    borderRadius: BorderRadius.circular(15)),
                child: TextFormField(
                  style: TextStyle(color: SpotmiesTheme.onBackground),
                  onSaved: (item) =>
                      widget.stepperController?.stepperPersonalModel.name,
                  keyboardType: TextInputType.name,
                  controller: widget.stepperController?.nameTf,
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                        borderSide: BorderSide(
                            width: 1, color: SpotmiesTheme.background)),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                        borderSide: BorderSide(
                            width: 1, color: SpotmiesTheme.background)),
                    hintStyle: TextStyle(
                        fontSize: 17, color: SpotmiesTheme.onBackground),
                    hintText: 'Name',

                    suffixIcon: Icon(Icons.person),
                    //border: InputBorder.none,
                    contentPadding: EdgeInsets.all(20),
                  ),
                  validator: (value) {
                    if (value != null && value.isEmpty) {
                      return 'Please Enter Your Name';
                    }
                    if (value != null && value.length < 5)
                      return 'name should be greater than 4 letters';
                    return null;
                  },
                  onChanged: (value) {
                    this.widget.stepperController?.name = value;
                  },
                ),
              ),
              SizedBox(
                height: 7,
              ),
              Container(
                //padding: EdgeInsets.all(10),
                height: height(context) * 0.1,
                width: width(context) * 1,
                decoration: BoxDecoration(
                    color: SpotmiesTheme.background,
                    borderRadius: BorderRadius.circular(15)),
                child: TextFormField(
                  style: TextStyle(color: SpotmiesTheme.onBackground),
                  onSaved: (item) =>
                      widget.stepperController?.stepperPersonalModel.email,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                        borderSide: BorderSide(
                            width: 1, color: SpotmiesTheme.background)),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                        borderSide: BorderSide(
                            width: 1, color: SpotmiesTheme.background)),
                    hintStyle:
                        TextStyle(fontSize: 17, color: SpotmiesTheme.equal),
                    hintText: 'Email(Optional)',
                    suffixIcon: Icon(Icons.email),
                    //border: InputBorder.none,
                    contentPadding: EdgeInsets.all(20),
                  ),
                  validator: (value) {
                    if (value != null &&
                        value.length > 1 &&
                        !value.contains('@')) {
                      return 'Please Enter Valid Email';
                    }
                    return null;
                  },
                  controller: widget.stepperController?.emailTf,
                  onChanged: (String? value) {
                    this.widget.stepperController?.email = value ?? "";
                  },
                ),
              ),
              SizedBox(
                height: 7,
              ),
              Container(
                //padding: EdgeInsets.all(10),
                height: height(context) * 0.1,
                width: width(context) * 1,
                decoration: BoxDecoration(
                    color: SpotmiesTheme.background,
                    borderRadius: BorderRadius.circular(15)),
                child: TextFormField(
                  style: TextStyle(color: SpotmiesTheme.onBackground),
                  maxLength: 10,
                  onSaved: (item) =>
                      widget.stepperController?.stepperPersonalModel.altnumber,
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    // labelText: "optional",
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                        borderSide: BorderSide(
                            width: 1, color: SpotmiesTheme.background)),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                        borderSide: BorderSide(
                            width: 1, color: SpotmiesTheme.background)),
                    hintStyle:
                        TextStyle(fontSize: 17, color: SpotmiesTheme.equal),
                    hintText: 'Alternative Mobile (optional)',
                    suffixIcon: Icon(Icons.dialpad),
                    //border: InputBorder.none,
                    contentPadding: EdgeInsets.all(20),
                    counterText: "",
                  ),
                  validator: (value) {
                    if (value != null &&
                        value.length == 10 &&
                        int.parse(value) < 5000000000) {
                      return 'Please Enter Valid Mobile Number';
                    } else if (value != null &&
                        value.length > 0 &&
                        value.length < 10) {
                      return 'Please Enter Valid Mobile Number';
                    }
                    return null;
                  },
                  controller: widget.stepperController?.altnumberTf,
                  onChanged: (String? value) {
                    this.widget.stepperController?.altnumber = value ?? "";
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
