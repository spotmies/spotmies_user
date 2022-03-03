import 'package:country_code_picker/country_code_picker.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:provider/provider.dart';
import 'package:spotmies/controllers/login_controller/login_controller.dart';
import 'package:spotmies/providers/theme_provider.dart';
import 'package:spotmies/providers/timer_provider.dart';
import 'package:spotmies/providers/universal_provider.dart';
import 'package:spotmies/utilities/appConfig.dart';
import 'package:spotmies/utilities/fonts.dart';
import 'package:spotmies/utilities/textWidget.dart';

//TextEditingController loginnum = TextEditingController();

class LoginPageScreen extends StatefulWidget {
  @override
  _LoginPageScreenState createState() => _LoginPageScreenState();
}

class _LoginPageScreenState extends StateMVC<LoginPageScreen> {
  late LoginPageController _loginPageController;
  late TimeProvider timerProvider;
  late UniversalProvider up;

  _LoginPageScreenState() : super(LoginPageController()) {
    this._loginPageController = controller as LoginPageController;
  }

  @override
  void initState() {
    super.initState();
    timerProvider = Provider.of<TimeProvider>(context, listen: false);
    up = Provider.of<UniversalProvider>(context, listen: false);
    up.setCurrentConstants("login");
  }

  @override
  Widget build(BuildContext context) {
    // final height(context) = MediaQuery.of(context).size.height -
    //     MediaQuery.of(context).padding.top -
    //     kToolbarHeight;
    // final width(context) = MediaQuery.of(context).size.width;
    return Consumer<TimeProvider>(builder: (context, data, child) {
      return Scaffold(
          key: _loginPageController.scaffoldkey,
          backgroundColor: SpotmiesTheme.background,
          body: ListView(children: [
            Form(
              key: _loginPageController.formkey,
              child: Container(
                // height: height(context) * 1.06,
                width: width(context) * 1,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                              margin: EdgeInsets.only(
                                  top: width(context) * 0.07,
                                  bottom: width(context) * 0.07),
                              child: Row(
                                children: [
                                  Container(
                                      height: height(context) * 0.05,
                                      margin: EdgeInsets.only(
                                          left: width(context) * 0.05,
                                          right: width(context) * 0.03),
                                      child: Image.asset('assets/logo.png')),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      TextWidget(
                                        text: 'SPOTMIES',
                                        // text: up.getText("spotmies_title"),
                                        weight: FontWeight.w600,
                                        size: width(context) * 0.06,
                                        color: SpotmiesTheme.primary,
                                        lSpace: 2.0,
                                      ),
                                      TextWidget(
                                          text: ' EXPERIENCE THE EXELLENCE',
                                          // text: up.getText("spotmies_tagline"),
                                          weight: FontWeight.w600,
                                          size: width(context) * 0.019,
                                          color: SpotmiesTheme.secondaryVariant,
                                          lSpace: 0.7),
                                    ],
                                  )
                                ],
                              )),
                          Container(
                              height: height(context) * 0.35,
                              padding: EdgeInsets.symmetric(
                                  horizontal: width(context) * 0.08),
                              child: SvgPicture.asset('assets/login.svg')),
                          SizedBox(
                            height: height(context) * 0.02,
                          ),
                          Container(
                            width: width(context),
                            margin: EdgeInsets.only(
                                left: width(context) * 0.05,
                                right: width(context) * 0.05),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                TextWidget(
                                  text: 'LOGIN',
                                  weight: FontWeight.w600,
                                  size: width(context) * 0.06,
                                  color: SpotmiesTheme.primary,
                                  lSpace: 1.0,
                                ),
                                SizedBox(
                                  height: height(context) * 0.01,
                                ),
                                TextWidget(
                                  text: 'Please login to continue',
                                  weight: FontWeight.w600,
                                  size: width(context) * 0.035,
                                  color: Colors.grey[500],
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: height(context) * 0.05,
                          ),
                          Container(
                            height: height(context) * 0.3,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                  padding: EdgeInsets.all(4),
                                  constraints: BoxConstraints(
                                      minHeight: height(context) * 0.10,
                                      maxHeight: height(context) * 0.15),
                                  margin: EdgeInsets.only(
                                      top: 0, right: 5, left: 5),
                                  decoration: BoxDecoration(
                                    color: SpotmiesTheme.surfaceVariant,
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  child: Row(
                                    children: [
                                      Container(
                                        width: width(context) * 0.26,
                                        child: CountryCodePicker(
                                          searchDecoration: InputDecoration(
                                            enabledBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: SpotmiesTheme
                                                      .secondaryVariant),
                                            ),
                                            focusedBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: SpotmiesTheme
                                                      .secondaryVariant),
                                            ),
                                            prefixIconColor:
                                                SpotmiesTheme.secondaryVariant,
                                            prefixIcon: Icon(
                                              Icons.search,
                                              color: SpotmiesTheme
                                                  .secondaryVariant,
                                            ),
                                          ),
                                          searchStyle: fonts(
                                              height(context) * 0.025,
                                              FontWeight.w500,
                                              SpotmiesTheme.secondaryVariant),
                                          // flagWidth: width(context) * 0.04,
                                          dialogSize: Size(
                                              width(context) * 0.85,
                                              height(context)),
                                          dialogBackgroundColor:
                                              SpotmiesTheme.surfaceVariant,
                                          boxDecoration: BoxDecoration(
                                            color: SpotmiesTheme.surfaceVariant,
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(8.0)),
                                            boxShadow: [
                                              BoxShadow(
                                                color:
                                                    Colors.grey.withOpacity(1),
                                                spreadRadius: 0,
                                                blurRadius: 0,
                                                offset: Offset(0,
                                                    0), // changes position of shadow
                                              ),
                                            ],
                                          ),
                                          showFlagDialog: true,
                                          initialSelection: "IN",
                                          textStyle: fonts(
                                              width(context) * 0.045,
                                              FontWeight.w600,
                                              SpotmiesTheme.secondaryVariant),
                                          favorite: ["IN"],
                                          onChanged: (item) {
                                            print(item.name);
                                          },
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(
                                            top: 0, right: 0, left: 0),
                                        width: width(context) * 0.69,
                                        decoration: BoxDecoration(
                                          color: SpotmiesTheme.surface,
                                          borderRadius:
                                              BorderRadius.circular(15),
                                        ),
                                        child: TextFormField(
                                          textInputAction: TextInputAction.done,
                                          onFieldSubmitted: (_) {
                                            if (data.loader) return;
                                            _loginPageController.dataToOTP(
                                                context, timerProvider);
                                          },
                                          inputFormatters: <TextInputFormatter>[
                                            FilteringTextInputFormatter.allow(
                                                RegExp(r'[0-9]')),
                                          ],
                                          onSaved: (item) =>
                                              _loginPageController
                                                  .loginModel.loginnum,
                                          style: fonts(
                                              width(context) * 0.045,
                                              FontWeight.w600,
                                              SpotmiesTheme.secondaryVariant),
                                          decoration: InputDecoration(
                                            border: new OutlineInputBorder(
                                                borderSide: new BorderSide(
                                                    color:
                                                        SpotmiesTheme.surface),
                                                borderRadius:
                                                    BorderRadius.circular(15)),
                                            suffixIcon: Icon(
                                              Icons.phone_android,
                                              color: SpotmiesTheme.primary,
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(15)),
                                                borderSide: BorderSide(
                                                    width: 1,
                                                    color:
                                                        SpotmiesTheme.surface)),
                                            enabledBorder: OutlineInputBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(15)),
                                                borderSide: BorderSide(
                                                    width: 1,
                                                    color:
                                                        SpotmiesTheme.surface)),
                                            hintStyle: fonts(
                                                width(context) * 0.045,
                                                FontWeight.w600,
                                                Colors.grey[400]),
                                            hintText: 'Phone number',
                                            // prefix: CountryCodePicker(
                                            //   initialSelection: "IN",
                                            //   favorite: ["+91", "IN"],
                                            //   // onChanged: (item) {
                                            //   //   print(item.name);
                                            //   // },
                                            //   // showCountryOnly: false,
                                            //   // // optional. Shows only country name and flag when popup is closed.
                                            //   // showOnlyCountryWhenClosed: false,
                                            //   // // optional. aligns the flag and the Text left
                                            //   // alignLeft: false,
                                            // ),
                                          ),
                                          validator: (value) {
                                            if (value?.length != 10) {
                                              return 'Please Enter Valid Mobile Number';
                                            }
                                            return null;
                                          },
                                          maxLength: 10,
                                          keyboardAppearance: Brightness.dark,
                                          buildCounter: (BuildContext context,
                                              {int? currentLength,
                                              int? maxLength,
                                              bool? isFocused}) {
                                            return null;
                                          },
                                          keyboardType: TextInputType.number,
                                          controller:
                                              _loginPageController.loginnum,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ]),
                    Container(
                        margin: EdgeInsets.all(10),
                        // width: width(context) * 0.6,
                        // height: height(context) * 0.06,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        // child: ElevatedButtonWidget(
                        //   height: height(context) * 0.06,
                        //   // minWidth: width(context) * 1,
                        // ),
                        child: FloatingActionButton(
                            backgroundColor: SpotmiesTheme.primary,
                            child: data.loader
                                ? CircularProgressIndicator(
                                    color: SpotmiesTheme.surface)
                                : Icon(Icons.arrow_forward_ios),
                            onPressed: () {
                              // _loginPageController.dataToOTP();
                              if (data.loader) return;
                              _loginPageController.dataToOTP(
                                  context, timerProvider);
                            })

                        // child: ElevatedButton(
                        //   style: ButtonStyle(
                        //       backgroundColor:
                        //           MaterialStateProperty.all(Colors.blue[900])),
                        //   onPressed: () {
                        //     _loginPageController.dataToOTP();
                        //   },
                        //   child: Row(
                        //     mainAxisAlignment: MainAxisAlignment.center,
                        //     children: [
                        //       Text(
                        //         'Verify',
                        //         style: TextStyle(color: Colors.white, fontSize: 18),
                        //       ),
                        //       SizedBox(
                        //         width: 10,
                        //       ),
                        //       Icon(
                        //         Icons.verified_user,
                        //         color: Colors.lightGreen,
                        //       )
                        //     ],
                        //   ),
                        // ),
                        ),
                  ],
                ),
              ),
            ),
          ]));
    });
  }
}
