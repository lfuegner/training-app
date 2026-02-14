import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:frontend/core/router/app_router.dart';
import 'package:frontend/core/theme/app_colors.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

@RoutePage()
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AutoTabsScaffold(
      routes: const [
        BattleRoute(),
        TrainingRoute(),
        CalendarRoute(),
        GroupsRoute(),
        ProfileRoute(),
      ],
      bottomNavigationBuilder: (context, tabsRouter) {
        return Theme(
          data: Theme.of(context).copyWith(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
          ),
          child: BottomNavigationBar(
            currentIndex: tabsRouter.activeIndex,
            onTap: tabsRouter.setActiveIndex,
            type: BottomNavigationBarType.fixed,
            backgroundColor: AppColors.navBarBackground,
            selectedItemColor: AppColors.headerDarkGreen,
            unselectedItemColor: AppColors.headerDarkGreen.withValues(alpha: 0.4),
            selectedFontSize: 12,
            unselectedFontSize: 12,
            enableFeedback: false,
          items: [
            BottomNavigationBarItem(
              icon: PhosphorIcon(PhosphorIcons.sword()),
              activeIcon: PhosphorIcon(PhosphorIcons.sword(PhosphorIconsStyle.fill)),
              label: 'Battle',
            ),
            BottomNavigationBarItem(
              icon: PhosphorIcon(PhosphorIcons.barbell()),
              activeIcon: PhosphorIcon(PhosphorIcons.barbell(PhosphorIconsStyle.fill)),
              label: 'Training',
            ),
            BottomNavigationBarItem(
              icon: PhosphorIcon(PhosphorIcons.calendar()),
              activeIcon: PhosphorIcon(PhosphorIcons.calendar(PhosphorIconsStyle.fill)),
              label: 'Calendar',
            ),
            BottomNavigationBarItem(
              icon: PhosphorIcon(PhosphorIcons.usersThree()),
              activeIcon: PhosphorIcon(PhosphorIcons.usersThree(PhosphorIconsStyle.fill)),
              label: 'Groups',
            ),
            BottomNavigationBarItem(
              icon: PhosphorIcon(PhosphorIcons.user()),
              activeIcon: PhosphorIcon(PhosphorIcons.user(PhosphorIconsStyle.fill)),
              label: 'Profile',
            ),
          ],
          ),
        );
      },
    );
  }
}
