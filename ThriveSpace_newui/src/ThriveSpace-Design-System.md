# ThriveSpace Design System
*Professional, Minimal, Calming Wellness App Design*

## Overview
ThriveSpace uses a professional, minimal design system optimized for iOS that feels calming and trustworthy. The system prioritizes clarity, accessibility, and emotional well-being through thoughtful color choices, clean typography, and generous spacing.

## Design Principles
- **Professional & Trustworthy**: Clean, reliable design that users can trust with their wellness journey
- **Minimal & Focused**: Stripped of unnecessary elements to reduce cognitive load
- **Calming & Peaceful**: Colors and spacing that promote relaxation and mindfulness
- **Accessible & Inclusive**: Design that works for all users across light and dark modes

---

## 1. Color System

### Primary Colors
```css
/* Muted Teal - Primary Accent */
Light Mode: #3AAFA9
Dark Mode: #4DB8B3
Usage: Primary buttons, navigation highlights, progress indicators
```

```css
/* Gentle Purple - Secondary Accent */
Light Mode: #7E6BF2
Dark Mode: #8C7BF4
Usage: Secondary actions, feature highlights, complementary elements
```

### Background Colors
```css
/* Light Mode Background */
Background: #F9FAFB (Soft neutral white)
Cards: #FFFFFF (Pure white)

/* Dark Mode Background */
Background: #1C1C1E (Graphite/deep charcoal)
Cards: #2C2C2E (Lighter charcoal)
```

### Text Colors
```css
/* Light Mode Text */
Primary: #1A1A1A (Dark gray)
Secondary: #6B7280 (Muted gray)

/* Dark Mode Text */
Primary: #F5F5F7 (Light gray/white)
Secondary: #8E8E93 (Muted light gray)
```

### Semantic Colors
```css
/* Success */
Light Mode: #4CAF50 (Muted green)
Dark Mode: #30D158 (iOS green)

/* Error/Destructive */
Light Mode: #E57373 (Muted red)
Dark Mode: #FF6B6B (Soft red)
```

### Neutral Scale
The neutral scale provides 9 shades that invert appropriately in dark mode:
- `neutral-50` to `neutral-900`
- Automatically adjusts for light/dark themes

---

## 2. Typography System

### Font Family
```css
Font Stack: -apple-system, BlinkMacSystemFont, "SF Pro Display", "Inter", "Segoe UI", Roboto, "Helvetica Neue", Arial, sans-serif
```

### Font Sizes & Weights
```css
/* Large Headings */
Size: 24px (1.5rem)
Weight: Bold (700)
Line Height: 1.3
Usage: Screen titles, main headings

/* Headings */
Size: 20px (1.25rem)
Weight: Bold (700)
Line Height: 1.4
Usage: Section titles, card headers

/* Subheadings */
Size: 18px (1.125rem)
Weight: Semibold (600)
Line Height: 1.4
Usage: Component titles, feature names

/* Body Text */
Size: 16px (1rem)
Weight: Regular (400)
Line Height: 1.6
Usage: Main content, descriptions

/* Small Text */
Size: 14px (0.875rem)
Weight: Regular (400)
Line Height: 1.4
Usage: Meta information, secondary content

/* Captions/Labels */
Size: 12px (0.75rem)
Weight: Light (300)
Line Height: 1.4
Color: Muted gray
Usage: Timestamps, helper text, form labels
```

### Typography Hierarchy
1. **Primary Headings**: Large, bold, high contrast
2. **Secondary Headings**: Medium, semibold, good contrast
3. **Body Text**: Comfortable reading size with optimal line height
4. **Supporting Text**: Smaller, lighter weight, muted color

---

## 3. Component Guidelines

### Buttons

#### Primary Button
```css
Background: var(--primary)
Text: var(--primary-foreground)
Border Radius: 12px
Padding: 12px 24px
Font Weight: Medium (500)
Shadow: 0 1px 3px rgba(0,0,0,0.1)
Hover: Slightly darker shade
```

#### Secondary Button
```css
Background: Transparent
Border: 1px solid var(--primary)
Text: var(--primary)
Border Radius: 12px
Padding: 12px 24px
Font Weight: Medium (500)
Hover: Light background tint
```

#### Tertiary Button
```css
Background: Transparent
Text: var(--primary)
No border
Font Weight: Medium (500)
Hover: Slight background
```

### Input Fields
```css
Background: var(--input-background)
Border: 1px solid var(--input-border)
Border Radius: 12px
Padding: 12px 16px
Font Size: 16px
Focus: Border color changes to primary
Placeholder: Muted text color
```

### Cards
```css
Background: var(--card)
Border Radius: 16px
Shadow: 0 1px 3px rgba(0,0,0,0.1)
Padding: 16px minimum
Border: Optional subtle border in dark mode
```

### Navigation Tabs

#### Top Tabs
```css
Style: Underline indicator
Active Color: var(--primary)
Inactive Color: var(--muted-foreground)
Indicator: 2px solid line
Padding: 12px 16px
```

#### Bottom Navigation
```css
Icons: 20px line icons with rounded edges
Active: Primary color with optional fill
Inactive: Muted gray
Background: Semi-transparent with backdrop blur
Height: 60px
```

### Charts & Data Visualization
```css
Primary Color: var(--chart-1) - Teal
Secondary Color: var(--chart-2) - Purple
Accent Colors: var(--chart-3), var(--chart-4), var(--chart-5)
Background: Subtle grid or no background
Style: Clean lines, minimal decorations
```

---

## 4. Spacing & Layout System

### Spacing Scale
```css
--spacing-xs: 4px    /* Fine details */
--spacing-sm: 8px    /* Small gaps */
--spacing-base: 16px /* Standard spacing */
--spacing-lg: 24px   /* Section spacing */
--spacing-xl: 32px   /* Large gaps */
--spacing-2xl: 48px  /* Major sections */
```

### Layout Guidelines
- **Minimum Padding**: 16px around all components
- **Content Max Width**: 448px (28rem) for mobile optimization
- **Vertical Rhythm**: Consistent 16px baseline grid
- **Card Spacing**: 16px padding inside, 8px-16px between cards
- **Section Spacing**: 24px-32px between major sections

### Grid System
- **Mobile-First**: Designed for 375px-428px screen widths
- **Single Column**: Primary layout pattern
- **Flexible Grid**: Uses CSS Grid and Flexbox for responsive behavior
- **Safe Areas**: Respects iOS safe areas and notches

---

## 5. Iconography

### Icon Style
- **Line Icons**: Consistent 1.5px stroke width
- **Rounded Edges**: Subtle rounded line caps
- **Size**: 20px for navigation, 16px for inline, 24px for features
- **Color**: Inherits from parent or uses semantic colors

### Icon Library
Primary icons from **Lucide React** with these characteristics:
- Minimal and clean
- Consistent stroke width
- Optimized for small sizes
- Excellent iOS compatibility

---

## 6. Shadows & Elevation

### Shadow System
```css
/* Subtle Shadow - Cards, buttons */
--shadow-sm: 0 1px 2px rgba(0,0,0,0.05)

/* Standard Shadow - Floating elements */
--shadow-base: 0 1px 3px rgba(0,0,0,0.1), 0 1px 2px rgba(0,0,0,0.06)

/* Prominent Shadow - Modals, overlays */
--shadow-lg: 0 10px 15px rgba(0,0,0,0.1), 0 4px 6px rgba(0,0,0,0.05)
```

### Usage Guidelines
- Use sparingly for depth and hierarchy
- Reduce shadow intensity in dark mode
- Prefer subtle elevation over dramatic shadows

---

## 7. Responsive Behavior

### Breakpoints
- **Mobile**: 375px - 428px (primary target)
- **Large Mobile**: 428px+ (iPhone Pro Max, etc.)
- **Tablet**: 768px+ (fallback, not primary focus)

### Adaptive Design
- Components scale proportionally
- Text remains readable at all sizes
- Touch targets meet 44px minimum
- Safe area compliance for iOS devices

---

## 8. Accessibility Standards

### Color Contrast
- **Normal Text**: 4.5:1 minimum contrast ratio
- **Large Text**: 3:1 minimum contrast ratio
- **Interactive Elements**: Clear focus states
- **Error States**: Color + text/icon indicators

### Interactive Elements
- **Minimum Touch Target**: 44px × 44px
- **Focus Indicators**: Visible outline using ring color
- **State Changes**: Clear visual feedback
- **Loading States**: Skeleton screens or subtle animations

---

## 9. Motion & Animation

### Animation Principles
- **Subtle & Purposeful**: Animations support user understanding
- **iOS-Native Feel**: Matches system animation curves
- **Performance**: 60fps, optimized transitions
- **Accessibility**: Respects reduced motion preferences

### Common Animations
```css
/* Standard Transition */
transition: all 200ms ease-out;

/* Hover States */
transition: transform 150ms ease-out;

/* Modal Entrance */
transition: opacity 300ms ease-out, transform 300ms ease-out;
```

---

## 10. Implementation Guidelines

### CSS Custom Properties
All design tokens are available as CSS custom properties:
```css
color: var(--primary);
background: var(--card);
border-radius: var(--radius-lg);
padding: var(--spacing-base);
```

### Component Classes
Use semantic class names that reflect purpose:
```css
.wellness-card { /* Card specifically for wellness content */ }
.meditation-timer { /* Timer component styling */ }
.progress-indicator { /* Progress tracking styles */ }
```

### Dark Mode Implementation
- Uses CSS custom properties for automatic switching
- All components automatically adapt
- Manual theme toggle available
- System preference detection

---

## 11. Usage Examples

### Typical Card Component
```tsx
<div className="bg-card rounded-lg shadow-base p-4 border border-border/50">
  <h3 className="text-lg font-semibold text-foreground mb-2">
    Card Title
  </h3>
  <p className="text-muted-foreground">
    Card content with proper typography and spacing.
  </p>
</div>
```

### Primary Button
```tsx
<button className="bg-primary text-primary-foreground font-medium px-6 py-3 rounded-xl hover:bg-primary-hover transition-colors">
  Primary Action
</button>
```

### Input Field
```tsx
<input 
  className="w-full bg-input-background border border-input-border rounded-xl px-4 py-3 text-foreground placeholder:text-muted-foreground focus:ring-2 focus:ring-ring focus:border-ring"
  placeholder="Enter text..."
/>
```

---

## 12. Quality Checklist

Before implementing any new component, ensure:

- [ ] Follows spacing guidelines (16px minimum padding)
- [ ] Uses semantic color tokens (not hardcoded colors)
- [ ] Works in both light and dark modes
- [ ] Meets accessibility contrast requirements
- [ ] Uses proper typography hierarchy
- [ ] Includes appropriate hover/focus states
- [ ] Maintains 44px minimum touch targets
- [ ] Implements smooth, purposeful transitions
- [ ] Respects iOS safe areas and design patterns
- [ ] Feels calming and professional, not flashy

---

*This design system ensures consistency across all ThriveSpace features while maintaining the professional, minimal, and calming aesthetic that users expect from a wellness application.*