import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class PDFView extends StatelessWidget {
  const PDFView({Key? key, this.PDFUrl}) : super(key: key);
  final String? PDFUrl;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("PDFView")),
      body: SafeArea(
        child: SizedBox(
          height: double.infinity,
          width: double.infinity,
          child: SfPdfViewer.network("https://jymnew.spitel.com${PDFUrl}"),
        ),
      ),
    );
  }
}
