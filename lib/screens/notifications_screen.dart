import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../widgets/animated/animated_button.dart';
import '../widgets/animated/animated_card.dart';
import '../utils/animation_constants.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen>
    with TickerProviderStateMixin {
  
  // Mock notifications data grouped by time
  final Map<String, List<Map<String, dynamic>>> _notifications = {
    'Today': [
      {
        'id': '1',
        'type': 'like',
        'user': 'Anna Chen',
        'avatar': 'https://images.unsplash.com/photo-1494790108755-2616b612b647?w=150&h=150&fit=crop&crop=face',
        'message': 'liked your meditation post',
        'time': '2h ago',
        'isRead': false,
        'postImage': 'https://images.unsplash.com/photo-1635545999375-057ee4013deb?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&w=100',
      },
      {
        'id': '2',
        'type': 'comment',
        'user': 'Marcus Johnson',
        'avatar': 'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=150&h=150&fit=crop&crop=face',
        'message': 'commented: "This is so inspiring! Thank you for sharing 🙏"',
        'time': '4h ago',
        'isRead': false,
        'postImage': 'https://images.unsplash.com/photo-1701416050721-2e8a9f765ac2?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&w=100',
      },
      {
        'id': '3',
        'type': 'follow',
        'user': 'Sarah Williams',
        'avatar': 'https://images.unsplash.com/photo-1438761681033-6461ffad8d80?w=150&h=150&fit=crop&crop=face',
        'message': 'started following you',
        'time': '6h ago',
        'isRead': true,
        'postImage': null,
      },
      {
        'id': '4',
        'type': 'wellness_tip',
        'user': null,
        'avatar': null,
        'message': 'New wellness tip available: "5-minute morning mindfulness routine"',
        'time': '8h ago',
        'isRead': false,
        'postImage': null,
        'icon': LucideIcons.lightbulb,
        'iconColor': Color(0xFF3AAFA9),
      },
    ],
    'This Week': [
      {
        'id': '5',
        'type': 'like',
        'user': 'Dr. Alex Park',
        'avatar': 'https://images.unsplash.com/photo-1559209172-d0d45d8d1ce8?w=150&h=150&fit=crop&crop=face',
        'message': 'liked your yoga journey post',
        'time': '2d ago',
        'isRead': true,
        'postImage': 'https://images.unsplash.com/photo-1613637069737-2cce919a4ab7?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&w=100',
      },
      {
        'id': '6',
        'type': 'achievement',
        'user': null,
        'avatar': null,
        'message': 'Congratulations! You\'ve completed your 30-day meditation streak 🎉',
        'time': '3d ago',
        'isRead': true,
        'postImage': null,
        'icon': LucideIcons.award,
        'iconColor': Color(0xFF7E6BF2),
      },
      {
        'id': '7',
        'type': 'follow',
        'user': 'Luna Rodriguez',
        'avatar': 'https://images.unsplash.com/photo-1544005313-94ddf0286df2?w=150&h=150&fit=crop&crop=face',
        'message': 'started following you',
        'time': '4d ago',
        'isRead': true,
        'postImage': null,
      },
      {
        'id': '8',
        'type': 'reminder',
        'user': null,
        'avatar': null,
        'message': 'Time for your daily mindfulness session',
        'time': '5d ago',
        'isRead': true,
        'postImage': null,
        'icon': LucideIcons.clock,
        'iconColor': Color(0xFFFF9800),
      },
    ],
    'Earlier': [
      {
        'id': '9',
        'type': 'like',
        'user': 'Emma Wellness',
        'avatar': 'https://images.unsplash.com/photo-1494790108755-2616b612b647?w=150&h=150&fit=crop&crop=face',
        'message': 'liked your nutrition tips post',
        'time': '1w ago',
        'isRead': true,
        'postImage': 'https://images.unsplash.com/photo-1601921386176-d6b3206b6ace?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&w=100',
      },
      {
        'id': '10',
        'type': 'comment',
        'user': 'David Kim',
        'avatar': 'https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?w=150&h=150&fit=crop&crop=face',
        'message': 'commented: "Your transformation story is incredible!"',
        'time': '1w ago',
        'isRead': true,
        'postImage': 'https://images.unsplash.com/photo-1635545999375-057ee4013deb?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&w=100',
      },
      {
        'id': '11',
        'type': 'wellness_milestone',
        'user': null,
        'avatar': null,
        'message': 'You\'ve helped 10 friends start their wellness journey! 🌟',
        'time': '2w ago',
        'isRead': true,
        'postImage': null,
        'icon': LucideIcons.users,
        'iconColor': Color(0xFF4CAF50),
      },
    ],
  };

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Row(
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
                  const SizedBox(width: 8),
                  Text(
                    'Notifications',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: colorScheme.onSurface,
                    ),
                  ),
                  const Spacer(),
                  AnimatedWellnessButton(
                    onPressed: _markAllAsRead,
                    backgroundColor: Colors.transparent,
                    padding: const EdgeInsets.all(8),
                    borderRadius: BorderRadius.circular(20),
                    child: Text(
                      'Mark all read',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: colorScheme.primary,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Notifications List
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: _notifications.keys.length,
                itemBuilder: (context, sectionIndex) {
                  final sectionKey = _notifications.keys.elementAt(sectionIndex);
                  final sectionNotifications = _notifications[sectionKey]!;

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Section Header
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        child: Text(
                          sectionKey,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: colorScheme.onSurface.withValues(alpha: 0.8),
                          ),
                        ),
                      ),

                      // Section Notifications
                      ...sectionNotifications.asMap().entries.map((entry) {
                        final index = entry.key;
                        final notification = entry.value;
                        final globalIndex = sectionIndex * 100 + index; // Unique index for animation

                        return Dismissible(
                          key: Key(notification['id']),
                          direction: DismissDirection.endToStart,
                          background: _buildDismissBackground(theme),
                          onDismissed: (direction) => _dismissNotification(notification),
                          child: _buildNotificationItem(notification, globalIndex),
                        );
                      }).toList(),

                      if (sectionIndex < _notifications.keys.length - 1)
                        const SizedBox(height: 8),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNotificationItem(Map<String, dynamic> notification, int index) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final isRead = notification['isRead'] as bool;

    return AnimatedWellnessCard(
      animationDelay: index * 80,
      onTap: () => _handleNotificationTap(notification),
      margin: const EdgeInsets.only(bottom: 8),
      backgroundColor: isRead
          ? colorScheme.surface
          : colorScheme.primary.withValues(alpha: 0.05),
      child: Row(
        children: [
          // Avatar or Icon
          _buildNotificationAvatar(notification, theme),
          
          const SizedBox(width: 12),

          // Content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildNotificationText(notification, colorScheme),
                const SizedBox(height: 4),
                Text(
                  notification['time'],
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: colorScheme.onSurface.withValues(alpha: 0.5),
                  ),
                ),
              ],
            ),
          ),

          // Post Image or Action
          _buildNotificationAction(notification, theme),

          // Unread Indicator
          if (!isRead)
            Container(
              width: 8,
              height: 8,
              margin: const EdgeInsets.only(left: 12),
              decoration: BoxDecoration(
                color: colorScheme.primary,
                shape: BoxShape.circle,
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildNotificationAvatar(Map<String, dynamic> notification, ThemeData theme) {
    final colorScheme = theme.colorScheme;

    if (notification['avatar'] != null) {
      // User avatar
      return Container(
        width: 44,
        height: 44,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: colorScheme.outline.withValues(alpha: 0.2),
            width: 1,
          ),
        ),
        child: CircleAvatar(
          radius: 21,
          backgroundColor: colorScheme.surfaceContainerHighest,
          backgroundImage: CachedNetworkImageProvider(notification['avatar']),
        ),
      );
    } else if (notification['icon'] != null) {
      // System notification icon
      return Container(
        width: 44,
        height: 44,
        decoration: BoxDecoration(
          color: notification['iconColor'].withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Icon(
          notification['icon'],
          color: notification['iconColor'],
          size: 20,
        ),
      );
    } else {
      // Default ThriveSpace icon
      return Container(
        width: 44,
        height: 44,
        decoration: BoxDecoration(
          color: colorScheme.primary.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Icon(
          LucideIcons.heart,
          color: colorScheme.primary,
          size: 20,
        ),
      );
    }
  }

  Widget _buildNotificationText(Map<String, dynamic> notification, ColorScheme colorScheme) {
    final user = notification['user'] as String?;
    final message = notification['message'] as String;

    if (user != null) {
      // Notification with user
      return RichText(
        text: TextSpan(
          style: TextStyle(
            fontSize: 14,
            color: colorScheme.onSurface,
            height: 1.3,
          ),
          children: [
            TextSpan(
              text: user,
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
            TextSpan(
              text: ' $message',
              style: const TextStyle(fontWeight: FontWeight.w400),
            ),
          ],
        ),
      );
    } else {
      // System notification
      return Text(
        message,
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: colorScheme.onSurface,
          height: 1.3,
        ),
      );
    }
  }

  Widget _buildNotificationAction(Map<String, dynamic> notification, ThemeData theme) {
    final postImage = notification['postImage'] as String?;

    if (postImage != null) {
      // Show post thumbnail
      return ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: CachedNetworkImage(
          imageUrl: postImage,
          width: 40,
          height: 40,
          fit: BoxFit.cover,
          placeholder: (context, url) => Container(
            width: 40,
            height: 40,
            color: theme.colorScheme.surfaceContainerHighest,
            child: Center(
              child: CircularProgressIndicator(
                strokeWidth: 2,
                color: theme.colorScheme.primary,
              ),
            ),
          ),
        ),
      );
    } else if (notification['type'] == 'follow') {
      // Follow/Unfollow button
      return AnimatedWellnessButton(
        onPressed: () => _handleFollowAction(notification),
        backgroundColor: theme.colorScheme.primary,
        borderRadius: BorderRadius.circular(8),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        child: Text(
          'Follow',
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
      );
    } else {
      // Right arrow for other notifications
      return Icon(
        LucideIcons.chevronRight,
        size: 16,
        color: theme.colorScheme.onSurface.withValues(alpha: 0.4),
      );
    }
  }

  Widget _buildDismissBackground(ThemeData theme) {
    return Container(
      alignment: Alignment.centerRight,
      padding: const EdgeInsets.only(right: 20),
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: Colors.red.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            LucideIcons.trash2,
            color: Colors.red,
            size: 20,
          ),
          const SizedBox(height: 4),
          Text(
            'Delete',
            style: TextStyle(
              color: Colors.red,
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  void _handleNotificationTap(Map<String, dynamic> notification) {
    // Mark as read
    setState(() {
      notification['isRead'] = true;
    });

    // Handle different notification types
    final type = notification['type'] as String;
    switch (type) {
      case 'like':
      case 'comment':
        _navigateToPost(notification);
        break;
      case 'follow':
        _navigateToProfile(notification);
        break;
      case 'wellness_tip':
      case 'achievement':
      case 'reminder':
      case 'wellness_milestone':
        _handleSystemNotification(notification);
        break;
    }
  }

  void _navigateToPost(Map<String, dynamic> notification) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Navigating to post...'),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void _navigateToProfile(Map<String, dynamic> notification) {
    final user = notification['user'] as String;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Navigating to $user\'s profile...'),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void _handleSystemNotification(Map<String, dynamic> notification) {
    final type = notification['type'] as String;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Opening ${type.replaceAll('_', ' ')}...'),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void _handleFollowAction(Map<String, dynamic> notification) {
    final user = notification['user'] as String;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Following $user'),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void _dismissNotification(Map<String, dynamic> notification) {
    // Find and remove the notification from the appropriate section
    for (final section in _notifications.values) {
      section.removeWhere((item) => item['id'] == notification['id']);
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Notification deleted'),
        behavior: SnackBarBehavior.floating,
        action: SnackBarAction(
          label: 'Undo',
          onPressed: () {
            // Could implement undo functionality here
          },
        ),
      ),
    );
  }

  void _markAllAsRead() {
    setState(() {
      for (final section in _notifications.values) {
        for (final notification in section) {
          notification['isRead'] = true;
        }
      }
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('All notifications marked as read'),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}