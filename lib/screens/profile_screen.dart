import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../widgets/animated/animated_button.dart';
import '../widgets/animated/animated_card.dart';
import '../utils/animation_constants.dart';
import '../utils/asset_manager.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen>
    with TickerProviderStateMixin {
  late TabController _tabController;
  int _currentTabIndex = 0;

  // Mock user data
  final bool isOwnProfile = true;
  final Map<String, dynamic> userProfile = {
    'name': 'Emma Wellness',
    'username': 'emmawellness',
    'bio': 'Mindful living advocate 🧘‍♀️\nYoga instructor & wellness coach\nSpread peace, one breath at a time ✨',
    'avatar': 'https://images.unsplash.com/photo-1494790108755-2616b612b647?w=150&h=150&fit=crop&crop=face',
    'isVerified': true,
    'followers': 1247,
    'following': 342,
    'posts': 89,
    'wellnessStreak': 47,
  };

  // Sample posts using wellness images
  final List<Map<String, dynamic>> userPosts = [
    {
      'id': '1',
      'image': 'https://images.unsplash.com/photo-1635545999375-057ee4013deb?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&w=400',
      'type': 'meditation',
      'likes': 24,
    },
    {
      'id': '2',
      'image': 'https://images.unsplash.com/photo-1701416050721-2e8a9f765ac2?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&w=400',
      'type': 'yoga',
      'likes': 42,
    },
    {
      'id': '3',
      'image': 'https://images.unsplash.com/photo-1613637069737-2cce919a4ab7?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&w=400',
      'type': 'nutrition',
      'likes': 67,
    },
    {
      'id': '4',
      'image': 'https://images.unsplash.com/photo-1601921386176-d6b3206b6ace?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&w=400',
      'type': 'wellness',
      'likes': 89,
    },
    {
      'id': '5',
      'image': 'https://images.unsplash.com/photo-1635545999375-057ee4013deb?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&w=400',
      'type': 'meditation',
      'likes': 35,
    },
    {
      'id': '6',
      'image': 'https://images.unsplash.com/photo-1701416050721-2e8a9f765ac2?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&w=400',
      'type': 'yoga',
      'likes': 56,
    },
  ];

  // Wellness achievements
  final List<Map<String, dynamic>> achievements = [
    {
      'title': '30-Day Streak',
      'description': 'Meditated 30 days in a row',
      'icon': LucideIcons.target,
      'color': Color(0xFF3AAFA9),
      'date': '2 weeks ago',
    },
    {
      'title': 'Mindful Moments',
      'description': 'Completed 100 mindfulness sessions',
      'icon': LucideIcons.brain,
      'color': Color(0xFF7E6BF2),
      'date': '1 month ago',
    },
    {
      'title': 'Wellness Advocate',
      'description': 'Helped 5 friends start their journey',
      'icon': LucideIcons.users,
      'color': Color(0xFF4CAF50),
      'date': '2 months ago',
    },
    {
      'title': 'Morning Ritual',
      'description': 'Started day with yoga 50 times',
      'icon': LucideIcons.sunrise,
      'color': Color(0xFFFF9800),
      'date': '3 months ago',
    },
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _tabController.addListener(() {
      setState(() {
        _currentTabIndex = _tabController.index;
      });
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            // Header with back button and settings
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AnimatedWellnessButton(
                    onPressed: () => Navigator.of(context).pop(),
                    backgroundColor: Colors.transparent,
                    padding: const EdgeInsets.all(8),
                    borderRadius: BorderRadius.circular(20),
                    child: Icon(
                      LucideIcons.arrowLeft,
                      size: 20,
                      color: colorScheme.onSurface.withValues(alpha: 0.7),
                    ),
                  ),
                  Text(
                    userProfile['username'],
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: colorScheme.onSurface,
                    ),
                  ),
                  AnimatedWellnessButton(
                    onPressed: _navigateToSettings,
                    backgroundColor: Colors.transparent,
                    padding: const EdgeInsets.all(8),
                    borderRadius: BorderRadius.circular(20),
                    child: Icon(
                      LucideIcons.settings,
                      size: 20,
                      color: colorScheme.onSurface.withValues(alpha: 0.7),
                    ),
                  ),
                ],
              ),
            ),

            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    // Profile Header
                    _buildProfileHeader(),
                    
                    const SizedBox(height: 16),
                    
                    // Stats Row
                    _buildStatsRow(),
                    
                    const SizedBox(height: 20),
                    
                    // Action Buttons
                    _buildActionButtons(),
                    
                    const SizedBox(height: 24),
                    
                    // Content Tabs
                    _buildContentTabs(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileHeader() {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        children: [
          // Large centered avatar
          Stack(
            children: [
              Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: colorScheme.primary.withValues(alpha: 0.3),
                    width: 3,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: colorScheme.primary.withValues(alpha: 0.1),
                      blurRadius: 20,
                      spreadRadius: 0,
                    ),
                  ],
                ),
                child: CircleAvatar(
                  radius: 47,
                  backgroundColor: colorScheme.surfaceContainerHighest,
                  backgroundImage: CachedNetworkImageProvider(
                    userProfile['avatar'],
                  ),
                ),
              ),
              if (userProfile['isVerified'])
                Positioned(
                  bottom: 4,
                  right: 4,
                  child: Container(
                    width: 24,
                    height: 24,
                    decoration: BoxDecoration(
                      color: colorScheme.primary,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: theme.scaffoldBackgroundColor,
                        width: 2,
                      ),
                    ),
                    child: Icon(
                      LucideIcons.check,
                      size: 12,
                      color: Colors.white,
                    ),
                  ),
                ),
            ],
          ),

          const SizedBox(height: 16),

          // Name and bio
          Text(
            userProfile['name'],
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: colorScheme.onSurface,
            ),
            textAlign: TextAlign.center,
          ),

          const SizedBox(height: 8),

          Text(
            userProfile['bio'],
            style: TextStyle(
              fontSize: 14,
              height: 1.4,
              color: colorScheme.onSurface.withValues(alpha: 0.7),
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildStatsRow() {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildStatItem('Posts', '${userProfile['posts']}'),
          Container(
            width: 1,
            height: 40,
            color: colorScheme.outline.withValues(alpha: 0.2),
          ),
          _buildStatItem('Followers', _formatCount(userProfile['followers'])),
          Container(
            width: 1,
            height: 40,
            color: colorScheme.outline.withValues(alpha: 0.2),
          ),
          _buildStatItem('Following', '${userProfile['following']}'),
          Container(
            width: 1,
            height: 40,
            color: colorScheme.outline.withValues(alpha: 0.2),
          ),
          _buildStatItem('Streak', '${userProfile['wellnessStreak']}d'),
        ],
      ),
    );
  }

  Widget _buildStatItem(String label, String count) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Column(
      children: [
        Text(
          count,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: colorScheme.onSurface,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: colorScheme.onSurface.withValues(alpha: 0.6),
          ),
        ),
      ],
    );
  }

  Widget _buildActionButtons() {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: AnimatedWellnessButton(
              onPressed: _editProfile,
              backgroundColor: colorScheme.surface,
              borderRadius: BorderRadius.circular(12),
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: Text(
                'Edit Profile',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: colorScheme.onSurface,
                ),
              ),
            ),
          ),
          
          const SizedBox(width: 12),
          
          Expanded(
            child: AnimatedWellnessButton(
              onPressed: _shareProfile,
              backgroundColor: colorScheme.surface,
              borderRadius: BorderRadius.circular(12),
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: Icon(
                LucideIcons.share,
                size: 16,
                color: colorScheme.onSurface,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContentTabs() {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Column(
      children: [
        // Tab Bar
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 24),
          decoration: BoxDecoration(
            color: colorScheme.surface.withValues(alpha: 0.5),
            borderRadius: BorderRadius.circular(12),
          ),
          child: TabBar(
            controller: _tabController,
            indicator: BoxDecoration(
              color: colorScheme.primary,
              borderRadius: BorderRadius.circular(10),
            ),
            indicatorSize: TabBarIndicatorSize.tab,
            dividerColor: Colors.transparent,
            labelColor: Colors.white,
            unselectedLabelColor: colorScheme.onSurface.withValues(alpha: 0.6),
            labelStyle: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
            unselectedLabelStyle: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
            tabs: const [
              Tab(
                height: 40,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(LucideIcons.grid3x3, size: 14),
                    SizedBox(width: 6),
                    Text('Posts'),
                  ],
                ),
              ),
              Tab(
                height: 40,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(LucideIcons.list, size: 14),
                    SizedBox(width: 6),
                    Text('List'),
                  ],
                ),
              ),
              Tab(
                height: 40,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(LucideIcons.award, size: 14),
                    SizedBox(width: 6),
                    Text('Awards'),
                  ],
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 20),

        // Tab Content
        SizedBox(
          height: 600,
          child: TabBarView(
            controller: _tabController,
            children: [
              _buildPostsGrid(),
              _buildPostsList(),
              _buildAchievements(),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildPostsGrid() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: GridView.builder(
        physics: const NeverScrollableScrollPhysics(),
        itemCount: userPosts.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 8,
          mainAxisSpacing: 8,
        ),
        itemBuilder: (context, index) {
          final post = userPosts[index];
          return AnimatedWellnessCard(
            animationDelay: index * 50,
            onTap: () => _viewPost(post),
            margin: EdgeInsets.zero,
            padding: EdgeInsets.zero,
            borderRadius: 12,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Stack(
                children: [
                  CachedNetworkImage(
                    imageUrl: post['image'],
                    width: double.infinity,
                    height: double.infinity,
                    fit: BoxFit.cover,
                    placeholder: (context, url) => Container(
                      color: Theme.of(context).colorScheme.surfaceContainerHighest,
                      child: Center(
                        child: CircularProgressIndicator(
                          color: Theme.of(context).colorScheme.primary,
                          strokeWidth: 2,
                        ),
                      ),
                    ),
                  ),
                  // Gradient overlay
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      height: 30,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.transparent,
                            Colors.black.withValues(alpha: 0.6),
                          ],
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(6),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Icon(
                              LucideIcons.heart,
                              size: 12,
                              color: Colors.white,
                            ),
                            const SizedBox(width: 2),
                            Text(
                              '${post['likes']}',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 10,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildPostsList() {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        itemCount: userPosts.length,
        itemBuilder: (context, index) {
          final post = userPosts[index];
          return AnimatedWellnessCard(
            animationDelay: index * 100,
            onTap: () => _viewPost(post),
            margin: const EdgeInsets.only(bottom: 12),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: CachedNetworkImage(
                    imageUrl: post['image'],
                    width: 60,
                    height: 60,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${post['type'].toString().toUpperCase()} POST',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: colorScheme.primary,
                          letterSpacing: 0.5,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Mindful moment shared with love and intention',
                        style: TextStyle(
                          fontSize: 14,
                          color: colorScheme.onSurface,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '${post['likes']} likes • 3 days ago',
                        style: TextStyle(
                          fontSize: 12,
                          color: colorScheme.onSurface.withValues(alpha: 0.6),
                        ),
                      ),
                    ],
                  ),
                ),
                Icon(
                  LucideIcons.chevronRight,
                  size: 16,
                  color: colorScheme.onSurface.withValues(alpha: 0.4),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildAchievements() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        itemCount: achievements.length,
        itemBuilder: (context, index) {
          final achievement = achievements[index];
          return AnimatedWellnessCard(
            animationDelay: index * 150,
            margin: const EdgeInsets.only(bottom: 12),
            child: Row(
              children: [
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: achievement['color'].withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    achievement['icon'],
                    color: achievement['color'],
                    size: 24,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        achievement['title'],
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        achievement['description'],
                        style: TextStyle(
                          fontSize: 14,
                          color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.7),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        achievement['date'],
                        style: TextStyle(
                          fontSize: 12,
                          color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.5),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  String _formatCount(int count) {
    if (count >= 1000000) {
      return '${(count / 1000000).toStringAsFixed(1)}M';
    } else if (count >= 1000) {
      return '${(count / 1000).toStringAsFixed(1)}K';
    }
    return count.toString();
  }

  void _navigateToSettings() {
    // Navigate to settings screen
    Navigator.of(context).pushNamed('/settings');
  }

  void _editProfile() {
    // Navigate to edit profile screen
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Edit Profile - Coming Soon!'),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void _shareProfile() {
    // Share profile functionality
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Share Profile - Coming Soon!'),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void _viewPost(Map<String, dynamic> post) {
    // Navigate to post detail
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Viewing ${post['type']} post'),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}