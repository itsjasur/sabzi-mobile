import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sabzi/app/auth/signin/check_terms_widget.dart';
import 'package:flutter_sabzi/app/auth/signin/signin_provider.dart';
import 'package:flutter_sabzi/core/widgets/custom_bottom_sheet_drag.dart';
import 'package:flutter_sabzi/core/widgets/custom_checkbox.dart';

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
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 40),
                const Text(
                  'Consent is required to use Sabzi',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 20),
                CustomCheckbox(
                  borderRadius: 20,
                  size: 22,
                  value: state.allRequiredTermsChecked,
                  onChanged: (value) {
                    provider.isUserTermsAgreeChecked(value!);
                    provider.isPrivacyAgreeChecked(value);
                    provider.isMarketingAgreeChecked(value);
                  },
                  child: const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      spacing: 10,
                      children: [
                        Flexible(
                          child: Text(
                            'Consent to all',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        Flexible(
                          child: Text(
                            'Includes collection and use of the minimum personal information essential for using the service, collection and use of location information, consent to receive advertising information (optional) and consent to receive marketing information (optional).',
                            style: TextStyle(fontSize: 13),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Divider(color: Theme.of(context).colorScheme.secondary, thickness: 0.5, height: 40),
                CheckTermsWidget(
                  title: "I agree to user terms",
                  value: state.isUserTermsAgreeChecked,
                  onCheck: (newValue) {
                    provider.isUserTermsAgreeChecked(newValue!);
                  },
                  onOpen: () {},
                ),
                // const SizedBox(height: 10),
                CheckTermsWidget(
                  title: "I agree to privacy policy",
                  value: state.isPrivacyAgreeChecked,
                  onCheck: (newValue) {
                    provider.isPrivacyAgreeChecked(newValue!);
                  },
                  onOpen: () {},
                ),
                const SizedBox(height: 140),
              ],
            ),
          ),
          const CustomBottomSheetDrag()
        ],
      ),
    );
  }
}
