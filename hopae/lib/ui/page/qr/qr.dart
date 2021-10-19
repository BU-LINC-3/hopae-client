import 'package:flutter/material.dart';
import 'package:hopae/ui/widget/sizes.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QRPage extends StatefulWidget {

    final String qrData;

    const QRPage({ Key? key, required this.qrData }) : super(key: key);

    @override
    _QRPageState createState() => _QRPageState();
}

class _QRPageState extends State<QRPage> {


    @override
    void initState() {
        super.initState();
    }

    @override
    Widget build(BuildContext context) {
        return Scaffold(
            backgroundColor: Theme.of(context).backgroundColor,
            body: Padding(
                padding: const EdgeInsets.symmetric(vertical: Sizes.safeAreaVertical * 2),
                child: Column(
                    children: [
                        QrImage(
                            data: widget.qrData,
                            errorCorrectionLevel: QrErrorCorrectLevel.Q,
                            padding: const EdgeInsets.symmetric(vertical: Sizes.safeAreaHorizontal, horizontal: Sizes.safeAreaHorizontal),
                        ),
                    ]
                ),
            ),
        );
    }
}