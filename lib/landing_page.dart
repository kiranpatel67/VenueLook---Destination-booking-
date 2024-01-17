import 'package:flutter/material.dart';
import 'button.dart';
import 'enter_mobile_number.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:get/get.dart';

class IntroController extends GetxController {
  final RxInt currentIndex = 0.obs;

  void incrementIndex() {
    currentIndex.value++;
  }
}

// class IntroPage extends StatefulWidget {
//   const IntroPage({super.key});
//
//   @override
//   State<IntroPage> createState() => _IntroPageState();
// }
//
// class _IntroPageState extends State<IntroPage> {
//
//   final Uri _url = Uri.parse('https://fograph.com/beta-tester-policies');
//
//   @override
//   Widget build(BuildContext context) {
//     // double screenwidth = MediaQuery.of(context).size.width;
//     double screenheight = MediaQuery.of(context).size.height;
//     return Scaffold(
//       backgroundColor: Colors.black,
//       body: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         crossAxisAlignment: CrossAxisAlignment.stretch,
//         children: [
//           const Expanded(
//               flex: 8,
//               child: Image(image: AssetImage('asset/img/fograph_logo.png'))),
//           Expanded(
//             flex: 2,
//             child: Padding(
//               padding: const EdgeInsets.only(left: 10),
//               child: Stack(
//                 alignment: AlignmentDirectional.topStart,
//                 children: [
//                   DefaultTextStyle(
//                     style: const TextStyle(
//                       fontSize: 21,
//                       color: Colors.white
//                     ),
//                     child: AnimatedTextKit(
//                       repeatForever: true,
//                       isRepeatingAnimation: true,
//                       animatedTexts: [
//                         FadeAnimatedText('Join the #FoGraph community & become a FoGrapher'),
//                         FadeAnimatedText('Hassle-free destination booking'),
//                         FadeAnimatedText('Premium location for Affordable prices'),
//                       ],
//                     ),
//                   ),
//                   Positioned(
//                     top: screenheight * 0.09,
//                     child: GreenButton(
//                         text: 'GET STARTED',
//                       onPressed: (){
//                           Navigator.push(context, MaterialPageRoute(builder: (context)=>EnterPhone()));
//                       },
//                     )
//                   ),
//                 ],
//               ),
//             ),
//           ),
//           Expanded(
//             flex: 1,
//             child: Align(
//               alignment: AlignmentDirectional.centerStart,
//               child: Padding(
//                 padding: const EdgeInsets.all(10.0),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start, // Align children to the start
//                   children: [
//                     const Text(
//                       'By clicking Get Started you agree to our',
//                       style: TextStyle(
//                         color: Colors.green,
//                         fontStyle: FontStyle.italic,
//                       ),
//                     ),
//                     InkWell(
//                       onTap: (){
//                         launchUrl(_url);
//                       },
//                       child: const Text(
//                         'Terms & Conditions',
//                         style: TextStyle(
//                             color: Colors.green,
//                             fontStyle: FontStyle.italic,
//                             decoration: TextDecoration.underline,
//                             decorationColor: Colors.green,
//                             decorationStyle: TextDecorationStyle.solid
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }


class IntroPage extends StatelessWidget {
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
                    style: const TextStyle(fontSize: 21, color: Colors.white),
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
                        Get.to(EnterPhone());
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
                    const Text(
                      'By clicking Get Started you agree to our',
                      style: TextStyle(
                        color: Colors.green,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        launchUrl(_url);
                      },
                      child: const Text(
                        'Terms & Conditions',
                        style: TextStyle(
                          color: Colors.green,
                          fontStyle: FontStyle.italic,
                          decoration: TextDecoration.underline,
                          decorationColor: Colors.green,
                          decorationStyle: TextDecorationStyle.solid,
                        ),
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
