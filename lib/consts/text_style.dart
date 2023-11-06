import 'package:audio_player/consts/colors.dart';
import 'package:flutter/material.dart';

const italic = "Labrada-Italic-VariableFont_wght";
const variable = "Labrada-VariableFont_wght";
const Playpen_Sans = "PlaypenSans-VariableFont_wght";

ourStyle({family = variable, double? size = 14, color = whiteColor}) {
  return TextStyle(
    fontSize: size,
    color: color,
    fontFamily: family,
  );
}
