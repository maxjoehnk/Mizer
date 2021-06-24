import 'package:nativeshell/nativeshell.dart' as nativeshell;

import '../platform.dart';

extension NativeShellMenu on Menu {
  nativeshell.Menu toNative() {
    return nativeshell.Menu(() => this.items.map((item) => item.toNative()).toList());
  }
}

extension NativeShellMenuItem on MenuItem {
  nativeshell.MenuItem toNative() {
    return nativeshell.MenuItem(title: title, action: action);
  }
}
