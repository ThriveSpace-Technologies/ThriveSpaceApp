import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../widgets/animated/animated_card.dart';
import '../widgets/animated/animated_navigation.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final PageController _pageController = PageController();
  bool _isDarkMode = false;

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
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _pageController.dispose();
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
    setState(() {
      _isDarkMode = !_isDarkMode;
    });
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

    return Scaffold(
      body: Column(
        children: [
          // Custom App Bar
          SafeArea(
            child: Container(
              decoration: BoxDecoration(
                color: theme.scaffoldBackgroundColor.withOpacity(0.95),
                border: Border(
                  bottom: BorderSide(
                    color: colorScheme.outline.withOpacity(0.1),
                    width: 0.5,
                  ),
                ),
              ),
              child: Column(
                children: [
                  // Header row
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    child: Row(
                      children: [
                        // Profile Avatar
                        GestureDetector(
                          onTap: _handleProfileClick,
                          child: CircleAvatar(
                            radius: 20,
                            backgroundColor: colorScheme.primary.withOpacity(0.1),
                            backgroundImage: const CachedNetworkImageProvider(
                              'https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?w=150&h=150&fit=crop&crop=face',
                            ),
                            child: Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: colorScheme.primary.withOpacity(0.2),
                                  width: 1,
                                ),
                              ),
                            ),
                          ),
                        ),

                        // App Title
                        Expanded(
                          child: Text(
                            'ThriveSpace',
                            style: theme.textTheme.headlineSmall?.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),

                        // Right Actions
                        Row(
                          children: [
                            IconButton(
                              onPressed: _toggleTheme,
                              icon: Icon(
                                _isDarkMode ? LucideIcons.sun : LucideIcons.moon,
                                size: 20,
                                color: colorScheme.onSurface.withOpacity(0.7),
                              ),
                              style: IconButton.styleFrom(
                                backgroundColor: colorScheme.surface,
                                padding: const EdgeInsets.all(8),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Stack(
                              children: [
                                IconButton(
                                  onPressed: _handleNotifications,
                                  icon: Icon(
                                    LucideIcons.bell,
                                    size: 20,
                                    color: colorScheme.onSurface.withOpacity(0.7),
                                  ),
                                  style: IconButton.styleFrom(
                                    backgroundColor: colorScheme.surface,
                                    padding: const EdgeInsets.all(8),
                                  ),
                                ),
                                Positioned(
                                  right: 6,
                                  top: 6,
                                  child: Container(
                                    width: 16,
                                    height: 16,
                                    decoration: BoxDecoration(
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
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  // Animated Tab Bar
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

          // Tab Content
          Expanded(
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
        ],
      ),

      // Floating Action Button
      floatingActionButton: FloatingActionButton(
        onPressed: _handleNewPost,
        backgroundColor: colorScheme.primary,
        child: const Icon(LucideIcons.plus, color: Colors.white),
      ),
    );
  }

  Widget _buildPostsList(List<Map<String, dynamic>> posts) {
    if (posts.isEmpty) {
      return const Center(
        child: Text('No posts to show'),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.symmetric(vertical: 16),
      itemCount: posts.length,
      itemBuilder: (context, index) {
        return AnimatedWellnessCard(
          animationDelay: index * 100,
          onTap: () {
            // Handle post tap
          },
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
                          style: theme.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          '@${post['user']['username']} • ${post['timestamp']}',
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: colorScheme.onSurface.withOpacity(0.6),
                          ),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(
                      LucideIcons.moreVertical,
                      size: 20,
                      color: colorScheme.onSurface.withOpacity(0.6),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 12),

              // Content
              Text(
                post['content'],
                style: theme.textTheme.bodyMedium,
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
                      color: colorScheme.surface,
                      child: const Center(
                        child: CircularProgressIndicator(),
                      ),
                    ),
                    errorWidget: (context, url, error) => Container(
                      height: 200,
                      color: colorScheme.surface,
                      child: const Center(
                        child: Icon(Icons.error),
                      ),
                    ),
                  ),
                ),
              ],

              const SizedBox(height: 12),

              // Actions
              Row(
                children: [
                  // Like button
                  Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          // Toggle like
                        },
                        icon: Icon(
                          post['isLiked'] ? LucideIcons.heart : LucideIcons.heart,
                          size: 20,
                          color: post['isLiked'] 
                              ? Colors.red 
                              : colorScheme.onSurface.withOpacity(0.6),
                        ),
                        style: IconButton.styleFrom(
                          minimumSize: const Size(40, 40),
                          padding: const EdgeInsets.all(8),
                        ),
                      ),
                      Text('${post['likes']}'),
                    ],
                  ),

                  const SizedBox(width: 16),

                  // Comment button
                  Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          // Show comments
                        },
                        icon: Icon(
                          LucideIcons.messageCircle,
                          size: 20,
                          color: colorScheme.onSurface.withOpacity(0.6),
                        ),
                        style: IconButton.styleFrom(
                          minimumSize: const Size(40, 40),
                          padding: const EdgeInsets.all(8),
                        ),
                      ),
                      Text('${post['comments']}'),
                    ],
                  ),

                  const Spacer(),

                  // Share button
                  IconButton(
                    onPressed: () {
                      // Share post
                    },
                    icon: Icon(
                      LucideIcons.share,
                      size: 20,
                      color: colorScheme.onSurface.withOpacity(0.6),
                    ),
                    style: IconButton.styleFrom(
                      minimumSize: const Size(40, 40),
                      padding: const EdgeInsets.all(8),
                    ),
                  ),
                ],
              ),
            ],
    );
  }
}