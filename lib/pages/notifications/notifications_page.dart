import 'package:flutter/material.dart';
import 'package:flutter_sabzi/core/widgets/scaled_tap.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class NotificationsPage extends StatelessWidget {
  const NotificationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
      ),
      body: RefreshIndicator(
        onRefresh: () async {},
        child: ListView.separated(
          separatorBuilder: (context, index) => const SizedBox(height: 30),
          padding: const EdgeInsets.symmetric(horizontal: 15),
          itemCount: 20,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return ScaledTap(
              onTap: () {},
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                // mainAxisSize: MainAxisSize.max,
                spacing: 7,
                children: [
                  Icon(
                    PhosphorIconsFill.circle,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  Expanded(
                    child: Column(
                      // spacing: 5,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          spacing: 5,
                          children: [
                            Text(
                              'Hoodud news',
                              style: TextStyle(
                                fontSize: 13,
                                color: Theme.of(context).colorScheme.onSurface.withAlpha(150),
                              ),
                            ),
                            const Spacer(),
                            Text(
                              '2 days ago',
                              style: TextStyle(
                                fontSize: 13,
                                color: Theme.of(context).colorScheme.onSurface.withAlpha(120),
                              ),
                            ),
                            ScaledTap(
                              onTap: () {},
                              child: Icon(
                                PhosphorIconsFill.dotsThreeOutlineVertical,
                                color: Theme.of(context).colorScheme.onSurface.withAlpha(100),
                                size: 17,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 3),
                        Container(
                          // color: Colors.amber,
                          child: Text(
                            'Happy notifications to you. This is lorem ipsum placeholder for notification overflowing to the 3rd line $index',
                            style: const TextStyle(fontSize: 14),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        const SizedBox(height: 10),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(6),
                          child: Image.network(
                            "https://hips.hearstapps.com/hmg-prod/images/new-years-wishes-funny-new-year-wishes-67339a311b3e2.jpg?crop=0.559xw:1.00xh;0.199xw,0&resize=980:*",
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
