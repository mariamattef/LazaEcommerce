import 'package:flutter/material.dart';
import 'package:laza_ecommerce/core/app_theme.dart';

import 'get_started_screen.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  WelcomeScreenState createState() => WelcomeScreenState();
}

class WelcomeScreenState extends State<WelcomeScreen> {
  int _activeIndex = 1;

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromARGB(255, 194, 182, 241),
              Color.fromARGB(255, 163, 109, 240),
              AppTheme.primaryColorLight,
              Color.fromARGB(255, 194, 182, 241),
              Color.fromARGB(255, 194, 182, 241),
              Color.fromARGB(255, 163, 109, 240),
              AppTheme.primaryColorLight,
              Color.fromARGB(255, 194, 182, 241),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomCenter,
            tileMode: TileMode.repeated,
          ),
        ),
        child: Stack(
          children: [
            // Background Image
            Positioned(
              top: screenHeight * 0.06,
              left: 0,
              right: 0,
              child: Image.asset(
                'assets/images/welcome_background.png',
                height: screenHeight * 0.9,
                fit: BoxFit.contain,
              ),
            ),

            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                padding: const EdgeInsets.all(30.0),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40.0),
                    topRight: Radius.circular(40.0),
                  ),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Look Good, Feel Good',
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.w600,
                        color: AppTheme.textColor1,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Create your individual & unique style and look amazing everyday.',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                        color: AppTheme.colorGray,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 30),
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              setState(() {
                                _activeIndex = 0;
                              });
                            },
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(vertical: 15),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              foregroundColor: _activeIndex == 0
                                  ? Colors.white
                                  : AppTheme.colorGray,
                              backgroundColor: _activeIndex == 0
                                  ? AppTheme.mainColor
                                  : AppTheme.lightGray,

                              elevation: 0,
                            ),
                            child: const Text(
                              'Men',
                              style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 20),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              setState(() {
                                _activeIndex = 1;
                              });
                            },
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(vertical: 15),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              foregroundColor: _activeIndex == 1
                                  ? Colors.white
                                  : AppTheme.colorGray,
                              backgroundColor: _activeIndex == 1
                                  ? AppTheme.mainColor
                                  : AppTheme.lightGray,
                              elevation: 0,
                            ),
                            child: const Text(
                              'Women',
                              style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.w500,
                                // color: AppTheme.textColor,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const GetStartedScreen(),
                          ),
                        );
                      },
                      child: Text(
                        'Skip',
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w500,
                          color: AppTheme.colorGray,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:laza_ecommerce/core/app_theme.dart';
// import 'package:laza_ecommerce/core/utiles/color_utiles.dart';

// import 'get_started_screen.dart';

// class WelcomeScreen extends StatelessWidget {
//   const WelcomeScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final screenHeight = MediaQuery.of(context).size.height;
//     final screenWidth = MediaQuery.of(context).size.width;
//     // bool isAcive = false;
//     return Scaffold(
//       body: Container(
//         decoration: const BoxDecoration(
//           gradient: LinearGradient(
//             colors: [
//               AppTheme.primaryColor, // #7661C5
//               AppTheme.primaryColorLight, // #B0A3E5
//             ],
//             begin: Alignment.topCenter,
//             end: Alignment.bottomCenter,
//           ),
//         ),
//         child: Stack(
//           children: [
//             Positioned(
//               top: screenHeight * 0.1,
//               left: 0,
//               right: 0,
//               child: Image.asset(
//                 'assets/images/welcome_background.png',
//                 height: screenHeight * 0.6,
//                 fit: BoxFit.contain,
//               ),
//             ),

//             Positioned(
//               bottom: 0,
//               left: 0,
//               right: 0,
//               child: Container(
//                 padding: const EdgeInsets.all(30.0),
//                 decoration: const BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.only(
//                     topLeft: Radius.circular(40.0),
//                     topRight: Radius.circular(40.0),
//                   ),
//                 ),
//                 child: Column(
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     Text(
//                       'Look Good, Feel Good',
//                       style: TextStyle(
//                         fontSize: 25,
//                         fontWeight: FontWeight.w600,
//                         color: ColorUtility.textColor1,
//                       ),
//                       textAlign: TextAlign.center,
//                     ),
//                     const SizedBox(height: 10),
//                     Text(
//                       'Create your individual & unique style and look amazing everyday.',
//                       style: TextStyle(
//                         fontSize: 15,
//                         fontWeight: FontWeight.w400,
//                         color: ColorUtility.colorGray,
//                       ),
//                       textAlign: TextAlign.center,
//                     ),
//                     const SizedBox(height: 30),
//                     StatefulBuilder(
//                       builder: (context, setState) {
//                         int activeIndex = 0;
//                         return Row(
//                           children: [
//                             Expanded(
//                               child: ElevatedButton(
//                                 onPressed: () {
//                                   setState(() {
//                                     activeIndex = 0;
//                                   });
//                                 },
//                                 style: ElevatedButton.styleFrom(
//                                   backgroundColor: activeIndex == 0
//                                       ? AppTheme.mainColor
//                                       : AppTheme.lightGray,
//                                   foregroundColor: activeIndex == 0
//                                       ? Colors.white
//                                       : AppTheme.textColor,
//                                   elevation: 0,
//                                 ),
//                                 child: const Text('Men'),
//                               ),
//                             ),
//                             const SizedBox(width: 20),
//                             Expanded(
//                               child: ElevatedButton(
//                                 onPressed: () {
//                                   setState(() {
//                                     activeIndex = 1;
//                                   });
//                                 },
//                                 style: ElevatedButton.styleFrom(
//                                   backgroundColor: activeIndex == 1
//                                       ? AppTheme.mainColor
//                                       : AppTheme.lightGray,
//                                   foregroundColor: activeIndex == 1
//                                       ? Colors.white
//                                       : AppTheme.textColor,
//                                   elevation: 0,
//                                 ),
//                                 child: const Text('Women'),
//                               ),
//                             ),
//                           ],
//                         );
//                       },
//                     ),

//                     const SizedBox(height: 20),
//                     TextButton(
//                       onPressed: () {
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                             builder: (context) => const GetStartedScreen(),
//                           ),
//                         );
//                       },
//                       child: Text(
//                         'Skip',
//                         style: TextStyle(
//                           fontSize: 17,
//                           color: ColorUtility.colorGray,
//                           fontWeight: FontWeight.w500,
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
