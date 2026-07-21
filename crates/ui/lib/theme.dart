import 'package:flutter/material.dart';
import 'package:mizer/consts.dart';
import 'package:mizer/protos/console.pbenum.dart';

ThemeData darkTheme() {
  final theme = ThemeData.dark(useMaterial3: false);
  return theme.copyWith(
      colorScheme:
          theme.colorScheme.copyWith(primary: Colors.blueGrey, secondary: Colors.deepOrangeAccent),
      primaryColor: Colors.blueGrey,
      scaffoldBackgroundColor: Black,
      extensions: [MizerTheme.dark()]);
}

ThemeData lightTheme() {
  final theme = ThemeData.light(useMaterial3: false);
  return theme.copyWith(
      colorScheme:
          theme.colorScheme.copyWith(primary: Colors.blueGrey, secondary: Colors.deepOrangeAccent),
      primaryColor: Colors.blueGrey,
      scaffoldBackgroundColor: White,
      extensions: [MizerTheme.light()]);
}

ThemeData getTheme() {
  final theme = ThemeData.dark(useMaterial3: false);
  return theme.copyWith(
      colorScheme:
          theme.colorScheme.copyWith(primary: Colors.blueGrey, secondary: Colors.deepOrangeAccent),
      primaryColor: Colors.blueGrey);
}

@immutable
class MizerTheme extends ThemeExtension<MizerTheme> {
  final Color tileBorder;
  final Color tileBackground;
  final Color tileDisabled;
  final Color tileSelected;
  final Color tileSelectedBorder;
  final Color tileHover;

  final Color actionBorder;
  final Color actionDisabled;
  final Color actionBackground;
  final Color actionHover;
  final Color actionActive;

  final Color panelBackground;
  final Color panelBorder;
  final Color panelAction;
  final Color panelActionHovered;
  final Color panelActionActive;

  final Color statusBarBackground;
  final Color statusBarSeparator;

  final Color menuBarBackground;
  final Color menuBarActive;
  final Color menuBarHovered;
  final Color menuBarSeparator;

  final Color primary;

  final Color fieldLabel;
  final Color fieldValue;
  final Color fieldAction;
  final Color fieldActionHovered;

  final Color tableSelected;
  final Color tableHovered;

  final Color dropdownBackground;

  final Color text;
  final Color textDimmed;
  final Color textDisabled;

  final Color grid;

  final Color commandLineDebug;
  final Color commandLineInfo;
  final Color commandLineWarning;
  final Color commandLineError;

  late final Map<ConsoleLevel, Color> levelColors;

  MizerTheme(
      {required this.tileBorder,
      required this.tileBackground,
      required this.tileDisabled,
      required this.tileSelected,
      required this.tileSelectedBorder,
      required this.tileHover,
      required this.actionBorder,
      required this.actionDisabled,
      required this.actionBackground,
      required this.actionHover,
      required this.actionActive,
      required this.panelBackground,
      required this.panelBorder,
      required this.panelAction,
      required this.panelActionHovered,
      required this.panelActionActive,
      required this.statusBarBackground,
      required this.statusBarSeparator,
      required this.menuBarBackground,
      required this.menuBarActive,
      required this.menuBarHovered,
      required this.menuBarSeparator,
      required this.primary,
      required this.fieldLabel,
      required this.fieldValue,
      required this.fieldAction,
      required this.fieldActionHovered,
      required this.tableSelected,
      required this.tableHovered,
      required this.dropdownBackground,
      required this.text,
      required this.textDimmed,
      required this.textDisabled, required this.grid, required this.commandLineDebug, required this.commandLineInfo, required this.commandLineWarning, required this.commandLineError}) {
    levelColors = {
      ConsoleLevel.DEBUG: this.commandLineDebug,
      ConsoleLevel.INFO: this.commandLineInfo,
      ConsoleLevel.WARNING: this.commandLineWarning,
      ConsoleLevel.ERROR: this.commandLineError,
    };
  }

  factory MizerTheme.dark() {
    return MizerTheme(
      tileBorder: Grey400,
      tileBackground: Grey700,
      tileDisabled: Grey800,
      tileSelected: Grey500,
      tileSelectedBorder: White,
      tileHover: Grey600,
      actionBorder: Grey400,
      actionBackground: Grey700,
      actionDisabled: Grey800,
      actionHover: Grey600,
      actionActive: Grey500,
      panelBackground: Grey900,
      panelBorder: Grey700,
      panelAction: Grey800,
      panelActionHovered: Grey700,
      panelActionActive: Grey500,
      statusBarBackground: Grey900,
      statusBarSeparator: Grey600,
      menuBarBackground: Grey800,
      menuBarActive: Grey600,
      menuBarHovered: Grey700,
      menuBarSeparator: Grey700,
      primary: Colors.deepOrange,
      fieldLabel: Grey700,
      fieldValue: Grey600,
      fieldAction: Grey700,
      fieldActionHovered: Grey500,
      tableSelected: Grey800,
      tableHovered: Grey700,
      dropdownBackground: Grey800,
      text: Colors.white,
      textDimmed: Colors.white54,
      textDisabled: Colors.white24,
      grid: Colors.white10,
      commandLineDebug: Colors.white30,
      commandLineInfo: Colors.green.shade300,
      commandLineWarning: Colors.orange.shade300,
      commandLineError: Colors.red.shade300,
    );
  }

  factory MizerTheme.light() {
    return MizerTheme(
      tileBorder: White400,
      tileBackground: White700,
      tileDisabled: White800,
      tileSelected: White500,
      tileSelectedBorder: Black,
      tileHover: White600,
      actionBorder: White400,
      actionBackground: White700,
      actionDisabled: White800,
      actionHover: White600,
      actionActive: White500,
      panelBackground: White900,
      panelBorder: White700,
      panelAction: White800,
      panelActionHovered: White700,
      panelActionActive: White500,
      statusBarBackground: White900,
      statusBarSeparator: White600,
      menuBarBackground: White800,
      menuBarActive: White600,
      menuBarHovered: White700,
      menuBarSeparator: White700,
      primary: Colors.deepOrangeAccent,
      fieldLabel: White700,
      fieldValue: White600,
      fieldAction: White700,
      fieldActionHovered: White500,
      tableSelected: White800,
      tableHovered: White700,
      dropdownBackground: White800,
      text: Colors.black,
      textDimmed: Colors.black54,
      textDisabled: Colors.black26,
      grid: Colors.black12,
      commandLineDebug: Colors.black26,
      commandLineInfo: Colors.green.shade800,
      commandLineWarning: Colors.yellow.shade800,
      commandLineError: Colors.red.shade900,
    );
  }

  @override
  ThemeExtension<MizerTheme> copyWith() {
    return this;
  }

  @override
  ThemeExtension<MizerTheme> lerp(covariant ThemeExtension<MizerTheme>? other, double t) {
    if (other is! MizerTheme) {
      return this;
    }

    return MizerTheme(
      tileBorder: Color.lerp(tileBorder, other.tileBorder, t)!,
      tileBackground: Color.lerp(tileBackground, other.tileBackground, t)!,
      tileDisabled: Color.lerp(tileDisabled, other.tileDisabled, t)!,
      tileSelected: Color.lerp(tileSelected, other.tileSelected, t)!,
      tileSelectedBorder: Color.lerp(tileSelectedBorder, other.tileSelectedBorder, t)!,
      tileHover: Color.lerp(tileHover, other.tileHover, t)!,
      actionBorder: Color.lerp(actionBorder, other.actionBorder, t)!,
      actionBackground: Color.lerp(actionBackground, other.actionBackground, t)!,
      actionDisabled: Color.lerp(actionDisabled, other.actionDisabled, t)!,
      actionHover: Color.lerp(actionHover, other.actionHover, t)!,
      actionActive: Color.lerp(actionActive, other.actionActive, t)!,
      panelBackground: Color.lerp(panelBackground, other.panelBackground, t)!,
      panelBorder: Color.lerp(panelBorder, other.panelBorder, t)!,
      panelAction: Color.lerp(panelAction, other.panelAction, t)!,
      panelActionHovered: Color.lerp(panelActionHovered, other.panelActionHovered, t)!,
      panelActionActive: Color.lerp(panelActionActive, other.panelActionActive, t)!,
      statusBarBackground: Color.lerp(statusBarBackground, other.statusBarBackground, t)!,
      statusBarSeparator: Color.lerp(statusBarSeparator, other.statusBarSeparator, t)!,
      menuBarBackground: Color.lerp(menuBarBackground, other.menuBarBackground, t)!,
      menuBarActive: Color.lerp(menuBarActive, other.menuBarActive, t)!,
      menuBarHovered: Color.lerp(menuBarHovered, other.menuBarHovered, t)!,
      menuBarSeparator: Color.lerp(menuBarSeparator, other.menuBarSeparator, t)!,
      primary: Color.lerp(primary, other.primary, t)!,
      fieldLabel: Color.lerp(fieldLabel, other.fieldLabel, t)!,
      fieldValue: Color.lerp(fieldValue, other.fieldValue, t)!,
      fieldAction: Color.lerp(fieldAction, other.fieldAction, t)!,
      fieldActionHovered: Color.lerp(fieldActionHovered, other.fieldActionHovered, t)!,
      tableSelected: Color.lerp(tableSelected, other.tableSelected, t)!,
      tableHovered: Color.lerp(tableHovered, other.tableHovered, t)!,
      dropdownBackground: Color.lerp(dropdownBackground, other.dropdownBackground, t)!,
      text: Color.lerp(text, other.text, t)!,
      textDimmed: Color.lerp(textDimmed, other.textDimmed, t)!,
      textDisabled: Color.lerp(textDisabled, other.textDisabled, t)!,
      grid: Color.lerp(grid, other.grid, t)!,
      commandLineDebug: Color.lerp(commandLineDebug, other.commandLineDebug, t)!,
      commandLineInfo: Color.lerp(commandLineInfo, other.commandLineInfo, t)!,
      commandLineWarning: Color.lerp(commandLineWarning, other.commandLineWarning, t)!,
      commandLineError: Color.lerp(commandLineError, other.commandLineError, t)!,
    );
  }
}

extension MizerThemeExtension on ThemeData {
  MizerTheme get mizerTheme {
    return this.extension<MizerTheme>() ?? MizerTheme.dark();
  }
}
