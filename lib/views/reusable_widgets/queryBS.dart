import 'package:flutter/material.dart';
import 'package:spotmies/utilities/appConfig.dart';
import 'package:spotmies/utilities/elevatedButtonWidget.dart';
import 'package:spotmies/utilities/textFormFieldWidget.dart';
import 'package:spotmies/views/reusable_widgets/text_wid.dart';

newQueryBS(BuildContext context,
    {Function onSubmit,
    String type = "text",
    String heading = "Rise a new query",
    String hint = "Ask Question",
    String label = "Enter Here"}) {
  TextEditingController queryControl = TextEditingController();
  GlobalKey<FormState> queryForm = GlobalKey<FormState>();
  // bool loader = false;
  return showModalBottomSheet(
      context: context,
      elevation: 22,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
      builder: (BuildContext context) {
        // if (loader)
        //   return Center(
        //     child: CircularProgressIndicator(),
        //   );
        return Container(
          height: height(context) * 0.47,
          margin: EdgeInsets.only(
              left: 10,
              right: 10,
              top: 10,
              bottom: MediaQuery.of(context).viewInsets.bottom),
          child: Form(
            key: queryForm,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextWid(
                    text: heading,
                    size: width(context) * 0.06,
                    weight: FontWeight.w600,
                    flow: TextOverflow.visible,
                    align: TextAlign.center),
                TextFieldWidget(
                  label: label,
                  hint: hint,
                  enableBorderColor: Colors.grey,
                  focusBorderColor: Colors.indigo[900],
                  enableBorderRadius: 15,
                  controller: queryControl,
                  isRequired: true,
                  focusBorderRadius: 15,
                  errorBorderRadius: 15,
                  focusErrorRadius: 15,
                  autofocus: true,
                  type: type,
                  maxLength: 500,
                  validateMsg: 'Please check above text',
                  maxLines: type == "text" ? 9 : 1,
                  postIcon: Icon(Icons.change_circle),
                  postIconColor: Colors.indigo[900],
                ),
                Container(
                  padding: EdgeInsets.all(5),
                  child: ElevatedButtonWidget(
                    bgColor: Colors.indigo[900],
                    minWidth: width(context),
                    height: height(context) * 0.06,
                    textColor: Colors.white,
                    buttonName: 'Submit',
                    textSize: width(context) * 0.05,
                    textStyle: FontWeight.w600,
                    borderRadius: 10.0,
                    borderSideColor: Colors.indigo[50],
                    onClick: () async {
                      if (queryForm.currentState.validate()) {
                        if (onSubmit != null) {
                          onSubmit(queryControl.text);
                          Navigator.pop(context);
                        }
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      });
}
