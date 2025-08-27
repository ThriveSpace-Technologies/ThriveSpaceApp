# ThriveSpace Animated Components

A collection of beautifully animated Flutter widgets designed for the ThriveSpace wellness app. These components provide smooth, professional micro-interactions that align with the calming wellness brand.

## 🎯 Design Philosophy

- **Calm & Professional**: Soft easing curves and gentle transitions
- **Wellness-Focused**: Animations that feel meditative and peaceful
- **Material 3 Compatible**: Full support for light and dark themes
- **Consistent**: Unified animation constants across all components

## 🎨 Animation System

### Animation Constants (`WellnessAnimations`)
- **Durations**: From `quickFade` (150ms) to `meditative` (600ms)
- **Easing Curves**: `gentleEase`, `smoothEase`, `calmEase`, `breathingEase`
- **Scale Values**: Subtle press feedback (0.95x scale)
- **Glow Effects**: Adaptive for light (shadows) and dark (glow) modes

## 🧩 Available Components

### 1. AnimatedWellnessButton
Buttons with smooth press animations and hover effects.

```dart
AnimatedWellnessButton(
  onPressed: () => print('Tapped!'),
  child: Text('Get Started'),
  backgroundColor: colorScheme.primary,
  borderRadius: BorderRadius.circular(16),
)
```

**Features:**
- Press scale animation (0.95x)
- Hover glow effects
- Adaptive shadows/glows for light/dark themes
- Smooth color transitions

### 2. AnimatedWellnessTextField
Input fields with focus states and error animations.

```dart
AnimatedWellnessTextField(
  controller: emailController,
  labelText: 'Email',
  hintText: 'Enter your email',
  prefixIcon: LucideIcons.mail,
  hasError: hasValidationError,
  errorText: 'Please enter a valid email',
)
```

**Features:**
- Focus state with accent border glow
- Shake animation for errors
- Smooth color transitions
- Floating label animation

### 3. AnimatedWellnessCard
Cards with entrance animations and tap effects.

```dart
AnimatedWellnessCard(
  animationDelay: index * 100, // Staggered animation
  onTap: () => navigateToDetail(),
  enableRipple: true,
  child: YourCardContent(),
)
```

**Features:**
- Slide-up entrance animation
- Hover elevation effects
- Ripple tap feedback
- Staggered list animations

### 4. AnimatedBottomNavigation
Bottom navigation with smooth tab transitions.

```dart
AnimatedBottomNavigation(
  currentIndex: selectedIndex,
  onTap: (index) => setState(() => selectedIndex = index),
  items: [
    BottomNavItem(icon: LucideIcons.home, label: 'Home'),
    BottomNavItem(icon: LucideIcons.search, label: 'Explore'),
    // ... more items
  ],
)
```

**Features:**
- Tab press animations
- Active state transitions
- Smooth icon and label color changes
- Subtle background highlights

### 5. AnimatedTopTabBar
Top tab bar with sliding indicator.

```dart
AnimatedTopTabBar(
  tabs: ['For You', 'Following', 'Wellness News'],
  currentIndex: tabController.index,
  onTap: (index) => tabController.animateTo(index),
)
```

**Features:**
- Sliding underline indicator
- Smooth tab transitions
- Color interpolation for active states

### 6. Progress Animations

#### Circular Progress
```dart
AnimatedCircularProgress(
  progress: 0.75,
  size: 120,
  animationDuration: Duration(milliseconds: 1200),
  center: Text('75%'),
)
```

#### Linear Progress
```dart
AnimatedLinearProgress(
  progress: 0.6,
  height: 8,
  borderRadius: BorderRadius.circular(4),
)
```

**Features:**
- Smooth progress animations from 0% to target
- Customizable duration and easing
- Auto-start or manual trigger
- Progress completion callbacks

### 7. Message Animations

#### Message Bubbles
```dart
AnimatedMessageBubble(
  message: 'Hello! How are you feeling today?',
  senderName: 'Wellness Coach',
  isMe: false,
  animationDelay: index * 100,
)
```

#### Message Notifications
```dart
AnimatedMessageNotification(
  message: 'You have a new meditation reminder',
  senderName: 'ThriveSpace',
  onTap: () => openNotification(),
  onDismiss: () => dismissNotification(),
)
```

**Features:**
- Slide-in from appropriate direction
- Gentle breathing pulse for notifications
- Smooth dismiss animations

## 🎛️ Customization

### Light vs Dark Mode Behavior

The animation system automatically adapts for theme brightness:

**Light Mode:**
- Soft shadows for depth
- Subtle color transitions
- Clean, minimal effects

**Dark Mode:**
- Glowing accents instead of shadows
- Higher contrast transitions
- Luminous feedback effects

### Animation Timing

All animations use wellness-focused timing:
- **Quick feedback**: 100-200ms for button presses
- **Smooth transitions**: 250-350ms for state changes
- **Gentle entrances**: 400-600ms for card animations
- **Meditative progress**: 800-1200ms for charts

### Custom Curves

Special easing curves designed for wellness:
- `breathingEase`: Sine-based for breathing-like animations
- `gentleBounce`: Soft elastic for notifications
- `mindfulEase`: Circular easing for meditation timers
- `progressiveReveal`: Exponential for content reveals

## 🚀 Usage Tips

1. **Stagger List Animations**: Use `animationDelay: index * 100` for lists
2. **Batch State Changes**: Group related animations together
3. **Respect Motion Preferences**: Components automatically handle `prefers-reduced-motion`
4. **Theme-Aware Colors**: Use `colorScheme` colors for automatic theme support

## 🎯 Performance

- All animations use `vsync` for 60fps performance
- Minimal memory footprint with proper dispose patterns
- GPU-accelerated transforms where possible
- Optimized for smooth scrolling during animations

## 📱 Accessibility

- Screen reader friendly
- Respects system motion preferences
- High contrast mode support
- Touch target sizes meet accessibility guidelines (44px minimum)

---

*These animated components create a cohesive, calming user experience that reinforces ThriveSpace's focus on mindful wellness.*