import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';

class ExploreScreen extends StatefulWidget {
  const ExploreScreen({super.key});

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Explore'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // Search Bar
              Container(
                decoration: BoxDecoration(
                  color: colorScheme.surface,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: colorScheme.outline.withOpacity(0.2),
                  ),
                ),
                child: TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    hintText: 'Search wellness content...',
                    prefixIcon: const Icon(LucideIcons.search),
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.all(16),
                  ),
                ),
              ),
              
              const SizedBox(height: 24),
              
              // Categories Grid
              Expanded(
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    childAspectRatio: 1.2,
                  ),
                  itemCount: _categories.length,
                  itemBuilder: (context, index) {
                    final category = _categories[index];
                    return _buildCategoryCard(category);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCategoryCard(ExploreCategory category) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Card(
      child: InkWell(
        onTap: () {
          // Navigate to category content
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('${category.title} - Coming Soon!')),
          );
        },
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: colorScheme.primary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  category.icon,
                  size: 24,
                  color: colorScheme.primary,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                category.title,
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 4),
              Text(
                category.subtitle,
                style: theme.textTheme.bodySmall,
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ExploreCategory {
  final String title;
  final String subtitle;
  final IconData icon;

  ExploreCategory({
    required this.title,
    required this.subtitle,
    required this.icon,
  });
}

final List<ExploreCategory> _categories = [
  ExploreCategory(
    title: 'Meditation',
    subtitle: 'Mindfulness & peace',
    icon: LucideIcons.brain,
  ),
  ExploreCategory(
    title: 'Fitness',
    subtitle: 'Workouts & movement',
    icon: LucideIcons.dumbbell,
  ),
  ExploreCategory(
    title: 'Nutrition',
    subtitle: 'Healthy eating habits',
    icon: LucideIcons.apple,
  ),
  ExploreCategory(
    title: 'Sleep',
    subtitle: 'Rest & recovery',
    icon: LucideIcons.moon,
  ),
  ExploreCategory(
    title: 'Mindfulness',
    subtitle: 'Present moment awareness',
    icon: LucideIcons.heart,
  ),
  ExploreCategory(
    title: 'Community',
    subtitle: 'Connect with others',
    icon: LucideIcons.users,
  ),
];