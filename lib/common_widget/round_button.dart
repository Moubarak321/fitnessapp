import "package:fitnessapp/common/color_extension.dart";
import "package:flutter/material.dart";

enum RoundButtonType { bgGradient, textGradient }

class RoundButton extends StatelessWidget {
  final String title;
  final RoundButtonType type;
  final VoidCallback onPressed;
  const RoundButton(
      {super.key,
      required this.title,
      this.type = RoundButtonType.bgGradient,
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
            colors: Tcolor.primaryG,
            begin: Alignment.bottomLeft,
            end: Alignment.centerRight),
        borderRadius: BorderRadius.circular(25),
        boxShadow: type == RoundButtonType.bgGradient
            ? const [
                BoxShadow(
                    color: Colors.black26,
                    blurRadius: 0.5,
                    offset: Offset(0, 0.5))
              ]
            : null,
      ),
      child: MaterialButton(
        onPressed: onPressed,
        height: 50,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
        textColor: Tcolor.primaryColor1,
        minWidth: double.maxFinite,
        elevation: type == RoundButtonType.bgGradient ? 0 : 1,
        color: type == RoundButtonType.bgGradient
            ? Colors.transparent
            : Tcolor.white, //Tcolor.white,

        child: type == RoundButtonType.bgGradient
            ? Text(
                title,
                style: TextStyle(
                    color: Tcolor.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w700),
              )
            : ShaderMask(
                blendMode: BlendMode.srcIn,
                shaderCallback: (bounds) {
                  return LinearGradient(
                          colors: Tcolor.primaryG,
                          begin: Alignment.bottomLeft,
                          end: Alignment.centerRight)
                      .createShader(
                    Rect.fromLTRB(0, 0, bounds.width, bounds.height),
                  );
                },
                child: Text(
                  title,
                  style: TextStyle(
                      color: Tcolor.primaryColor1,
                      fontSize: 16,
                      fontWeight: FontWeight.w700),
                ),
              ),
      ),
    );
  }
}
