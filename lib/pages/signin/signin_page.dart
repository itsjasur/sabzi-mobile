// signin_page.dart
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sabzi/app/app.dart';
import 'package:flutter_sabzi/app/auth/auth_provider.dart';
import 'package:flutter_sabzi/pages/signin/signin_provider.dart';
import 'package:flutter_sabzi/pages/signin/terms_modal_content.dart';
import 'package:flutter_sabzi/core/formatters/phone_number_formatters.dart';
import 'package:flutter_sabzi/core/widgets/custom_text_form_field.dart';
import 'package:flutter_sabzi/core/widgets/primary_button.dart';

class SigninPage extends ConsumerStatefulWidget {
  final bool isNewUser;
  const SigninPage({super.key, this.isNewUser = false});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SigninPageState();
}

class _SigninPageState extends ConsumerState<SigninPage> {
  final _phoneFocusNode = FocusNode();
  final _codeFocusNode = FocusNode();
  Timer? _timer;
  int _timerSeconds = 120;

  @override
  void initState() {
    super.initState();

    // request initial focus after frame is built
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      ref.read(signinProvider.notifier).resetState();
      _phoneFocusNode.requestFocus();

      if (widget.isNewUser) {
        await Future.delayed(const Duration(milliseconds: 400));
        await _showTermsModal();
        if (!ref.watch(signinProvider).allRequiredTermsChecked) {
          if (mounted) Navigator.pop(context);
        }
      }
    });
  }

  Future<void> _showTermsModal() async {
    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      isDismissible: true,
      builder: (BuildContext context) => const TermsModalContent(),
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    _phoneFocusNode.dispose();
    _codeFocusNode.dispose();
    super.dispose();
  }

  void _startTimer() {
    _timer?.cancel();
    _timerSeconds = 300;

    _timer = Timer.periodic(
      const Duration(seconds: 1),
      (timer) {
        if (_timerSeconds == 0) {
          timer.cancel();
          ref.read(signinProvider.notifier).resetSentState();
        } else {
          _timerSeconds--;
        }
        setState(() {});
      },
    );
  }

  String get _timeDisplay {
    int minutes = _timerSeconds ~/ 60;
    int remainingSeconds = _timerSeconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(signinProvider);
    final provider = ref.read(signinProvider.notifier);
    double textSize = 17;
    FontWeight fontWeight = FontWeight.w500;

    return GestureDetector(
      onTap: () {
        _phoneFocusNode.unfocus();
        _codeFocusNode.unfocus();
      },
      child: Scaffold(
        appBar: AppBar(),
        body: Stack(
          children: [
            SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                spacing: 10,
                children: [
                  const Text(
                    'Sign in with your phone number',
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  CustomTextFormField(
                    focusNode: _phoneFocusNode,
                    controller: state.phoneController,
                    keyboardType: TextInputType.number,
                    hintText: '00 000 0000',
                    enabled: !state.verificationCodeSent,
                    inputFormatters: [UzbNumberTextFormatter()],
                    textSize: textSize,
                    fontWeight: fontWeight,
                    onChanged: (value) => setState(() {}),
                    prefixIcon: IntrinsicWidth(
                      child: Center(
                        child: Container(
                          margin: const EdgeInsets.only(left: 10, right: 5),
                          child: Text(
                            '+998',
                            style: TextStyle(
                              fontSize: textSize,
                              fontWeight: fontWeight,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  if (state.verificationCodeSent)
                    CustomTextFormField(
                      key: ValueKey(state.error),
                      focusNode: _codeFocusNode,
                      controller: state.codeController,
                      keyboardType: TextInputType.number,
                      hintText: '000000',
                      maxLength: 6,
                      textSize: textSize,
                      onChanged: (value) => setState(() {}),
                      errorText: state.error,
                      fontWeight: fontWeight,
                      suffixIcon: IntrinsicWidth(
                        child: Center(
                          child: Container(
                            margin: const EdgeInsets.only(left: 10, right: 10),
                            child: Text(
                              _timeDisplay.toString(),
                              style: TextStyle(
                                fontSize: textSize,
                                color: _timerSeconds < 30 ? Colors.red : Theme.of(context).colorScheme.onSurface,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  if (state.verificationCodeSent && _timerSeconds < 30)
                    Container(
                      margin: const EdgeInsets.only(top: 10),
                      height: 35,
                      child: IntrinsicWidth(
                        child: PrimaryButton(
                          elevation: 0,
                          borderRadius: 4,
                          backgroundColor: Theme.of(context).colorScheme.onSurface.withAlpha(50),
                          onTap: () {
                            provider.requestCode();
                            _startTimer();
                            _codeFocusNode.requestFocus();
                          },
                          child: Text(
                            'Resend code',
                            style: TextStyle(
                              fontSize: 13,
                              color: Theme.of(context).colorScheme.onSurface,
                            ),
                          ),
                        ),
                      ),
                    ),
                  if (!state.verificationCodeSent && state.phoneController.text.length >= 8)
                    PrimaryButton(
                      isLoading: state.isLoading,
                      onTap: () async {
                        // bool? isNewUser = await provider.checkNewUser();
                        bool isNewAccount = await provider.checkNewUser();
                        _phoneFocusNode.unfocus();

                        if (isNewAccount && !ref.watch(signinProvider).allRequiredTermsChecked) await _showTermsModal();

                        if (isNewAccount && !ref.watch(signinProvider).allRequiredTermsChecked) {
                          provider.updateLoadingState(false);
                          return;
                        }

                        await Future.delayed(const Duration(milliseconds: 300));
                        _phoneFocusNode.unfocus();
                        provider.requestCode();
                        _startTimer();
                        _codeFocusNode.requestFocus();
                      },
                      child: const Text('Request code'),
                    ),
                  if (state.verificationCodeSent && state.codeController.text.length >= 6)
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: PrimaryButton(
                        isLoading: state.isLoading,
                        onTap: () {
                          _codeFocusNode.unfocus();
                          provider.verifyCode();
                        },
                        child: const Text('Confirm'),
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
