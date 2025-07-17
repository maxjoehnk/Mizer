import 'dart:io' as io;

import 'package:flutter/material.dart' hide View;
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:mizer/consts.dart';
import 'package:mizer/extensions/context_state_extensions.dart';
import 'package:mizer/i18n.dart';
import 'package:mizer/project_files.dart';
import 'package:mizer/protos/session.pb.dart';
import 'package:mizer/state/navigation_bloc.dart';
import 'package:mizer/state/session_bloc.dart';
import 'package:mizer/widgets/dialog/action_dialog.dart';
import 'package:mizer/widgets/hoverable.dart';
import 'package:mizer/widgets/popup/popup_route.dart';
import 'package:mizer/widgets/popup/popup_select.dart';
import 'package:nativeshell/nativeshell.dart' show Window;

import '../api/contracts/session.dart';
import '../api/plugin/app.dart';
import '../dialogs/power_dialog.dart';

class ApplicationMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SessionBloc, Session>(
      builder: (context, state) => BlocBuilder<NavigationBloc, NavigationState>(
        buildWhen: (previous, current) => previous.header != current.header,
        builder: (context, navigationState) {
          return MenuBar(
            children: [
              const MenuBarTitle(),
              const MenuPlaceholder(),
              MenuButton.text("Project",
                  popupBuilder: (context) => PopupSelect(
                        width: context.globalPaintBounds!.width,
                        title: "Project",
                        items: [
                          SelectItem(
                            title: "New",
                            onTap: () => _newProject(context),
                          ),
                          SelectItem(
                            title: "Open",
                            onTap: () => _openProject(context),
                          ),
                          SelectItem(
                            title: "Save",
                            onTap: () => ProjectFiles.saveProject(context),
                          ),
                          SelectItem(
                            title: "Save as",
                            onTap: () => ProjectFiles.saveProjectAs(context),
                          ),
                        ],
                      )),
              Expanded(
                  child: MenuButton.text(state.hasProject() ? state.project : "New Project",
                      popupBuilder: (context) => PopupSelect(
                            width: context.globalPaintBounds!.width,
                            height: 48 * 6,
                            title: "Open Recent",
                            items: state.projectHistory
                                .map((history) => SelectItem(
                                    title: history.split(io.Platform.pathSeparator).last,
                                    onTap: () =>
                                        _openProjectFromHistory(context, context.read(), history)))
                                .toList(),
                          ))),
              const MenuPlaceholder(),
              MenuButton.icon(MdiIcons.undo, onTap: () async {
                await context.read<SessionApi>().undo();
                _refreshViews(context);
              }),
              MenuButton.icon(MdiIcons.redo, onTap: () async {
                await context.read<SessionApi>().redo();
                _refreshViews(context);
              }),
              const MenuPlaceholder(),
              MenuButton.icon(Icons.monitor, onTap: () async {
                Window.create({});
              }),
              const MenuPlaceholder(),
              for (var action in navigationState.header)
                MenuButton.text(action.title,
                    active: navigationState.currentRoute == action.route,
                    onTap: () => context.navigate(action.route)),
              const MenuPlaceholder(),
              MenuButton.icon(MdiIcons.cog,
                  active: navigationState.currentRoute is PreferencesRoute,
                  onTap: () => context.navigate(PreferencesRoute())),
              MenuButton.icon(MdiIcons.power, onTap: () {
                ApplicationPluginApi applicationApi = context.read();
                showDialog(
                    context: context,
                    builder: (context) => PowerDialog(applicationApi: applicationApi));
              }),
            ],
          );
        },
      ),
    );
  }

  Future<void> _newProject(BuildContext context) async {
    await context.read<SessionApi>().newProject();
    _refreshViews(context);
  }

  Future<void> _openProject(BuildContext context) async {
    try {
      await ProjectFiles.openProject(context);
    } on PlatformException catch (err) {
      showDialog(
          context: context,
          builder: (context) => ErrorDialog(
              title: "Unable to load project file".i18n, text: err.message ?? err.toString()));
    }
  }

  Future<void> _openProjectFromHistory(
      BuildContext context, SessionApi api, String filePath) async {
    await ProjectFiles.openProjectFrom(context, filePath);
  }

  void _refreshViews(BuildContext context) {
    context.refreshAllStates();
  }
}

class MenuBar extends StatelessWidget {
  final List<Widget> children;

  const MenuBar({required this.children, super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(height: GRID_2_SIZE, child: Row(children: children, spacing: PANEL_GAP_SIZE));
  }
}

class MenuBarTitle extends StatelessWidget {
  const MenuBarTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(BORDER_RADIUS),
        color: Grey800,
      ),
      width: GRID_4_SIZE,
      alignment: Alignment.center,
      child: Text("Mizer", style: TextStyle(fontWeight: FontWeight.bold)),
    );
  }
}

class MenuButton extends StatelessWidget {
  final Widget child;
  final double width;
  final bool active;
  final Function()? onTap;
  final WidgetBuilder? popupBuilder;

  const MenuButton(
      {required this.child,
      required this.width,
      super.key,
      this.onTap,
      this.popupBuilder,
      this.active = false});

  factory MenuButton.text(String text,
      {bool active = false, Function()? onTap, WidgetBuilder? popupBuilder}) {
    return MenuButton(
        child: Text(text),
        width: GRID_5_SIZE,
        onTap: onTap,
        popupBuilder: popupBuilder,
        active: active);
  }

  factory MenuButton.icon(IconData icon,
      {bool active = false, Function()? onTap, WidgetBuilder? popupBuilder}) {
    return MenuButton(
        child: Icon(icon),
        width: GRID_2_SIZE,
        onTap: onTap,
        popupBuilder: popupBuilder,
        active: active);
  }

  @override
  Widget build(BuildContext context) {
    return Hoverable(
      onTap: onTap,
      onTapDown: popupBuilder == null
          ? null
          : (details) {
              Navigator.of(context).push(MizerPopupRoute(
                  position: context.globalPaintBounds!.bottomLeft, child: popupBuilder!(context)));
            },
      builder: (hovered) => Container(
        height: GRID_2_SIZE,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(BORDER_RADIUS),
          color: active ? Grey600 : (hovered ? Grey700 : Grey800),
        ),
        width: width,
        alignment: Alignment.center,
        child: child,
      ),
    );
  }
}

class MenuPlaceholder extends StatelessWidget {
  const MenuPlaceholder({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Grey800,
      width: 4,
    );
  }
}

class ErrorDialog extends StatelessWidget {
  final String title;
  final String text;

  const ErrorDialog({super.key, required this.title, required this.text});

  @override
  Widget build(BuildContext context) {
    return ActionDialog(
        title: title,
        content: SizedBox(height: 768, child: SingleChildScrollView(child: Text(text))));
  }
}

extension GlobalPaintBounds on BuildContext {
  Rect? get globalPaintBounds {
    final renderObject = findRenderObject();
    final translation = renderObject?.getTransformTo(null).getTranslation();
    if (translation != null && renderObject?.paintBounds != null) {
      final offset = Offset(translation.x, translation.y);
      return renderObject!.paintBounds.shift(offset);
    } else {
      return null;
    }
  }
}
