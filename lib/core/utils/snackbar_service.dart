// // lib/core/services/snackbar_service.dart
// import 'package:flutter/material.dart';
// import 'package:flutter/scheduler.dart';
// import 'package:flutter_sabzi/main.dart';

// class SnackBarService {
//   static OverlayEntry? _currentSnackBar;
//   static AnimationController? _animationController;

//   static void _showMessageImpl(String message) {
//     final overlay = navigatorKey.currentState!.overlay;
//     if (overlay == null) return;

//     _currentSnackBar?.remove();
//     _animationController?.dispose();
//     _animationController = AnimationController(duration: const Duration(milliseconds: 200), vsync: overlay);

//     final offsetAnimation = Tween<Offset>(
//       begin: Offset.zero,
//       end: const Offset(0.0, -1.0),
//     ).animate(CurvedAnimation(
//       parent: _animationController!,
//       curve: Curves.easeIn,
//     ));

//     Widget snackbarContent = GestureDetector(
//       onVerticalDragUpdate: (details) {
//         if (details.primaryDelta! < 0) {
//           _animationController!.value -= details.primaryDelta! / 100;
//         }
//       },
//       onVerticalDragEnd: (details) {
//         if (_animationController!.value > 0.3 || details.primaryVelocity! < -700) {
//           _animationController!.forward().then((_) => _removeSnackBar());
//         } else {
//           _animationController!.reverse();
//         }
//       },
//       child: Material(
//         elevation: 4.0,
//         borderRadius: BorderRadius.circular(8),
//         color: Colors.black87,
//         child: Container(
//           constraints: const BoxConstraints(maxWidth: 400),
//           padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
//           child: Text(
//             message,
//             style: const TextStyle(color: Colors.white),
//             textAlign: TextAlign.center,
//           ),
//         ),
//       ),
//     );

//     _currentSnackBar = OverlayEntry(
//       builder: (context) => Positioned(
//         top: MediaQuery.of(context).padding.top + 10,
//         width: MediaQuery.of(context).size.width,
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 20),
//           child: Center(
//             child: SlideTransition(
//               position: offsetAnimation,
//               child: snackbarContent,
//             ),
//           ),
//         ),
//       ),
//     );

//     overlay.insert(_currentSnackBar!);

//     Future.delayed(const Duration(seconds: 30), () {
//       if (_currentSnackBar != null) {
//         _animationController!.forward().then((_) {
//           _currentSnackBar?.remove();
//           _currentSnackBar = null;
//           _animationController?.dispose();
//           _animationController = null;
//         });
//       }
//     });
//   }

//   static void _removeSnackBar() {
//     _currentSnackBar?.remove();
//     _currentSnackBar = null;
//     _animationController?.dispose();
//     _animationController = null;
//   }

//   static void show(String message) {
//     if (SchedulerBinding.instance.schedulerPhase == SchedulerPhase.persistentCallbacks) {
//       SchedulerBinding.instance.addPostFrameCallback((_) {
//         _showMessageImpl(message);
//       });
//     } else {
//       _showMessageImpl(message);
//     }
//   }
// }
