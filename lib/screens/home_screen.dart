import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../widgets/animated/animated_card.dart';
import '../widgets/animated/animated_navigation.dart';
import '../widgets/animated/animated_button.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with TickerProviderStateMixin {
  late TabController _tabController;
  late AnimationController _badgeController;
  late Animation<double> _badgeAnimation;

  // Mock data matching React exactly
  final List<Map<String, dynamic>> _mockPosts = [
    {
      'id': '1',
      'user': {
        'name': 'Emma Chen',
        'username': 'emmawellness',
        'avatar': 'https://images.unsplash.com/photo-1494790108755-2616b612b647?w=150&h=150&fit=crop&crop=face'
      },
      'content': 'Starting my morning with 10 minutes of meditation has completely transformed my day. The peace I feel carries through everything I do. 🧘‍♀️✨',
      'image': 'https://images.unsplash.com/photo-1635545999375-057ee4013deb?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3Nzg4Nzd8MHwxfHNlYXJjaHwxfHxtZWRpdGF0aW9uJTIwd2VsbG5lc3MlMjBtaW5kZnVsbmVzc3xlbnwxfHx8fDE3NTYyNjk3MjV8MA&ixlib=rb-4.1.0&q=80&w=1080',
      'likes': 24,
      'comments': 8,
      'timestamp': '2h',
      'isLiked': false
    },
    {
      'id': '2',
      'user': {
        'name': 'Marcus Johnson',
        'username': 'marcusyoga',
        'avatar': 'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=150&h=150&fit=crop&crop=face'
      },
      'content': 'Yoga in nature hits differently. The fresh air, birds chirping, and feeling connected to the earth - this is what wellness means to me.',
      'image': 'https://images.unsplash.com/photo-1701416050721-2e8a9f765ac2?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3Nzg4Nzd8MHwxfHNlYXJjaHwxfHx5b2dhJTIwcGVhY2VmdWwlMjBuYXR1cmV8ZW58MXx8fHwxNzU2MjY5NzI1fDA&ixlib=rb-4.1.0&q=80&w=1080',
      'likes': 42,
      'comments': 12,
      'timestamp': '4h',
      'isLiked': true
    },
    {
      'id': '3',
      'user': {
        'name': 'Sarah Williams',
        'username': 'sarahwellness',
        'avatar': 'https://images.unsplash.com/photo-1438761681033-6461ffad8d80?w=150&h=150&fit=crop&crop=face'
      },
      'content': 'Remember: self-care isn\'t selfish. Taking time for yourself allows you to show up better for others. What\'s one thing you\'re doing for yourself today?',
      'likes': 67,
      'comments': 23,
      'timestamp': '6h',
      'isLiked': false
    },
    {
      'id': '4',
      'user': {
        'name': 'Dr. Alex Park',
        'username': 'drpark_wellness',
        'avatar': 'https://images.unsplash.com/photo-1559209172-d0d45d8d1ce8?w=150&h=150&fit=crop&crop=face'
      },
      'content': 'The science is clear: just 15 minutes of daily mindfulness practice can reduce stress hormones by up to 23%. Small habits, big impact.',
      'image': 'https://images.unsplash.com/photo-1601921386176-d6b3206b6ace?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3Nzg4Nzd8MHwxfHNlYXJjaHwxfHxtZW50YWwlMjBoZWFsdGglMjBzZWxmJTIwY2FyZXxlbnwxfHx8fDE3NTYyNjk3MjZ8MA&ixlib=rb-4.1.0&q=80&w=1080',
      'likes': 89,
      'comments': 31,
      'timestamp': '8h',
      'isLiked': true
    },
    {
      'id': '5',
      'user': {
        'name': 'Luna Rodriguez',
        'username': 'lunaheals',
        'avatar': 'https://images.unsplash.com/photo-1544005313-94ddf0286df2?w=150&h=150&fit=crop&crop=face'
      },
      'content': 'Meal prep Sunday is self-care Sunday. Nourishing my body with colorful, whole foods sets me up for a week of energy and vitality 🥗💚',
      'image': 'https://images.unsplash.com/photo-1613637069737-2cce919a4ab7?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3Nzg4Nzd8MHwxfHNlYXJjaHwxfHxoZWFsdGh5JTIwbGlmZXN0eWxlJTIwd2VsbG5lc3N8ZW58MXx8fHwxNzU2MjUzMDMyfDA&ixlib=rb-4.1.0&q=80&w=1080',
      'likes': 35,
      'comments': 15,
      'timestamp': '12h',
      'isLiked': false
    }
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    
    // Badge pulse animation
    _badgeController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );
    
    _badgeAnimation = Tween<double>(
      begin: 1.0,
      end: 1.2,
    ).animate(CurvedAnimation(
      parent: _badgeController,
      curve: Curves.easeInOut,
    ));
    
    // Start badge pulse
    _badgeController.repeat(reverse: true);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _badgeController.dispose();
    super.dispose();
  }

  void _handleNotifications() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Notifications - Coming Soon!'),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void _handleProfileClick() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Profile - Coming Soon!'),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void _toggleTheme() {
    // Toggle theme via inherited widget or provider
    final brightness = Theme.of(context).brightness;
    
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Theme: ${brightness == Brightness.light ? 'Dark' : 'Light'} mode'),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void _handleNewPost() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('New Post - Coming Soon!'),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: Column(
        children: [
          // Header matching React design exactly
          Container(
            decoration: BoxDecoration(
              color: theme.scaffoldBackgroundColor.withValues(alpha: 0.95),
              border: Border(
                bottom: BorderSide(
                  color: colorScheme.outline.withValues(alpha: 0.1),
                  width: 0.5,
                ),
              ),
            ),
            child: SafeArea(
              bottom: false,
              child: Column(
                children: [
                  // Header row
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    child: Row(
                      children: [
                        // Profile Avatar (left)
                        AnimatedWellnessButton(
                          onPressed: _handleProfileClick,
                          backgroundColor: Colors.transparent,
                          padding: EdgeInsets.zero,
                          borderRadius: BorderRadius.circular(20),
                          child: CircleAvatar(
                            radius: 20,
                            backgroundColor: colorScheme.surfaceContainerHighest,
                            backgroundImage: const CachedNetworkImageProvider(
                              'https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?w=150&h=150&fit=crop&crop=face',
                            ),
                            child: Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: colorScheme.primary.withValues(alpha: 0.2),
                                  width: 1,
                                ),
                              ),
                            ),
                          ),
                        ),

                        // App Title (center)
                        Expanded(
                          child: Text(
                            'ThriveSpace',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: colorScheme.onSurface,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),

                        // Right Actions
                        Row(
                          children: [
                            // Theme Toggle
                            AnimatedWellnessButton(
                              onPressed: _toggleTheme,
                              backgroundColor: colorScheme.surface,
                              padding: const EdgeInsets.all(8),
                              borderRadius: BorderRadius.circular(8),
                              child: Icon(
                                isDark ? LucideIcons.sun : LucideIcons.moon,
                                size: 16,
                                color: colorScheme.onSurface.withValues(alpha: 0.7),
                              ),
                            ),
                            
                            const SizedBox(width: 8),
                            
                            // Notifications with badge pulse
                            Stack(
                              clipBehavior: Clip.none,
                              children: [
                                AnimatedWellnessButton(
                                  onPressed: _handleNotifications,
                                  backgroundColor: colorScheme.surface,
                                  padding: const EdgeInsets.all(8),
                                  borderRadius: BorderRadius.circular(8),
                                  child: Icon(
                                    LucideIcons.bell,
                                    size: 16,
                                    color: colorScheme.onSurface.withValues(alpha: 0.7),
                                  ),
                                ),
                                Positioned(
                                  right: -2,
                                  top: -2,
                                  child: AnimatedBuilder(
                                    animation: _badgeAnimation,
                                    builder: (context, child) {
                                      return Transform.scale(
                                        scale: _badgeAnimation.value,
                                        child: Container(
                                          width: 16,
                                          height: 16,
                                          decoration: const BoxDecoration(
                                            color: Colors.red,
                                            shape: BoxShape.circle,
                                          ),
                                          child: const Center(
                                            child: Text(
                                              '3',
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 10,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  // Sub-tabs with smooth indicator animation
                  AnimatedTopTabBar(
                    tabs: const ['For You', 'Following', 'Wellness News'],
                    currentIndex: _tabController.index,
                    onTap: (index) {
                      _tabController.animateTo(index);
                    },
                  ),
                ],
              ),
            ),
          ),

          // Content with constrained width like React
          Expanded(
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 448), // max-w-md
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    _buildPostsList(_mockPosts),
                    _buildPostsList(_mockPosts.where((post) => 
                        post['user']['username'] == 'emmawellness' || 
                        post['user']['username'] == 'marcusyoga').toList()),
                    _buildPostsList(_mockPosts.where((post) => 
                        post['user']['username'] == 'drpark_wellness').toList()),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),

      // Floating Action Button
      floatingActionButton: AnimatedWellnessButton(
        onPressed: _handleNewPost,
        backgroundColor: colorScheme.primary,
        borderRadius: BorderRadius.circular(28),
        padding: const EdgeInsets.all(16),
        child: const Icon(
          LucideIcons.plus,
          color: Colors.white,
          size: 24,
        ),
      ),
    );
  }

  Widget _buildPostsList(List<Map<String, dynamic>> posts) {
    if (posts.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Text(
            'More wellness news coming soon...',
            style: TextStyle(
              color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.6),
              fontSize: 14,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      itemCount: posts.length,
      itemBuilder: (context, index) {
        return AnimatedWellnessCard(
          animationDelay: index * 100, // Staggered entrance
          onTap: () {
            // Handle post tap
          },
          margin: const EdgeInsets.only(bottom: 16),
          child: _buildPostContent(posts[index]),
        );
      },
    );
  }

  Widget _buildPostContent(Map<String, dynamic> post) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // User Info
        Row(
          children: [
            CircleAvatar(
              radius: 20,
              backgroundImage: CachedNetworkImageProvider(
                post['user']['avatar'],
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    post['user']['name'],
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    '@${post['user']['username']} • ${post['timestamp']}',
                    style: TextStyle(
                      fontSize: 14,
                      color: colorScheme.onSurface.withValues(alpha: 0.6),
                    ),
                  ),
                ],
              ),
            ),
            AnimatedWellnessButton(
              onPressed: () {},
              backgroundColor: Colors.transparent,
              padding: const EdgeInsets.all(8),
              borderRadius: BorderRadius.circular(20),
              child: Icon(
                LucideIcons.moreVertical,
                size: 16,
                color: colorScheme.onSurface.withValues(alpha: 0.6),
              ),
            ),
          ],
        ),

        const SizedBox(height: 12),

        // Content
        Text(
          post['content'],
          style: const TextStyle(
            fontSize: 16,
            height: 1.5,
          ),
        ),

        // Image if present
        if (post['image'] != null) ...[
          const SizedBox(height: 12),
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: CachedNetworkImage(
              imageUrl: post['image'],
              width: double.infinity,
              height: 200,
              fit: BoxFit.cover,
              placeholder: (context, url) => Container(
                height: 200,
                color: colorScheme.surfaceContainerHighest,
                child: Center(
                  child: CircularProgressIndicator(
                    color: colorScheme.primary,
                  ),
                ),
              ),
              errorWidget: (context, url, error) => Container(
                height: 200,
                color: colorScheme.surfaceContainerHighest,
                child: Icon(
                  LucideIcons.image,
                  color: colorScheme.onSurface.withValues(alpha: 0.4),
                ),
              ),
            ),
          ),
        ],

        const SizedBox(height: 12),

        // Actions
        Row(
          children: [
            // Like button with animation
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                AnimatedWellnessButton(
                  onPressed: () {
                    // Toggle like with heart animation
                  },
                  backgroundColor: Colors.transparent,
                  padding: const EdgeInsets.all(8),
                  borderRadius: BorderRadius.circular(20),
                  child: Icon(
                    post['isLiked'] ? LucideIcons.heart : LucideIcons.heart,
                    size: 20,
                    color: post['isLiked'] 
                        ? Colors.red 
                        : colorScheme.onSurface.withValues(alpha: 0.6),
                  ),
                ),
                Text('${post['likes']}',
                  style: TextStyle(
                    fontSize: 14,
                    color: colorScheme.onSurface.withValues(alpha: 0.6),
                  ),
                ),
              ],
            ),

            const SizedBox(width: 16),

            // Comment button
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                AnimatedWellnessButton(
                  onPressed: () {
                    // Show comments
                  },
                  backgroundColor: Colors.transparent,
                  padding: const EdgeInsets.all(8),
                  borderRadius: BorderRadius.circular(20),
                  child: Icon(
                    LucideIcons.messageCircle,
                    size: 20,
                    color: colorScheme.onSurface.withValues(alpha: 0.6),
                  ),
                ),
                Text('${post['comments']}',
                  style: TextStyle(
                    fontSize: 14,
                    color: colorScheme.onSurface.withValues(alpha: 0.6),
                  ),
                ),
              ],
            ),

            const Spacer(),

            // Share button
            AnimatedWellnessButton(
              onPressed: () {
                // Share post
              },
              backgroundColor: Colors.transparent,
              padding: const EdgeInsets.all(8),
              borderRadius: BorderRadius.circular(20),
              child: Icon(
                LucideIcons.share,
                size: 20,
                color: colorScheme.onSurface.withValues(alpha: 0.6),
              ),
            ),
          ],
        ),
      ],
    );
  }
}