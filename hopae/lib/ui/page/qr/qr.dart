import 'package:flutter/material.dart';
import 'package:hopae/ui/widget/sizes.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QRPage extends StatefulWidget {

    final String qrData;
    final List<Widget>? extraText;

    const QRPage({ Key? key, required this.qrData, this.extraText }) : super(key: key);

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
            appBar: AppBar(
                backgroundColor: Colors.blueAccent,
                toolbarHeight: 100,
                automaticallyImplyLeading: false,
                title: Align(
                    alignment: Alignment.center,
                    child: Column(
                        children: const [ 
                            Text(
                                "HOPAE",
                                style: TextStyle(
                                    fontSize: Sizes.fontSizeTitle,
                                ),
                            ),
                            Text(
                                "DID 기반 백석대학교 출입 시스템",
                                style: TextStyle(
                                    fontSize: Sizes.fontSizeContents,
                                ),
                            ),
                        ],
                    ),
                ),
            ),
            body: Padding(
                padding: const EdgeInsets.symmetric(horizontal: Sizes.safeAreaHorizontal, vertical: Sizes.safeAreaVertical * 0.7),
                child: Column(
                    children: [
                        QrImage(
                            data: widget.qrData,
                            errorCorrectionLevel: QrErrorCorrectLevel.M,
                            padding: const EdgeInsets.all(0),
                        ),
                        Container(
                            color: Colors.black.withOpacity(0.05),
                            width: double.infinity,
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget> [
                                    const Divider(),
                                ] + (widget.extraText ?? <Widget> []) + [
                                    const Divider(),
                                ],
                            ),
                        ),
                        const Expanded(
                            child: SizedBox(),
                        ),
                        SizedBox( 
                            width: double.infinity,
                            child: Material(
                                color: Colors.blueAccent,
                                child: InkWell(
                                    onTap: () {
                                        Navigator.of(context).pop();
                                    },
                                    child: const Padding(
                                        padding: EdgeInsets.symmetric(horizontal: Sizes.safeAreaHorizontal, vertical: Sizes.safeAreaVertical / 2),
                                        child: Text(
                                            "뒤로가기",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                fontSize: Sizes.fontSizeContents,
                                                color: Colors.white,
                                            ),
                                        ),
                                    ),
                                ),
                            ),
                        ),
                    ]
                ),
            ),
        );
    }
}