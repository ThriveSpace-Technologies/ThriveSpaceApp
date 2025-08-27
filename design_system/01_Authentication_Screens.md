# ThriveSpace Authentication Screens
*Professional, Minimal, Calming Wellness App Design*

## 🎯 Authentication Flow Overview

The authentication experience sets the tone for ThriveSpace's mindful approach. Each screen uses generous whitespace, calming colors, and gentle animations to create a welcoming first impression.

### Flow Structure
1. **Splash Screen** → Auto-transitions to Welcome
2. **Welcome Screen** → Entry point with app introduction  
3. **Sign In Screen** → Returning users
4. **Sign Up Screen** → New users
5. **Password Recovery** → Reset flow (if needed)

---

## 📱 Screen Specifications

### Target Canvas: iPhone 14 Pro (390×844px)
- **Safe Area Top**: 59px (Dynamic Island + Status Bar)
- **Safe Area Bottom**: 34px (Home Indicator)
- **Content Area**: 390×751px
- **Horizontal Padding**: 24px standard

---

## 🌟 1. Splash Screen

### Visual Design
```css
Background: Linear gradient 
  - Top: #F9FAFB (Light) / #1C1C1E (Dark)
  - Bottom: #3AAFA9 (10% opacity blend)

Logo Placement: Center, 120px from top of safe area
Logo Size: 80×80px with subtle glow
App Name: "ThriveSpace" 32px, SF Pro Display Bold
Tagline: "Mindful Wellness" 16px, Medium, 60% opacity
```

### Animation Sequence
1. **Logo Fade In** (400ms, gentle ease)
2. **App Name Slide Up** (300ms, 100ms delay)  
3. **Tagline Fade In** (250ms, 200ms delay)
4. **Hold State** (1000ms)
5. **Transition Out** (600ms fade to Welcome)

### Implementation Notes
- Total splash duration: ~2 seconds
- Respects system `prefers-reduced-motion` 
- Logo has subtle breathing animation (optional)

---

## 🤝 2. Welcome Screen

### Layout Structure
```
[Safe Area - 24px padding]

Logo Area (160px height)
├─ ThriveSpace Logo (64×64px)
├─ App Name (24px, Semibold) 
└─ Tagline (14px, Medium, 60% opacity)

Hero Content (300px height)  
├─ Welcome Message (32px Display, Bold)
├─ Description (16px Body, 60% opacity)
└─ Feature Highlights (3 items)

Action Area (120px height)
├─ Primary CTA Button (52px height)
├─ Secondary CTA Button (48px height)  
└─ Legal Links (12px, centered)
```

### Content Specifications

#### Welcome Message
```
Light Mode: "Find Your Inner Balance"
Dark Mode: "Discover Mindful Wellness"  
Font: 28px SF Pro Display Bold
Color: Primary text color
Line Height: 1.2
Letter Spacing: -0.02em
```

#### Description  
```
Text: "Join thousands finding peace through mindful practices, wellness tracking, and supportive community."
Font: 16px SF Pro Text Regular  
Color: Secondary text (60% opacity)
Line Height: 1.5
Max Width: 300px (centered)
```

#### Feature Highlights
Three key features with icons (20×20px):
1. 🧘‍♀️ **Mindful Practices** - "Guided meditations & breathing"
2. 📊 **Wellness Tracking** - "Monitor your progress daily"  
3. 🤝 **Supportive Community** - "Connect with like-minded people"

#### Call-to-Action Buttons
```css
Primary Button: "Get Started"
├─ Background: Primary color (#3AAFA9)
├─ Text: White, 16px Medium
├─ Size: 342×52px (full width - 48px)
├─ Border Radius: 16px
├─ Shadow: 0 4px 12px rgba(58,175,169,0.25)
└─ Press Animation: Scale 0.95x + darker shade

Secondary Button: "I already have an account"  
├─ Background: Transparent
├─ Text: Primary color, 16px Medium
├─ Size: 342×48px
├─ Border: 1.5px solid primary (30% opacity)
├─ Border Radius: 14px
└─ Press Animation: Background tint (10% opacity)
```

### Dark Mode Adaptations
- Background transitions to dark charcoal
- Logo gains subtle teal glow
- Buttons get enhanced contrast
- Feature highlights use lighter icons

---

## 🔐 3. Sign In Screen  

### Layout Structure
```
[Navigation Bar - 44px]
├─ Back Button (24px icon + "Back")
├─ Screen Title: "Welcome Back" (center)
└─ Help Button (optional)

[Hero Section - 120px]
├─ Greeting: "Sign in to continue" 
└─ Motivational text (optional)

[Form Section - 300px]
├─ Email Input Field (56px)
├─ Password Input Field (56px)  
├─ Forgot Password Link
└─ Sign In Button (52px)

[Divider Section - 60px]
├─ "or continue with" text + lines
  
[Social Login - 120px]  
├─ Apple Sign In (48px)
├─ Google Sign In (48px)
└─ Facebook Sign In (48px)

[Footer - 60px]
├─ "Don't have account?" + Sign Up link
```

### Form Design Specifications

#### Input Fields
```css
Email Field:
├─ Label: "Email" (floating, 14px Medium)
├─ Placeholder: "Enter your email address"  
├─ Input: 16px SF Pro Text Regular
├─ Size: 342×56px
├─ Background: Surface color
├─ Border: 1px solid outline (10% opacity)
├─ Border Radius: 16px
├─ Padding: 16px
├─ Icon: Mail icon (20px, left side)
└─ Focus State: Primary color border + subtle glow

Password Field:
├─ Label: "Password" (floating, 14px Medium)
├─ Placeholder: "Enter your password"
├─ Input: 16px SF Pro Text Regular  
├─ Size: 342×56px
├─ Toggle: Eye icon for visibility
├─ Same styling as email field
└─ Validation: Real-time strength indicator
```

#### Error States
```css
Error Field:
├─ Border: Error color (#E57373)
├─ Background: Error color (5% opacity)
├─ Icon: Error icon (red)
├─ Animation: Shake 4px left-right (300ms)
└─ Error Text: 12px, error color, below field
```

#### Sign In Button
```css
Primary Button: "Sign In"
├─ Background: Primary color (#3AAFA9)
├─ Text: White, 16px Semibold
├─ Size: 342×52px  
├─ Border Radius: 16px
├─ Disabled State: 60% opacity
├─ Loading State: Spinner + "Signing In..."
└─ Success State: Checkmark + "Welcome!"
```

### Social Login Buttons
```css
Apple Button: 
├─ Background: Black (Light) / White (Dark)
├─ Text/Icon: White (Light) / Black (Dark)
├─ Icon: Apple logo (20px)
├─ Text: "Continue with Apple" 16px Medium
├─ Size: 342×48px
├─ Border Radius: 12px

Google Button:
├─ Background: White with 1px border
├─ Icon: Google logo (20px)  
├─ Text: "Continue with Google" 16px Medium
├─ Size: 342×48px
├─ Border Radius: 12px

Facebook Button:
├─ Background: #1877F2
├─ Text/Icon: White  
├─ Icon: Facebook logo (20px)
├─ Text: "Continue with Facebook" 16px Medium  
├─ Size: 342×48px
├─ Border Radius: 12px
```

### Micro-interactions
- **Field Focus**: Smooth border color transition (200ms)
- **Button Press**: Scale 0.95x with haptic feedback
- **Form Validation**: Real-time with gentle error animations
- **Social Login**: Loading states with branded colors
- **Success Flow**: Smooth transition to home (600ms)

---

## ✨ 4. Sign Up Screen

### Layout Structure  
Similar to Sign In but with additional fields:

```
[Navigation + Hero - Same as Sign In]

[Extended Form Section - 420px]
├─ Full Name Input (56px)
├─ Email Input (56px)  
├─ Password Input (56px)
├─ Confirm Password Input (56px)
├─ Terms Agreement Checkbox
└─ Create Account Button (52px)

[Social Login - Same as Sign In]

[Footer - Same with "Sign In" link]
```

### Additional Form Elements

#### Full Name Field
```css
Name Field:
├─ Label: "Full Name" (floating)
├─ Placeholder: "Enter your full name"
├─ Icon: User icon (20px)
├─ Validation: Minimum 2 words
└─ Same styling as other inputs
```

#### Password Confirmation  
```css
Confirm Password:
├─ Label: "Confirm Password" (floating)
├─ Placeholder: "Re-enter your password"
├─ Icon: Lock icon (20px)
├─ Validation: Real-time match checking
└─ Success State: Checkmark when matched
```

#### Terms Agreement
```css
Checkbox Row:
├─ Custom checkbox (20×20px)
├─ Text: "I agree to Terms of Service and Privacy Policy"
├─ Font: 14px Regular
├─ Links: Primary color, underlined
└─ Required: Form disabled until checked
```

#### Create Account Button
```css  
Primary Button: "Create Account"
├─ Same styling as Sign In button
├─ Disabled until all fields valid
├─ Loading: "Creating Account..." with spinner
└─ Success: "Account Created!" with checkmark
```

### Validation Flow
1. **Real-time Validation**: As user types
2. **Field Dependencies**: Password confirmation updates on password change
3. **Form Validation**: Overall form state management  
4. **Error Prevention**: Helpful hints before errors occur
5. **Success Feedback**: Clear completion signals

---

## 🎨 Animation & Transition Patterns

### Screen Transitions
```css
Enter Animation:
├─ Slide from right (iOS standard)
├─ Duration: 300ms
├─ Easing: Ease-out cubic
└─ Concurrent fade-in of elements

Exit Animation:  
├─ Slide to left
├─ Duration: 250ms  
├─ Easing: Ease-in cubic
└─ Staggered fade-out
```

### Element Animations
```css
Form Fields:
├─ Entrance: Fade up 20px (staggered 100ms)
├─ Focus: Gentle scale 1.02x + glow
├─ Error: Shake + color transition
└─ Success: Subtle pulse + checkmark

Buttons:
├─ Hover: Slight elevation increase
├─ Press: Scale 0.95x + deeper color
├─ Loading: Spin animation + text change
└─ Success: Checkmark celebration

Logo/Branding:
├─ Entrance: Gentle fade + scale
├─ Idle: Subtle breathing (optional)
└─ Interaction: Playful bounce on tap
```

### Loading States
```css
Button Loading:
├─ Spinner: 16×16px, primary color
├─ Text: Fades to loading message
├─ Button: Disabled interaction
└─ Duration: Typically 1-3 seconds

Form Submission:
├─ Overlay: Semi-transparent background
├─ Spinner: Centered, branded colors
├─ Message: "Creating your account..."
└─ Success: Checkmark + "Welcome to ThriveSpace!"
```

---

## 🌗 Dark Mode Implementation

### Color Mapping
```css
Authentication Dark Mode:
├─ Background: #1C1C1E (True black avoided)
├─ Cards/Forms: #2C2C2E (Elevated surfaces)  
├─ Primary Text: #F5F5F7 (Soft white)
├─ Secondary Text: #8E8E93 (Muted)
├─ Borders: #38383A (Subtle lines)
├─ Primary Button: #4DB8B3 (Brighter teal)
└─ Input Fields: #2C2C2E background + #38383A borders
```

### Dark Mode Enhancements
- **Logo Glow**: Subtle teal luminescence around logo
- **Button Shadows**: Replaced with colored glows
- **Social Buttons**: Apple button inverts to white
- **Form Focus**: Enhanced glow effects for visibility
- **Success States**: Brighter feedback colors

### Transition Behavior
```css
Theme Transition:
├─ Duration: 300ms
├─ Easing: Ease-in-out
├─ Properties: All color values
├─ Preservation: Form state maintained
└─ Trigger: System setting or manual toggle
```

---

## ♿ Accessibility Features

### Visual Accessibility
- **High Contrast**: All text meets WCAG AA standards
- **Focus Indicators**: 2px colored outlines on interactive elements
- **Color Independence**: Information not solely conveyed through color
- **Dynamic Type**: Supports iOS text size preferences

### Motor Accessibility  
- **Touch Targets**: Minimum 44×44px tap areas
- **Gesture Alternatives**: All gestures have button equivalents
- **Timeout Extensions**: Extended time for form completion
- **Error Recovery**: Clear paths to fix validation errors

### Cognitive Accessibility
- **Clear Hierarchy**: Logical tab order and visual flow
- **Error Prevention**: Inline validation prevents mistakes  
- **Help Text**: Available for complex interactions
- **Progress Indicators**: Clear steps in sign-up process
- **Consistent Patterns**: Familiar interaction models

### Screen Reader Support
- **Semantic Markup**: Proper heading structure
- **Alt Text**: Descriptive image and icon labels
- **Form Labels**: Clear association with inputs
- **State Announcements**: Loading, error, success feedback
- **Navigation**: Clear landmark identification

---

## 📊 Success Metrics

### User Experience KPIs
- **Conversion Rate**: Welcome → Account Creation
- **Drop-off Points**: Which screen users abandon
- **Time to Complete**: Average sign-up duration
- **Error Rates**: Validation failures by field
- **Social Login Adoption**: Preferred authentication methods

### Technical Performance
- **Load Time**: Screen transition speed
- **Animation Performance**: 60fps maintenance
- **Accessibility Score**: Automated testing compliance
- **Cross-Device**: Consistent experience across iOS versions

---

*These authentication screens establish ThriveSpace's calming, professional brand while providing a smooth onboarding experience that respects users' time and mental well-being.*