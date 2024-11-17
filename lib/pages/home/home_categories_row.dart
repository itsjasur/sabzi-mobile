// import 'package:flutter/material.dart';
// import 'package:flutter_sabzi/core/models/category.dart';
// import 'package:flutter_sabzi/core/widgets/scaled_tap.dart';

// class MyWidget extends StatelessWidget {

//   const MyWidget({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return SingleChildScrollView(
//       scrollDirection: Axis.horizontal,
//       child: Row(
//         children: [
//           const SizedBox(width: 20),
//           ...List.generate(categories.length, (categoryIndex) {
//             ItemCategory category = categories[categoryIndex];

//             return ScaledTap(
//               onTap: () {
//                 _selectedCategory = category.code;
//                 setState(() {});
//               },
//               child: Container(
//                 padding: const EdgeInsets.symmetric(horizontal: 10),
//                 margin: const EdgeInsets.only(right: 10),
//                 constraints: const BoxConstraints(minWidth: 50, minHeight: 35),
//                 alignment: Alignment.center,
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(6),
//                   color: Theme.of(context).colorScheme.tertiary,
//                   border: _selectedCategory == category.code ? Border.all(color: Theme.of(context).colorScheme.primary.withOpacity(0.5)) : null,
//                 ),
//                 child: Text(category.name),
//               ),
//             );
//           }),
//           const SizedBox(width: 20),
//         ],
//       ),
//     );
//   }
// }
