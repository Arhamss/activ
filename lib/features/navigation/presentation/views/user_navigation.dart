import 'package:activ/core/models/navigation_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:activ/constants/app_colors.dart';
import 'package:activ/constants/app_text_style.dart';
import 'package:activ/constants/asset_paths.dart';

class UserNavigation extends StatelessWidget {
  const UserNavigation({required this.shell, super.key});

  final StatefulNavigationShell shell;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      backgroundColor: AppColors.white,
      body: shell,
      bottomNavigationBar: shell.currentIndex == 1
          ? null
          : Container(
              decoration: const BoxDecoration(
                color: AppColors.white,
                border: Border(
                  top: BorderSide(
                    color: AppColors.disabled,
                    width: 0.5,
                  ),
                ),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(24),
                  topRight: Radius.circular(24),
                ),
              ),
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: 24,
                    right: 24,
                    top: 4,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: List.generate(_navBarItems.length, (index) {
                      return InkWell(
                        onTap: () {
                          shell.goBranch(index, initialLocation: true);
                        },
                        child: _buildNavItem(context, index),
                      );
                    }),
                  ),
                ),
              ),
            ),
    );
  }

  List<NavItem> get _navBarItems => [
        const NavItem(
          icon: AssetPaths.homeNavbarIcon,
          label: 'Home',
        ),
        const NavItem(
          icon: AssetPaths.searchNavbarIcon,
          label: 'Search',
        ),
        const NavItem(
          icon: AssetPaths.chatNavbarIcon,
          label: 'Chat',
        ),
        const NavItem(
          icon: AssetPaths.profileNavbarIcon,
          label: 'Profile',
        ),
      ];

  Widget _buildNavItem(BuildContext context, int index) {
    NavItem item;
    item = _navBarItems[index];
    final isSelected = index == shell.currentIndex;
    if (isSelected) {
      return Container(
        child: SvgPicture.asset(
          item.icon,
          colorFilter: const ColorFilter.mode(
            AppColors.black,
            BlendMode.srcOut,
          ),
        ),
      );
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset(
            item.icon,
          ),
          const SizedBox(height: 6),
          Text(
            item.label,
            style: context.b2.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
