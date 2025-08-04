import 'package:nativeshell/nativeshell.dart' as nativeshell;

import 'package:mizer/platform/platform.dart';

extension NativeShellMenu on Menu {
  nativeshell.Menu toNative() {
    return nativeshell.Menu(() => this.items.map((item) => item.toNative()).toList());
  }
}

extension NativeShellMenuBaseItem on MenuBaseItem {
  nativeshell.MenuItem toNative() {
    if (this is MenuItem) {
      return (this as MenuItem).toNative();
    } else if (this is MenuDivider) {
      return (this as MenuDivider).toNative();
    } else if (this is SubMenu) {
      return (this as SubMenu).toNative();
    } else {
      throw new UnimplementedError("toNative is not implemented on ${this.runtimeType}");
    }
  }
}

extension NativeShellMenuItem on MenuItem {
  nativeshell.MenuItem toNative() {
    return nativeshell.MenuItem(title: label, action: (disabled ?? false) ? null : this.action);
  }
}

extension NativeShellMenuDivider on MenuDivider {
  nativeshell.MenuItem toNative() {
    return nativeshell.MenuItem.separator();
  }
}

extension NativeShellSubMenu on SubMenu {
  nativeshell.MenuItem toNative() {
    return nativeshell.MenuItem.children(
        title: title, children: children.map((item) => item.toNative()).toList(growable: false));
  }
}
