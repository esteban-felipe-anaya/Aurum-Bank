import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/theme/design_tokens.dart';

class _Destination {
  const _Destination(this.icon, this.selectedIcon, this.label);
  final IconData icon;
  final IconData selectedIcon;
  final String label;
}

const _destinations = <_Destination>[
  _Destination(Icons.dashboard_outlined, Icons.dashboard_rounded, 'Home'),
  _Destination(
    Icons.receipt_long_outlined,
    Icons.receipt_long_rounded,
    'Activity',
  ),
  _Destination(Icons.credit_card_outlined, Icons.credit_card_rounded, 'Cards'),
  _Destination(
    Icons.pie_chart_outline_rounded,
    Icons.pie_chart_rounded,
    'Insights',
  ),
  _Destination(Icons.settings_outlined, Icons.settings_rounded, 'Settings'),
];

/// Adaptive navigation scaffold:
///  - compact (<600dp): bottom [NavigationBar]
///  - medium (600–840dp): [NavigationRail]
///  - expanded (>840dp): extended [NavigationRail]
class AppShell extends StatelessWidget {
  const AppShell({super.key, required this.navigationShell});

  final StatefulNavigationShell navigationShell;

  void _onSelect(int index) {
    navigationShell.goBranch(
      index,
      initialLocation: index == navigationShell.currentIndex,
    );
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;
        if (Breakpoints.isCompact(width)) {
          return _CompactShell(
            navigationShell: navigationShell,
            onSelect: _onSelect,
          );
        }
        return _RailShell(
          navigationShell: navigationShell,
          onSelect: _onSelect,
          extended: Breakpoints.isExpanded(width),
        );
      },
    );
  }
}

class _CompactShell extends StatelessWidget {
  const _CompactShell({required this.navigationShell, required this.onSelect});
  final StatefulNavigationShell navigationShell;
  final ValueChanged<int> onSelect;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: NavigationBar(
        selectedIndex: navigationShell.currentIndex,
        onDestinationSelected: onSelect,
        destinations: [
          for (final d in _destinations)
            NavigationDestination(
              icon: Icon(d.icon),
              selectedIcon: Icon(d.selectedIcon),
              label: d.label,
            ),
        ],
      ),
    );
  }
}

class _RailShell extends StatelessWidget {
  const _RailShell({
    required this.navigationShell,
    required this.onSelect,
    required this.extended,
  });
  final StatefulNavigationShell navigationShell;
  final ValueChanged<int> onSelect;
  final bool extended;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          SafeArea(
            right: false,
            child: SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight:
                      MediaQuery.sizeOf(context).height -
                      MediaQuery.paddingOf(context).vertical,
                ),
                child: IntrinsicHeight(
                  child: NavigationRail(
                    extended: extended,
                    minExtendedWidth: 196,
                    selectedIndex: navigationShell.currentIndex,
                    onDestinationSelected: onSelect,
                    leading: const _RailLeading(),
                    labelType: extended
                        ? NavigationRailLabelType.none
                        : NavigationRailLabelType.all,
                    destinations: [
                      for (final d in _destinations)
                        NavigationRailDestination(
                          icon: Icon(d.icon),
                          selectedIcon: Icon(d.selectedIcon),
                          label: Text(d.label),
                        ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          const VerticalDivider(width: 1),
          Expanded(child: navigationShell),
        ],
      ),
    );
  }
}

class _RailLeading extends StatelessWidget {
  const _RailLeading();

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: Spacing.lg),
      child: CircleAvatar(
        radius: 20,
        backgroundColor: scheme.primaryContainer,
        child: Icon(
          Icons.account_balance_rounded,
          color: scheme.onPrimaryContainer,
        ),
      ),
    );
  }
}
