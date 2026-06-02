import 'package:flutter_riverpod/flutter_riverpod.dart';

enum AppFlavor { github, store }

final appFlavorProvider = Provider<AppFlavor>((_) => .store);
