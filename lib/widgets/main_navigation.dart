import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../screens/home_screen.dart';
import '../screens/journey_screen.dart';
import '../screens/messages_screen.dart';
import '../screens/learn_screen.dart';
import '../utils/animation_constants.dart';
import 'explore_screen.dart';
import 'animated/animated_navigation.dart';

class MainNavigation extends StatefulWidget {
  const MainNavigation({super.key});

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation>
    with SingleTickerProviderStateMixin {
  int _currentIndex = 0;
  late AnimationController _screenController;
  late Animation<Offset> _screenAnimation;

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

  @override
  void initState() {
    super.initState();
    _screenController = AnimationController(
      duration: WellnessAnimations.tabTransition,
      vsync: this,
    );
    _screenAnimation = Tween<Offset>(
      begin: Offset.zero,
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _screenController,
      curve: WellnessAnimations.tabCurve,
    ));
  }

  @override
  void dispose() {
    _screenController.dispose();
    super.dispose();
  }

  void _onNavTap(int index) {
    if (index == _currentIndex) return;
    
    final direction = index > _currentIndex ? 1.0 : -1.0;
    
    _screenAnimation = Tween<Offset>(
      begin: Offset(direction, 0),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _screenController,
      curve: WellnessAnimations.tabCurve,
    ));

    setState(() {
      _currentIndex = index;
    });

    _screenController.forward(from: 0.0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SlideTransition(
        position: _screenAnimation,
        child: IndexedStack(
          index: _currentIndex,
          children: _screens,
        ),
      ),
      bottomNavigationBar: AnimatedBottomNavigation(
        currentIndex: _currentIndex,
        onTap: _onNavTap,
        items: _navItems,
      ),
    );
  }
}