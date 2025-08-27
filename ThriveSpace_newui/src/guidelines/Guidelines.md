# ThriveSpace Development Guidelines

## General Guidelines

* Only use absolute positioning when necessary. Opt for responsive and well structured layouts that use flexbox and grid by default
* Refactor code as you go to keep code clean
* Keep file sizes small and put helper functions and components in their own files
* Always use semantic color tokens from the design system instead of hardcoded colors
* Maintain 16px minimum padding around all components
* Ensure all interactive elements meet 44px minimum touch target size
* Test components in both light and dark modes

## Design System Guidelines

### Colors
* **Primary Color**: Use `var(--primary)` for main actions, navigation highlights, progress indicators
* **Secondary Color**: Use `var(--secondary)` for secondary actions, feature highlights, complementary elements
* **Never hardcode colors**: Always use CSS custom properties from the design system
* **Semantic colors**: Use `var(--success)` for positive states, `var(--destructive)` for errors
* **Text colors**: Use `var(--foreground)` for primary text, `var(--muted-foreground)` for secondary text

### Typography
* **Base font size**: 16px (1rem) for body text
* **Heading hierarchy**: Use semantic HTML headings (h1, h2, h3) that automatically apply design system styles
* **Font weights**: Medium (500) for buttons/labels, Regular (400) for body text, Bold (700) for headings
* **Line height**: 1.6 for body text, 1.4 for headings, 1.5 for UI elements
* **Never override system typography** unless explicitly needed for custom components

### Spacing
* **Base spacing**: 16px (`var(--spacing-base)`) for standard padding and margins
* **Component padding**: Minimum 16px inside cards and containers
* **Section spacing**: 24px-32px between major sections
* **Grid baseline**: Use 16px baseline grid for consistent vertical rhythm
* **Safe areas**: Always respect iOS safe areas and notches

### Components

#### Buttons
* **Primary Button**: `bg-primary text-primary-foreground` with 12px padding, medium font weight
* **Secondary Button**: Outline style with `border-primary text-primary` 
* **Tertiary Button**: Ghost style with `text-primary hover:bg-primary/5`
* **Border radius**: 12px (`rounded-xl`) for all buttons
* **One primary button per section** to guide users toward the most important action

#### Cards
* **Background**: Use `bg-card` with automatic dark mode adaptation
* **Border radius**: 16px (`rounded-lg`) for cards
* **Shadow**: Use `shadow-base` for subtle elevation
* **Padding**: Minimum 16px inside cards
* **Border**: Optional subtle border in dark mode using `border-border/50`

#### Input Fields
* **Background**: Use `bg-input-background` with `border-input-border`
* **Border radius**: 12px (`rounded-xl`)
* **Padding**: 12px horizontal, 12px vertical
* **Focus state**: `focus:ring-2 focus:ring-ring focus:border-ring`
* **Font size**: 16px to prevent zoom on iOS

#### Navigation
* **Bottom navigation height**: 60px with backdrop blur
* **Tab indicators**: 2px solid underline in primary color
* **Icon size**: 20px for navigation icons
* **Active state**: Primary color with optional fill
* **Maximum 5 tabs** in bottom navigation

### Layout Guidelines
* **Mobile-first**: Design for 375px-428px screen widths primarily
* **Content max width**: 448px (28rem) for optimal mobile experience
* **Single column layout**: Primary pattern for mobile
* **Vertical rhythm**: Maintain consistent spacing based on 16px grid
* **Responsive behavior**: Components should scale proportionally

### Accessibility
* **Color contrast**: Minimum 4.5:1 for normal text, 3:1 for large text
* **Touch targets**: Minimum 44px × 44px for interactive elements
* **Focus indicators**: Visible outline using `ring` color
* **Loading states**: Use skeleton screens or subtle loading indicators
* **Reduced motion**: Respect user preferences for reduced motion

### iOS Optimization
* **Safe areas**: Use appropriate padding for notches and home indicators
* **System fonts**: Leverage SF Pro Display/Text when available
* **Native feel**: Match iOS animation curves and interaction patterns
* **Performance**: Target 60fps for all animations and transitions
* **Gestures**: Support standard iOS gestures where appropriate

### Wellness App Specific
* **Calming aesthetic**: Avoid flashy or high-contrast designs
* **Trust indicators**: Use consistent, professional styling
* **Progress visualization**: Use teal/purple highlights against muted backgrounds
* **Content hierarchy**: Clear visual hierarchy for wellness content
* **Data visualization**: Clean, minimal charts without unnecessary decorations

### Code Quality
* **Component props**: Use TypeScript interfaces for all props
* **CSS classes**: Prefer Tailwind utilities over custom CSS
* **Custom properties**: Use design system tokens for all styling
* **File organization**: Group related components in logical folders
* **Performance**: Optimize for mobile devices and slower networks