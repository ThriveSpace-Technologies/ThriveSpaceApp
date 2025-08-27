import 'package:flutter/material.dart';
import '../../utils/animation_constants.dart';

class AnimatedBottomNavigation extends StatefulWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;
  final List<BottomNavItem> items;

  const AnimatedBottomNavigation({
    super.key,
    required this.currentIndex,
    required this.onTap,
    required this.items,
  });

  @override
  State<AnimatedBottomNavigation> createState() => _AnimatedBottomNavigationState();
}

class _AnimatedBottomNavigationState extends State<AnimatedBottomNavigation>
    with TickerProviderStateMixin {
  late AnimationController _slideController;
  late Animation<double> _slideAnimation;
  late List<AnimationController> _itemControllers;
  late List<Animation<double>> _itemAnimations;

  int _previousIndex = 0;

  @override
  void initState() {
    super.initState();
    
    _slideController = AnimationController(
      duration: WellnessAnimations.tabTransition,
      vsync: this,
    );
    
    _slideAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _slideController,
      curve: WellnessAnimations.tabCurve,
    ));

    // Create individual controllers for each nav item
    _itemControllers = List.generate(
      widget.items.length,
      (index) => AnimationController(
        duration: WellnessAnimations.smooth,
        vsync: this,
      ),
    );

    _itemAnimations = _itemControllers.map((controller) =>
      Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
        parent: controller,
        curve: WellnessAnimations.gentleEase,
      ))
    ).toList();

    // Animate the initially selected item
    if (widget.currentIndex < _itemControllers.length) {
      _itemControllers[widget.currentIndex].forward();
    }
  }

  @override
  void dispose() {
    _slideController.dispose();
    for (final controller in _itemControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  void didUpdateWidget(AnimatedBottomNavigation oldWidget) {
    super.didUpdateWidget(oldWidget);
    
    if (widget.currentIndex != oldWidget.currentIndex) {
      _animateTabTransition(oldWidget.currentIndex, widget.currentIndex);
    }
  }

  void _animateTabTransition(int fromIndex, int toIndex) {
    _previousIndex = fromIndex;
    
    // Animate out the previous tab
    if (fromIndex < _itemControllers.length) {
      _itemControllers[fromIndex].reverse();
    }
    
    // Animate in the new tab
    if (toIndex < _itemControllers.length) {
      _itemControllers[toIndex].forward();
    }
    
    // Trigger slide animation for screen transition
    _slideController.forward().then((_) {
      _slideController.reset();
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final isDark = theme.brightness == Brightness.dark;

    return Container(
      decoration: BoxDecoration(
        color: theme.scaffoldBackgroundColor.withValues(alpha: 0.95),
        border: Border(
          top: BorderSide(
            color: colorScheme.outline.withValues(alpha: 0.1),
            width: 0.5,
          ),
        ),
        boxShadow: [
          BoxShadow(
            color: isDark
                ? Colors.black.withValues(alpha: 0.3)
                : Colors.black.withValues(alpha: 0.05),
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
            children: List.generate(widget.items.length, (index) {
              return Expanded(
                child: _AnimatedNavItem(
                  item: widget.items[index],
                  isSelected: widget.currentIndex == index,
                  animation: _itemAnimations[index],
                  onTap: () => widget.onTap(index),
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}

class _AnimatedNavItem extends StatefulWidget {
  final BottomNavItem item;
  final bool isSelected;
  final Animation<double> animation;
  final VoidCallback onTap;

  const _AnimatedNavItem({
    required this.item,
    required this.isSelected,
    required this.animation,
    required this.onTap,
  });

  @override
  State<_AnimatedNavItem> createState() => _AnimatedNavItemState();
}

class _AnimatedNavItemState extends State<_AnimatedNavItem>
    with SingleTickerProviderStateMixin {
  late AnimationController _tapController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    
    _tapController = AnimationController(
      duration: WellnessAnimations.buttonPress,
      reverseDuration: WellnessAnimations.buttonRelease,
      vsync: this,
    );

    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 0.9,
    ).animate(CurvedAnimation(
      parent: _tapController,
      curve: WellnessAnimations.buttonCurve,
    ));
  }

  @override
  void dispose() {
    _tapController.dispose();
    super.dispose();
  }

  void _handleTapDown(TapDownDetails details) {
    _tapController.forward();
  }

  void _handleTapUp(TapUpDetails details) {
    _tapController.reverse();
    widget.onTap();
  }

  void _handleTapCancel() {
    _tapController.reverse();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return AnimatedBuilder(
      animation: Listenable.merge([widget.animation, _scaleAnimation]),
      builder: (context, child) {
        final selectedValue = widget.animation.value;
        final isSelected = widget.isSelected;
        
        return Transform.scale(
          scale: _scaleAnimation.value,
          child: GestureDetector(
            onTapDown: _handleTapDown,
            onTapUp: _handleTapUp,
            onTapCancel: _handleTapCancel,
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Animated icon with subtle glow
                  AnimatedContainer(
                    duration: WellnessAnimations.smooth,
                    curve: WellnessAnimations.gentleEase,
                    padding: EdgeInsets.all(isSelected ? 8 : 4),
                    decoration: BoxDecoration(
                      color: isSelected 
                          ? colorScheme.primary.withValues(alpha: 0.1)
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(
                      widget.item.icon,
                      size: 20,
                      color: Color.lerp(
                        colorScheme.onSurface.withValues(alpha: 0.6),
                        colorScheme.primary,
                        selectedValue,
                      ),
                    ),
                  ),
                  
                  const SizedBox(height: 4),
                  
                  // Animated label
                  AnimatedDefaultTextStyle(
                    duration: WellnessAnimations.smooth,
                    curve: WellnessAnimations.gentleEase,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: isSelected ? FontWeight.w500 : FontWeight.w400,
                      color: Color.lerp(
                        colorScheme.onSurface.withValues(alpha: 0.6),
                        colorScheme.primary,
                        selectedValue,
                      ),
                    ),
                    child: Text(widget.item.label),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

// Animated top tab bar with sliding indicator
class AnimatedTopTabBar extends StatefulWidget {
  final List<String> tabs;
  final int currentIndex;
  final ValueChanged<int> onTap;

  const AnimatedTopTabBar({
    super.key,
    required this.tabs,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  State<AnimatedTopTabBar> createState() => _AnimatedTopTabBarState();
}

class _AnimatedTopTabBarState extends State<AnimatedTopTabBar>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _indicatorAnimation;

  @override
  void initState() {
    super.initState();
    
    _controller = AnimationController(
      duration: WellnessAnimations.tabTransition,
      vsync: this,
    );

    _indicatorAnimation = Tween<double>(
      begin: widget.currentIndex.toDouble(),
      end: widget.currentIndex.toDouble(),
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: WellnessAnimations.tabCurve,
    ));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(AnimatedTopTabBar oldWidget) {
    super.didUpdateWidget(oldWidget);
    
    if (widget.currentIndex != oldWidget.currentIndex) {
      _indicatorAnimation = Tween<double>(
        begin: oldWidget.currentIndex.toDouble(),
        end: widget.currentIndex.toDouble(),
      ).animate(CurvedAnimation(
        parent: _controller,
        curve: WellnessAnimations.tabCurve,
      ));
      
      _controller.forward(from: 0.0);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: colorScheme.outline.withValues(alpha: 0.1),
            width: 0.5,
          ),
        ),
      ),
      child: Row(
        children: [
          for (int i = 0; i < widget.tabs.length; i++) ...[
            Expanded(
              child: GestureDetector(
                onTap: () => widget.onTap(i),
                child: AnimatedContainer(
                  duration: WellnessAnimations.smooth,
                  curve: WellnessAnimations.gentleEase,
                  padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                  child: Column(
                    children: [
                      AnimatedDefaultTextStyle(
                        duration: WellnessAnimations.smooth,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: widget.currentIndex == i 
                              ? FontWeight.w600
                              : FontWeight.w400,
                          color: widget.currentIndex == i
                              ? colorScheme.primary
                              : colorScheme.onSurface.withValues(alpha: 0.6),
                        ),
                        child: Text(widget.tabs[i]),
                      ),
                      
                      const SizedBox(height: 8),
                      
                      // Animated indicator
                      AnimatedBuilder(
                        animation: _indicatorAnimation,
                        builder: (context, child) {
                          final indicatorPosition = _indicatorAnimation.value;
                          final isCurrentTab = (indicatorPosition - i).abs() < 0.5;
                          
                          return AnimatedContainer(
                            duration: WellnessAnimations.smooth,
                            height: 2,
                            width: isCurrentTab ? 40 : 0,
                            decoration: BoxDecoration(
                              color: colorScheme.primary,
                              borderRadius: BorderRadius.circular(1),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
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