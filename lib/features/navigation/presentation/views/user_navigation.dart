import 'package:activ/core/models/navigation_item.dart';
import 'package:activ/exports.dart';
import 'package:activ/features/home/presentation/cubit/cubit.dart';
import 'package:activ/features/home/presentation/widgets/add_game_bottomsheet.dart';

class UserNavigation extends StatelessWidget {
  const UserNavigation({required this.shell, super.key});

  final StatefulNavigationShell shell;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      backgroundColor: const Color.fromARGB(255, 222, 212, 212),
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
              showModalBottomSheet(
                context: context,
                builder: (context) => const AddGameBottomSheet(),
                isScrollControlled: true,
                backgroundColor: AppColors.white,
              );
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
      bottomNavigationBar: Container(
        height: 80,
        decoration: const BoxDecoration(
          color: AppColors.white,
        ),
        child: Row(
          children: [
            Expanded(child: _buildNavItem(context, 0)), // Home
            Expanded(child: _buildNavItem(context, 1)), // Search
            const SizedBox(width: 76), // Space for FAB
            Expanded(child: _buildNavItem(context, 2)), // Chat
            Expanded(child: _buildNavItem(context, 3)), // Profile
          ],
        ),
      ),
    );
  }

  List<NavItem> get _navBarItems => [
        const NavItem(
          icon: AssetPaths.homeNavbarIcon,
          selectedIcon: AssetPaths.homeNavbarSelected,
          label: 'Home',
        ),
        const NavItem(
          icon: AssetPaths.gamesNavbarIcon,
          selectedIcon: AssetPaths.gamesNavbarSelected,
          label: 'Games',
        ),
        const NavItem(
          icon: AssetPaths.chatNavbarIcon,
          selectedIcon: AssetPaths.chatNavbarSelected,
          label: 'Chat',
        ),
        const NavItem(
          icon: AssetPaths.profileNavbarIcon,
          selectedIcon: AssetPaths.profileNavbarSelected,
          label: 'Profile',
        ),
      ];

  Widget _buildNavItem(BuildContext context, int index) {
    // Determine if this item should be selected
    bool isSelected;

    final item = _navBarItems[index];

    isSelected = index == shell.currentIndex;

    final color =
        isSelected ? AppColors.primaryColor : AppColors.secondaryColor;

    return GestureDetector(
      onTap: () {
        shell.goBranch(index, initialLocation: true);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset(
              isSelected ? item.selectedIcon : item.icon,
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
