import 'package:activ/core/models/navigation_item.dart';
import 'package:activ/exports.dart';

class UserNavigation extends StatelessWidget {
  const UserNavigation({required this.shell, super.key});

  final StatefulNavigationShell shell;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      backgroundColor: AppColors.white,
      body: shell,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Container(
        width: 76,
        height: 76,
        margin: const EdgeInsets.only(top: 30),
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: AppColors.fabBackground,
          boxShadow: [
            BoxShadow(
              color: Color.fromRGBO(0, 0, 0, 0.12),
              blurRadius: 8,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            splashFactory: NoSplash.splashFactory,
            customBorder: const CircleBorder(),
            onTap: () {
              // Handle FAB action here
              // For example, opening chat or any desired index
            },
            child: Stack(
              children: [
                Center(
                  child: Container(
                    width: 65,
                    height: 65,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.primaryColor,
                    ),
                  ),
                ),
                Center(
                  child: SvgPicture.asset(
                    AssetPaths
                        .bottomNavLogo, // Make sure this asset path exists
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: AppColors.white,
        elevation: 8,
        padding: EdgeInsets.zero,
        child: SafeArea(
          top: false,
          child: Container(
            height: 65,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Left side nav items (2 items)
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildNavItem(context, 0),
                      _buildNavItem(context, 1),
                    ],
                  ),
                ),
                // Space for FAB in the middle
                const SizedBox(width: 76), // Same width as FAB
                // Right side nav items (2 items)
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildNavItem(context, 2),
                      _buildNavItem(context, 3),
                    ],
                  ),
                ),
              ],
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
    final item = _navBarItems[index];
    final isSelected = index == shell.currentIndex;
    final color =
        isSelected ? AppColors.primaryColor : AppColors.secondaryColor;
    final iconColor = isSelected ? AppColors.black : null;

    return InkWell(
      splashFactory: NoSplash.splashFactory,
      onTap: () => shell.goBranch(index, initialLocation: true),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset(
              item.icon,
              colorFilter: iconColor != null
                  ? ColorFilter.mode(iconColor, BlendMode.srcIn)
                  : null,
            ),
            const SizedBox(height: 4),
            Text(
              item.label,
              style: context.b2.copyWith(
                fontWeight: FontWeight.w600,
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
