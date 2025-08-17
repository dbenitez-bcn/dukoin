import 'package:dukoin/presentation/state/navigation_state.dart';
import 'package:flutter/material.dart';

class DukoinPageRoute extends StatefulWidget {
  final GlobalKey<NavigatorState> navigatorKey;
  final int index;
  final WidgetBuilder builder;

  const DukoinPageRoute({
    super.key,
    required this.navigatorKey,
    required this.index,
    required this.builder,
  });

  @override
  State<DukoinPageRoute> createState() => _DukoinPageRouteState();
}

class _DukoinPageRouteState extends State<DukoinPageRoute> {
  Widget? _cachedChild; // Para no reconstruir siempre

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<int>(
      stream: NavigationStateProvider.of(context).currentPageStream,
      initialData: NavigationStateProvider.of(context).currentPageIndex,
      builder: (context, asyncSnapshot) {
        final isActive = asyncSnapshot.data! == widget.index;

        if (isActive && _cachedChild == null) {
          _cachedChild = widget.builder(context);
        }

        return Offstage(
          offstage: !isActive,
          child: _cachedChild == null
              ? const SizedBox.shrink()
              : Navigator(
                  key: widget.navigatorKey,
                  onGenerateRoute: (_) =>
                      MaterialPageRoute(builder: (_) => _cachedChild!),
                ),
        );
      },
    );
  }
}
