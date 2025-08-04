import 'package:dukoin/presentation/state/navigation_state.dart';
import 'package:flutter/material.dart';

class DukoinPageRoute extends StatelessWidget {
  final GlobalKey<NavigatorState> navigatorKey;
  final int index;
  final Widget child;
  const DukoinPageRoute({super.key,required this.navigatorKey, required this.index, required this.child});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<int>(
      stream: NavigationState.of(context).currentPageStream,
      initialData: NavigationState.of(context).currentPageIndex,
      builder: (context, asyncSnapshot) {
        return Offstage(
          offstage: asyncSnapshot.data! != index,
          child: Navigator(
            key: navigatorKey,
            onGenerateRoute: (_) => MaterialPageRoute(builder: (_) => child),
          ),
        );
      },
    );
  }
}
