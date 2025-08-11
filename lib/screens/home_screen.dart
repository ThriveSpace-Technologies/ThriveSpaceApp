import 'package:flutter/material.dart';
import '../utils/asset_manager.dart';
import '../widgets/thrive_space_logo.dart';
import '../services/database_service.dart';
import '../services/auth_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final DatabaseService _databaseService = DatabaseService();
  final AuthService _authService = AuthService();
  List<Map<String, dynamic>> _posts = [];
  List<Map<String, dynamic>> _stories = [];
  bool _isLoadingPosts = true;
  bool _isLoadingStories = true;

  @override
  void initState() {
    super.initState();
    _loadFeedData();
  }

  Future<void> _loadFeedData() async {
    try {
      // Load posts and stories in parallel
      final results = await Future.wait([
        _databaseService.getPosts(limit: 20),
        _loadActiveUsers(), // For stories section
      ]);
      
      if (mounted) {
        setState(() {
          _posts = results[0];
          _stories = results[1];
          _isLoadingPosts = false;
          _isLoadingStories = false;
        });
      }
    } catch (e) {
      print('Error loading feed data: $e');
      // Fallback to sample data if Supabase fails
      _loadSampleData();
    }
  }

  Future<List<Map<String, dynamic>>> _loadActiveUsers() async {
    // This would normally load from a "user_activity" or "online_users" table
    // For now, return sample data that resembles real users with better naming
    return [
      {'name': 'Your Story', 'avatar_url': '', 'is_current_user': true},
      {'name': 'Coach Mike', 'avatar_url': AssetManager.profileMale1, 'is_current_user': false},
      {'name': 'Anna', 'avatar_url': AssetManager.profileFemale1, 'is_current_user': false},
      {'name': 'David', 'avatar_url': AssetManager.profile1, 'is_current_user': false},
      {'name': 'Sarah', 'avatar_url': AssetManager.profile2, 'is_current_user': false},
      {'name': 'Alex', 'avatar_url': AssetManager.profileMale1, 'is_current_user': false},
    ];
  }

  void _loadSampleData() {
    // Fallback sample data with Supabase-like structure
    final samplePosts = List.generate(10, (index) => {
      'id': 'sample_$index',
      'content': _getSamplePostContent(index),
      'image_url': _getSamplePostImage(index),
      'created_at': DateTime.now().subtract(Duration(hours: index + 1)).toIso8601String(),
      'likes_count': 12 + (index * 3),
      'comments_count': 3 + index,
      'profiles': {
        'username': _getTrainerName(index),
        'full_name': _getTrainerName(index),
        'avatar_url': AssetManager.getProfileImageByIndex(index % AssetManager.profileImages.length),
      },
    });
    
    final sampleStories = [
      {'name': 'Your Story', 'avatar_url': '', 'is_current_user': true},
      {'name': 'Coach Mike', 'avatar_url': AssetManager.profileMale1, 'is_current_user': false},
      {'name': 'Anna', 'avatar_url': AssetManager.profileFemale1, 'is_current_user': false},
      {'name': 'David', 'avatar_url': AssetManager.profile1, 'is_current_user': false},
      {'name': 'Sarah', 'avatar_url': AssetManager.profile2, 'is_current_user': false},
      {'name': 'Alex', 'avatar_url': AssetManager.profileMale1, 'is_current_user': false},
    ];

    if (mounted) {
      setState(() {
        _posts = samplePosts;
        _stories = sampleStories;
        _isLoadingPosts = false;
        _isLoadingStories = false;
      });
    }
  }

  String _getSamplePostContent(int index) {
    final contents = [
      "Just crushed my morning workout! 💪 Who's joining me for tomorrow's session?",
      "Meal prep Sunday is done! 🥗 This week's menu is looking fresh and healthy.",
      "New PR on deadlifts today! Consistency pays off, keep pushing everyone! 🔥",
      "Yoga session complete ✨ Nothing beats that post-workout peace and clarity.",
      "5K morning run done! The early bird catches the worm 🏃‍♀️",
      "Protein smoothie recipe that changed my game! Recipe in the comments 👇",
      "Rest day is just as important as workout days. Listen to your body! 🧘‍♂️",
      "Group fitness class was amazing today! Community makes everything better 💯",
    ];
    return contents[index % contents.length];
  }

  String? _getSamplePostImage(int index) {
    if (index % 3 == 0) {
      final images = [
        AssetManager.workoutDeadlift,
        AssetManager.workoutBench,
        AssetManager.workoutSquats,
        AssetManager.nutritionMealprep,
        AssetManager.workoutYoga,
      ];
      return images[index % images.length];
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header with App Branding
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 20, 70, 12),
              child: Row(
                children: [
                  // ThriveSpace Logo
                  const ThriveSpaceLogo(
                    size: 40,
                    primaryColor: Color(0xFF22c55e),
                    secondaryColor: Color(0xFF0891b2),
                    backgroundColor: Colors.white,
                  ),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'ThriveSpace',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF0a0a0a),
                        ),
                      ),
                      Text(
                        'Your wellness journey awaits',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Stories Section  
            Container(
              height: 120,
              margin: const EdgeInsets.symmetric(vertical: 8),
              child: _isLoadingStories 
                ? _buildStoriesLoading()
                : ListView.builder(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    itemCount: _stories.length,
                    itemBuilder: (context, index) {
                      final story = _stories[index];
                      final isCurrentUser = story['is_current_user'] ?? false;
                      
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 6),
                        child: Column(
                          children: [
                            Container(
                              width: 64,
                              height: 64,
                              padding: const EdgeInsets.all(2),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                gradient: isCurrentUser 
                                  ? const LinearGradient(
                                      colors: [Color(0xFF64748b), Color(0xFF94a3b8)],
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                    )
                                  : const LinearGradient(
                                      colors: [Color(0xFFFF6B35), Color(0xFFEC4899)],
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                    ),
                              ),
                              child: Container(
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.white,
                                ),
                                padding: const EdgeInsets.all(2),
                                child: CircleAvatar(
                                  radius: 28,
                                  backgroundColor: const Color(0xFFf1f5f9),
                                  child: story['avatar_url']?.isNotEmpty == true
                                    ? ClipOval(
                                        child: Image.asset(
                                          story['avatar_url']!,
                                          width: 56,
                                          height: 56,
                                          fit: BoxFit.cover,
                                          errorBuilder: (context, error, stackTrace) {
                                            return Icon(
                                              isCurrentUser ? Icons.add : Icons.person,
                                              color: const Color(0xFF64748b),
                                              size: 24,
                                            );
                                          },
                                        ),
                                      )
                                    : Icon(
                                        isCurrentUser ? Icons.add : Icons.person,
                                        color: const Color(0xFF64748b),
                                        size: 24,
                                      ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              story['name'] ?? 'User',
                              style: const TextStyle(
                                fontSize: 11,
                                color: Color(0xFF64748b),
                                fontWeight: FontWeight.w500,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      );
                    },
                  ),
            ),

            // Feed Section
            Expanded(
              child: _isLoadingPosts
                ? _buildFeedLoading()
                : RefreshIndicator(
                    onRefresh: _loadFeedData,
                    child: _posts.isEmpty
                      ? _buildEmptyFeed()
                      : ListView.builder(
                          padding: const EdgeInsets.only(bottom: 100),
                          itemCount: _posts.length,
                          itemBuilder: (context, index) {
                            final post = _posts[index];
                            final profile = post['profiles'] as Map<String, dynamic>?;
                            final createdAt = DateTime.parse(post['created_at'] ?? DateTime.now().toIso8601String());
                            final timeAgo = _getTimeAgo(createdAt);
                            
                            return Container(
                              margin: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 8,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(16),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withValues(alpha: 0.05),
                                    blurRadius: 10,
                                    offset: const Offset(0, 2),
                                  ),
                                ],
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Post Header
                                  Padding(
                                    padding: const EdgeInsets.all(16),
                                    child: Row(
                                      children: [
                                        CircleAvatar(
                                          radius: 20,
                                          backgroundImage: profile?['avatar_url']?.isNotEmpty == true
                                            ? AssetImage(profile!['avatar_url']!)
                                            : null,
                                          backgroundColor: const Color(0xFFf1f5f9),
                                          child: profile?['avatar_url']?.isEmpty != false
                                            ? const Icon(
                                                Icons.person,
                                                color: Color(0xFF64748b),
                                                size: 20,
                                              )
                                            : null,
                                          onBackgroundImageError: (exception, stackTrace) {
                                            // Handle error
                                          },
                                        ),
                                        const SizedBox(width: 12),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                children: [
                                                  Text(
                                                    profile?['full_name'] ?? profile?['username'] ?? 'User',
                                                    style: const TextStyle(
                                                      fontWeight: FontWeight.bold,
                                                      fontSize: 14,
                                                      color: Color(0xFF0a0a0a),
                                                    ),
                                                  ),
                                                  if (index % 3 == 0) ...[
                                                    const SizedBox(width: 4),
                                                    const Icon(
                                                      Icons.verified,
                                                      color: Color(0xFF5f41c4),
                                                      size: 14,
                                                    ),
                                                  ],
                                                ],
                                              ),
                                              Text(
                                                timeAgo,
                                                style: const TextStyle(
                                                  color: Color(0xFF64748b),
                                                  fontSize: 12,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        IconButton(
                                          icon: const Icon(
                                            Icons.more_horiz,
                                            color: Color(0xFF64748b),
                                          ),
                                          onPressed: () => _showPostOptions(post),
                                        ),
                                      ],
                          ),
                        ),

                                  // Post Content Text
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 16),
                                    child: Text(
                                      post['content'] ?? '',
                                      style: const TextStyle(
                                        fontSize: 14,
                                        color: Color(0xFF0a0a0a),
                                        height: 1.4,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 12),

                                  // Post Image
                                  if (post['image_url'] != null && post['image_url'].isNotEmpty)
                                    ClipRRect(
                                      borderRadius: const BorderRadius.all(Radius.circular(12)),
                                      child: Container(
                                        margin: const EdgeInsets.symmetric(horizontal: 16),
                                        child: Image.asset(
                                          post['image_url'],
                                          height: 200,
                                          width: double.infinity,
                                          fit: BoxFit.cover,
                                          errorBuilder: (context, error, stackTrace) {
                                            return Container(
                                              height: 200,
                                              decoration: BoxDecoration(
                                                color: Colors.grey[100],
                                                borderRadius: BorderRadius.circular(12),
                                              ),
                                              child: Center(
                                                child: Column(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: [
                                                    Icon(
                                                      Icons.image_outlined,
                                                      size: 40,
                                                      color: Colors.grey[400],
                                                    ),
                                                    const SizedBox(height: 8),
                                                    Text(
                                                      "Image not found",
                                                      style: TextStyle(
                                                        color: Colors.grey[500],
                                                        fontSize: 12,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                    ),

                                  // Action Buttons and Stats
                                  Padding(
                                    padding: const EdgeInsets.all(16),
                                    child: Column(
                                      children: [
                                        Row(
                                          children: [
                                            _buildActionButton(
                                              icon: Icons.favorite_border,
                                              activeIcon: Icons.favorite,
                                              isActive: false, // TODO: Check if user liked
                                              onPressed: () => _handleLike(post),
                                            ),
                                            const SizedBox(width: 16),
                                            _buildActionButton(
                                              icon: Icons.chat_bubble_outline,
                                              activeIcon: Icons.chat_bubble,
                                              isActive: false,
                                              onPressed: () => _handleComment(post),
                                            ),
                                            const SizedBox(width: 16),
                                            _buildActionButton(
                                              icon: Icons.share_outlined,
                                              activeIcon: Icons.share,
                                              isActive: false,
                                              onPressed: () => _handleShare(post),
                                            ),
                                            const Spacer(),
                                            _buildActionButton(
                                              icon: Icons.bookmark_border,
                                              activeIcon: Icons.bookmark,
                                              isActive: false, // TODO: Check if user bookmarked
                                              onPressed: () => _handleBookmark(post),
                                            ),
                                          ],
                              ),
                                        const SizedBox(height: 8),
                                        Row(
                                          children: [
                                            Text(
                                              "${post['likes_count'] ?? 0} likes",
                                              style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 13,
                                                color: Color(0xFF0a0a0a),
                                              ),
                                            ),
                                            const Text(
                                              " • ",
                                              style: TextStyle(
                                                color: Color(0xFF64748b),
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            Text(
                                              "${post['comments_count'] ?? 0} comments",
                                              style: const TextStyle(
                                                color: Color(0xFF64748b),
                                                fontSize: 13,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                    ),
            ),
          ],
        ),
      ),
    );
  }

  // Helper methods
  String _getTimeAgo(DateTime dateTime) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);

    if (difference.inDays > 0) {
      return "${difference.inDays}d";
    } else if (difference.inHours > 0) {
      return "${difference.inHours}h";
    } else if (difference.inMinutes > 0) {
      return "${difference.inMinutes}m";
    } else {
      return "now";
    }
  }

  void _showPostOptions(Map<String, dynamic> post) {
    // Show bottom sheet with post options
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.flag_outlined),
              title: const Text('Report Post'),
              onTap: () => Navigator.pop(context),
            ),
            ListTile(
              leading: const Icon(Icons.block),
              title: const Text('Block User'),
              onTap: () => Navigator.pop(context),
            ),
          ],
        ),
      ),
    );
  }

  void _handleLike(Map<String, dynamic> post) async {
    final user = _authService.currentUser;
    if (user == null) return;

    try {
      // TODO: Check if already liked, then like/unlike
      await _databaseService.likePost(
        userId: user.id,
        postId: post['id'],
      );
      // Refresh the posts to show updated like count
      _loadFeedData();
    } catch (e) {
      print('Error liking post: $e');
    }
  }

  void _handleComment(Map<String, dynamic> post) {
    // Navigate to post details/comments screen
    print('Comment on post: ${post['id']}');
  }

  void _handleShare(Map<String, dynamic> post) {
    // Share post functionality
    print('Share post: ${post['id']}');
  }

  void _handleBookmark(Map<String, dynamic> post) {
    // Bookmark post functionality
    print('Bookmark post: ${post['id']}');
  }

  Widget _buildStoriesLoading() {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      itemCount: 5,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 6),
          child: Column(
            children: [
              Container(
                width: 64,
                height: 64,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.grey[300],
                ),
              ),
              const SizedBox(height: 6),
              Container(
                width: 40,
                height: 10,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildFeedLoading() {
    return ListView.builder(
      padding: const EdgeInsets.only(bottom: 100),
      itemCount: 3,
      itemBuilder: (context, index) {
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.05),
                blurRadius: 10,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.grey[300],
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 100,
                            height: 14,
                            decoration: BoxDecoration(
                              color: Colors.grey[300],
                              borderRadius: BorderRadius.circular(7),
                            ),
                          ),
                          const SizedBox(height: 4),
                          Container(
                            width: 60,
                            height: 10,
                            decoration: BoxDecoration(
                              color: Colors.grey[300],
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: double.infinity,
                      height: 14,
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(7),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Container(
                      width: 200,
                      height: 14,
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(7),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
        );
      },
    );
  }

  Widget _buildEmptyFeed() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.fitness_center,
            size: 64,
            color: Colors.grey[400],
          ),
          const SizedBox(height: 16),
          Text(
            'No posts yet',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Follow some fitness enthusiasts to see their posts here!',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[500],
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  String _getTrainerName(int index) {
    final names = [
      'Mike Thompson',
      'Anna Rodriguez', 
      'David Kim',
      'Sarah Johnson',
      'Alex Chen',
      'Emily Davis',
      'Ryan Martinez',
      'Jessica Wilson'
    ];
    return names[index % names.length];
  }

  Widget _buildActionButton({
    required IconData icon,
    required IconData activeIcon,
    required bool isActive,
    required VoidCallback onPressed,
  }) {
    return GestureDetector(
      onTap: onPressed,
      child: Icon(
        isActive ? activeIcon : icon,
        color: isActive ? const Color(0xFFFF6B35) : const Color(0xFF64748b),
        size: 22,
      ),
    );
  }

}
