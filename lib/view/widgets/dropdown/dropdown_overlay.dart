import 'package:flutter/material.dart';
import 'package:handy_beachhack/view/constants/constants.dart';

class DropDownOverlay extends StatefulWidget {
  const DropDownOverlay(
      {Key? key,
      required this.overlayEntry,
      required this.x,
      required this.y,
      required this.items,
      this.textStyle,
      required this.width,
      required this.selection})
      : super(key: key);

  @override
  State<DropDownOverlay> createState() => _DropDownOverlayState();

  final OverlayEntry overlayEntry;
  final double x;
  final List<String> items;
  final double y;
  final double width;
  final TextStyle? textStyle;
  final Function(int) selection;
}

class _DropDownOverlayState extends State<DropDownOverlay> {
  @override
  Widget build(BuildContext context) {
    return Positioned(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Material(
        color: Colors.transparent,
        child: Stack(
          children: [
            GestureDetector(
              onTap: () => widget.overlayEntry.remove(),
              child: Container(
                color: Colors.transparent,
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.height,
              ),
            ),
            Positioned(
              top: widget.y,
              left: widget.x,
              child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: defaultPadding),
                  decoration: BoxDecoration(
                    color: white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(.2),
                        blurRadius: 5,
                      ),
                    ],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      for (int i = 0; i < widget.items.length; i++)
                        InkWell(
                          onTap: () {
                            widget.selection(i);
                            widget.overlayEntry.remove();
                          },
                          child: Container(
                              alignment: Alignment.center,
                              height: 40,
                              width: widget.width,
                              child: Text(
                                widget.items[i],
                                style: widget.textStyle,
                                overflow: TextOverflow.ellipsis,
                              )),
                        ),
                    ],
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
