import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sabzi/core/widgets/primary_button.dart';
import 'package:flutter_sabzi/pages/area/my_area_page.dart';

class VerifyLocationAlert extends ConsumerWidget {
  const VerifyLocationAlert({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AlertDialog(
      contentPadding: const EdgeInsets.all(20),
      alignment: Alignment.center,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Verify location',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 10),
          const Text('Please verify your location to sell your listings.'),
          const SizedBox(height: 15),
          Row(
            // mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                child: SizedBox(
                  height: 40,
                  child: PrimaryButton(
                    elevation: 0,
                    backgroundColor: Theme.of(context).colorScheme.tertiary,
                    onTap: () {
                      // Navigator.of(context).pushAndRemoveUntil(
                      //   MaterialPageRoute(builder: (context) => const HomePage()),
                      //   (route) => false,
                      // );

                      Navigator.of(context).popUntil((route) => route.isFirst);
                    },
                    child: Text(
                      'Cancel',
                      maxLines: 1,
                      style: TextStyle(color: Theme.of(context).colorScheme.onSurface),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: SizedBox(
                  height: 40,
                  child: PrimaryButton(
                    elevation: 0,
                    onTap: () {
                      Navigator.of(context).pop();
                      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const MyAreaPage()));
                    },
                    child: const Text(
                      'Verify location',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
