import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import '../core/notifiers/getCategoryNotifier.dart';

List<SingleChildWidget> providers = [
  ChangeNotifierProvider(create: ((context) => CategoryNotifier())),
];
