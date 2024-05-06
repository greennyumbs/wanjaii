import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_dating_app/screens/screens.dart';

class OnboardingScreen extends StatelessWidget {
  static const String routeName = '/onboarding';

  const OnboardingScreen({super.key});

  static Route route() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (context) => OnboardingScreen(),
    );
  }

  static const List<Tab> tabs = <Tab>[
    Tab(text: 'GenderSelectionScreen'),
    Tab(text: 'InterestScreen'),
    Tab(text: 'ProfileSetupScreen'),
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: tabs.length,
      child: Builder(builder: (BuildContext context) {
        final TabController tabController = DefaultTabController.of(context);
        tabController.addListener(() {
          if (!tabController.indexIsChanging) {}
        });
        return Scaffold(
          body: GestureDetector(
            onHorizontalDragCancel: () {},
            child: TabBarView(
              children: [
                GenderSelectionScreen(
                    tabController: tabController,
                    onGenderSelected: (bool isWomen,
                        {bool isChooseAnother = true}) {}),
                InterestScreen(tabController: tabController),
                ProfileSetupScreen(
                  tabController: tabController,
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
