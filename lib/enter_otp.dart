import 'package:flutter/material.dart';
import 'package:fographdestinationbooking/utils/constant/app_textstyles.dart';
import 'custom_button.dart';
import 'package:pinput/pinput.dart';


class EnterOTP extends StatelessWidget {
  EnterOTP({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenwidth = MediaQuery.of(context).size.width;
    double screenheight = MediaQuery.of(context).size.height;

    final defaultPinTheme = PinTheme(
        width: screenwidth*0.15,
        height: screenheight*0.09,
        textStyle: TextStyle(color: Colors.white),
        decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(15.0),
            border: Border.all(color: Colors.green)));

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
                  Text(
                    'Mobile\nNumber',
                    style: AppHeadingStyle.heading,
                    textAlign: TextAlign.left,
                  ),
                  Align(
                    alignment: AlignmentDirectional.center,
                    child: Container(
                      margin: EdgeInsets.only(
                          top: screenheight * 0.26,
                          // left: screenwidth * 0.0002,
                          // right: screenwidth * 0.0002
                      ),
                      child: Column(
                        children: [
                          GestureDetector(
                            onTap: () {
                              // Handle onTap
                            },
                            child: Row(
                              children: [
                                Padding(
                                  padding:
                                  EdgeInsets.symmetric(vertical: screenheight * 0.01),
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
                              padding: EdgeInsets.only(right: screenwidth * 0.05),
                              alignment: AlignmentDirectional.topCenter,
                              child: TextField(
                                keyboardType: TextInputType.phone,
                                // Replace the controller with your logic to retrieve the previous phone number
                                // controller: TextEditingController(text: "PreviousPhoneNumber"),
                                decoration: InputDecoration(
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(screenheight * 0.02),
                                      borderSide: BorderSide(color: Colors.green)),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(screenheight * 0.02)),
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
                          Container(
                            padding: EdgeInsets.fromLTRB(0, 0, screenwidth*0.04, screenheight*0.1),
                              alignment: AlignmentDirectional.topCenter,
                              child: Pinput(
                                length: 6,
                                defaultPinTheme: defaultPinTheme,
                                focusedPinTheme: defaultPinTheme.copyWith(
                                    decoration: defaultPinTheme.decoration!.copyWith(
                                      border: Border.all(color: Colors.white),
                                    )),
                                onCompleted: (pin) => debugPrint(pin),
                              )
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
                  Text(
                    'Your mobile number will be verified.',
                    style: AppTextStyles.title,
                  ),
                  Positioned(
                    top: screenheight * 0.06,
                    child: GreenButton(
                      text: 'VERIFY OTP',
                      onPressed: () {
                        // Handle VERIFY OTP button press
                      },
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
