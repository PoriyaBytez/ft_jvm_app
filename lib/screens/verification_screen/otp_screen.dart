import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:jym_app/models/get_user_model.dart';
import 'package:jym_app/screens/onboarding_screen.dart';
import 'package:jym_app/screens/splash_screen.dart';
import 'package:jym_app/screens/verification_screen/profile_screen.dart';
import 'package:jym_app/services/api_services.dart';
import 'package:jym_app/utils/preferences.dart';
import '../../common_widgets/custom_textformfield.dart';
import '../../utils/app_textstyle.dart';
import '../../utils/theme_manager.dart';
import '../main_screen.dart';

class OtpScreen extends StatefulWidget {
  final String? mobileNumber, otp;

  const OtpScreen({Key? key, this.mobileNumber, this.otp}) : super(key: key);

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  TextEditingController otpController = TextEditingController();
  final GlobalKey<FormState> _validatorKey = GlobalKey();
  APIServices apiServices = APIServices();
  bool _isLoading = false;
  Preferences _preferences = Preferences();

  ///----------Resend OTP------------

  sendOtp() async {
    _isLoading = true;
    try {
      var response = await apiServices.sendOtp(widget.mobileNumber!);
      if (response.statusCode == 200) {
        var result = json.decode(response.body);
        if (result["error"] == false) {
          String otp = result["otp"].toString();
          print("Otp is ===========================> $otp");
          _isLoading = false;
          try {
            var response =
                await apiServices.sendUserOTP(widget.mobileNumber!, otp);
            if (response.statusCode == 200) {
              var result = response.body;
              return result;
            } else {
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
                    horizontal: Get.width * 0.05, vertical: Get.height * 0.02),
                duration: const Duration(seconds: 3),
                isDismissible: true,
                forwardAnimationCurve: Curves.easeOutBack,
              ),
            );
            print("e ===========================> $e");

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
        } else {
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
              horizontal: Get.width * 0.05, vertical: Get.height * 0.02),
          duration: const Duration(seconds: 3),
          isDismissible: true,
          forwardAnimationCurve: Curves.easeOutBack,
        ),
      );
      print("e ===========================> $e");

    } finally {
      _isLoading = false;
    }
    setState(() {});
  }

  ///----------Verify OTP------------

  Future verifyOTP(String otp) async {
    _isLoading = true;
    setState(() {});
    var response = await apiServices.verifyOTP(widget.mobileNumber!, otp);
    try {
      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);

        if (result["message"] == "OTP verify successfully") {


          _preferences.setToken(result["token"]);
          _preferences.setNumber(widget.mobileNumber ?? "");
          var response = await apiServices.getUserData();
          if (response.statusCode == 200) {
            var resultForGetUser = json.decode(response.body);
            editProfileModel = EditProfileModel.fromJson(result);

            _preferences.setUid(resultForGetUser['id']);
            ///new code added by rk
            Get.dialog(
                WillPopScope(
                  onWillPop: () async {
                    return false;
                  },
                  child: Dialog(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    insetPadding: EdgeInsets.symmetric(
                      vertical: Get.height * 0.25,
                    ),
                    backgroundColor: ThemeManager().getWhiteColor,
                    child: SizedBox(
                      width: Get.width * 0.9,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(
                              top: Get.height * 0.045,
                            ),
                            child: Image.asset(
                              "assets/icon/otp_verified.png",
                              height: Get.width * 0.25,
                              width: Get.width * 0.25,
                              fit: BoxFit.fill,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                              top: Get.height * 0.035,
                            ),
                            child: Text(
                              "OTP verification Successful.",
                              style: poppinsSemiBold.copyWith(
                                color: ThemeManager().getThemeGreenColor,
                                fontSize: Get.width * 0.055,
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                              top: Get.height * 0.025,
                            ),
                            child: SizedBox(
                              width: Get.width * 0.65,
                              child: Text(
                                "Your mobile number verification is successful.",
                                style: poppinsRegular.copyWith(
                                  color: ThemeManager().getLightGreyColor,
                                  fontSize: Get.width * 0.04,
                                ),
                              ),
                            ),
                          ),
                          Container(
                            width: Get.width,
                            height: Get.height * 0.06,
                            margin: EdgeInsets.only(
                                left: Get.width * 0.05,
                                top: Get.height * 0.045,
                                right: Get.width * 0.05),
                            child: ElevatedButton(
                              onPressed: () async {
                                /// new add
                                if (result['system_status'] == "0") {
                                  Get.dialog(
                                      WillPopScope(
                                        onWillPop: () async {
                                          return false;
                                        },
                                        child: Dialog(
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(15),
                                          ),
                                          insetPadding: EdgeInsets.symmetric(
                                            vertical: Get.height * 0.15,
                                          ),
                                          backgroundColor: ThemeManager().getWhiteColor,
                                          child: SizedBox(
                                            width: Get.width * 0.9,
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              children: [
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                    top: Get.height * 0.045,
                                                  ),
                                                  child: Image.asset(
                                                    "assets/icon/registration_under_process.png",
                                                    height: Get.width * 0.25,
                                                    width: Get.width * 0.25,
                                                    fit: BoxFit.fill,
                                                  ),
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                    top: Get.height * 0.035,
                                                  ),
                                                  child: Text(
                                                    "Registration under process.",
                                                    style: poppinsSemiBold.copyWith(
                                                      color: ThemeManager().getThemeGreenColor,
                                                      fontSize: Get.width * 0.055,
                                                    ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                    top: Get.height * 0.025,
                                                  ),
                                                  child: SizedBox(
                                                    width: Get.width * 0.7,
                                                    child: Text(
                                                      "Your Registration is under process. Thank you for your Patience.",
                                                      style: poppinsRegular.copyWith(
                                                        color: ThemeManager().getLightGreyColor,
                                                        fontSize: Get.width * 0.04,
                                                      ),
                                                      textAlign: TextAlign.center,
                                                    ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                    top: Get.height * 0.025,
                                                  ),
                                                  child: Row(children: <Widget>[
                                                    Expanded(
                                                      child: Container(
                                                          margin: EdgeInsets.only(
                                                            left: Get.width * 0.05,
                                                            right: Get.width * 0.035,
                                                          ),
                                                          child: Divider(
                                                            color: ThemeManager().getBlackColor,
                                                            height: 2,
                                                          )),
                                                    ),
                                                    Text(
                                                      "Contact US",
                                                      style: poppinsRegular.copyWith(
                                                        fontSize: Get.width * 0.045,
                                                        color: ThemeManager().getBlackColor,
                                                      ),
                                                    ),
                                                    Expanded(
                                                      child: Container(
                                                          margin: EdgeInsets.only(
                                                            left: Get.width * 0.035,
                                                            right: Get.width * 0.05,
                                                          ),
                                                          child: Divider(
                                                            color: ThemeManager().getBlackColor,
                                                            height: 2,
                                                          )),
                                                    ),
                                                  ]),
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                    top: Get.height * 0.025,
                                                  ),
                                                  child: Text(
                                                    "contactus@jym.com",
                                                    style: poppinsRegular.copyWith(
                                                      color: ThemeManager().getLightGreyColor,
                                                      fontSize: Get.width * 0.04,
                                                    ),
                                                    textAlign: TextAlign.center,
                                                  ),
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                    top: Get.height * 0.015,
                                                  ),
                                                  child: Text(
                                                    "+91 ${widget.mobileNumber}",
                                                    style: poppinsRegular.copyWith(
                                                      color: ThemeManager().getLightGreyColor,
                                                      fontSize: Get.width * 0.04,
                                                    ),
                                                    textAlign: TextAlign.center,
                                                  ),
                                                ),
                                                Container(
                                                  width: Get.width,
                                                  height: Get.height * 0.06,
                                                  margin: EdgeInsets.only(
                                                      left: Get.width * 0.05,
                                                      top: Get.height * 0.045,
                                                      right: Get.width * 0.05),
                                                  child: ElevatedButton(
                                                    onPressed: () {
                                                      // SystemNavigator.pop();
                                                      // Get.back();
                                                      // Get.off(() => const MainScreen());
                                                      Get.off(() => const OnBoardingScreen());
                                                    },
                                                    style: ElevatedButton.styleFrom(
                                                      backgroundColor: ThemeManager().getThemeGreenColor,
                                                      shape: RoundedRectangleBorder(
                                                        borderRadius: BorderRadius.circular(25),
                                                      ),
                                                      padding: EdgeInsets.symmetric(
                                                        horizontal: Get.width * 0.25,
                                                        vertical: Get.height * 0.015,
                                                      ),
                                                    ),
                                                    child: Text(
                                                      "ok",
                                                      style: poppinsSemiBold.copyWith(
                                                        fontSize: Get.width * 0.045,
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
                                      barrierColor: ThemeManager().getBlackColor.withOpacity(0.3),
                                      barrierDismissible: false);
                                  /*  Get.dialog(
                  WillPopScope(
                    onWillPop: () async {
                      return false;
                    },
                    child: Dialog(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      insetPadding: EdgeInsets.symmetric(
                        vertical: Get.height * 0.25,
                      ),
                      backgroundColor: ThemeManager().getWhiteColor,
                      child: SizedBox(
                        width: Get.width * 0.9,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(
                                top: Get.height * 0.045,
                              ),
                              child: Image.asset(
                                "assets/icon/otp_verified.png",
                                height: Get.width * 0.25,
                                width: Get.width * 0.25,
                                fit: BoxFit.fill,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                top: Get.height * 0.035,
                              ),
                              child: Text(
                                "OTP verification Successful.",
                                style: poppinsSemiBold.copyWith(
                                  color: ThemeManager().getThemeGreenColor,
                                  fontSize: Get.width * 0.055,
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                top: Get.height * 0.025,
                              ),
                              child: SizedBox(
                                width: Get.width * 0.65,
                                child: Text(
                                  "Your mobile number verification is successful.",
                                  style: poppinsRegular.copyWith(
                                    color: ThemeManager().getLightGreyColor,
                                    fontSize: Get.width * 0.04,
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              width: Get.width,
                              height: Get.height * 0.06,
                              margin: EdgeInsets.only(
                                  left: Get.width * 0.05,
                                  top: Get.height * 0.045,
                                  right: Get.width * 0.05),
                              child: ElevatedButton(
                                onPressed: () {
                                  /// new add
                                  Get.dialog(
                                      WillPopScope(
                                        onWillPop: () async {
                                          return false;
                                        },
                                        child: Dialog(
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(15),
                                          ),
                                          insetPadding: EdgeInsets.symmetric(
                                            vertical: Get.height * 0.15,
                                          ),
                                          backgroundColor: ThemeManager().getWhiteColor,
                                          child: SizedBox(
                                            width: Get.width * 0.9,
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              children: [
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                    top: Get.height * 0.045,
                                                  ),
                                                  child: Image.asset(
                                                    "assets/icon/registration_under_process.png",
                                                    height: Get.width * 0.25,
                                                    width: Get.width * 0.25,
                                                    fit: BoxFit.fill,
                                                  ),
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                    top: Get.height * 0.035,
                                                  ),
                                                  child: Text(
                                                    "Registration under process.",
                                                    style: poppinsSemiBold.copyWith(
                                                      color: ThemeManager().getThemeGreenColor,
                                                      fontSize: Get.width * 0.055,
                                                    ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                    top: Get.height * 0.025,
                                                  ),
                                                  child: SizedBox(
                                                    width: Get.width * 0.7,
                                                    child: Text(
                                                      "Your Registration is under process. Thank you for your Patience.",
                                                      style: poppinsRegular.copyWith(
                                                        color: ThemeManager().getLightGreyColor,
                                                        fontSize: Get.width * 0.04,
                                                      ),
                                                      textAlign: TextAlign.center,
                                                    ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                    top: Get.height * 0.025,
                                                  ),
                                                  child: Row(children: <Widget>[
                                                    Expanded(
                                                      child: Container(
                                                          margin: EdgeInsets.only(
                                                            left: Get.width * 0.05,
                                                            right: Get.width * 0.035,
                                                          ),
                                                          child: Divider(
                                                            color: ThemeManager().getBlackColor,
                                                            height: 2,
                                                          )),
                                                    ),
                                                    Text(
                                                      "Contact US",
                                                      style: poppinsRegular.copyWith(
                                                        fontSize: Get.width * 0.045,
                                                        color: ThemeManager().getBlackColor,
                                                      ),
                                                    ),
                                                    Expanded(
                                                      child: Container(
                                                          margin: EdgeInsets.only(
                                                            left: Get.width * 0.035,
                                                            right: Get.width * 0.05,
                                                          ),
                                                          child: Divider(
                                                            color: ThemeManager().getBlackColor,
                                                            height: 2,
                                                          )),
                                                    ),
                                                  ]),
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                    top: Get.height * 0.025,
                                                  ),
                                                  child: Text(
                                                    "contactus@jym.com",
                                                    style: poppinsRegular.copyWith(
                                                      color: ThemeManager().getLightGreyColor,
                                                      fontSize: Get.width * 0.04,
                                                    ),
                                                    textAlign: TextAlign.center,
                                                  ),
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                    top: Get.height * 0.015,
                                                  ),
                                                  child: Text(
                                                    "+91 ${widget.mobileNumber}",
                                                    style: poppinsRegular.copyWith(
                                                      color: ThemeManager().getLightGreyColor,
                                                      fontSize: Get.width * 0.04,
                                                    ),
                                                    textAlign: TextAlign.center,
                                                  ),
                                                ),
                                                Container(
                                                  width: Get.width,
                                                  height: Get.height * 0.06,
                                                  margin: EdgeInsets.only(
                                                      left: Get.width * 0.05,
                                                      top: Get.height * 0.045,
                                                      right: Get.width * 0.05),
                                                  child: ElevatedButton(
                                                    onPressed: () {
                                                      // SystemNavigator.pop();
                                                      // Get.back();
                                                      // Get.off(() => const MainScreen());
                                                      Get.off(() => const OnBoardingScreen());
                                                    },
                                                    style: ElevatedButton.styleFrom(
                                                      backgroundColor: ThemeManager().getThemeGreenColor,
                                                      shape: RoundedRectangleBorder(
                                                        borderRadius: BorderRadius.circular(25),
                                                      ),
                                                      padding: EdgeInsets.symmetric(
                                                        horizontal: Get.width * 0.25,
                                                        vertical: Get.height * 0.015,
                                                      ),
                                                    ),
                                                    child: Text(
                                                      "ok",
                                                      style: poppinsSemiBold.copyWith(
                                                        fontSize: Get.width * 0.045,
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
                                      barrierColor: ThemeManager().getBlackColor.withOpacity(0.3),
                                      barrierDismissible: false);
                                  // Get.back();
                                  // Get.back();
                                  // Get.back();
                                  /// old code commited by rk
                                *//*  if (isLoginOrSignup.value == true) {
                                    Get.to(() => ProfileScreen(
                                          number: widget.mobileNumber,
                                        ));
                                  } else {
                                    Get.dialog(
                                        WillPopScope(
                                          onWillPop: () async {
                                            return false;
                                          },
                                          child: Dialog(
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(15),
                                            ),
                                            insetPadding: EdgeInsets.symmetric(
                                              vertical: Get.height * 0.15,
                                            ),
                                            backgroundColor: ThemeManager().getWhiteColor,
                                            child: SizedBox(
                                              width: Get.width * 0.9,
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                children: [
                                                  Padding(
                                                    padding: EdgeInsets.only(
                                                      top: Get.height * 0.045,
                                                    ),
                                                    child: Image.asset(
                                                      "assets/icon/registration_under_process.png",
                                                      height: Get.width * 0.25,
                                                      width: Get.width * 0.25,
                                                      fit: BoxFit.fill,
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: EdgeInsets.only(
                                                      top: Get.height * 0.035,
                                                    ),
                                                    child: Text(
                                                      "Registration under process.",
                                                      style: poppinsSemiBold.copyWith(
                                                        color: ThemeManager().getThemeGreenColor,
                                                        fontSize: Get.width * 0.055,
                                                      ),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: EdgeInsets.only(
                                                      top: Get.height * 0.025,
                                                    ),
                                                    child: SizedBox(
                                                      width: Get.width * 0.7,
                                                      child: Text(
                                                        "Your Registration is under process. Thank you for your Patience.",
                                                        style: poppinsRegular.copyWith(
                                                          color: ThemeManager().getLightGreyColor,
                                                          fontSize: Get.width * 0.04,
                                                        ),
                                                        textAlign: TextAlign.center,
                                                      ),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: EdgeInsets.only(
                                                      top: Get.height * 0.025,
                                                    ),
                                                    child: Row(children: <Widget>[
                                                      Expanded(
                                                        child: Container(
                                                            margin: EdgeInsets.only(
                                                              left: Get.width * 0.05,
                                                              right: Get.width * 0.035,
                                                            ),
                                                            child: Divider(
                                                              color: ThemeManager().getBlackColor,
                                                              height: 2,
                                                            )),
                                                      ),
                                                      Text(
                                                        "Contact US",
                                                        style: poppinsRegular.copyWith(
                                                          fontSize: Get.width * 0.045,
                                                          color: ThemeManager().getBlackColor,
                                                        ),
                                                      ),
                                                      Expanded(
                                                        child: Container(
                                                            margin: EdgeInsets.only(
                                                              left: Get.width * 0.035,
                                                              right: Get.width * 0.05,
                                                            ),
                                                            child: Divider(
                                                              color: ThemeManager().getBlackColor,
                                                              height: 2,
                                                            )),
                                                      ),
                                                    ]),
                                                  ),
                                                  Padding(
                                                    padding: EdgeInsets.only(
                                                      top: Get.height * 0.025,
                                                    ),
                                                    child: Text(
                                                      "contactus@jym.com",
                                                      style: poppinsRegular.copyWith(
                                                        color: ThemeManager().getLightGreyColor,
                                                        fontSize: Get.width * 0.04,
                                                      ),
                                                      textAlign: TextAlign.center,
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: EdgeInsets.only(
                                                      top: Get.height * 0.015,
                                                    ),
                                                    child: Text(
                                                      "+91 ${widget.mobileNumber}",
                                                      style: poppinsRegular.copyWith(
                                                        color: ThemeManager().getLightGreyColor,
                                                        fontSize: Get.width * 0.04,
                                                      ),
                                                      textAlign: TextAlign.center,
                                                    ),
                                                  ),
                                                  Container(
                                                    width: Get.width,
                                                    height: Get.height * 0.06,
                                                    margin: EdgeInsets.only(
                                                        left: Get.width * 0.05,
                                                        top: Get.height * 0.045,
                                                        right: Get.width * 0.05),
                                                    child: ElevatedButton(
                                                      onPressed: () {
                                                        // SystemNavigator.pop();
                                                        // Get.back();
                                                        // Get.off(() => const MainScreen());
                                                        Get.off(() => const OnBoardingScreen());
                                                      },
                                                      style: ElevatedButton.styleFrom(
                                                        backgroundColor: ThemeManager().getThemeGreenColor,
                                                        shape: RoundedRectangleBorder(
                                                          borderRadius: BorderRadius.circular(25),
                                                        ),
                                                        padding: EdgeInsets.symmetric(
                                                          horizontal: Get.width * 0.25,
                                                          vertical: Get.height * 0.015,
                                                        ),
                                                      ),
                                                      child: Text(
                                                        "ok",
                                                        style: poppinsSemiBold.copyWith(
                                                          fontSize: Get.width * 0.045,
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
                                        barrierColor: ThemeManager().getBlackColor.withOpacity(0.3),
                                        barrierDismissible: false);

                                    // Get.off(() => const MainScreen());
                                  }*//*
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      ThemeManager().getThemeGreenColor,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(25),
                                  ),
                                  padding: EdgeInsets.symmetric(
                                    horizontal: Get.width * 0.25,
                                    vertical: Get.height * 0.015,
                                  ),
                                ),
                                child: Text(
                                  "Close",
                                  style: poppinsSemiBold.copyWith(
                                    fontSize: Get.width * 0.045,
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
                  barrierColor: ThemeManager().getBlackColor.withOpacity(0.3),
                  barrierDismissible: true);*/
                                } else if (result['system_status'] == "1") {

                                  _preferences.setUserRegistered();
                                  await _preferences.setCityId(resultForGetUser['city_id']);

                                  Get.off(() => const MainScreen());
                                } else if (result['system_status'] == "2") {
                                  Get.dialog(
                                      WillPopScope(
                                        onWillPop: () async {
                                          return false;
                                        },
                                        child: Dialog(
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(15),
                                          ),
                                          insetPadding: EdgeInsets.symmetric(
                                            vertical: Get.height * 0.15,
                                          ),
                                          backgroundColor: ThemeManager().getWhiteColor,
                                          child: SizedBox(
                                            width: Get.width * 0.9,
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              children: [
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                    top: Get.height * 0.045,
                                                  ),
                                                  child: Image.asset(
                                                    "assets/icon/registration_under_process.png",
                                                    height: Get.width * 0.25,
                                                    width: Get.width * 0.25,
                                                    fit: BoxFit.fill,
                                                  ),
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                    top: Get.height * 0.035,
                                                  ),
                                                  child: Text(
                                                    "Registration under process.",
                                                    style: poppinsSemiBold.copyWith(
                                                      color: ThemeManager().getThemeGreenColor,
                                                      fontSize: Get.width * 0.055,
                                                    ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                    top: Get.height * 0.025,
                                                  ),
                                                  child: SizedBox(
                                                    width: Get.width * 0.7,
                                                    child: Text(
                                                      "Your Registration Rejected Please Contact Admin.",
                                                      style: poppinsRegular.copyWith(
                                                        color: ThemeManager().getLightGreyColor,
                                                        fontSize: Get.width * 0.04,
                                                      ),
                                                      textAlign: TextAlign.center,
                                                    ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                    top: Get.height * 0.025,
                                                  ),
                                                  child: Row(children: <Widget>[
                                                    Expanded(
                                                      child: Container(
                                                          margin: EdgeInsets.only(
                                                            left: Get.width * 0.05,
                                                            right: Get.width * 0.035,
                                                          ),
                                                          child: Divider(
                                                            color: ThemeManager().getBlackColor,
                                                            height: 2,
                                                          )),
                                                    ),
                                                    Text(
                                                      "Contact US",
                                                      style: poppinsRegular.copyWith(
                                                        fontSize: Get.width * 0.045,
                                                        color: ThemeManager().getBlackColor,
                                                      ),
                                                    ),
                                                    Expanded(
                                                      child: Container(
                                                          margin: EdgeInsets.only(
                                                            left: Get.width * 0.035,
                                                            right: Get.width * 0.05,
                                                          ),
                                                          child: Divider(
                                                            color: ThemeManager().getBlackColor,
                                                            height: 2,
                                                          )),
                                                    ),
                                                  ]),
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                    top: Get.height * 0.025,
                                                  ),
                                                  child: Text(
                                                    "contactus@jym.com",
                                                    style: poppinsRegular.copyWith(
                                                      color: ThemeManager().getLightGreyColor,
                                                      fontSize: Get.width * 0.04,
                                                    ),
                                                    textAlign: TextAlign.center,
                                                  ),
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                    top: Get.height * 0.015,
                                                  ),
                                                  child: Text(
                                                    "+91 ${widget.mobileNumber}",
                                                    style: poppinsRegular.copyWith(
                                                      color: ThemeManager().getLightGreyColor,
                                                      fontSize: Get.width * 0.04,
                                                    ),
                                                    textAlign: TextAlign.center,
                                                  ),
                                                ),
                                                Container(
                                                  width: Get.width,
                                                  height: Get.height * 0.06,
                                                  margin: EdgeInsets.only(
                                                      left: Get.width * 0.05,
                                                      top: Get.height * 0.045,
                                                      right: Get.width * 0.05),
                                                  child: ElevatedButton(
                                                    onPressed: () {
                                                      SystemNavigator.pop();
                                                    },
                                                    style: ElevatedButton.styleFrom(
                                                      backgroundColor:
                                                      ThemeManager().getThemeGreenColor,
                                                      shape: RoundedRectangleBorder(
                                                        borderRadius: BorderRadius.circular(25),
                                                      ),
                                                      padding: EdgeInsets.symmetric(
                                                        horizontal: Get.width * 0.25,
                                                        vertical: Get.height * 0.015,
                                                      ),
                                                    ),
                                                    child: Text(
                                                      "ok",
                                                      style: poppinsSemiBold.copyWith(
                                                        fontSize: Get.width * 0.045,
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
                                      barrierColor: ThemeManager().getBlackColor.withOpacity(0.3),
                                      barrierDismissible: false);
                                }else{
                                  Get.to(() => ProfileScreen(
                                    number: widget.mobileNumber,
                                  ));
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                ThemeManager().getThemeGreenColor,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(25),
                                ),
                                padding: EdgeInsets.symmetric(
                                  horizontal: Get.width * 0.25,
                                  vertical: Get.height * 0.015,
                                ),
                              ),
                              child: Text(
                                "Close",
                                style: poppinsSemiBold.copyWith(
                                  fontSize: Get.width * 0.045,
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
                barrierColor: ThemeManager().getBlackColor.withOpacity(0.3),
                barrierDismissible: true);


          }
        }
        return result;
      }
    } catch (e) {
      print("e ===========================> $e");

      _isLoading = false;
      setState(() {});
    } finally {
      _isLoading = false;
      setState(() {});
    }
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
                    "Verify OTP",
                    style: poppinsLight.copyWith(
                      color: ThemeManager().getBlackColor,
                      fontSize: Get.width * 0.065,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: Get.height * 0.01),
                  child: Row(
                    children: [
                      Text(
                        "Enter the OTP sent to +91${widget.mobileNumber}",
                        style: poppinsLight.copyWith(
                          color: ThemeManager().getLightGreyColor,
                          fontSize: Get.width * 0.04,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: Get.width * 0.02),
                        child: GestureDetector(
                          onTap: () {
                            Get.back();
                          },
                          child: Transform.scale(
                            scale: 1.3,
                            child: ImageIcon(
                              const AssetImage("assets/icon/edit.png"),
                              color: ThemeManager().getThemeGreenColor,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                ///----------------Otp TextField-------------------

                Form(
                  key: _validatorKey,
                  child: Padding(
                    padding: EdgeInsets.only(top: Get.height * 0.05),
                    child: CustomTextFormField(
                      controller: otpController,
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(RegExp('[0-9]')),
                        LengthLimitingTextInputFormatter(6),
                      ],
                      validator: (value) {
                        if (value.isEmpty) {
                          return "*Invalid OTP.";
                        }
                        return null;
                      },
                      onChanged: (value) {
                        setState(() {});
                      },
                      labelText: "Enter 6 Digit OTP",
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
                  margin: EdgeInsets.only(top: Get.height * 0.05),
                  child: ElevatedButton(
                    onPressed: otpController.text.length == 6
                        ? () {
                            verifyOTP(otpController.text);
                          }
                        : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: ThemeManager().getThemeGreenColor,
                      disabledBackgroundColor:
                          ThemeManager().getThemeGreenColor.withOpacity(0.57),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                    ),
                    child: Text(
                      "Verify",
                      style: poppinsSemiBold.copyWith(
                        fontSize: Get.width * 0.04,
                        color: ThemeManager().getWhiteColor,
                      ),
                    ),
                  ),
                ),

                Padding(
                  padding: EdgeInsets.only(top: Get.height * 0.04),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Don't Receive Code ?",
                        style: poppinsRegular.copyWith(
                          fontSize: Get.width * 0.035,
                          color: ThemeManager().getLightGreyColor,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          left: Get.width * 0.015,
                        ),
                        child: GestureDetector(
                          onTap: () {
                            sendOtp();
                          },
                          child: Text(
                            "Resend Code",
                            style: poppinsSemiBold.copyWith(
                              fontSize: Get.width * 0.035,
                              color: ThemeManager().getThemeGreenColor,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ],
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
