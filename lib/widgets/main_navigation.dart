import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../screens/home_screen.dart';
import '../screens/journey_screen.dart';
import '../screens/messages_screen.dart';
import '../screens/learn_screen.dart';
import 'explore_screen.dart';

class MainNavigation extends StatefulWidget {
  const MainNavigation({super.key});

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const HomeScreen(),
    const ExploreScreen(),
    const LearnScreen(),
    const MyJourneyScreen(),
    const MessagesScreen(),
  ];

  final List<BottomNavItem> _navItems = [
    BottomNavItem(
      icon: LucideIcons.home,
      label: 'Home',
    ),
    BottomNavItem(
      icon: LucideIcons.search,
      label: 'Explore',
    ),
    BottomNavItem(
      icon: LucideIcons.bookOpen,
      label: 'Learn',
    ),
    BottomNavItem(
      icon: LucideIcons.trendingUp,
      label: 'Journey',
    ),
    BottomNavItem(
      icon: LucideIcons.messageCircle,
      label: 'Messages',
    ),
  ];

  void _onNavTap(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      body: Stack(
        children: [
          // Main content
          IndexedStack(
            index: _currentIndex,
            children: _screens,
          ),
          
          // Bottom navigation
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              decoration: BoxDecoration(
                color: theme.scaffoldBackgroundColor.withOpacity(0.95),
                border: Border(
                  top: BorderSide(
                    color: colorScheme.outline.withOpacity(0.2),
                    width: 0.5,
                  ),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, -5),
                  ),
                ],
              ),
              child: SafeArea(
                child: Container(
                  constraints: const BoxConstraints(maxWidth: 448),
                  margin: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: List.generate(_navItems.length, (index) {
                      final item = _navItems[index];
                      final isActive = _currentIndex == index;
                      
                      return Expanded(
                        child: InkWell(
                          onTap: () => _onNavTap(index),
                          borderRadius: BorderRadius.circular(12),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              vertical: 8,
                              horizontal: 4,
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  item.icon,
                                  size: 20,
                                  color: isActive
                                      ? colorScheme.primary
                                      : colorScheme.onSurface.withOpacity(0.6),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  item.label,
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: isActive
                                        ? FontWeight.w500
                                        : FontWeight.w400,
                                    color: isActive
                                        ? colorScheme.primary
                                        : colorScheme.onSurface.withOpacity(0.6),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class BottomNavItem {
  final IconData icon;
  final String label;

  BottomNavItem({
    required this.icon,
    required this.label,
  });
}