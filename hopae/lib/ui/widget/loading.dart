import 'package:flutter/material.dart';

class LoadingWrapper extends StatelessWidget {

    final bool isLoading;
    final Widget child;

    const LoadingWrapper({ Key? key,  this.isLoading = false, required this.child }) : super(key: key);

    @override
    Widget build(BuildContext context) {
        return Stack(
            children: [
                child,
            ] + ((isLoading) ? [
                Container(
                    color: Colors.black38,
                ),
                const LoadingIndicator(),
            ] : []),
        );
    }
}


class LoadingIndicator extends StatelessWidget {

    final double? value;

    const LoadingIndicator({ Key? key,  this.value }) : super(key: key);
    
    @override
    Widget build(BuildContext context) {
        return Center(
            child: CircularProgressIndicator(
                strokeWidth: 1.5,
                valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor.withOpacity(0.7)),
                backgroundColor: Theme.of(context).backgroundColor.withOpacity(0.45),
                value: value,
            ),
        );
    }

}