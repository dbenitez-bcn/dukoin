import 'package:dukoin/l10n/app_localizations.dart';
import 'package:dukoin/presentation/widgets/dukoin_icon.dart';
import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';

class AppInfoCard extends StatelessWidget {
  const AppInfoCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card.outlined(
      color: Theme.of(context).colorScheme.primary.withAlpha(13),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            DukoinIcon(
              icon: Icons.flutter_dash,
              color: Theme.of(context).colorScheme.primary,
              isSolid: true,
              size: 48,
            ),
            SizedBox(height: 8),
            FutureBuilder<PackageInfo>(
              future: PackageInfo.fromPlatform(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        snapshot.data!.appName,
                        style: TextTheme.of(context).displaySmall,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text("·"),
                      ),
                      Text(
                        AppLocalizations.of(
                          context,
                        )!.settingsApplicationInfoVersion(
                          snapshot.data!.version,
                        ),
                      ),
                    ],
                  );
                } else {
                  return Container();
                }
              },
            ),
            Text(AppLocalizations.of(context)!.settingsApplicationInfoMessage),
          ],
        ),
      ),
    );
  }
}
