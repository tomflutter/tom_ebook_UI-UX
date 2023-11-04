import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class PdfViewScreen extends StatefulWidget {
  final String bookpdf;
  final String type;
  PdfViewScreen(this.bookpdf, this.type);
  @override
  _PdfViewScreenState createState() => _PdfViewScreenState();
}

class _PdfViewScreenState extends State<PdfViewScreen> {
  String pdfs = '';
  PdfPageChangedDetails? page;
  @override
  void initState() {
    super.initState();
    if (widget.type == 'MostPopular' || widget.type.isEmpty) {
      pdfs = widget.bookpdf;
    }
  }

  PdfDocumentLoadedDetails? pdfDocumentLoadedDetails;

  final GlobalKey<SfPdfViewerState> _pdfViewerKey = GlobalKey();
  PdfViewerController pdfViewerController = PdfViewerController();
  get _pa => pdfDocumentLoadedDetails!.document.pages.count;

  percentage() {
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
            icon: const Icon(
              Icons.keyboard_arrow_up,
              color: Colors.white,
            ),
            onPressed: () {
              pdfViewerController.previousPage();
            },
          ),
          IconButton(
            icon: const Icon(
              Icons.keyboard_arrow_down,
              color: Colors.white,
            ),
            onPressed: () {
              pdfViewerController.nextPage();
            },
          ),
          IconButton(
            icon: const Icon(
              Icons.bookmark,
              color: Colors.white,
            ),
            onPressed: () {
              _pdfViewerKey.currentState?.openBookmarkView();
            },
          ),
        ],
      ),
      body: WillPopScope(
        onWillPop: () => percentage(),
        child: SfPdfViewer.network(
          pdfs,
          key: _pdfViewerKey,
          controller: pdfViewerController,
          onDocumentLoaded: (detail) {
            pdfDocumentLoadedDetails = detail;
                      },
          onPageChanged: (pages) {
            if (pages.newPageNumber >= pages.oldPageNumber) {
              page = pages;
            } else {
              return;
            }
          },
        ),
      ),
    );
  }
}
