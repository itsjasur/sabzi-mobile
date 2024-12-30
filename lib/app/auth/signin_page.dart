import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sabzi/app/auth/auth_provider.dart';
import 'package:flutter_sabzi/core/formatters/phone_number_formatters.dart';
import 'package:flutter_sabzi/core/widgets/custom_text_form_field.dart';
import 'package:flutter_sabzi/core/widgets/primary_button.dart';

class SigninPage extends ConsumerStatefulWidget {
  const SigninPage({super.key});

  @override
  ConsumerState<SigninPage> createState() => _SigningPageState();
}

class _SigningPageState extends ConsumerState<SigninPage> {
  final FocusNode _pageFocusNode = FocusNode();
  // final TextEditingController? phoneNumberController = TextEditingController();
  // final TextEditingController? verCodeController = TextEditingController();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _pageFocusNode.requestFocus();
    });
  }

  @override
  void dispose() {
    _pageFocusNode.dispose();
    _timer?.cancel();
    super.dispose();
  }

  Timer? _timer;
  late int _seconds = 120; // 5 mins to enter code

  void _startTimer() {
    if (_timer != null) _timer!.cancel();
    _seconds = 120;

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_seconds <= 0) {
        _timer?.cancel();
        // _codeRequested = false;
        ref.read(authProvider.notifier).changeIsCodeRequested(false);
      } else {
        _seconds--;
      }
      setState(() {});
    });
  }

  String get timeDisplay {
    int minutes = _seconds ~/ 60;
    int remainingSeconds = _seconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    double textSize = 17;
    FontWeight fontWeight = FontWeight.w500;

    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        appBar: AppBar(),
        body: Stack(
          children: [
            SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                spacing: 15,
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
                    focusNode: !ref.watch(authProvider).isCodeRequested ? _pageFocusNode : null,
                    controller: ref.watch(authProvider).phoneNumberController,
                    keyboardType: TextInputType.number,
                    hintText: '00 000 0000',
                    inputFormatters: [UzbNumberTextFormatter()],
                    textSize: textSize,
                    fontWeight: fontWeight,
                    onChanged: (value) {
                      setState(() {});
                    },
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
                  if (ref.watch(authProvider).isCodeRequested)
                    CustomTextFormField(
                      focusNode: ref.watch(authProvider).isCodeRequested ? _pageFocusNode : null,
                      controller: ref.watch(authProvider).verCodeController,
                      keyboardType: TextInputType.number,
                      hintText: '000000',
                      maxLength: 6,
                      textSize: textSize,
                      errorText: ref.watch(authProvider).error,
                      fontWeight: fontWeight,
                      onChanged: (value) {
                        setState(() {});
                      },
                      // timer
                      suffixIcon: IntrinsicWidth(
                        child: Center(
                          child: Container(
                            margin: const EdgeInsets.only(left: 10, right: 10),
                            child: Text(
                              timeDisplay,
                              style: TextStyle(
                                fontSize: textSize,
                                color: _seconds < 30 ? Colors.red : Theme.of(context).colorScheme.onSurface,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  if (!ref.watch(authProvider).isCodeRequested && ref.watch(authProvider).phoneNumberController.text.length >= 9)
                    PrimaryButton(
                      onTap: ref.watch(authProvider).isLoading
                          ? null
                          : () async {
                              await ref.read(authProvider.notifier).getCode();
                              setState(() {});
                              _startTimer();

                              // change focus once code is sent
                              _pageFocusNode.unfocus();
                              await Future.delayed(const Duration(milliseconds: 200));
                              _pageFocusNode.requestFocus();
                            },
                      child: ref.watch(authProvider).isLoading
                          ? const SizedBox(
                              height: 26,
                              width: 26,
                              child: CircularProgressIndicator(
                                color: Colors.white,
                                strokeWidth: 2,
                              ),
                            )
                          : const Text('Request code'),
                    ),
                  if (ref.watch(authProvider).isCodeRequested && ref.watch(authProvider).verCodeController.text.length >= 6)
                    PrimaryButton(
                      onTap: ref.watch(authProvider).isLoading
                          ? null
                          : () async {
                              await ref.read(authProvider.notifier).verifyCode();
                            },
                      child: const Text('Confirm'),
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
