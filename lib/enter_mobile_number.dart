import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'button.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class EnterPhoneController extends GetxController {
  final RxBool animationPlayed = false.obs;
  final TextEditingController textEditingController = TextEditingController();

  void showSnackbar(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Snack bar Message'),
        duration: const Duration(seconds: 2),
        action: SnackBarAction(
          label: 'Undo',
          onPressed: () {
            // Handle undo action here
          },
        ),
      ),
    );
  }
}



class EnterPhone extends StatelessWidget {
  final EnterPhoneController enterPhoneController = Get.put(EnterPhoneController());


  EnterPhone({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenwidth = MediaQuery.of(context).size.width;
    double screenheight = MediaQuery.of(context).size.height;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.black,
      body: Column(
        children: [
          Expanded(
            flex: 9,
            child: Padding(
              padding: EdgeInsets.only(
                top: screenheight * 0.1,
                left: screenwidth * 0.06,
              ),
              child: Stack(
                children: [
                  Obx(
                        () => enterPhoneController.animationPlayed.value
                        ? Text(
                      'Mobile',
                      style: TextStyle(
                        fontSize: screenheight * 0.06,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.left,
                    )
                        : TypewriterAnimatedTextKit(
                      text: const ['Mobile\nNumber'],
                      textStyle: TextStyle(
                        fontSize: screenheight * 0.06,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.left,
                      totalRepeatCount: 1,
                      repeatForever: false,
                      speed: const Duration(milliseconds: 200),
                      pause: const Duration(milliseconds: 1000),
                    ),
                  ),
                  Align(
                    alignment: AlignmentDirectional.center,
                    child: Container(
                      margin: EdgeInsets.only(
                        top: screenheight * 0.26,
                        left: screenwidth * 0.0002,
                        right: screenwidth*0.0002
                      ),
                      child: Column(
                        children: [
                          GestureDetector(
                            onTap: () {
                              enterPhoneController.showSnackbar(context);
                            },
                            child: Row(
                              children: [
                                Padding(
                                  padding: EdgeInsets.symmetric(vertical: screenheight*0.01),
                                  child: Text(
                                    'India +91',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: screenheight * 0.024,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Flexible(

                            child: Container(
                              padding: EdgeInsets.only(right: screenheight*0.02),
                              alignment: AlignmentDirectional.topCenter,
                              child: TextField(
                                keyboardType: TextInputType.phone,
                                controller: enterPhoneController.textEditingController,
                                decoration: InputDecoration(
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(screenheight*0.02),
                                    borderSide: BorderSide(
                                      color: Colors.green
                                    )
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(screenheight*0.02)
                                  ),
                                  labelText: 'Enter mobile number',
                                  floatingLabelBehavior: FloatingLabelBehavior.auto,
                                  labelStyle: TextStyle(
                                    color: Colors.grey,
                                  ),
                                  filled: true,
                                  fillColor: Colors.white, // Set the background color
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Stack(
                alignment: AlignmentDirectional.topStart,
                children: [
                  const Text(
                    'Your mobile number will be verified.',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                    ),
                  ),
                  Positioned(
                    top: screenheight * 0.06,
                    child: GreenButton(
                      text: 'CONTINUE',
                      onPressed: () {},
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
