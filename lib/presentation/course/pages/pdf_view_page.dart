import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class PdfViewPage extends StatefulWidget {
  const PdfViewPage({Key? key, required this.pdfUrl}) : super(key: key);

  final String pdfUrl;

  @override
  State<PdfViewPage> createState() => _PdfViewPageState();
}

class _PdfViewPageState extends State<PdfViewPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SfPdfViewer.network(
            widget.pdfUrl,
          ),
        ),
      ),
    );
  }
}
