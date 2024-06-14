import "package:flutter/material.dart";
import 'package:google_fonts/google_fonts.dart';

class GradientButton extends StatefulWidget {
  final String text;
  final double ftSize;
  final Color buttonColor;
  final Color textColor;
  final double padding;
  final Color buttonColor1;
  final Color buttonColor2;
  final Color shadowColor;
  final double offsetY;
  final double offsetX;
  final double width;
  final double iconHeight;
  final Function() function;

  const GradientButton(
      {Key? key,
      this.text = "Button",
      this.ftSize = 16.0,
      this.buttonColor = Colors.blue,
      this.textColor = Colors.white,
      this.padding = 20.0,
      this.buttonColor1 = Colors.purple,
      this.buttonColor2 = Colors.blue,
      this.shadowColor = Colors.blue,
      this.offsetX = 4,
      this.offsetY = 7,
      this.width = double.minPositive,
      this.iconHeight = 30,
      required this.function})
      : super(key: key);

  @override
  State<GradientButton> createState() => _GradientButtonState();
}

class _GradientButtonState extends State<GradientButton> {
  bool isButtonPressed = false;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        widget.function();
        print("Button pressed");
        setState(() {
          isButtonPressed = !isButtonPressed;
          Future.delayed(const Duration(milliseconds: 150), () {
            setState(() {
              isButtonPressed = !isButtonPressed;
            });
          });
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        width: widget.width,
        padding: EdgeInsets.symmetric(vertical: 16, horizontal: widget.padding),
        decoration: BoxDecoration(
          boxShadow: isButtonPressed
              ? null
              : [
                  BoxShadow(
                      offset: Offset(widget.offsetX, widget.offsetY),
                      color: widget.shadowColor,
                      blurRadius: 15,
                      spreadRadius: 0)
                ],
          gradient: LinearGradient(
              colors: [widget.buttonColor1, widget.buttonColor2]),
          borderRadius: BorderRadius.circular(32),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              widget.text,
              style: GoogleFonts.montserrat(
                  fontSize: widget.ftSize,
                  fontWeight: FontWeight.w500,
                  color: widget.textColor),
            ),
          ],
        ),
      ),
    );
  }
}
