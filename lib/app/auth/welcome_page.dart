import 'package:flutter/material.dart';
import 'package:flutter_sabzi/core/widgets/primary_button.dart';
import 'package:flutter_sabzi/core/widgets/scaled_tap.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Container(
          // color: Colors.amber,
          padding: const EdgeInsets.symmetric(horizontal: 15),
          width: double.infinity,
          child: Column(
            // spacing: 10,
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Spacer(),
              Icon(
                Icons.person_pin_circle_rounded,
                color: Theme.of(context).colorScheme.primary,
                size: 100,
              ),
              const Text(
                'Welcome to Sabzi',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Text(
                'Your friendly neighborhood marketplace',
                style: TextStyle(fontSize: 15),
              ),
              const Spacer(),
              PrimaryButton(
                onTap: () {},
                child: const Text('Get started'),
              ),
              const SizedBox(height: 15),
              ScaledTap(
                onTap: () {},
                child: RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    style: TextStyle(
                      fontSize: 15,
                      color: Theme.of(context).colorScheme.onSurface.withAlpha(150),
                    ),
                    children: [
                      const TextSpan(text: 'Have an account? '),
                      TextSpan(
                        text: 'Log in',
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.primary,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}
