import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../widgets/animated/animated_button.dart';
import '../widgets/animated/animated_card.dart';
import '../utils/animation_constants.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  // Wellness Preferences Toggle States
  bool _pushNotifications = true;
  bool _emailNotifications = false;
  bool _wellnessReminders = true;
  bool _darkMode = false;
  bool _dataAnalytics = true;
  bool _locationTracking = false;
  bool _biometricLogin = true;
  bool _privateProfile = false;

  // Settings sections with their items
  final List<Map<String, dynamic>> _settingsSections = [
    {
      'title': 'Account',
      'items': [
        {
          'title': 'Edit Profile',
          'subtitle': 'Update your personal information',
          'icon': LucideIcons.user,
          'type': 'nav',
          'route': '/edit-profile',
        },
        {
          'title': 'Change Password',
          'subtitle': 'Update your account security',
          'icon': LucideIcons.lock,
          'type': 'nav',
          'route': '/change-password',
        },
        {
          'title': 'Subscription',
          'subtitle': 'Manage your ThriveSpace Pro plan',
          'icon': LucideIcons.crown,
          'type': 'nav',
          'route': '/subscription',
          'badge': 'Pro',
        },
        {
          'title': 'Connected Accounts',
          'subtitle': 'Link social media and fitness apps',
          'icon': LucideIcons.link,
          'type': 'nav',
          'route': '/connected-accounts',
        },
      ],
    },
    {
      'title': 'Notifications',
      'items': [
        {
          'title': 'Push Notifications',
          'subtitle': 'Receive notifications on your device',
          'icon': LucideIcons.bell,
          'type': 'toggle',
          'key': 'pushNotifications',
        },
        {
          'title': 'Email Notifications',
          'subtitle': 'Get updates via email',
          'icon': LucideIcons.mail,
          'type': 'toggle',
          'key': 'emailNotifications',
        },
        {
          'title': 'Wellness Reminders',
          'subtitle': 'Daily mindfulness and activity prompts',
          'icon': LucideIcons.heart,
          'type': 'toggle',
          'key': 'wellnessReminders',
        },
        {
          'title': 'Notification Settings',
          'subtitle': 'Customize notification preferences',
          'icon': LucideIcons.settings2,
          'type': 'nav',
          'route': '/notification-settings',
        },
      ],
    },
    {
      'title': 'Wellness Preferences',
      'items': [
        {
          'title': 'Dark Mode',
          'subtitle': 'Switch to dark theme',
          'icon': LucideIcons.moon,
          'type': 'toggle',
          'key': 'darkMode',
        },
        {
          'title': 'Meditation Style',
          'subtitle': 'Choose your preferred meditation approach',
          'icon': LucideIcons.brain,
          'type': 'nav',
          'route': '/meditation-style',
          'value': 'Mindfulness',
        },
        {
          'title': 'Wellness Goals',
          'subtitle': 'Set and track your personal goals',
          'icon': LucideIcons.target,
          'type': 'nav',
          'route': '/wellness-goals',
        },
        {
          'title': 'Activity Tracking',
          'subtitle': 'Monitor your daily activities',
          'icon': LucideIcons.activity,
          'type': 'nav',
          'route': '/activity-tracking',
        },
      ],
    },
    {
      'title': 'Privacy & Security',
      'items': [
        {
          'title': 'Data & Analytics',
          'subtitle': 'Help improve app experience',
          'icon': LucideIcons.pieChart,
          'type': 'toggle',
          'key': 'dataAnalytics',
        },
        {
          'title': 'Location Tracking',
          'subtitle': 'Allow location-based features',
          'icon': LucideIcons.mapPin,
          'type': 'toggle',
          'key': 'locationTracking',
        },
        {
          'title': 'Biometric Login',
          'subtitle': 'Use fingerprint or face unlock',
          'icon': LucideIcons.fingerprint,
          'type': 'toggle',
          'key': 'biometricLogin',
        },
        {
          'title': 'Private Profile',
          'subtitle': 'Make your profile private',
          'icon': LucideIcons.eyeOff,
          'type': 'toggle',
          'key': 'privateProfile',
        },
        {
          'title': 'Data Export',
          'subtitle': 'Download your account data',
          'icon': LucideIcons.download,
          'type': 'nav',
          'route': '/data-export',
        },
      ],
    },
    {
      'title': 'Support',
      'items': [
        {
          'title': 'Help Center',
          'subtitle': 'Find answers to common questions',
          'icon': LucideIcons.helpCircle,
          'type': 'nav',
          'route': '/help-center',
        },
        {
          'title': 'Contact Support',
          'subtitle': 'Get in touch with our team',
          'icon': LucideIcons.messageCircle,
          'type': 'nav',
          'route': '/contact-support',
        },
        {
          'title': 'Community Guidelines',
          'subtitle': 'Learn about our community rules',
          'icon': LucideIcons.users,
          'type': 'nav',
          'route': '/community-guidelines',
        },
        {
          'title': 'Terms of Service',
          'subtitle': 'Read our terms and conditions',
          'icon': LucideIcons.fileText,
          'type': 'nav',
          'route': '/terms-of-service',
        },
        {
          'title': 'Privacy Policy',
          'subtitle': 'Understand how we handle your data',
          'icon': LucideIcons.shield,
          'type': 'nav',
          'route': '/privacy-policy',
        },
      ],
    },
  ];

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
            _buildHeader(colorScheme),

            // Settings List
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: _settingsSections.length + 1, // +1 for logout button
                itemBuilder: (context, sectionIndex) {
                  if (sectionIndex == _settingsSections.length) {
                    // Logout button at the end
                    return _buildLogoutSection();
                  }

                  final section = _settingsSections[sectionIndex];
                  final sectionItems = section['items'] as List<Map<String, dynamic>>;

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Section Header
                      _buildSectionHeader(section['title'], colorScheme),

                      // Section Items
                      ...sectionItems.asMap().entries.map((entry) {
                        final index = entry.key;
                        final item = entry.value;
                        final globalIndex = sectionIndex * 100 + index;

                        return _buildSettingsItem(item, globalIndex);
                      }).toList(),

                      const SizedBox(height: 24),
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

  Widget _buildHeader(ColorScheme colorScheme) {
    return Padding(
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
            'Settings',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: colorScheme.onSurface,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title, ColorScheme colorScheme) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: colorScheme.primary,
          letterSpacing: 0.5,
        ),
      ),
    );
  }

  Widget _buildSettingsItem(Map<String, dynamic> item, int index) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final type = item['type'] as String;

    return AnimatedWellnessCard(
      animationDelay: index * 60,
      onTap: type == 'nav' ? () => _handleNavigation(item) : null,
      margin: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          // Icon
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: colorScheme.primary.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(
              item['icon'],
              size: 20,
              color: colorScheme.primary,
            ),
          ),

          const SizedBox(width: 16),

          // Content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      item['title'],
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: colorScheme.onSurface,
                      ),
                    ),
                    if (item['badge'] != null) ...[
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                        decoration: BoxDecoration(
                          color: const Color(0xFF7E6BF2),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          item['badge'],
                          style: const TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
                const SizedBox(height: 2),
                Text(
                  item['subtitle'],
                  style: TextStyle(
                    fontSize: 13,
                    color: colorScheme.onSurface.withValues(alpha: 0.6),
                  ),
                ),
                if (item['value'] != null) ...[
                  const SizedBox(height: 4),
                  Text(
                    item['value'],
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: colorScheme.primary,
                    ),
                  ),
                ],
              ],
            ),
          ),

          // Action (Toggle or Arrow)
          _buildSettingsAction(item, type),
        ],
      ),
    );
  }

  Widget _buildSettingsAction(Map<String, dynamic> item, String type) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    if (type == 'toggle') {
      final key = item['key'] as String;
      final currentValue = _getToggleValue(key);

      return Transform.scale(
        scale: 0.8,
        child: Switch(
          value: currentValue,
          onChanged: (value) => _handleToggleChange(key, value),
          activeColor: Colors.white,
          activeTrackColor: colorScheme.primary,
          inactiveThumbColor: Colors.white,
          inactiveTrackColor: colorScheme.outline.withValues(alpha: 0.3),
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        ),
      );
    } else {
      return Icon(
        LucideIcons.chevronRight,
        size: 16,
        color: colorScheme.onSurface.withValues(alpha: 0.4),
      );
    }
  }

  Widget _buildLogoutSection() {
    return Column(
      children: [
        const SizedBox(height: 16),
        AnimatedWellnessCard(
          animationDelay: 1000,
          onTap: _handleLogout,
          backgroundColor: Colors.red.withValues(alpha: 0.05),
          child: Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.red.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(
                  LucideIcons.logOut,
                  size: 20,
                  color: Colors.red,
                ),
              ),
              const SizedBox(width: 16),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Log Out',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: Colors.red,
                      ),
                    ),
                    SizedBox(height: 2),
                    Text(
                      'Sign out of your account',
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.red,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),
        
        // App Version
        Text(
          'ThriveSpace v1.0.0',
          style: TextStyle(
            fontSize: 12,
            color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.5),
          ),
        ),
        const SizedBox(height: 24),
      ],
    );
  }

  bool _getToggleValue(String key) {
    switch (key) {
      case 'pushNotifications':
        return _pushNotifications;
      case 'emailNotifications':
        return _emailNotifications;
      case 'wellnessReminders':
        return _wellnessReminders;
      case 'darkMode':
        return _darkMode;
      case 'dataAnalytics':
        return _dataAnalytics;
      case 'locationTracking':
        return _locationTracking;
      case 'biometricLogin':
        return _biometricLogin;
      case 'privateProfile':
        return _privateProfile;
      default:
        return false;
    }
  }

  void _handleToggleChange(String key, bool value) {
    setState(() {
      switch (key) {
        case 'pushNotifications':
          _pushNotifications = value;
          break;
        case 'emailNotifications':
          _emailNotifications = value;
          break;
        case 'wellnessReminders':
          _wellnessReminders = value;
          break;
        case 'darkMode':
          _darkMode = value;
          break;
        case 'dataAnalytics':
          _dataAnalytics = value;
          break;
        case 'locationTracking':
          _locationTracking = value;
          break;
        case 'biometricLogin':
          _biometricLogin = value;
          break;
        case 'privateProfile':
          _privateProfile = value;
          break;
      }
    });

    // Show feedback
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${_getSettingTitle(key)} ${value ? 'enabled' : 'disabled'}'),
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 1),
      ),
    );
  }

  String _getSettingTitle(String key) {
    switch (key) {
      case 'pushNotifications':
        return 'Push notifications';
      case 'emailNotifications':
        return 'Email notifications';
      case 'wellnessReminders':
        return 'Wellness reminders';
      case 'darkMode':
        return 'Dark mode';
      case 'dataAnalytics':
        return 'Data analytics';
      case 'locationTracking':
        return 'Location tracking';
      case 'biometricLogin':
        return 'Biometric login';
      case 'privateProfile':
        return 'Private profile';
      default:
        return 'Setting';
    }
  }

  void _handleNavigation(Map<String, dynamic> item) {
    final route = item['route'] as String;
    final title = item['title'] as String;
    
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Opening $title...'),
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 1),
      ),
    );
    
    // In a real app, you would navigate to the actual route:
    // Navigator.of(context).pushNamed(route);
  }

  void _handleLogout() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        final colorScheme = Theme.of(context).colorScheme;
        
        return AlertDialog(
          backgroundColor: colorScheme.surface,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: Text(
            'Log Out',
            style: TextStyle(
              fontWeight: FontWeight.w600,
              color: colorScheme.onSurface,
            ),
          ),
          content: Text(
            'Are you sure you want to log out of your ThriveSpace account?',
            style: TextStyle(
              color: colorScheme.onSurface.withValues(alpha: 0.8),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(
                'Cancel',
                style: TextStyle(
                  color: colorScheme.onSurface.withValues(alpha: 0.7),
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                // In a real app, handle actual logout
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Logged out successfully'),
                    behavior: SnackBarBehavior.floating,
                  ),
                );
              },
              child: const Text(
                'Log Out',
                style: TextStyle(
                  color: Colors.red,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}