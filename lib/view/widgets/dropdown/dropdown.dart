import 'package:flutter/material.dart';
import 'package:handy_beachhack/view/constants/constants.dart';
import 'package:handy_beachhack/view/widgets/dropdown/dropdown_overlay.dart';

class DropDownCustom extends StatefulWidget {
  const DropDownCustom({
    Key? key,
    this.width = double.maxFinite,
    required this.text,
    required this.items,
    required this.dropdownChanged,
    this.iconColor = primaryPurple,
    this.textStyle = const TextStyle(
      fontSize: 16,
      color: primaryPurple,
    ),
  }) : super(key: key);
  final double width;
  final List<String> items;
  final String text;
  final Function(int) dropdownChanged;
  final Color iconColor;
  final TextStyle textStyle;
  @override
  State<DropDownCustom> createState() => DropDownCustomState();
}

class DropDownCustomState extends State<DropDownCustom> {
  int selected = -1;
  List<String> items = [];

  GlobalKey dropdownKey = GlobalKey();
  double width = 80;

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      RenderBox box = context.findRenderObject() as RenderBox;
      setState(() {
        width = box.size.width;
      });
    });
    items = widget.items;
    return GestureDetector(
      onTap: () {
        RenderBox box = context.findRenderObject() as RenderBox;
        double width = box.size.width - 38;
        Offset position =
            box.localToGlobal(Offset.zero); //this is global position

        double y = position.dy + 55;
        double x = position.dx;
        width = box.size.width - 38;
        late OverlayEntry overlayEntry;
        overlayEntry = OverlayEntry(
          builder: (context) => DropDownOverlay(
            selection: (value) {
              setState(() {
                selected = value;
                widget.dropdownChanged(value);
              });
            },
            width: width,
            overlayEntry: overlayEntry,
            x: x,
            y: y,
            items: widget.items,
            textStyle: widget.textStyle,
          ),
        );
        Overlay.of(context)?.insert(overlayEntry);
      },
      child: Container(
          key: dropdownKey,
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(
              vertical: 5, horizontal: defaultPadding),
          width: widget.width,
          height: 55,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: white,
              boxShadow: [
                BoxShadow(
                  blurRadius: 20,
                  color: primaryPurple.withOpacity(0.1),
                )
              ]),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: width - 70,
                child: Text(
                  selected == -1 ? widget.text : items[selected],
                  style: selected == -1
                      ? TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w300,
                          color: Colors.black)
                      : widget.textStyle,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Icon(
                Icons.arrow_drop_down_rounded,
                size: 32,
                color: widget.iconColor,
              )
            ],
          )),
    );
  }
}
