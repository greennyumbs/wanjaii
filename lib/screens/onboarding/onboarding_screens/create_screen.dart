import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dating_app/screens/onboarding/onboarding_screens/chat_main.dart';
import 'package:flutter_dating_app/screens/onboarding/onboarding_screens/signin.dart';
import 'package:flutter_dating_app/screens/onboarding/onboarding_screens/signup.dart';

import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class Create extends StatelessWidget {
  final String title;
  //final TabController tabController;

  Create({
    Key? key,
    required this.title,
    //required this.tabController,
  }) : super(key: key);

  final List<Map<String, dynamic>> rawData = [];
  final List<Image> displayPhoto = [
    Image.asset('assets/images/girl1.png'),
    Image.asset('assets/images/girl2.png'),
    Image.asset('assets/images/girl3.png')
  ];

  final List<String> text1 = ["Algorithm", "Matches", "Premium"];
  final List<String> text2 = [
    "Users going through a vetting process to",
    "We match you with people that have a",
    "Sign up today and enjoy the first month"
  ];
  final List<String> text3 = [
    "ensure you never match with bots.",
    "large array of similar interests.",
    "of premium benefits on us."
  ];

  @override
  Widget build(BuildContext context) {
    int activeIndex = 0;

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SingleChildScrollView(
              child: CarouselSlider(
                options: CarouselOptions(
                  height: 450,
                  autoPlay: true,
                  enableInfiniteScroll: true,
                  autoPlayAnimationDuration: const Duration(seconds: 2),
                  enlargeCenterPage: true,
                  aspectRatio: 8.0,
                  viewportFraction: 0.6, // Adjust this to show 3 images
                  onPageChanged: (index, reason) => activeIndex = index,
                ),
                items: displayPhoto,
              ),
            ),
            const SizedBox(height: 0),
            buildTextList(text1, text2, text3, activeIndex),
            const SizedBox(height: 20),
            buildIndicator(displayPhoto.length, activeIndex),
            const SizedBox(height: 80),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SignUp()),
                );
                print('Create Account button pressed');
              },
              style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all<Color>(const Color(0xFFBB254A)),
                minimumSize:
                    MaterialStateProperty.all<Size>(const Size(295, 56)),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                ),
              ),
              child: const Text(
                'Create Account',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Sk-Modernist',
                  color: Color(0xFFFFFFFF),
                ),
              ),
            ),
            const SizedBox(height: 0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Already have an account?',
                  style: TextStyle(
                    fontSize: 14,
                    fontFamily: 'Sk-Modernist',
                    color: Color(0xFF323755),
                    fontWeight: FontWeight.w600,
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const SignIn()),
                    );
                  },
                  child: const Text(
                    "Sign In",
                    style: TextStyle(
                      fontSize: 14,
                      fontFamily: 'Sk-Modernist',
                      fontWeight: FontWeight.w700,
                      color: Color(0xFFBB254A),
                    ),
                  ),
                ),
                //BELL
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const ChatMain()),
                    );
                  },
                  child: const Text(
                    "Go To ChatMain",
                    style: TextStyle(
                      fontSize: 14,
                      fontFamily: 'Sk-Modernist',
                      fontWeight: FontWeight.w700,
                      color: Color(0xFFBB254A),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildIndicator(int itemCount, int activeIndex) =>
      AnimatedSmoothIndicator(
        effect: const WormEffect(
          dotWidth: 10,
          dotHeight: 10,
          activeDotColor: Color(0xFFE94057),
        ),
        activeIndex: activeIndex,
        count: itemCount,
      );

  Widget buildTextList(List<String> text1, List<String> text2,
      List<String> text3, int activeIndex) {
    return ListView.builder(
      itemCount: 1,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return Column(
          children: [
            Text(
              text1[activeIndex],
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 24,
                fontFamily: 'Sk-Modernist',
                color: Color(0xFFBB254A),
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              text2[activeIndex],
              style: const TextStyle(
                fontSize: 14,
                fontFamily: 'Sk-Modernist',
                color: Color(0xFF323755),
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              text3[activeIndex],
              style: const TextStyle(
                fontSize: 14,
                fontFamily: 'Sk-Modernist',
                color: Color(0xFF323755),
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        );
      },
    );
  }
}
