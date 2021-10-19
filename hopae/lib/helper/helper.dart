import 'package:flutter/material.dart';
import 'package:hopae/ui/widget/blur.dart';

class Helper {

    static void navigateRoute(BuildContext context, Widget child) {
        Navigator.of(context).push(
            PageRouteBuilder(
                opaque: false,
                transitionDuration: const Duration(milliseconds: 500),
                pageBuilder: (context, animation, secondaryAnimation) => BlurTransition(
                    animation: Tween<double>(begin: 30.0, end: 0.0).animate(animation),
                    child: child,
                ),
            ),
        );
    }

    static void snack(BuildContext context, { required String text, required String label, Duration duration = const Duration(seconds: 5), Function? onPressed }) {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
                duration: duration,
                backgroundColor: Theme.of(context).backgroundColor,
                content: Text(
                    text,
                    style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.w300,
                    ),
                ),
                action: SnackBarAction(
                    textColor: Theme.of(context).primaryColor,
                    disabledTextColor: Theme.of(context).primaryColor.withOpacity(0.5),
                    label: label,
                    onPressed: () => onPressed!(),
                ),
            )
        );
    }
}
