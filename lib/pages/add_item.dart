import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:sabzi_app/components/custom_icon_button.dart';
import 'package:sabzi_app/components/gallery_view.dart';
import 'package:sabzi_app/components/image_picker_container.dart';
import 'package:sabzi_app/theme.dart';
import 'package:uicons/uicons.dart';

class AddItemPage extends StatefulWidget {
  const AddItemPage({super.key});

  @override
  State<AddItemPage> createState() => _AddItemPageState();
}

class _AddItemPageState extends State<AddItemPage> {
  @override
  Widget build(BuildContext context) {
    final colors = AppColorPalette.of(context);
    // return Scaffold(

    //   appBar: AppBar(
    //     leadingWidth: 0,
    //     leading: const SizedBox.shrink(),
    //     actions: const [
    //       SizedBox(width: 15),
    //       CustomIconButton(
    //         icon: Icons.close,
    //         iconSize: 26,
    //       ),
    //       Spacer(),
    //     ],
    //   ),
    // );

    return Material(
      child: SafeArea(
        child: Column(
          children: [
            Container(
              color: Colors.amber.shade100,
              height: 50,
              child: Row(
                // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(width: 15),
                  CustomIconButton(
                    icon: Icons.close,
                    iconSize: 27,
                  ),
                  Spacer(),
                  Text(
                    'Save draft',
                    style: TextStyle(
                      fontSize: 14,
                      color: colors.secondary.withOpacity(0.7),
                    ),
                  ),
                  SizedBox(width: 15),
                ],
              ),
            ),
            SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Text(
                      'Input all the necessary information aobut the item you want to sell',
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  ImagePickerContainer(),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
