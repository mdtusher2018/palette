// lib/controllers/auth_controller.dart
import 'dart:async';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:palette/models/auth%20models/GoogleSignInResponseModel.dart';
import 'package:palette/models/auth%20models/email_verified_model.dart';
import 'package:palette/models/auth%20models/forget_password_model.dart';
import 'package:palette/models/auth%20models/otp_verified_model.dart';
import 'package:palette/models/auth%20models/password_reset_model.dart';
import 'package:palette/models/auth%20models/signin_model.dart';
import 'package:palette/models/auth%20models/signup_model.dart';
import 'package:palette/services/local_storage_service.dart';
import 'package:palette/views/Authuntication/enter_otp_page.dart';
import 'package:palette/views/Authuntication/new_password_page.dart';
import 'package:palette/views/Authuntication/sign_in_page.dart';
import 'package:palette/views/res/commonWidgets.dart';
import 'package:palette/views/root_page.dart';
import '../repositories/auth_repository.dart';

class AuthController extends GetxController {
  AuthRepository authRepository = AuthRepository();

  var isLoading = false.obs;
  var errorMessage = ''.obs;

  // OTP verification states
  var isVerifyingOtp = false.obs;
  var otpErrorMessage = ''.obs;

  // Timer states for OTP resend
  var canResend = false.obs;
  var countdown = 55.obs;
  var isResendOtp = false.obs;
  Timer? _timer;

  Future<void> signInAndGetEmail() async {
    final GoogleSignIn _googleSignIn = GoogleSignIn();
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) return; // user canceled

      googleSignin(googleUser.email,
          image: googleUser.photoUrl, name: googleUser.displayName);
    } catch (e) {
      print("Google Sign-In error: $e");
      return null;
    }
  }

  Future<void> signIn(String email, String password,
      {required bool isRememberMeChecked}) async {
    var user = Rxn<LoginResponse>();
    try {
      isLoading.value = true;
      errorMessage.value = '';
      final response = await authRepository.signIn(email, password);
      user.value = response;
      isLoading.value = false;
      if (response.statusCode >= 200 && response.statusCode < 300) {
        LocalStorageService().saveToken(response.data.accessToken);
        LocalStorageService().saveUserAttributes(response.data.attributes);
        if (isRememberMeChecked) {
          LocalStorageService().saveLoginToLocal(email, password);
        }
        navigateToPage(
            RootPage(
              userInfo: response.data.attributes,
            ),
            clearStack: true);
      } else {
        errorMessage.value = response.message;
      }
    } catch (e) {
      isLoading.value = false;
      errorMessage.value = e.toString();
    }
  }

  Future<void> googleSignin(String email, {String? name, String? image}) async {
    var user = Rxn<GoogleUserData>();
    try {
      isLoading.value = true;
      errorMessage.value = '';
      final response =
          await authRepository.googleSignin(email, image: image, name: name);
      user.value = response.data;
      isLoading.value = false;
      if (response.statusCode >= 200 && response.statusCode < 300) {
        LocalStorageService().saveToken(response.data.accessToken);
        LocalStorageService().saveUserAttributes(response.data.attributes);

        navigateToPage(
            RootPage(
              userInfo: response.data.attributes,
            ),
            clearStack: true);
      } else {
        errorMessage.value = response.message;
      }
    } catch (e) {
      isLoading.value = false;
      errorMessage.value = e.toString();
    }
  }

  Future<void> signUp(String fullName, String email, String password) async {
    var signupResponse = Rxn<SignupResponse>();
    try {
      isLoading.value = true;
      errorMessage.value = '';
      final response = await authRepository.signUp(fullName, email, password);
      signupResponse.value = response;
      isLoading.value = false;
      if (response.statusCode >= 200 && response.statusCode < 300) {
        LocalStorageService().saveToken(response.data.signUpToken);
        navigateToPage(EnterOtpPage(
          email: email,
          isEmailVerified: true,
        ));
      } else {
        otpErrorMessage.value = response.message;
      }
    } catch (e) {
      isLoading.value = false;
      errorMessage.value = e.toString();
    }
  }

// OTP Timer management
  void startOtpTimer() {
    canResend.value = false;
    countdown.value = 55;

    _timer?.cancel();

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (countdown.value == 0) {
        canResend.value = true;
        timer.cancel();
      } else {
        countdown.value--;
      }
    });
  }

  Future<void> resendOtp(String email,
      {required bool isEmailVerification}) async {
    try {
      startOtpTimer();
      authRepository.resendOtp(email);
      isResendOtp.value = true;
    } catch (e) {
      otpErrorMessage.value = e.toString();
    }
  }

  // OTP verification
  Future<void> verifyOtp(
      String email, String otp, bool isEmailVarification) async {
    if (isEmailVarification) {
      try {
        isVerifyingOtp.value = true;
        otpErrorMessage.value = '';
        final EmailVerifiedResponse response = await authRepository
            .verifyEmail(email, otp, isResendPurpose: isResendOtp.value);
        isVerifyingOtp.value = false;
        if (response.statusCode >= 200 && response.statusCode < 300) {
          navigateToPage(SignInPage(), clearStack: true);
          LocalStorageService().saveToken(response.accessToken);
        } else {
          otpErrorMessage.value = response.message;
        }
      } catch (e) {
        isVerifyingOtp.value = false;
        otpErrorMessage.value = e.toString();
      }
    } else {
      try {
        isVerifyingOtp.value = true;
        otpErrorMessage.value = '';
        final OtpVerifiedResponse response =
            await authRepository.verifyForgetPasswordOtp(email, otp,
                isResendPurpose: isResendOtp.value);
        isVerifyingOtp.value = false;
        if (response.statusCode >= 200 && response.statusCode < 300) {
          LocalStorageService().saveToken(response.forgetPasswordToken);
          navigateToPage(NewPasswordPage(
            userEmail: email,
          ));
        } else {
          otpErrorMessage.value = response.message;
        }
      } catch (e) {
        isVerifyingOtp.value = false;
        otpErrorMessage.value = e.toString();
      }
    }
  }

  Future<void> resetPassword(String email, String newPassword) async {
    var resetPasswordResponse = Rxn<PasswordResetResponse>();
    try {
      isLoading.value = true;
      errorMessage.value = '';
      final response = await authRepository.resetPassword(email, newPassword);
      resetPasswordResponse.value = response;
      isLoading.value = false;
      if (response.statusCode >= 200 && response.statusCode < 300) {
        navigateToPage(SignInPage());
      } else {
        otpErrorMessage.value = response.message;
      }
    } catch (e) {
      isLoading.value = false;
      errorMessage.value = e.toString();
    }
  }

  Future<void> sendForgetPasswordOtp(String email) async {
    var forgetPasswordOtpResponse = Rxn<ForgetPasswordOtpResponse>();
    try {
      isLoading.value = true;
      errorMessage.value = '';
      final response = await authRepository.sendForgetPasswordOtp(email);
      forgetPasswordOtpResponse.value = response;
      isLoading.value = false;
      if (response.statusCode >= 200 && response.statusCode < 300) {
        navigateToPage(EnterOtpPage(
          email: email,
          isEmailVerified: false,
        ));
      } else {
        errorMessage.value = response.message;
      }
    } catch (e) {
      isLoading.value = false;
      errorMessage.value = e.toString();
    }
  }
}
