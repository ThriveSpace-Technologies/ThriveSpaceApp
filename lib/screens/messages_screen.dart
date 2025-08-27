// File: lib/screens/messages_screen.dart

import 'package:flutter/material.dart';
import '../utils/asset_manager.dart';
import '../widgets/thrive_space_logo.dart';
import '../services/database_service.dart';
import '../services/auth_service.dart';

class MessagesScreen extends StatefulWidget {
  const MessagesScreen({super.key});

  @override
  State<MessagesScreen> createState() => _MessagesScreenState();
}

class _MessagesScreenState extends State<MessagesScreen> {
  final DatabaseService _databaseService = DatabaseService();
  final AuthService _authService = AuthService();
  List<Map<String, dynamic>> _conversations = [];
  List<Map<String, dynamic>> _activeUsers = [];
  bool _isLoadingConversations = true;
  bool _isLoadingActiveUsers = true;

  @override
  void initState() {
    super.initState();
    _loadMessagesData();
  }

  Future<void> _loadMessagesData() async {
    final user = _authService.currentUser;
    if (user == null) {
      _loadSampleData();
      return;
    }

    try {
      final results = await Future.wait([
        _databaseService.getConversations(userId: user.id),
        _loadActiveUsers(),
      ]);

      if (mounted) {
        setState(() {
          _conversations = results[0] as List<Map<String, dynamic>>;
          _activeUsers = results[1] as List<Map<String, dynamic>>;
          _isLoadingConversations = false;
          _isLoadingActiveUsers = false;
        });
      }
    } catch (e) {
      print('Error loading messages data: $e');
      _loadSampleData();
    }
  }

  Future<List<Map<String, dynamic>>> _loadActiveUsers() async {
    // For now, return sample active users that would normally come from Supabase
    return [
      {
        'name': 'Coach Mike',
        'avatar_url': AssetManager.profileMale1,
        'is_online': true,
      },
      {
        'name': 'Anna F.',
        'avatar_url': AssetManager.profileFemale1,
        'is_online': true,
      },
      {
        'name': 'David N.',
        'avatar_url': AssetManager.profile1,
        'is_online': true,
      },
      {
        'name': 'Sarah L.',
        'avatar_url': AssetManager.profile2,
        'is_online': true,
      },
    ];
  }

  void _loadSampleData() {
    // Fallback sample data with Supabase-like structure
    final sampleConversations = [
      {
        'id': 'conv_1',
        'participant1': {
          'full_name': 'Coach Mike',
          'avatar_url': AssetManager.profileMale1,
        },
        'participant2': {
          'full_name': 'You',
          'avatar_url': '',
        },
        'last_message': {
          'content': 'Great job on today\'s workout! Keep it up 💪',
          'created_at': DateTime.now().subtract(const Duration(minutes: 2)).toIso8601String(),
          'sender_id': 'coach_mike',
        },
        'unread_count': 2,
        'is_online': true,
        'updated_at': DateTime.now().subtract(const Duration(minutes: 2)).toIso8601String(),
      },
      {
        'id': 'conv_2',
        'participant1': {
          'full_name': 'Anna Fitness',
          'avatar_url': AssetManager.profileFemale1,
        },
        'participant2': {
          'full_name': 'You',
          'avatar_url': '',
        },
        'last_message': {
          'content': 'Thanks for the nutrition tips! 🙏',
          'created_at': DateTime.now().subtract(const Duration(minutes: 15)).toIso8601String(),
          'sender_id': 'anna_f',
        },
        'unread_count': 1,
        'is_online': true,
        'updated_at': DateTime.now().subtract(const Duration(minutes: 15)).toIso8601String(),
      },
      {
        'id': 'conv_3',
        'participant1': {
          'full_name': 'Fitness Group',
          'avatar_url': AssetManager.workoutCardio,
        },
        'participant2': {
          'full_name': 'You',
          'avatar_url': '',
        },
        'last_message': {
          'content': 'John: Anyone up for a morning run?',
          'created_at': DateTime.now().subtract(const Duration(hours: 1)).toIso8601String(),
          'sender_id': 'john_runner',
        },
        'unread_count': 3,
        'is_online': false,
        'is_group': true,
        'updated_at': DateTime.now().subtract(const Duration(hours: 1)).toIso8601String(),
      },
      {
        'id': 'conv_4',
        'participant1': {
          'full_name': 'Sarah T.',
          'avatar_url': AssetManager.profile1,
        },
        'participant2': {
          'full_name': 'You',
          'avatar_url': '',
        },
        'last_message': {
          'content': 'Sent a photo',
          'created_at': DateTime.now().subtract(const Duration(hours: 2)).toIso8601String(),
          'sender_id': 'sarah_t',
        },
        'unread_count': 0,
        'is_online': false,
        'updated_at': DateTime.now().subtract(const Duration(hours: 2)).toIso8601String(),
      },
      {
        'id': 'conv_5',
        'participant1': {
          'full_name': 'David Nutrition',
          'avatar_url': AssetManager.profile2,
        },
        'participant2': {
          'full_name': 'You',
          'avatar_url': '',
        },
        'last_message': {
          'content': 'Your meal plan is ready for review',
          'created_at': DateTime.now().subtract(const Duration(hours: 3)).toIso8601String(),
          'sender_id': 'david_nutrition',
        },
        'unread_count': 1,
        'is_online': true,
        'updated_at': DateTime.now().subtract(const Duration(hours: 3)).toIso8601String(),
      },
    ];

    final sampleActiveUsers = [
      {
        'name': 'Coach Mike',
        'avatar_url': AssetManager.profileMale1,
        'is_online': true,
      },
      {
        'name': 'Anna F.',
        'avatar_url': AssetManager.profileFemale1,
        'is_online': true,
      },
      {
        'name': 'David N.',
        'avatar_url': AssetManager.profile1,
        'is_online': true,
      },
    ];

    if (mounted) {
      setState(() {
        _conversations = sampleConversations;
        _activeUsers = sampleActiveUsers;
        _isLoadingConversations = false;
        _isLoadingActiveUsers = false;
      });
    }
  }

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Messages',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(icon: const Icon(Icons.search), onPressed: () {}),
          IconButton(
            icon: const Icon(Icons.add_comment_rounded),
            onPressed: () {},
          ),
        ],
        elevation: 1,
      ),
      body: Column(
        children: [
          // Active/Online users horizontal scroll
          _buildActiveUsers(),

          // Messages list
          Expanded(
            child: RefreshIndicator(
              onRefresh: _loadMessagesData,
              child: _isLoadingConversations
                  ? _buildLoadingState()
                  : _conversations.isEmpty
                      ? _buildEmptyState()
                      : ListView.separated(
                          itemCount: _conversations.length,
                          separatorBuilder: (context, index) =>
                              Divider(height: 1, color: Colors.grey[200]),
                          itemBuilder: (context, index) {
                            final conversation = _conversations[index];
                            return _buildMessageTile(context, conversation);
                          },
                        ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.edit),
        tooltip: 'New Message',
      ),
    );
  }

  Widget _buildActiveUsers() {
    if (_isLoadingActiveUsers) return _buildActiveUsersLoading();
    if (_activeUsers.isEmpty) return const SizedBox.shrink();

    return Container(
      height: 100,
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              'Active Now',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Colors.grey,
              ),
            ),
          ),
          const SizedBox(height: 8),
          Expanded(
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: _activeUsers.length,
              itemBuilder: (context, index) {
                final user = _activeUsers[index];
                return Container(
                  width: 70,
                  margin: EdgeInsets.only(
                    left: index == 0 ? 16 : 4,
                    right: index == _activeUsers.length - 1 ? 16 : 4,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Stack(
                        children: [
                          Container(
                            width: 48,
                            height: 48,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.grey,
                            ),
                            child: ClipOval(
                              child: user['avatar_url']?.isNotEmpty == true
                                ? Image.asset(
                                    user['avatar_url']!,
                                    fit: BoxFit.cover,
                                    errorBuilder: (context, error, stackTrace) {
                                      return const Icon(
                                        Icons.person,
                                        color: Colors.white,
                                        size: 24,
                                      );
                                    },
                                  )
                                : const Icon(
                                    Icons.person,
                                    color: Colors.white,
                                    size: 24,
                                  ),
                            ),
                          ),
                          if (user['is_online'] == true)
                            Positioned(
                              bottom: 0,
                              right: 2,
                              child: Container(
                                width: 12,
                                height: 12,
                                decoration: BoxDecoration(
                                  color: Colors.green,
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: Colors.white,
                                    width: 2,
                                  ),
                                ),
                              ),
                            ),
                        ],
                      ),
                      const SizedBox(height: 6),
                      Text(
                        user['name']?.split(' ')[0] ?? 'User',
                        style: const TextStyle(fontSize: 11),
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMessageTile(BuildContext context, Map<String, dynamic> conversation) {
    final participant1 = conversation['participant1'] as Map<String, dynamic>?;
    final participant2 = conversation['participant2'] as Map<String, dynamic>?;
    final lastMessage = conversation['last_message'] as Map<String, dynamic>?;
    
    // Determine which participant is not the current user
    final otherParticipant = participant1?['full_name'] != 'You' ? participant1 : participant2;
    final displayName = otherParticipant?['full_name'] ?? 'Unknown User';
    final avatarUrl = otherParticipant?['avatar_url'] ?? '';
    
    final unreadCount = conversation['unread_count'] ?? 0;
    final isGroup = conversation['is_group'] == true;
    final isOnline = conversation['is_online'] == true;
    
    final timeAgo = lastMessage != null 
        ? _getTimeAgo(DateTime.parse(lastMessage['created_at']))
        : '';

    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      leading: Stack(
        children: [
          Container(
            width: 56,
            height: 56,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.grey,
            ),
            child: ClipOval(
              child: avatarUrl.isNotEmpty
                ? Image.asset(
                    avatarUrl,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return const Icon(
                        Icons.person,
                        color: Colors.white,
                        size: 32,
                      );
                    },
                  )
                : Icon(
                    isGroup ? Icons.group : Icons.person,
                    color: Colors.white,
                    size: 32,
                  ),
            ),
          ),
          if (isOnline)
            Positioned(
              bottom: 0,
              right: 0,
              child: Container(
                width: 16,
                height: 16,
                decoration: BoxDecoration(
                  color: Colors.green,
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 2),
                ),
              ),
            ),
          if (displayName.toLowerCase().contains('coach'))
            Positioned(
              top: 0,
              right: 0,
              child: Container(
                padding: const EdgeInsets.all(2),
                decoration: const BoxDecoration(
                  color: Colors.blue,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.verified,
                  color: Colors.white,
                  size: 12,
                ),
              ),
            ),
        ],
      ),
      title: Row(
        children: [
          Expanded(
            child: Text(
              displayName,
              style: TextStyle(
                fontWeight: unreadCount > 0
                    ? FontWeight.bold
                    : FontWeight.w600,
              ),
            ),
          ),
          if (isGroup)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Text(
                'Group',
                style: TextStyle(fontSize: 10, color: Colors.grey),
              ),
            ),
        ],
      ),
      subtitle: Text(
        lastMessage?['content'] ?? 'No messages yet',
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          color: unreadCount > 0 ? Colors.black87 : Colors.grey[600],
          fontWeight: unreadCount > 0
              ? FontWeight.w500
              : FontWeight.normal,
        ),
      ),
      trailing: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            timeAgo,
            style: TextStyle(
              fontSize: 12,
              color: unreadCount > 0 ? Colors.blue : Colors.grey,
              fontWeight: unreadCount > 0
                  ? FontWeight.w600
                  : FontWeight.normal,
            ),
          ),
          if (unreadCount > 0) ...[
            const SizedBox(height: 4),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: const BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              child: Text(
                unreadCount > 9 ? '9+' : '$unreadCount',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ],
      ),
      onTap: () {
        // Navigate to chat detail screen
        _openChatDetail(context, conversation);
      },
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ThriveSpaceLogo(
            size: 80,
            primaryColor: Colors.grey[300],
            backgroundColor: Colors.white,
          ),
          const SizedBox(height: 24),
          const Text(
            'No messages yet',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Start a conversation with your\nfitness community!',
            style: TextStyle(color: Colors.grey[600], fontSize: 16),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          ElevatedButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.add_comment),
            label: const Text('Start Chatting'),
          ),
        ],
      ),
    );
  }

  void _openChatDetail(BuildContext context, Map<String, dynamic> conversation) {
    final participant1 = conversation['participant1'] as Map<String, dynamic>?;
    final participant2 = conversation['participant2'] as Map<String, dynamic>?;
    final otherParticipant = participant1?['full_name'] != 'You' ? participant1 : participant2;
    final displayName = otherParticipant?['full_name'] ?? 'Unknown User';
    final avatarUrl = otherParticipant?['avatar_url'] ?? '';
    
    // TODO: Navigate to chat detail screen
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Opening chat with $displayName"),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  Widget _buildActiveUsersLoading() {
    return Container(
      height: 100,
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              'Active Now',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Colors.grey,
              ),
            ),
          ),
          const SizedBox(height: 8),
          Expanded(
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 4,
              itemBuilder: (context, index) {
                return Container(
                  width: 70,
                  margin: EdgeInsets.only(
                    left: index == 0 ? 16 : 4,
                    right: index == 3 ? 16 : 4,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 48,
                        height: 48,
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
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLoadingState() {
    return ListView.builder(
      itemCount: 5,
      itemBuilder: (context, index) {
        return ListTile(
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          leading: Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.grey[300],
            ),
          ),
          title: Container(
            width: 150,
            height: 16,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          subtitle: Container(
            width: 200,
            height: 14,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(7),
            ),
          ),
          trailing: Container(
            width: 20,
            height: 12,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(6),
            ),
          ),
        );
      },
    );
  }
}

// Simple chat detail screen
class ChatDetailScreen extends StatelessWidget {
  final String userName;
  final String userAvatar;
  final bool isOnline;
  final bool isCoach;

  const ChatDetailScreen({
    super.key,
    required this.userName,
    required this.userAvatar,
    required this.isOnline,
    required this.isCoach,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Stack(
              children: [
                CircleAvatar(
                  radius: 18,
                  backgroundImage: AssetImage(userAvatar),
                ),
                if (isOnline)
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      width: 12,
                      height: 12,
                      decoration: BoxDecoration(
                        color: Colors.green,
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 2),
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(userName, style: const TextStyle(fontSize: 16)),
                Text(
                  isOnline ? 'Online' : 'Last seen recently',
                  style: const TextStyle(fontSize: 12, color: Colors.grey),
                ),
              ],
            ),
          ],
        ),
        actions: [
          IconButton(icon: const Icon(Icons.videocam), onPressed: () {}),
          IconButton(icon: const Icon(Icons.call), onPressed: () {}),
          IconButton(icon: const Icon(Icons.more_vert), onPressed: () {}),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: Center(
              child: Text(
                'Chat with $userName',
                style: TextStyle(color: Colors.grey[600]),
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.grey[100],
              border: Border(top: BorderSide(color: Colors.grey[300]!)),
            ),
            child: Row(
              children: [
                IconButton(icon: const Icon(Icons.add), onPressed: () {}),
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Type a message...',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(24),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: Colors.white,
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send, color: Colors.blue),
                  onPressed: () {},
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
