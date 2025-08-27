# ThriveSpace – Complete Mobile UI/UX Design System
*Professional, Minimal, Calming Wellness App for iOS*

## 🎯 Design Philosophy

ThriveSpace embodies **mindful minimalism** – every element serves a purpose in supporting users' wellness journey. The design language prioritizes **calm over flashy**, **purposeful over decorative**, and **accessible over impressive**.

### Core Principles
- **Breathe**: Generous whitespace that lets content breathe
- **Focus**: Clear visual hierarchy guides attention
- **Calm**: Muted tones and gentle animations reduce stress
- **Trust**: Professional aesthetics build credibility
- **Inclusive**: Accessible to all users across abilities

---

## 🎨 Color System

### Primary Palette
```css
/* Primary Accent - Muted Teal */
Light: #3AAFA9 (Calming, trustworthy)
Dark: #4DB8B3 (Slightly brighter for visibility)
Usage: Primary buttons, active states, progress indicators

/* Secondary Accent - Gentle Purple */
Light: #7E6BF2 (Inspirational, creative)
Dark: #8C7BF4 (Enhanced visibility)
Usage: Secondary actions, highlights, premium features

/* Success - Muted Green */
Light: #4CAF50 (Achievement, growth)
Dark: #30D158 (iOS system green)

/* Warning - Soft Amber */
Light: #FF9800 (Gentle attention)
Dark: #FFD60A (iOS system amber)

/* Error - Muted Red */
Light: #E57373 (Non-aggressive)
Dark: #FF6B6B (Soft but visible)
```

### Neutral Scale
```css
/* Light Mode Backgrounds */
Background: #F9FAFB (Soft, warm white)
Surface: #FFFFFF (Pure white cards)
Border: #E5E7EB (Subtle divisions)

/* Dark Mode Backgrounds */
Background: #1C1C1E (Deep charcoal)
Surface: #2C2C2E (Elevated charcoal)
Border: #38383A (Subtle divisions)

/* Text Colors */
Light Mode:
  Primary: #1A1A1A (High contrast)
  Secondary: #6B7280 (Readable gray)
  Tertiary: #9CA3AF (Subtle text)

Dark Mode:
  Primary: #F5F5F7 (Soft white)
  Secondary: #8E8E93 (Muted light gray)
  Tertiary: #6D6D70 (Subdued text)
```

### Color Usage Guidelines
- **60-30-10 Rule**: 60% neutrals, 30% primary, 10% accent
- **Accessibility**: All text meets WCAG AA standards (4.5:1 minimum)
- **Emotional Mapping**: Cool tones for calm, warm accents for energy

---

## 📝 Typography System

### Font Stack
```css
Primary: -apple-system, BlinkMacSystemFont, "SF Pro Display"
Fallback: "Inter", "Segoe UI", Roboto, sans-serif
```

### Typography Scale
```css
/* Display Text - Hero Headlines */
Size: 28px (1.75rem)
Weight: 700 (Bold)
Line Height: 1.2
Letter Spacing: -0.02em
Usage: Welcome screens, major headings

/* Heading 1 - Screen Titles */
Size: 24px (1.5rem)
Weight: 600 (Semibold)
Line Height: 1.3
Usage: Screen titles, section headers

/* Heading 2 - Card Titles */
Size: 20px (1.25rem)
Weight: 600 (Semibold)
Line Height: 1.4
Usage: Card headers, feature titles

/* Heading 3 - Component Titles */
Size: 18px (1.125rem)
Weight: 500 (Medium)
Line Height: 1.4
Usage: List headers, form sections

/* Body Large - Primary Content */
Size: 16px (1rem)
Weight: 400 (Regular)
Line Height: 1.6
Usage: Main content, descriptions

/* Body Medium - Secondary Content */
Size: 14px (0.875rem)
Weight: 400 (Regular)
Line Height: 1.5
Usage: Meta information, captions

/* Body Small - Support Text */
Size: 12px (0.75rem)
Weight: 400 (Regular)
Line Height: 1.4
Usage: Timestamps, helper text

/* Caption - Fine Print */
Size: 11px (0.6875rem)
Weight: 300 (Light)
Line Height: 1.3
Usage: Legal text, micro-copy
```

### Typography Guidelines
- **Hierarchy**: Maximum 3 font sizes per screen
- **Contrast**: Minimum 4.5:1 for body text, 3:1 for large text
- **Readability**: 45-75 characters per line optimal
- **Spacing**: 1.5x font size minimum line height

---

## 🧩 Component Library

### Buttons

#### Primary Button
```css
Style: Filled
Background: Primary color (#3AAFA9)
Text: White
Border Radius: 12px
Padding: 12px 24px (vertical, horizontal)
Font: 16px, Medium (500)
Shadow: 0 2px 8px rgba(58, 175, 169, 0.15)
Hover: Darker shade + increased shadow
Press: Scale 0.95x + darker shade
```

#### Secondary Button
```css
Style: Outlined
Background: Transparent
Border: 1.5px solid primary
Text: Primary color
Border Radius: 12px
Padding: 12px 24px
Font: 16px, Medium (500)
Hover: Light primary background (10% opacity)
Press: Scale 0.95x + background tint
```

#### Tertiary Button
```css
Style: Text only
Background: Transparent
Text: Primary color
Font: 16px, Medium (500)
Padding: 8px 16px
Hover: Light background (5% opacity)
Press: Scale 0.95x
```

### Input Fields
```css
Background: Surface color
Border: 1px solid border color
Border Radius: 16px
Padding: 16px
Font Size: 16px (prevents zoom on iOS)
Placeholder: Tertiary text color
Icon: 20px, secondary text color

States:
  Default: Border color
  Focus: Primary color border + subtle glow
  Error: Error color border + shake animation
  Disabled: Reduced opacity (0.6)
```

### Cards
```css
Background: Surface color
Border Radius: 16px
Padding: 16px minimum
Shadow Light: 0 1px 3px rgba(0,0,0,0.1)
Shadow Dark: 0 1px 3px rgba(0,0,0,0.3)
Border: Optional 1px in dark mode

Hover: Slight elevation increase
Press: Scale 0.98x + ripple effect
```

### Navigation

#### Bottom Navigation
```css
Background: Surface with 95% opacity + blur
Height: 80px (including safe area)
Icon Size: 22px
Active Color: Primary
Inactive Color: Secondary text
Border Top: 0.5px border color

Animation: Scale 0.9x on press + color transition
```

#### Top Navigation
```css
Background: Transparent
Title: Heading 2 style, center aligned
Back Button: 20px icon + "Back" label
Action Buttons: 20px icons, right aligned
Shadow: Dynamic based on scroll position
```

### Tabs
```css
Style: Underline indicator
Height: 48px
Text: 14px Medium
Active: Primary color + 2px underline
Inactive: Secondary text color
Indicator: Smooth slide animation (300ms)
```

---

## 📐 Spacing & Layout

### Spacing Scale
```css
xs: 4px    /* Fine adjustments */
sm: 8px    /* Small gaps */
md: 16px   /* Standard spacing */
lg: 24px   /* Section spacing */
xl: 32px   /* Major sections */
2xl: 48px  /* Page-level spacing */
3xl: 64px  /* Hero sections */
```

### Layout Grid
```css
Container Max Width: 428px (iPhone 14 Pro Max)
Horizontal Padding: 16px minimum
Vertical Rhythm: 8px baseline grid
Content Areas: 16px padding
Card Margins: 16px horizontal, 8px vertical
```

### Safe Areas
- **Top**: Dynamic island + status bar
- **Bottom**: Home indicator + 16px padding
- **Sides**: 16px minimum (respects notches)

---

## 🎭 Elevation & Shadows

### Light Mode Shadows
```css
Level 1 (Cards): 0 1px 3px rgba(0,0,0,0.1)
Level 2 (Modals): 0 4px 12px rgba(0,0,0,0.15)
Level 3 (Floating): 0 8px 25px rgba(0,0,0,0.15)
```

### Dark Mode Shadows
```css
Level 1: 0 1px 3px rgba(0,0,0,0.3)
Level 2: 0 4px 12px rgba(0,0,0,0.4)
Level 3: 0 8px 25px rgba(0,0,0,0.5)
+ Primary color glow for interactive elements
```

---

## 🎬 Animation System

### Timing Functions
```css
Gentle: cubic-bezier(0.25, 0.46, 0.45, 0.94)  /* Ease-out-cubic */
Smooth: cubic-bezier(0.4, 0, 0.2, 1)          /* Material easing */
Bounce: cubic-bezier(0.68, -0.55, 0.265, 1.55) /* Gentle bounce */
Breathing: cubic-bezier(0.37, 0, 0.63, 1)      /* Sine-like */
```

### Duration Scale
```css
Instant: 100ms    /* Feedback */
Quick: 200ms      /* State changes */
Smooth: 300ms     /* Transitions */
Gentle: 400ms     /* Entrances */
Slow: 600ms       /* Page transitions */
```

### Micro-interactions
- **Button Press**: Scale 0.95x (100ms) → Return (200ms)
- **Tab Switch**: Slide indicator (300ms) + fade content (200ms)
- **Card Entrance**: Fade up 20px (400ms) staggered by 100ms
- **Input Focus**: Border color + glow (200ms)
- **Error State**: Shake 4px left-right (400ms)
- **Success**: Gentle scale pulse 1.02x (600ms)

---

## 📱 Screen Specifications

### Target Devices
- iPhone 12/13/14 (390x844)
- iPhone 12/13/14 Plus (428x926)
- iPhone 12/13/14 Pro Max (428x926)

### Design Constraints
- **Minimum Touch Target**: 44x44px
- **Text Size**: 16px minimum for body text
- **Contrast Ratio**: 4.5:1 minimum for normal text
- **Animation**: Respects `prefers-reduced-motion`

---

## ♿ Accessibility Guidelines

### Visual
- **Color Contrast**: WCAG AA compliant
- **Focus Indicators**: Clear 2px outline
- **Text Size**: Supports Dynamic Type
- **Color Independence**: Information not color-dependent

### Motor
- **Touch Targets**: 44px minimum
- **Gesture Alternatives**: All gestures have button alternatives
- **Timeout**: Extended for form completion

### Cognitive
- **Clear Hierarchy**: Logical tab order
- **Error Prevention**: Inline validation
- **Help Text**: Available for complex interactions
- **Progress Indicators**: For multi-step processes

---

## 🌗 Dark Mode Implementation

### Automatic Adaptation
- **System Detection**: Follows iOS setting
- **Manual Override**: User preference stored
- **Smooth Transition**: 300ms color interpolation

### Color Mapping
```css
Light → Dark Mappings:
Background (#F9FAFB) → (#1C1C1E)
Surface (#FFFFFF) → (#2C2C2E)
Primary Text (#1A1A1A) → (#F5F5F7)
Secondary Text (#6B7280) → (#8E8E93)
Border (#E5E7EB) → (#38383A)

Accent Colors:
Primary Teal (#3AAFA9) → (#4DB8B3)
Secondary Purple (#7E6BF2) → (#8C7BF4)
```

### Dark Mode Principles
- **Preserve Brand**: Accent colors remain recognizable
- **Reduce Eye Strain**: Lower luminance overall
- **Maintain Contrast**: Text remains highly readable
- **Subtle Glows**: Replace shadows with colored glows

---

*This design system ensures consistency, accessibility, and a calming user experience across all ThriveSpace interfaces.*