# ThriveSpace Navigation & Home Feed Design
*Professional, Minimal, Calming Wellness App Interface*

## 🏠 Home Feed Overview

The home feed is ThriveSpace's central hub where users discover wellness content, connect with community, and track their mindfulness journey. The design prioritizes calm consumption of meaningful content over endless scrolling.

### Core Principles
- **Purposeful Content**: Quality over quantity in feed curation
- **Breathing Space**: Generous margins prevent visual overwhelm  
- **Mindful Interactions**: Thoughtful engagement over addictive patterns
- **Community Focus**: Human connections in wellness journey

---

## 🧭 Main Navigation System

### Navigation Architecture
```
Bottom Navigation (Primary)
├─ Home (Feed & Overview)
├─ Explore (Discover Content) 
├─ Learn (Courses & Articles)
├─ Journey (Personal Progress)
└─ Profile (Settings & Account)

Top Navigation (Contextual)
├─ Screen Titles
├─ Search (when applicable)
├─ Notifications
└─ Quick Actions
```

### Bottom Navigation Specifications

#### Visual Design
```css
Container:
├─ Height: 80px (including safe area)
├─ Background: Surface color with 95% opacity + blur
├─ Border Top: 0.5px outline color (10% opacity)
├─ Shadow Light: 0 -2px 8px rgba(0,0,0,0.05)
├─ Shadow Dark: 0 -2px 8px rgba(0,0,0,0.15)
└─ Safe Area: Automatic bottom padding

Tab Items (5 total):
├─ Size: Equal width distribution
├─ Touch Target: 44×44px minimum
├─ Icon Size: 22×22px (Lucide Icons)
├─ Label: 11px SF Pro Text Medium
├─ Spacing: 4px between icon and label
└─ Active Indicator: Background highlight + primary color
```

#### Navigation Items
```css
Home Tab:
├─ Icon: Home (filled when active)
├─ Label: "Home"
├─ Active Color: Primary (#3AAFA9)
└─ Badge: Notification count (red dot)

Explore Tab:
├─ Icon: Compass  
├─ Label: "Explore"
├─ Active Color: Primary
└─ Feature: Discovery pulse animation

Learn Tab:  
├─ Icon: Book Open
├─ Label: "Learn"
├─ Active Color: Secondary Purple (#7E6BF2)
└─ Badge: New content indicator

Journey Tab:
├─ Icon: Target (or Trending Up)
├─ Label: "Journey" 
├─ Active Color: Success Green (#4CAF50)
└─ Feature: Progress ring animation

Profile Tab:
├─ Icon: User Circle
├─ Label: "Profile"
├─ Active Color: Primary
└─ Avatar: User profile image (when signed in)
```

#### Animation Behavior
```css
Tab Selection:
├─ Scale Animation: 0.9x press → 1.0x release (150ms)
├─ Color Transition: 200ms ease-out
├─ Background Highlight: Fade in primary color (10% opacity)
├─ Icon Transition: Outline → Filled variant
└─ Haptic Feedback: Light impact on selection

Tab Indicator:
├─ Background: Primary color (10% opacity)
├─ Border Radius: 12px  
├─ Size: Icon + label + 16px padding
├─ Animation: Scale from center (200ms gentle ease)
└─ Persistence: Maintains state across app usage
```

---

## 📱 Home Feed Design

### Feed Layout Structure
```
[Top Navigation Bar - 100px]
├─ Profile Avatar (tap for profile)
├─ App Title: "ThriveSpace" (center)
├─ Notification Bell + Theme Toggle
└─ Search Bar (expandable)

[Feed Filter Tabs - 48px]  
├─ "For You" (AI curated)
├─ "Following" (Subscribed creators)
├─ "Wellness News" (Articles & updates)
└─ Sliding indicator animation

[Content Feed - Infinite scroll]
├─ Wellness Posts (various types)
├─ Community Interactions  
├─ Progress Celebrations
├─ Learning Recommendations
└─ Mindful Moments (break suggestions)

[Floating Action - 56px FAB]
├─ Create Post/Share Moment
├─ Quick Journal Entry  
└─ Start Meditation Session
```

### Top Navigation Bar

#### Header Design
```css
Navigation Bar:
├─ Height: 100px (including safe area)
├─ Background: Scaffold color with 95% opacity
├─ Border Bottom: 0.5px outline (5% opacity)
├─ Blur Effect: System background material
└─ Dynamic Shadow: Appears on scroll

Profile Section (Left):
├─ Avatar: 40×40px circle with border
├─ Border: Primary color (20% opacity, 1px)
├─ Placeholder: Initials on colored background
├─ Online Status: Green dot (optional)
└─ Tap: Navigate to full profile

Title Section (Center):
├─ Text: "ThriveSpace" 20px SF Pro Display Semibold
├─ Color: Primary text
├─ Fade Animation: Appears/disappears with scroll
└─ Tap: Scroll to top (iOS standard)

Actions Section (Right):
├─ Theme Toggle: Sun/Moon icon (20px)
├─ Notifications: Bell icon with badge
├─ Search: Magnifying glass (expandable)
└─ Spacing: 8px between actions
```

#### Search Functionality
```css
Search Bar (Collapsed):
├─ Icon: Search (20×20px)
├─ Background: Surface color
├─ Size: 36×36px circle
├─ Border Radius: 18px
└─ Tap Animation: Scale 0.95x

Search Bar (Expanded):
├─ Width: Full navigation width - 80px
├─ Height: 40px
├─ Background: Surface color  
├─ Border: 1px outline (10% opacity)
├─ Border Radius: 20px
├─ Placeholder: "Search wellness content..."
├─ Font: 16px SF Pro Text Regular
├─ Clear Button: X icon on right
└─ Animation: Smooth width expansion (300ms)
```

### Feed Filter Tabs

#### Tab Bar Design
```css
Tab Container:
├─ Height: 48px
├─ Background: Transparent
├─ Border Bottom: 0.5px outline (5% opacity)
├─ Horizontal Padding: 16px
└─ Scroll: Horizontal when needed

Individual Tabs:
├─ Padding: 12px 20px vertical, horizontal
├─ Font: 14px SF Pro Text Medium  
├─ Active Color: Primary
├─ Inactive Color: Secondary text (60% opacity)
├─ Underline: 2px primary color (active only)
├─ Min Width: Fit content + 20px
└─ Touch Target: Full tab area

Sliding Indicator:
├─ Height: 2px
├─ Color: Primary
├─ Border Radius: 1px
├─ Position: Bottom of active tab
├─ Animation: 300ms ease-out slide
└─ Width: Match active tab text width
```

### Content Feed Cards

#### Standard Post Card
```css
Card Container:
├─ Background: Surface color
├─ Margin: 16px horizontal, 8px vertical
├─ Border Radius: 16px  
├─ Shadow Light: 0 1px 3px rgba(0,0,0,0.1)
├─ Shadow Dark: 0 1px 3px rgba(0,0,0,0.3) + border
├─ Padding: 16px
└─ Max Width: Screen width - 32px

Post Header:
├─ User Avatar: 40×40px circle
├─ Username: 16px SF Pro Text Semibold
├─ Handle + Timestamp: 14px Regular, 60% opacity
├─ More Menu: Three dots (vertical)
├─ Verification Badge: If applicable
└─ Layout: Avatar left, text center, menu right

Content Area:
├─ Text: 16px SF Pro Text Regular
├─ Line Height: 1.5
├─ Max Lines: Expandable with "Read more"
├─ Links: Primary color, underlined
├─ Hashtags: Primary color, clickable
├─ Mentions: Primary color, clickable
└─ Spacing: 12px below header

Media Attachment (if present):
├─ Border Radius: 12px
├─ Max Height: 300px  
├─ Aspect Ratio: Preserved
├─ Loading: Skeleton placeholder
├─ Error: Retry button with error icon
├─ Tap: Full screen view
└─ Multiple: Carousel with dots

Interaction Bar:
├─ Height: 44px (touch target)
├─ Spacing: 16px between actions
├─ Icons: 20×20px Lucide icons
├─ Colors: 60% opacity when inactive
├─ Layout: Like, Comment, Share (left), Save (right)
└─ Animations: Heart fill, counter updates
```

#### Wellness Moment Card
```css
Moment Card (Special Format):
├─ Background: Gradient based on mood/category
├─ Text Color: White or high contrast
├─ Icon: Wellness category (meditation, exercise, etc.)
├─ Quote/Tip: Centered, larger font (18px)
├─ Author: Small attribution at bottom
├─ Action: "Try this practice" button
└─ Theme: Calming colors, soft shadows
```

#### Progress Celebration Card  
```css
Achievement Card:
├─ Background: Success color gradient (10% opacity)
├─ Border: Success color (20% opacity)
├─ Icon: Trophy, star, or milestone badge
├─ Headline: "Great progress!" or custom message
├─ Metric: Days streaked, goals reached, etc.
├─ Encouragement: Personal motivational message
├─ Action: "View journey" or "Share achievement"
└─ Animation: Gentle pulse on appearance
```

### Content Types & Mix

#### Feed Algorithm Approach
```
Content Distribution (For You tab):
├─ Personal Progress: 20% (your achievements, reminders)
├─ Community Posts: 40% (following + recommended users)
├─ Educational Content: 25% (articles, tips, courses)
├─ Wellness Moments: 10% (inspirational quotes, practices)  
└─ Sponsored Content: 5% (relevant wellness brands)

Content Prioritization:
├─ Engagement Quality: Comments over likes
├─ Time Relevance: Recent but not exclusively
├─ Personal Relevance: Based on interests/goals
├─ Diversity: Varied content types and creators
└─ Well-being: Positive, uplifting content bias
```

### Floating Action Button

#### FAB Design
```css
Primary FAB:
├─ Size: 56×56px  
├─ Background: Primary color (#3AAFA9)
├─ Icon: Plus (24×24px white)
├─ Position: Bottom right, 16px from edges
├─ Elevation: 8dp (Material standard)
├─ Shadow: 0 4px 12px rgba(58,175,169,0.3)
├─ Press: Scale 0.9x + deeper color
└─ Hold: Expand to show quick actions

Quick Actions (on hold):
├─ "Share Moment" - Camera icon
├─ "Write Journal" - Edit icon  
├─ "Start Practice" - Play icon
├─ Layout: Vertical fan-out above FAB
├─ Animation: Scale + fade in sequence
└─ Backdrop: Dim overlay for focus
```

---

## 🎭 Animation & Micro-interactions

### Feed Interactions
```css
Card Entrance:
├─ Animation: Slide up 20px + fade in
├─ Duration: 400ms
├─ Easing: Gentle ease-out
├─ Stagger: 100ms between cards
└─ Trigger: On scroll into view

Pull to Refresh:
├─ Indicator: Custom ThriveSpace logo spin
├─ Color: Primary with gradient
├─ Duration: 800ms for full rotation
├─ Haptic: Light feedback on trigger
└─ Success: Brief checkmark confirmation

Like Animation:
├─ Heart Icon: Scale 1.2x + fill transition
├─ Duration: 200ms  
├─ Counter: Number count-up animation
├─ Color: Red for liked state
├─ Haptic: Light tap feedback
└─ Undo: Reverse animation on double-tap

Share Action:
├─ Icon: Brief scale pulse
├─ Sheet: Slide up from bottom
├─ Options: Native iOS share sheet
├─ Background: Blur overlay
└─ Dismiss: Swipe down or tap outside

Infinite Scroll:
├─ Trigger: 200px from bottom
├─ Loading: Skeleton cards (3-4)
├─ Animation: Fade in new content
├─ Error: Retry button with message
└─ End: "You're all caught up!" message
```

### Navigation Transitions
```css
Tab Switching:
├─ Content: Fade out → Fade in (200ms)
├─ Tab Indicator: Slide animation (300ms)
├─ Loading: Skeleton placeholder during fetch
├─ Haptic: Light selection feedback
└─ State: Preserve scroll position per tab

Screen Navigation:
├─ Forward: Slide from right (iOS standard)
├─ Back: Slide to right + fade
├─ Duration: 300ms
├─ Easing: iOS cubic bezier
└─ Concurrent: Tab bar remains visible

Search Expansion:
├─ Icon → Bar: Scale + width animation (300ms)
├─ Focus: Keyboard slides up
├─ Results: Fade in below search bar
├─ Cancel: Collapse + clear results
└─ Background: Slight dim on overlay content
```

---

## 🌗 Dark Mode Specifications

### Dark Mode Color Mapping
```css
Navigation Dark Mode:
├─ Background: #1C1C1E (Rich black avoided)
├─ Surface: #2C2C2E (Cards, elevated elements)
├─ Primary Text: #F5F5F7 (Soft white)
├─ Secondary Text: #8E8E93 (Apple gray)
├─ Borders: #38383A (Subtle dividers)
├─ Active States: #4DB8B3 (Brightened primary)
└─ Shadows: Replaced with colored glows

Feed Cards Dark Mode:
├─ Card Background: #2C2C2E
├─ Card Border: 1px #38383A (subtle definition)
├─ Text Primary: #F5F5F7
├─ Text Secondary: #8E8E93
├─ Media Overlay: Enhanced contrast
├─ Action Icons: Higher contrast when inactive
└─ Liked State: More vibrant colors
```

### Dark Mode Enhancements  
```css
Special Dark Features:
├─ Logo Glow: Subtle teal luminescence
├─ Active Tab: Enhanced glow instead of shadow
├─ Media: Brightness boost for better visibility  
├─ FAB Glow: Primary color glow effect
├─ Search Focus: Enhanced outline glow
├─ Success States: Brighter green feedback
└─ Loading States: Lighter skeleton colors
```

---

## ♿ Accessibility Implementation

### Screen Reader Support
```css
Semantic Structure:
├─ Navigation: Proper landmark roles
├─ Feed: Article structure for posts  
├─ Headings: H1-H6 hierarchy maintained
├─ Lists: Proper list markup for feed
├─ Images: Descriptive alt text
├─ Actions: Clear button labels
└─ State: Live regions for updates

Voice Control:
├─ All buttons: Voice-controllable names
├─ Navigation: "Tap Home", "Tap Explore", etc.
├─ Actions: "Like post", "Share moment", etc.
├─ Search: "Search wellness content"
└─ Content: Readable post text and metadata
```

### Motor Accessibility
```css
Touch Targets:
├─ Minimum: 44×44px for all interactive elements
├─ Navigation Tabs: Full tab width + height
├─ Post Actions: Generous tap areas
├─ FAB: Standard 56px Material size
├─ Search: Expandable for easier interaction
└─ Scrolling: Smooth, controlled momentum

Gesture Alternatives:
├─ All swipe actions have button equivalents
├─ Pull-to-refresh has manual refresh button
├─ Pinch-to-zoom not required for readability
├─ Long press actions also available via menu
└─ Shake gestures have alternative triggers
```

### Visual Accessibility
```css
High Contrast Support:
├─ All text: WCAG AA compliant contrast ratios
├─ Interactive elements: Clear focus indicators
├─ Status indicators: Not color-dependent
├─ Progress: Numerical values alongside visual
├─ Errors: Icons + text descriptions
├─ Success: Multi-modal feedback
└─ Navigation: Clear visual hierarchy

Dynamic Type:
├─ All text: Scales with iOS text size settings
├─ Layout: Adapts to larger text sizes
├─ Icons: Maintain proportion with text
├─ Touch targets: Scale appropriately
├─ Content: Readable at all supported sizes
└─ Navigation: Maintains usability when scaled
```

---

## 📊 Performance Considerations

### Optimization Strategies
```css
Image Loading:
├─ Lazy Loading: Off-screen images load on demand
├─ Progressive: Low quality → High quality
├─ Caching: Aggressive caching of profile images
├─ Compression: WebP format when supported
├─ Placeholder: Skeleton or blur during load
└─ Error Handling: Graceful fallbacks

Memory Management:
├─ Feed Recycling: Reuse cells for smooth scrolling
├─ Image Cache: Limit and LRU eviction
├─ Video: Pause off-screen videos
├─ Network: Cancel requests for off-screen content
├─ Data: Paginate and manage feed history
└─ Cleanup: Dispose unused resources

Battery Optimization:
├─ Animations: Respect reduce motion settings
├─ Background: Minimal processing when backgrounded
├─ Location: Only when necessary for features
├─ Network: Batch requests and use caching
├─ Dark Mode: True black pixels on OLED displays
└─ Refresh: Intelligent refresh intervals
```

### Loading States
```css
Initial Load:
├─ Skeleton Cards: 3-4 placeholder cards
├─ Navigation: Immediately available
├─ Shimmer: Subtle animation on placeholders  
├─ Duration: Typically 1-2 seconds
└─ Fallback: Retry mechanism for failures

Content Loading:
├─ Infinite Scroll: Skeleton cards at bottom
├─ Images: Progressive blur-to-sharp
├─ Videos: Poster frame → Loading → Play
├─ Text: Immediate display, format on load
└─ Actions: Available immediately after content

Error States:
├─ Network: "Check your connection" with retry
├─ Server: "Something went wrong" with retry  
├─ Empty Feed: "No posts yet" with suggestions
├─ Search: "No results found" with tips
└─ General: Friendly error messages with help
```

---

*This navigation and home feed design creates a calming, purposeful space for mindful wellness engagement while maintaining familiar iOS interaction patterns.*