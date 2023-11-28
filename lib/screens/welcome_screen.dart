import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:tasky_app/screens/home_screen.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  final introKey = GlobalKey<IntroductionScreenState>();

  void _onIntroEnd(context) {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (_) => const HomeScreen()),
    );
  }

  Widget _buildImage(String assetName, [double width = 350]) {
    return Image.asset('assets/$assetName', width: width);
  }

  @override
  Widget build(BuildContext context) {
    const bodyStyle = TextStyle(
      fontSize: 16.0,
      color: Colors.black,
      fontWeight: FontWeight.w500,
    );

    const pageDecoration = PageDecoration(
      titlePadding: EdgeInsets.symmetric(vertical: 12),
      titleTextStyle: TextStyle(
        fontSize: 22.0,
        fontWeight: FontWeight.w700,
        color: Colors.black,
      ),
      bodyTextStyle: bodyStyle,
      bodyFlex: 0,
      bodyPadding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 60.0),
      pageColor: Colors.white,
      imagePadding: EdgeInsets.all(16),
    );

    return IntroductionScreen(
      key: introKey,
      globalBackgroundColor: Colors.white,
      allowImplicitScrolling: true,
      autoScrollDuration: 3000,
      infiniteAutoScroll: true,
      showDoneButton: false,
      showNextButton: false,
      globalHeader: Padding(
        padding: const EdgeInsets.only(top: 60, right: 16),
        child: Align(
          alignment: Alignment.bottomRight,
          child: TextButton(
            onPressed: () {
              _onIntroEnd(context);
            },
            child: const Text('Skip',
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                  color: Colors.black,
                )),
          ),
        ),
      ),

      globalFooter: Padding(
        padding:
            const EdgeInsets.only(top: 16, left: 16, right: 16, bottom: 30),
        child: SizedBox(
          width: double.infinity,
          height: 60,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).primaryColor),
            child: const Text(
              'Let\'s go right away!',
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ),
            ),
            onPressed: () => _onIntroEnd(context),
          ),
        ),
      ),
      pages: [
        PageViewModel(
          title: "Task Management",
          body:
              "Now you don't Need to worry about what you have to do just add your task and stay updated.",
          image: _buildImage('images/welcome[3].jpg'),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "Get Progress of your Task",
          body: "You can easily view your task progress in Your Dashboard.",
          image: _buildImage('images/welcome[2].jpg'),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "Manage Your Tasks",
          body:
              "Manage your task efficiently with no hassle and get updated and remainder's.",
          decoration: pageDecoration,
          image: _buildImage('images/welcome[1].jpg'),
        ),
      ],
      onDone: () => _onIntroEnd(context),
      onSkip: () => _onIntroEnd(context), // You can override onSkip callback
      showSkipButton: false,
      skipOrBackFlex: 0,
      nextFlex: 0,
      showBackButton: false,
      // rtl: true, // Display as right-to-left
      back: Icon(Icons.arrow_back,
          color: Theme.of(context).colorScheme.background),
      skip: Text('Skip',
          style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 16,
              color: Theme.of(context).colorScheme.background)),
      next: Icon(Icons.arrow_forward,
          color: Theme.of(context).colorScheme.background),

      curve: Curves.fastLinearToSlowEaseIn,
      controlsMargin: const EdgeInsets.symmetric(
        vertical: 8,
        horizontal: 16,
      ),
      controlsPadding: kIsWeb
          ? const EdgeInsets.all(12.0)
          : const EdgeInsets.fromLTRB(8.0, 4.0, 8.0, 4.0),
      dotsDecorator: const DotsDecorator(
        size: Size(10.0, 10.0),
        color: Color(0xFFBDBDBD),
        activeSize: Size(22.0, 10.0),
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(25.0)),
        ),
      ),
      // dotsContainerDecorator: const ShapeDecoration(
      //   color: Colors.black87,
      //   shape: RoundedRectangleBorder(
      //     borderRadius: BorderRadius.all(Radius.circular(8.0)),
      //   ),
      // ),
    );
  }
}
