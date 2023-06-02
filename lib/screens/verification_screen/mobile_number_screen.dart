import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:jym_app/common_widgets/custom_textformfield.dart';
import 'package:jym_app/utils/theme_manager.dart';
import '../../services/api_services.dart';
import '../../utils/app_textstyle.dart';
import 'otp_screen.dart';

class MobileNumberScreen extends StatefulWidget {
  const MobileNumberScreen({Key? key}) : super(key: key);

  @override
  State<MobileNumberScreen> createState() => _MobileNumberScreenState();
}

class _MobileNumberScreenState extends State<MobileNumberScreen> {
  TextEditingController mobileNumberController = TextEditingController();
  final GlobalKey<FormState> _validatorKey = GlobalKey();
  bool _isLoading = false;
  APIServices apiServices = APIServices();

  sendOtp(String mobileNumber) async {
    _isLoading = true;
    setState(() {});
    try {
      var response = await apiServices.sendOtp(mobileNumber);
      if (response.statusCode == 200) {
        var result = json.decode(response.body);
        print("===============>$result");
        if (result["error"] == false) {
          String otp = result["otp"].toString();
          print("Otp is $otp");
          _isLoading = false;
          try {
            var response = await apiServices.sendUserOTP(mobileNumber, otp);
            if (response.statusCode == 200) {
              var result = response.body;
              Get.to(() => OtpScreen(
                  mobileNumber: mobileNumberController.text.toString(), otp: otp));
              return result;
            }
            else{
              Get.showSnackbar(
                GetSnackBar(
                  messageText: Text(
                    "Sorry, couldn't send the OTP.",
                    style: poppinsRegular.copyWith(
                      fontSize: Get.width * 0.035,
                      color: ThemeManager().getWhiteColor,
                    ),
                  ),
                  snackPosition: SnackPosition.BOTTOM,
                  backgroundColor: ThemeManager().getRedColor,
                  borderRadius: 20,
                  margin: EdgeInsets.symmetric(
                      horizontal: Get.width * 0.05,
                      vertical: Get.height * 0.02),
                  duration: const Duration(seconds: 3),
                  isDismissible: true,
                  forwardAnimationCurve: Curves.easeOutBack,
                ),
              );
            }
          } catch (e) {
            Get.showSnackbar(
              GetSnackBar(
                messageText: Text(
                  "Sorry, couldn't send the OTP.",
                  style: poppinsRegular.copyWith(
                    fontSize: Get.width * 0.035,
                    color: ThemeManager().getWhiteColor,
                  ),
                ),
                snackPosition: SnackPosition.BOTTOM,
                backgroundColor: ThemeManager().getRedColor,
                borderRadius: 20,
                margin: EdgeInsets.symmetric(
                    horizontal: Get.width * 0.05,
                    vertical: Get.height * 0.02),
                duration: const Duration(seconds: 3),
                isDismissible: true,
                forwardAnimationCurve: Curves.easeOutBack,
              ),
            );
            print(e);
          }
        } else if (result["message"] ==
            "Your account is not approved please contact admin") {
          Get.showSnackbar(
            GetSnackBar(
              messageText: Text(
                "Your account is not approved please contact to admin.",
                style: poppinsRegular.copyWith(
                  fontSize: Get.width * 0.035,
                  color: ThemeManager().getWhiteColor,
                ),
              ),
              snackPosition: SnackPosition.BOTTOM,
              backgroundColor: ThemeManager().getRedColor,
              borderRadius: 20,
              margin: EdgeInsets.symmetric(
                  horizontal: Get.width * 0.05, vertical: Get.height * 0.02),
              duration: const Duration(seconds: 3),
              isDismissible: true,
              forwardAnimationCurve: Curves.easeOutBack,
            ),
          );
          _isLoading = false;
          setState(() {});
        }
        else{
          Get.showSnackbar(
            GetSnackBar(
              messageText: Text(
                "Sorry, couldn't send the OTP.",
                style: poppinsRegular.copyWith(
                  fontSize: Get.width * 0.035,
                  color: ThemeManager().getWhiteColor,
                ),
              ),
              snackPosition: SnackPosition.BOTTOM,
              backgroundColor: ThemeManager().getRedColor,
              borderRadius: 20,
              margin: EdgeInsets.symmetric(
                  horizontal: Get.width * 0.05, vertical: Get.height * 0.02),
              duration: const Duration(seconds: 3),
              isDismissible: true,
              forwardAnimationCurve: Curves.easeOutBack,
            ),
          );
          _isLoading = false;
          setState(() {});
        }
      }
    } catch (e) {
      Get.showSnackbar(
        GetSnackBar(
          messageText: Text(
            "Sorry, couldn't send the OTP.",
            style: poppinsRegular.copyWith(
              fontSize: Get.width * 0.035,
              color: ThemeManager().getWhiteColor,
            ),
          ),
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: ThemeManager().getRedColor,
          borderRadius: 20,
          margin: EdgeInsets.symmetric(
              horizontal: Get.width * 0.05,
              vertical: Get.height * 0.02),
          duration: const Duration(seconds: 3),
          isDismissible: true,
          forwardAnimationCurve: Curves.easeOutBack,
        ),
      );
      print(e);
    } finally {
      _isLoading = false;
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        body: SafeArea(
          child: Container(
            height: Get.height,
            width: Get.width,
            color: ThemeManager().getWhiteColor,
            padding: EdgeInsets.symmetric(
              horizontal: Get.width * 0.05,
              vertical: Get.height * 0.02,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ///----------------Back button-------------------

                GestureDetector(
                  onTap: () {
                    Get.back();
                  },
                  child: Container(
                    height: Get.width * 0.1,
                    width: Get.width * 0.1,
                    decoration: BoxDecoration(
                      color: ThemeManager().getWhiteColor,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                            color:
                                ThemeManager().getBlackColor.withOpacity(0.075),
                            spreadRadius: 4,
                            blurRadius: 3),
                      ],
                    ),
                    alignment: Alignment.center,
                    child: Icon(
                      Icons.arrow_back_rounded,
                      size: Get.width * 0.065,
                      color: ThemeManager().getThemeGreenColor,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: Get.height * 0.025),
                  child: Text(
                    "Enter your Mobile Number to Get started",
                    style: poppinsLight.copyWith(
                      color: ThemeManager().getBlackColor,
                      fontSize: Get.width * 0.065,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: Get.height * 0.01),
                  child: Text(
                    "We’ll send to a verification code to your mobile number",
                    style: poppinsLight.copyWith(
                      color: ThemeManager().getLightGreyColor,
                      fontSize: Get.width * 0.04,
                    ),
                  ),
                ),

                ///----------------Mobile number TextField-------------------

                Form(
                  key: _validatorKey,
                  child: Padding(
                    padding: EdgeInsets.only(top: Get.height * 0.05),
                    child: CustomTextFormField(
                      controller: mobileNumberController,
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(RegExp('[0-9]')),
                        LengthLimitingTextInputFormatter(10),
                      ],
                      validator: (value) {
                        if (value.isEmpty) {
                          return "*Invalid Number";
                        }
                        return null;
                      },
                      onChanged: (value) {
                        setState(() {});
                      },
                      prefix: Text(
                        "+91",
                        style: poppinsRegular.copyWith(
                          fontSize: Get.width * 0.04,
                          color: ThemeManager().getBlackColor,
                        ),
                      ),
                      labelText: "Mobile Number",
                      labelStyle: poppinsRegular.copyWith(
                        fontSize: Get.width * 0.04,
                        color: ThemeManager().getLightGreyColor,
                      ),
                      mainTextStyle: poppinsRegular.copyWith(
                        fontSize: Get.width * 0.04,
                        color: ThemeManager().getBlackColor,
                      ),
                    ),
                  ),
                ),

                ///----------------OTP Button-------------------

                Container(
                  width: Get.width,
                  height: Get.height * 0.06,
                  margin: EdgeInsets.only(
                    top: Get.height * 0.05,
                  ),
                  child: _isLoading
                      ? Center(
                          child: CircularProgressIndicator(
                          color: ThemeManager().getThemeGreenColor,
                        ))
                      : ElevatedButton(
                          onPressed: mobileNumberController.text.length == 10
                              ? () {
                                  if (_validatorKey.currentState!.validate()) {
                                    FocusScope.of(context).unfocus();
                                    sendOtp(mobileNumberController.text.trim());
                                  }
                                }
                              : null,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: ThemeManager().getThemeGreenColor,
                            disabledBackgroundColor: ThemeManager()
                                .getThemeGreenColor
                                .withOpacity(0.57),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25),
                            ),
                          ),
                          child: Text(
                            "Send OTP",
                            style: poppinsSemiBold.copyWith(
                              fontSize: Get.width * 0.04,
                              color: ThemeManager().getWhiteColor,
                            ),
                          ),
                        ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
