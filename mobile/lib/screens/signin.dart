import 'package:e_garden/configs/AppConfig.dart';
import 'package:e_garden/core/services/user/user_model.service.dart';
import 'package:e_garden/main.dart';
import 'package:e_garden/screens/home.dart';
import 'package:e_garden/screens/study/study.dart';
import 'package:e_garden/widgets/button_green.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:e_garden/application.dart';

class SignIn extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _SignInState();
  }
}

class _SignInState extends State<SignIn> {
  final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();
  // TextEditingController _username = TextEditingController();
  // TextEditingController _password = TextEditingController();
  bool switcherValue = false;
  bool review = false;
  Map<String, dynamic> params;

  @override
  void initState() {
    super.initState();
    // _username = TextEditingController(text: "");
    // _password = TextEditingController(text: "");
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserModel>(context);
    // TODO: implement build
    return Scaffold(
      body: SingleChildScrollView(
        child: FormBuilder(
          key: _fbKey,
          autovalidateMode: AutovalidateMode.disabled,
          child: Column(
            children: [
              SizedBox(
                height: SizeConfig.screenHeight * 0.25,
              ),
              Text(
                "E-Garden",
                style: TextStyle(
                    fontSize: 50,
                    color: AppColors.green,
                    fontWeight: FontWeight.w600),
              ),
              SizedBox(
                height: SizeConfig.screenHeight * 0.05,
              ),
              SizedBox(
                width: SizeConfig.safeBlockHorizontal * 80,
                child: FormBuilderTextField(
                  attribute: "user_name",
                  validators: [FormBuilderValidators.required()],
                  style: TextStyle(
                      fontSize: SizeConfig.safeBlockVertical * 2.5,
                      color: AppColors.green),
                  // controller: _username,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.only(
                        left: SizeConfig.safeBlockHorizontal * 5,
                        right: SizeConfig.safeBlockHorizontal * 3,
                        top: SizeConfig.safeBlockVertical * 2,
                        bottom: SizeConfig.safeBlockVertical * 2),
                    border: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: AppColors.green, width: 5),
                        borderRadius: BorderRadius.circular(15)),
                    labelText: "Username",
                    hintText: "Username",
                    alignLabelWithHint: false,
                    labelStyle: TextStyle(
                        fontSize: SizeConfig.safeBlockVertical * 2.5,
                        fontWeight: FontWeight.w600),
                  ),
                ),
              ),
              SizedBox(
                height: SizeConfig.safeBlockVertical * 3,
              ),
              SizedBox(
                width: SizeConfig.safeBlockHorizontal * 80,
                child: FormBuilderTextField(
                  validators: [FormBuilderValidators.required()],
                  attribute: "password",
                  style: TextStyle(
                      fontSize: SizeConfig.safeBlockVertical * 2.5,
                      color: AppColors.green),
                  obscureText: review,
                  // controller: _password,
                  decoration: InputDecoration(
                    suffixIcon: IconButton(
                      icon: review
                          ? Icon(Icons.visibility_off)
                          : Icon(Icons.visibility),
                      onPressed: () {
                        setState(() {
                          review = !review;
                        });
                      },
                    ),
                    contentPadding: EdgeInsets.only(
                        left: SizeConfig.safeBlockHorizontal * 5,
                        right: SizeConfig.safeBlockHorizontal * 3,
                        top: SizeConfig.safeBlockVertical * 2,
                        bottom: SizeConfig.safeBlockVertical * 2),
                    border: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: AppColors.green, width: 5),
                        borderRadius: BorderRadius.circular(15)),
                    labelText: "Password",
                    alignLabelWithHint: false,
                    labelStyle: TextStyle(
                        // color: AppTheme.buttonBlend2,
                        fontSize: SizeConfig.safeBlockVertical * 2.5,
                        fontWeight: FontWeight.w600),
                    hintText: "Enter Password",
                  ),
                ),
              ),
              SizedBox(
                height: SizeConfig.safeBlockVertical * 5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Checkbox(
                      value: switcherValue,
                      onChanged: (change) => setState(() {
                            switcherValue = change;
                          })),
                  SizedBox(
                    width: SizeConfig.safeBlockHorizontal * 1,
                  ),
                  Text(
                    "Remember Account",
                    style: TextStyle(
                        color: Color(0xFF848484), fontWeight: FontWeight.w600),
                  )
                ],
              ),
              SizedBox(
                height: SizeConfig.safeBlockVertical * 5,
              ),
              user.status == Status.Authenticating
                  ? Center(child: CircularProgressIndicator())
                  : ButtonGreen(
                      height: SizeConfig.safeBlockVertical * 7,
                      width: SizeConfig.safeBlockHorizontal * 40,
                      text: "Log In",
                press: () async {
                  (_fbKey.currentState.saveAndValidate())
                      ? (await user.login(_fbKey.currentState.value))
                      ? Navigator.push(context, MaterialPageRoute(builder: (context)=>HomeScreen()))
                      : Fluttertoast.showToast(
                    msg: user.message,
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.BOTTOM,
                    timeInSecForIosWeb: 1,
                    backgroundColor: Colors.black45,
                    textColor: Colors.white,
                    fontSize: 16.0,
                  )
                      : Fluttertoast.showToast(
                    msg: "Invalid Value",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.BOTTOM,
                    timeInSecForIosWeb: 1,
                    backgroundColor: Colors.black45,
                    textColor: Colors.white,
                    fontSize: 16.0,
                  );
                },)
            ],
          ),
        ),
      ),
    );
  }
}
