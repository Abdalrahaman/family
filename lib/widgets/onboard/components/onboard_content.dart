import 'package:family/customs/elevated_default_button.dart';
import 'package:family/routes.dart';
import 'package:family/size_config.dart';
import 'package:family/values/colors.dart';
import 'package:family/widgets/home/home_widget.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnBoardContent extends StatefulWidget {
  final String header;
  final String text;
  final String image;
  final bool isFinished;
  const OnBoardContent({
    Key? key,
    required this.header,
    required this.text,
    required this.image,
    required this.isFinished,
  }) : super(key: key);

  @override
  State<OnBoardContent> createState() => _OnBoardContentState();
}

class _OnBoardContentState extends State<OnBoardContent> {
  final _deviceNameController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Expanded(
            flex: 3,
            child: Image.asset(
              widget.image,
              fit: BoxFit.cover,
            ),
          ),
          Expanded(
            flex: 2,
            child: widget.isFinished ? onboardInput() : onboardInfo(),
          ),
        ],
      ),
    );
  }

  Container onboardInfo() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 40.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            widget.header,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: fPrimaryColor,
              fontSize: 30,
              fontWeight: FontWeight.w700,
            ),
          ),
          Text(
            widget.text,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }

  Form onboardInput() {
    return Form(
      key: _formKey,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 40.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              widget.header,
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: fPrimaryColor,
                  fontSize: 30,
                  fontWeight: FontWeight.bold),
            ),
            buildDeviceNameFormField(),
            ElevatedDefaultButton(
                text: "Let's go",
                width: getProportionateScreenWidth(150),
                height: getProportionateScreenHeight(40),
                press: () async {
                  if (_formKey.currentState!.validate()) {
                    await _storeOnboardInfo(_deviceNameController.text);
                    await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: routes[HomeWidget.routeName]!,
                        ));
                  }
                }),
          ],
        ),
      ),
    );
  }

  TextFormField buildDeviceNameFormField() {
    return TextFormField(
      keyboardType: TextInputType.name,
      controller: _deviceNameController,
      onChanged: (value) {},
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your name';
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Name",
        hintText: widget.text,
        floatingLabelBehavior: FloatingLabelBehavior.always,
      ),
    );
  }

  Future<void> _storeOnboardInfo(String deviceName) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('onBoardCreated', true);
    await prefs.setString('deviceName', deviceName);
  }
}
