import 'package:baapapp/utils/app_utils/app_utils.dart';
import 'package:baapapp/utils/app_utils/extensions.dart';
import 'package:baapapp/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class InAppWebViewVidget extends StatefulWidget {
  const InAppWebViewVidget({super.key, this.categoryName, this.url});

  final String? categoryName;
  final String? url;

  @override
  State<InAppWebViewVidget> createState() => _InAppWebViewVidgetState();
}

class _InAppWebViewVidgetState extends State<InAppWebViewVidget> {
  @override
  Widget build(BuildContext context) {   
    return Scaffold(
      appBar: AppBar(
          systemOverlayStyle: systemOverLayStyle,
          surfaceTintColor: Colors.white10,
          iconTheme: const IconThemeData(
            color: Colors.black,
          ),
          automaticallyImplyLeading: true,
          elevation: 0,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          title: TextWidget(
            text: widget.categoryName.toString().capitalize(),
            color: Colors.black,
            fontSize: 17.sp,
          )),
      body: InAppWebView(
        initialUrlRequest: URLRequest(
          url: Uri.parse(widget.url ?? "https://baapcompany.com"),
        ),
        initialOptions:
            InAppWebViewGroupOptions(crossPlatform: InAppWebViewOptions()),
      ),
    );
  }
}
