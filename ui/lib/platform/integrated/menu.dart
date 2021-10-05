// @dart=2.11
import 'package:nativeshell/nativeshell.dart' as nativeshell;

import '../platform.dart';

extension NativeShellMenu on Menu {
  nativeshell.Menu toNative() {
    return nativeshell.Menu(() => this.items.map((item) => (item as MenuItem).toNative()).toList());
  }
}

extension NativeShellMenuItem on MenuItem {
  nativeshell.MenuItem toNative() {
    return nativeshell.MenuItem(title: label, action: action);
  }
}
