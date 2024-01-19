import 'package:flutter/material.dart';
import 'package:FoGraph/routes/app_route.dart';
import 'package:FoGraph/utils/constant/app_textstyles.dart';
import '../../custom_button.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:get/get.dart';

class IntroController extends GetxController {
  final RxInt currentIndex = 0.obs;

  void incrementIndex() {
    currentIndex.value++;
  }
}


class LandingPage extends StatelessWidget {
  final IntroController introController = Get.put(IntroController());

  final Uri _url = Uri.parse('https://fograph.com/beta-tester-policies');

  @override
  Widget build(BuildContext context) {
    double screenheight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            flex: 8,
            child: Image(image: AssetImage('asset/img/fograph_logo.png')),
          ),
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Stack(
                alignment: AlignmentDirectional.topStart,
                children: [
                  DefaultTextStyle(
                    style: AppTextStyles.title,
                    child: AnimatedTextKit(
                      repeatForever: true,
                      isRepeatingAnimation: true,
                      animatedTexts: [
                        FadeAnimatedText(
                            'Join the #FoGraph community & become a FoGrapher'),
                        FadeAnimatedText('Hassle-free destination booking'),
                        FadeAnimatedText(
                            'Premium location for Affordable prices'),
                      ],
                    ),
                  ),
                  Positioned(
                    top: screenheight * 0.09,
                    child: GreenButton(
                      text: 'GET STARTED',
                      onPressed: () {
                        introController.incrementIndex();
                        Get.toNamed(AppRoute.loginPage);
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Align(
              alignment: AlignmentDirectional.centerStart,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'By clicking Get Started you agree to our',
                      style: TermHeadingStyle.primary
                    ),
                    InkWell(
                      onTap: () {
                        launchUrl(_url);
                      },
                      child: Text(
                        'Terms & Conditions',
                        style: TermHeadingStyle.secondary
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
