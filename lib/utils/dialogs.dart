import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';

class Dialogs {
  static void showSnackBar(BuildContext context, String message, isError) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 1),
        backgroundColor: isError
            ? const Color.fromARGB(255, 227, 17, 17)
            : const Color.fromARGB(255, 38, 189, 18),
        margin: const EdgeInsets.all(16),
        showCloseIcon: true,
        content: Text(
          message,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  static void showProgressIndicator(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return Center(
            child: SizedBox(
                width: 60,
                height: 60,
                child: LoadingIndicator(
                  indicatorType: Indicator.ballRotateChase,

                  /// Required, The loading type of the widget
                  colors: [
                    Theme.of(context).primaryColor,
                    Colors.red,
                    Colors.cyanAccent,
                    Colors.yellowAccent,
                    Colors.greenAccent,
                  ],
                  strokeWidth: 4,
                )),
          );
        });
  }

 
}
