import 'package:flutter/widgets.dart';

class SigninState {
  final TextEditingController phoneController;
  final TextEditingController codeController;
  final bool isLoading;
  final bool verificationCodeSent;
  final String? error;
  final String? verificationToken;

  // final bool isNewAccount;
  final bool isUserTermsAgreeChecked;
  final bool isPrivacyAgreeChecked;
  final bool isMarketingAgreeChecked;

  SigninState({
    required this.phoneController,
    required this.codeController,
    this.isLoading = false,
    this.verificationCodeSent = false,
    this.error,
    this.verificationToken,
    // this.isNewAccount = false,
    this.isUserTermsAgreeChecked = false,
    this.isPrivacyAgreeChecked = false,
    this.isMarketingAgreeChecked = false,
  });

  SigninState copyWith({
    bool? isLoading,
    bool? verificationCodeSent,
    String? error,
    String? verificationToken,
    bool? isUserTermsAgreeChecked,
    bool? isPrivacyAgreeChecked,
    bool? isMarketingAgreeChecked,
  }) {
    return SigninState(
      phoneController: phoneController,
      codeController: codeController,
      isLoading: isLoading ?? this.isLoading,
      verificationCodeSent: verificationCodeSent ?? this.verificationCodeSent,
      // error: error ?? this.error,
      error: error == null ? null : (error),
      verificationToken: verificationToken ?? this.verificationToken,

      // isNewAccount: isNewAccount ?? this.isNewAccount,
      isUserTermsAgreeChecked: isUserTermsAgreeChecked ?? this.isUserTermsAgreeChecked,
      isPrivacyAgreeChecked: isPrivacyAgreeChecked ?? this.isPrivacyAgreeChecked,
      isMarketingAgreeChecked: isMarketingAgreeChecked ?? this.isMarketingAgreeChecked,
    );
  }

  bool get allRequiredTermsChecked => isUserTermsAgreeChecked && isPrivacyAgreeChecked;
}
