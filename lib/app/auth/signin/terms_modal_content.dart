import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sabzi/app/auth/signin/signin_provider.dart';
import 'package:flutter_sabzi/core/widgets/custom_bottom_sheet_drag.dart';
import 'package:flutter_sabzi/core/widgets/custom_checkbox.dart';
import 'package:flutter_sabzi/core/widgets/primary_button.dart';
import 'package:flutter_sabzi/core/widgets/scaled_tap.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class TermsModalContent extends ConsumerWidget {
  const TermsModalContent({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(signinProvider);
    final provider = ref.read(signinProvider.notifier);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      width: double.infinity,
      child: Stack(
        children: [
          SafeArea(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                spacing: 20,
                children: [
                  const SizedBox(height: 30),
                  const Text(
                    'Consent is required to use Sabzi',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  CustomCheckbox(
                    value: state.isUserTermsAgreeChecked,
                    onChanged: (value) {
                      provider.isUserTermsAgreeChecked(value!);
                    },
                    title: "I agree to user terms",
                    borderRadius: 20,
                    trailingIcon: ScaledTap(
                      onTap: () {},
                      child: Icon(
                        PhosphorIcons.caretRight(PhosphorIconsStyle.regular),
                        size: 18,
                      ),
                    ),
                  ),
                  CustomCheckbox(
                    value: state.isPrivacyAgreeChecked,
                    onChanged: (value) {
                      provider.isPrivacyAgreeChecked(value!);
                    },
                    borderRadius: 20,
                    title: 'I agree to privacy terms',
                    trailingIcon: ScaledTap(
                      onTap: () {},
                      child: Icon(
                        PhosphorIcons.caretRight(PhosphorIconsStyle.regular),
                        size: 18,
                      ),
                    ),
                  ),
                  CustomCheckbox(
                    value: state.isMarketingAgreeChecked,
                    onChanged: (value) {
                      provider.isMarketingAgreeChecked(value!);
                    },
                    borderRadius: 20,
                    title: '(Optional) I agree to marketing terms',
                    trailingIcon: ScaledTap(
                      onTap: () {},
                      child: Icon(
                        PhosphorIcons.caretRight(PhosphorIconsStyle.regular),
                        size: 18,
                      ),
                    ),
                  ),
                  PrimaryButton(
                    onTap: () => Navigator.pop(context),
                    child: const Text('Confirm'),
                  ),
                ],
              ),
            ),
          ),
          const CustomBottomSheetDrag()
        ],
      ),
    );
  }
}
