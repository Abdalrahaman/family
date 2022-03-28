import 'package:family/size_config.dart';
import 'package:family/values/colors.dart';
import 'package:family/widgets/onboard/components/onboard_content.dart';
import 'package:flutter/material.dart';

class OnBoardBody extends StatefulWidget {
  const OnBoardBody({Key? key}) : super(key: key);

  @override
  State<OnBoardBody> createState() => _OnBoardBodyState();
}

class _OnBoardBodyState extends State<OnBoardBody> {
  int _currentPage = 0;
  Set<Map<String, String>> _onboardData = {
    {
      "header": "Welcome to Family",
      "text":
          "Gather your family members and enjoy the features such as notification, chat and more.",
      "image": "assets/images/onboard_main_img.jpg"
    },
    {
      "header": "Notify",
      "text": "Alert when connect to any family member to take action.",
      "image": "assets/images/onboard_alert_img.png"
    },
    {
      "header": "Chat",
      "text":
          "Family members can chat with each other without access to the Internet.",
      "image": "assets/images/onboard_chat_img.png"
    },
    {
      "header": "Enter your name in Family",
      "text": "Enter your name in Family",
      "image": "assets/images/open_house.jpg"
    },
  };
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Column(
      children: [
        Expanded(
            flex: 2,
            child: PageView.builder(
              itemCount: _onboardData.length,
              onPageChanged: (value) {
                setState(() {
                  _currentPage = value;
                });
              },
              itemBuilder: (context, index) => OnBoardContent(
                header: _onboardData.elementAt(index)["header"]!,
                text: _onboardData.elementAt(index)["text"]!,
                image: _onboardData.elementAt(index)["image"]!,
                isFinished: _onboardData.length - 1 == index ? true : false,
              ),
            )),
        Padding(
          padding: EdgeInsets.symmetric(
              vertical: getProportionateScreenHeight(10.0)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children:
                List.generate(_onboardData.length, (index) => buildDot(index)),
          ),
        ),
      ],
    );
  }

  AnimatedContainer buildDot(int index) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 200),
      margin: const EdgeInsets.only(right: 5),
      height: 6,
      width: _currentPage == index ? 20 : 6,
      decoration: BoxDecoration(
        color: _currentPage == index ? fPrimaryColor : Color(0xffd8d8d8),
        borderRadius: BorderRadius.circular(3),
      ),
    );
  }
}
