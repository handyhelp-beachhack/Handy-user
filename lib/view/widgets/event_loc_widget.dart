import 'package:flutter/material.dart';
import 'package:handy_beachhack/models/event_model.dart';
import 'package:handy_beachhack/view/constants/constants.dart';
import 'package:handy_beachhack/view/widgets/buttons/rounded_rect_primary.dart';
import 'package:handy_beachhack/view/widgets/toast/toast.dart';

import 'package:webview_flutter/webview_flutter.dart';

class GetMapLocation extends StatefulWidget {
  final Function(Location) onTap;
  final String title;
  const GetMapLocation({Key? key, required this.onTap, this.title = ""})
      : super(key: key);

  @override
  State<GetMapLocation> createState() => _GetMapLocationState();
}

class _GetMapLocationState extends State<GetMapLocation> {
  late WebViewController webViewController;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
            backgroundColor: primaryPurple,
            title: Text(
              widget.title,
            ),
            actions: [
              Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  child: RoundedRectPrimaryButton(
                      text: "Next",
                      onpressed: () {
                        webViewController.currentUrl().then((url) {
                          if (url != null) {
                            final loc = extractCordinate(url);
                            if (loc != null) {
                              widget.onTap(loc);
                            }
                          }
                        });
                      }))
            ]),
        body: Center(
          child: WebView(
            onWebViewCreated: (controller) {
              webViewController = controller;
            },
            initialUrl:
                'https://www.google.com/maps/@10.2496321,76.3521509,15z',
            javascriptMode: JavascriptMode.unrestricted,
          ),
        ),
      ),
    );
  }

  Location? extractCordinate(String url) {
    String? lat, logitude;
    // https://www.google.com/maps/place/Cafe+QD,+Mookkannoor,
    // +Kerala+683577/@10.2262122,76.4141403,17z/data=!4m2!3m1!1s0x3b080726c1b61179:0x93dba9fd6f9acd65
    if (url.startsWith("https://www.google.com/maps/place/")) {
      url = url.replaceFirst("https://www.google.com/maps/place/", "");

      final split = url.split(",");
      for (int i = 0; i < split.length; i++) {
        String s = split[i].toLowerCase();

        if (s.startsWith("+kerala+")) {
          //683577/@10.2315176
          s = s.replaceFirst("+kerala+", "");
          lat = s.split("/@")[1];
          //pincode = s.split("/@")[0];
          logitude = split[i + 1];
          break;
        }
      }

      debugPrint(" lat : $lat | long : $logitude");
      if (lat != null && logitude != null) {
        return Location(
            type: "point",
            coordinates: [double.parse(logitude), double.parse(lat)]);
      }
    } else {
      showToast(
          context: context,
          title: "Select a Valid Location",
          description: "",
          icon: Icons.warning,
          color: Colors.amber);
    }
    return null;
  }
}
