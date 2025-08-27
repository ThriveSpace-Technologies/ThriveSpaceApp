# ThriveSpace Micro-Interactions & Animation Patterns
*Professional, Minimal, Calming Wellness-Focused Animation System*

## 🎭 Animation Philosophy

ThriveSpace's animation system is designed around the principles of mindfulness and calm. Every motion serves a purpose: to guide attention, provide feedback, or create a sense of peaceful flow. Animations feel natural, never jarring, and always respect the user's mental state and wellness journey.

### Animation Principles
- **Purposeful Motion**: Every animation has clear intent and meaning
- **Calming Rhythm**: Gentle easing curves that feel like natural breathing
- **Respectful Timing**: Animations that don't rush or create anxiety
- **Mindful Transitions**: Smooth flows that maintain mental focus
- **Wellness-Centered**: Motion that supports rather than distracts from wellness practices

---

## ⏱️ Animation Timing & Easing System

### Wellness Animation Constants
```css
/* Duration Scale - Based on Natural Rhythms */
--duration-instant: 100ms;      /* Immediate feedback */
--duration-quick: 150ms;        /* Quick state changes */
--duration-fast: 200ms;         /* Button presses, toggles */
--duration-smooth: 300ms;       /* Standard transitions */
--duration-gentle: 400ms;       /* Card entrances, modals */
--duration-flowing: 500ms;      /* Page transitions */
--duration-meditative: 600ms;   /* Progress animations */
--duration-breathing: 800ms;    /* Breathing-rhythm animations */
--duration-celebration: 1000ms; /* Achievement unlocks */
--duration-ambient: 2000ms;     /* Background ambient motion */

/* Easing Curves - Inspired by Natural Motion */
--easing-instant: linear;                           /* Immediate, mechanical */
--easing-gentle: cubic-bezier(0.25, 0.46, 0.45, 0.94); /* Ease-out-cubic */
--easing-smooth: cubic-bezier(0.4, 0, 0.2, 1);     /* Material Design standard */
--easing-natural: cubic-bezier(0.23, 1, 0.32, 1);   /* Ease-out-quart */
--easing-breathing: cubic-bezier(0.37, 0, 0.63, 1); /* Sine-like, breathing rhythm */
--easing-bounce: cubic-bezier(0.68, -0.55, 0.265, 1.55); /* Gentle bounce */
--easing-spring: cubic-bezier(0.175, 0.885, 0.32, 1.275); /* Natural spring */
--easing-meditation: cubic-bezier(0.25, 0.1, 0.25, 1);   /* Peaceful, flowing */
```

### Context-Aware Timing
```css
/* Adaptive Duration Based on Context */
.wellness-practice-mode {
  /* Slower, more meditative timing during practices */
  --duration-multiplier: 1.3;
}

.quick-interaction-mode {
  /* Faster responses for productivity features */
  --duration-multiplier: 0.8;
}

@media (prefers-reduced-motion) {
  /* Respect accessibility preferences */
  --duration-instant: 0ms;
  --duration-quick: 0ms;
  --duration-fast: 100ms;
  --duration-smooth: 150ms;
  /* Reduce but don't eliminate important transitions */
}

/* Battery-aware animations */
.low-battery-mode {
  --duration-multiplier: 0.7;
  --animation-iterations: 1; /* Reduce repetitive animations */
}
```

---

## 🔲 Button & Interactive Element Animations

### Button Interaction Patterns
```css
/* Standard Button Press Animation */
.wellness-button {
  transform: scale(1);
  box-shadow: 0 2px 8px rgba(58, 175, 169, 0.15);
  transition: transform var(--duration-fast) var(--easing-gentle),
              box-shadow var(--duration-smooth) var(--easing-gentle),
              background-color var(--duration-fast) var(--easing-gentle);
}

.wellness-button:active {
  transform: scale(0.95);
  box-shadow: 0 1px 4px rgba(58, 175, 169, 0.2);
}

.wellness-button:hover {
  box-shadow: 0 4px 12px rgba(58, 175, 169, 0.25);
}

/* Success State Animation */
.button-success {
  animation: success-pulse var(--duration-celebration) var(--easing-gentle);
}

@keyframes success-pulse {
  0% { transform: scale(1); }
  50% { transform: scale(1.05); box-shadow: 0 0 20px rgba(48, 209, 88, 0.3); }
  100% { transform: scale(1); }
}

/* Loading State */
.button-loading {
  pointer-events: none;
  position: relative;
}

.button-loading::after {
  content: '';
  position: absolute;
  width: 16px;
  height: 16px;
  border: 2px solid transparent;
  border-top: 2px solid currentColor;
  border-radius: 50%;
  animation: spin var(--duration-breathing) linear infinite;
}

@keyframes spin {
  to { transform: rotate(360deg); }
}
```

### Toggle & Switch Animations
```css
/* Wellness-themed toggle switch */
.wellness-toggle {
  position: relative;
  width: 48px;
  height: 28px;
  background: var(--color-surface-secondary);
  border-radius: 14px;
  transition: background-color var(--duration-smooth) var(--easing-gentle);
}

.wellness-toggle::before {
  content: '';
  position: absolute;
  width: 24px;
  height: 24px;
  background: white;
  border-radius: 50%;
  top: 2px;
  left: 2px;
  transition: transform var(--duration-smooth) var(--easing-spring),
              box-shadow var(--duration-smooth) var(--easing-gentle);
  box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
}

.wellness-toggle.active {
  background: var(--color-primary);
}

.wellness-toggle.active::before {
  transform: translateX(20px);
  box-shadow: 0 2px 8px rgba(58, 175, 169, 0.3);
}
```

### Icon Interaction Animations
```css
/* Heart/Like Animation */
.heart-icon {
  transform: scale(1);
  transition: transform var(--duration-fast) var(--easing-gentle);
}

.heart-icon.liked {
  animation: heart-like var(--duration-gentle) var(--easing-bounce);
  color: #FF6B6B;
}

@keyframes heart-like {
  0% { transform: scale(1); }
  25% { transform: scale(1.2); }
  50% { transform: scale(0.95); }
  100% { transform: scale(1); }
}

/* Bookmark Animation */
.bookmark-icon {
  transform: translateY(0);
  transition: transform var(--duration-smooth) var(--easing-gentle);
}

.bookmark-icon.saved {
  animation: bookmark-save var(--duration-gentle) var(--easing-natural);
}

@keyframes bookmark-save {
  0% { transform: translateY(0) scale(1); }
  50% { transform: translateY(-4px) scale(1.1); }
  100% { transform: translateY(0) scale(1); }
}
```

---

## 📱 Navigation & Screen Transition Animations

### Tab Navigation Animations
```css
/* Bottom Tab Selection */
.tab-item {
  transform: scale(1);
  transition: transform var(--duration-fast) var(--easing-gentle),
              color var(--duration-smooth) var(--easing-gentle);
}

.tab-item:active {
  transform: scale(0.9);
}

.tab-item.active {
  color: var(--color-primary);
}

.tab-item.active .tab-icon {
  animation: tab-activate var(--duration-smooth) var(--easing-spring);
}

@keyframes tab-activate {
  0% { transform: scale(1); }
  50% { transform: scale(1.1); }
  100% { transform: scale(1); }
}

/* Tab Content Transitions */
.tab-content-enter {
  opacity: 0;
  transform: translateY(20px);
  animation: tab-content-enter var(--duration-gentle) var(--easing-natural);
}

@keyframes tab-content-enter {
  to {
    opacity: 1;
    transform: translateY(0);
  }
}
```

### Page Transition Patterns
```css
/* iOS-Style Screen Transitions */
.screen-enter {
  transform: translateX(100%);
  animation: screen-slide-in var(--duration-flowing) var(--easing-natural);
}

.screen-exit {
  animation: screen-slide-out var(--duration-smooth) var(--easing-gentle);
}

@keyframes screen-slide-in {
  to { transform: translateX(0); }
}

@keyframes screen-slide-out {
  to { transform: translateX(-100%); opacity: 0.8; }
}

/* Modal Animations */
.modal-enter {
  opacity: 0;
  transform: scale(0.9) translateY(50px);
  animation: modal-enter var(--duration-gentle) var(--easing-spring);
}

@keyframes modal-enter {
  to {
    opacity: 1;
    transform: scale(1) translateY(0);
  }
}

/* Bottom Sheet Animation */
.bottom-sheet-enter {
  transform: translateY(100%);
  animation: bottom-sheet-slide var(--duration-smooth) var(--easing-natural);
}

@keyframes bottom-sheet-slide {
  to { transform: translateY(0); }
}
```

---

## 📊 Progress & Data Visualization Animations

### Progress Ring Animations
```css
/* Circular Progress Animation */
.progress-ring {
  transform: rotate(-90deg);
}

.progress-circle {
  fill: none;
  stroke: var(--color-primary);
  stroke-width: 4;
  stroke-linecap: round;
  stroke-dasharray: 0 100;
  transition: stroke-dasharray var(--duration-meditative) var(--easing-breathing);
}

.progress-circle.animated {
  animation: progress-draw var(--duration-meditative) var(--easing-breathing);
}

@keyframes progress-draw {
  from { stroke-dasharray: 0 100; }
  to { stroke-dasharray: var(--progress-value) 100; }
}

/* Progress Ring Completion Celebration */
.progress-complete {
  animation: progress-celebrate var(--duration-celebration) var(--easing-gentle);
}

@keyframes progress-celebrate {
  0% { transform: rotate(-90deg) scale(1); }
  50% { transform: rotate(-90deg) scale(1.05); filter: drop-shadow(0 0 8px var(--color-primary)); }
  100% { transform: rotate(-90deg) scale(1); }
}
```

### Chart & Data Animations
```css
/* Line Chart Drawing Animation */
.chart-line {
  stroke-dasharray: 1000;
  stroke-dashoffset: 1000;
  animation: chart-draw var(--duration-breathing) var(--easing-natural);
}

@keyframes chart-draw {
  to {
    stroke-dashoffset: 0;
  }
}

/* Bar Chart Growth Animation */
.chart-bar {
  transform: scaleY(0);
  transform-origin: bottom;
  animation: bar-grow var(--duration-gentle) var(--easing-spring);
}

.chart-bar:nth-child(n) {
  animation-delay: calc(var(--index) * 100ms);
}

@keyframes bar-grow {
  to { transform: scaleY(1); }
}

/* Data Point Entrance */
.data-point {
  opacity: 0;
  transform: scale(0);
  animation: data-point-enter var(--duration-smooth) var(--easing-spring);
}

@keyframes data-point-enter {
  to {
    opacity: 1;
    transform: scale(1);
  }
}
```

---

## 🎯 Feedback & Achievement Animations

### Achievement Unlock Celebration
```css
/* Badge Unlock Animation */
.achievement-badge {
  transform: scale(0.8);
  opacity: 0;
  animation: badge-unlock var(--duration-celebration) var(--easing-spring);
}

@keyframes badge-unlock {
  0% { transform: scale(0.8); opacity: 0; }
  50% { transform: scale(1.1); opacity: 1; }
  100% { transform: scale(1); opacity: 1; }
}

/* Particle Effect for Celebrations */
.celebration-particles {
  position: relative;
}

.celebration-particles::before {
  content: '';
  position: absolute;
  width: 100%;
  height: 100%;
  background: radial-gradient(circle, var(--color-primary) 2px, transparent 2px);
  background-size: 20px 20px;
  opacity: 0;
  animation: particles-burst var(--duration-celebration) var(--easing-natural);
}

@keyframes particles-burst {
  0% { opacity: 0; transform: scale(0); }
  50% { opacity: 0.8; transform: scale(1.2); }
  100% { opacity: 0; transform: scale(2); }
}

/* Streak Fire Animation */
.streak-fire {
  animation: fire-flicker var(--duration-ambient) ease-in-out infinite;
}

@keyframes fire-flicker {
  0%, 100% { transform: scale(1) rotate(0deg); }
  25% { transform: scale(1.05) rotate(1deg); }
  50% { transform: scale(0.98) rotate(-1deg); }
  75% { transform: scale(1.02) rotate(0.5deg); }
}
```

### Success & Error State Animations
```css
/* Success Checkmark Animation */
.success-checkmark {
  stroke-dasharray: 20;
  stroke-dashoffset: 20;
  animation: checkmark-draw var(--duration-gentle) var(--easing-natural);
}

@keyframes checkmark-draw {
  to { stroke-dashoffset: 0; }
}

.success-container {
  animation: success-glow var(--duration-gentle) var(--easing-gentle);
}

@keyframes success-glow {
  0% { box-shadow: 0 0 0 rgba(48, 209, 88, 0); }
  50% { box-shadow: 0 0 20px rgba(48, 209, 88, 0.3); }
  100% { box-shadow: 0 0 0 rgba(48, 209, 88, 0); }
}

/* Error Shake Animation */
.error-shake {
  animation: error-shake var(--duration-gentle) var(--easing-natural);
}

@keyframes error-shake {
  0%, 100% { transform: translateX(0); }
  10%, 30%, 50%, 70%, 90% { transform: translateX(-4px); }
  20%, 40%, 60%, 80% { transform: translateX(4px); }
}
```

---

## 🌊 Loading & State Transition Animations

### Loading Animations
```css
/* Wellness-themed Loading Spinner */
.wellness-spinner {
  width: 40px;
  height: 40px;
  border: 3px solid var(--color-surface-tertiary);
  border-top: 3px solid var(--color-primary);
  border-radius: 50%;
  animation: spin var(--duration-breathing) linear infinite;
}

/* Breathing Loader */
.breathing-loader {
  width: 60px;
  height: 60px;
  background: radial-gradient(circle, var(--color-primary), transparent);
  border-radius: 50%;
  animation: breathe var(--duration-ambient) var(--easing-breathing) infinite;
}

@keyframes breathe {
  0%, 100% { transform: scale(1); opacity: 0.7; }
  50% { transform: scale(1.2); opacity: 0.4; }
}

/* Skeleton Loading */
.skeleton {
  background: linear-gradient(90deg, 
    var(--color-surface-secondary) 25%, 
    var(--color-surface-tertiary) 50%, 
    var(--color-surface-secondary) 75%);
  background-size: 200% 100%;
  animation: skeleton-wave var(--duration-breathing) ease-in-out infinite;
}

@keyframes skeleton-wave {
  0% { background-position: -200% 0; }
  100% { background-position: 200% 0; }
}
```

### Content State Transitions
```css
/* Fade In/Out Animations */
.fade-enter {
  opacity: 0;
  animation: fade-in var(--duration-smooth) var(--easing-gentle);
}

@keyframes fade-in {
  to { opacity: 1; }
}

/* Slide Up Content Entrance */
.slide-up-enter {
  opacity: 0;
  transform: translateY(30px);
  animation: slide-up var(--duration-gentle) var(--easing-natural);
}

@keyframes slide-up {
  to {
    opacity: 1;
    transform: translateY(0);
  }
}

/* Staggered List Item Entrance */
.list-item-enter {
  opacity: 0;
  transform: translateY(20px);
  animation: list-item-enter var(--duration-gentle) var(--easing-natural);
  animation-delay: calc(var(--index) * 100ms);
}

@keyframes list-item-enter {
  to {
    opacity: 1;
    transform: translateY(0);
  }
}
```

---

## 🧘 Wellness-Specific Animations

### Meditation & Practice Animations
```css
/* Breathing Guide Animation */
.breathing-guide {
  width: 200px;
  height: 200px;
  border: 2px solid var(--color-primary);
  border-radius: 50%;
  animation: breathing-cycle 8s var(--easing-breathing) infinite;
}

@keyframes breathing-cycle {
  0%, 100% { transform: scale(1); opacity: 0.6; }
  25% { transform: scale(1.3); opacity: 0.8; } /* Inhale */
  50% { transform: scale(1.3); opacity: 0.8; } /* Hold */
  75% { transform: scale(1); opacity: 0.6; } /* Exhale */
}

/* Meditation Timer Ripple */
.meditation-ripple {
  position: relative;
}

.meditation-ripple::before,
.meditation-ripple::after {
  content: '';
  position: absolute;
  border: 1px solid var(--color-primary);
  border-radius: 50%;
  animation: ripple 3s var(--easing-breathing) infinite;
}

.meditation-ripple::after {
  animation-delay: 1.5s;
}

@keyframes ripple {
  0% {
    width: 0;
    height: 0;
    opacity: 1;
  }
  100% {
    width: 300px;
    height: 300px;
    opacity: 0;
  }
}

/* Focus Mode Transition */
.focus-mode-enter {
  animation: focus-enter var(--duration-meditative) var(--easing-meditation);
}

@keyframes focus-enter {
  0% { 
    background: var(--color-background-primary);
    filter: blur(0);
  }
  100% { 
    background: var(--color-background-meditation);
    filter: blur(20px) brightness(0.3);
  }
}
```

### Wellness Journey Animations
```css
/* Goal Progress Animation */
.goal-progress {
  width: 100%;
  height: 8px;
  background: var(--color-surface-secondary);
  border-radius: 4px;
  overflow: hidden;
}

.goal-progress-fill {
  height: 100%;
  background: linear-gradient(90deg, var(--color-primary), var(--color-secondary));
  border-radius: 4px;
  width: 0%;
  animation: goal-fill var(--duration-meditative) var(--easing-natural);
}

@keyframes goal-fill {
  to { width: var(--progress-percentage); }
}

/* Habit Streak Visualization */
.habit-dot {
  width: 12px;
  height: 12px;
  background: var(--color-surface-secondary);
  border-radius: 50%;
  transition: background var(--duration-smooth) var(--easing-gentle);
}

.habit-dot.completed {
  background: var(--color-primary);
  animation: habit-complete var(--duration-gentle) var(--easing-bounce);
}

@keyframes habit-complete {
  0% { transform: scale(1); }
  50% { transform: scale(1.3); }
  100% { transform: scale(1); }
}
```

---

## 🎨 Dark Mode Animation Adaptations

### Dark Mode Specific Enhancements
```css
/* Enhanced Glow Effects for Dark Mode */
@media (prefers-color-scheme: dark) {
  .button-primary:hover {
    box-shadow: 0 4px 16px rgba(77, 184, 179, 0.4);
  }
  
  .success-glow {
    animation: success-glow-dark var(--duration-gentle) var(--easing-gentle);
  }
  
  @keyframes success-glow-dark {
    0% { box-shadow: 0 0 0 rgba(48, 209, 88, 0); }
    50% { box-shadow: 0 0 30px rgba(48, 209, 88, 0.5); }
    100% { box-shadow: 0 0 0 rgba(48, 209, 88, 0); }
  }
  
  .celebration-particles::before {
    background: radial-gradient(circle, rgba(77, 184, 179, 0.8) 2px, transparent 2px);
    filter: drop-shadow(0 0 4px rgba(77, 184, 179, 0.6));
  }
}
```

---

## ♿ Accessible Animation Patterns

### Motion Accessibility
```css
/* Respect User Motion Preferences */
@media (prefers-reduced-motion: reduce) {
  * {
    animation-duration: 0.01ms !important;
    animation-iteration-count: 1 !important;
    transition-duration: 0.01ms !important;
  }
  
  /* Keep essential animations but reduce them */
  .progress-ring,
  .success-checkmark,
  .loading-spinner {
    animation-duration: 0.3s !important;
  }
  
  /* Remove decorative animations entirely */
  .breathing-guide,
  .meditation-ripple,
  .celebration-particles {
    animation: none !important;
  }
}

/* Focus-visible for keyboard navigation */
.interactive-element:focus-visible {
  outline: 2px solid var(--color-primary);
  outline-offset: 2px;
  animation: focus-pulse 0.3s var(--easing-gentle);
}

@keyframes focus-pulse {
  0% { outline-color: transparent; }
  100% { outline-color: var(--color-primary); }
}
```

### Alternative Animation Descriptions
```css
/* Screen Reader Announcements */
.sr-animation-description {
  position: absolute;
  width: 1px;
  height: 1px;
  padding: 0;
  margin: -1px;
  overflow: hidden;
  clip: rect(0, 0, 0, 0);
  white-space: nowrap;
  border: 0;
}

/* Example Usage */
<div class="progress-ring" aria-describedby="progress-description">
  <span id="progress-description" class="sr-animation-description">
    Progress bar filling to 75% complete
  </span>
</div>
```

---

## 📱 Performance Optimizations

### Animation Performance
```css
/* GPU Acceleration for Smooth Animations */
.gpu-accelerated {
  will-change: transform, opacity;
  backface-visibility: hidden;
  perspective: 1000px;
}

/* Efficient Transform Animations */
.efficient-animation {
  /* Use transform instead of changing layout properties */
  transform: translateZ(0); /* Force GPU layer */
  animation: efficient-move var(--duration-smooth) var(--easing-gentle);
}

@keyframes efficient-move {
  from { transform: translateX(-100%) translateZ(0); }
  to { transform: translateX(0) translateZ(0); }
}

/* Battery-Aware Animations */
.battery-efficient {
  animation-play-state: running;
}

@media (prefers-reduced-motion), (prefers-color-scheme: dark) and (max-device-pixel-ratio: 1) {
  .battery-efficient {
    animation-iteration-count: 1;
    animation-duration: calc(var(--duration-smooth) * 0.7);
  }
}
```

---

## 🎯 Animation Success Metrics

### Performance Metrics
```css
/* Animation Performance Monitoring */
Animation Quality KPIs:
├─ Frame Rate: Maintain 60fps during all transitions
├─ Jank Score: Minimize layout thrashing and repaints
├─ Battery Impact: Monitor power consumption from animations
├─ Load Time: Animation asset loading impact
├─ Memory Usage: Efficient cleanup of animation resources
├─ User Preference Compliance: Respect reduced motion settings
└─ Cross-Device Performance: Consistent experience across devices

User Experience Metrics:
├─ Completion Rates: Whether users wait for animations to finish
├─ Perceived Performance: User satisfaction with animation speed
├─ Accessibility Usage: Animation experience for users with disabilities
├─ Error Reduction: Whether animations help prevent user mistakes
├─ Engagement: Time spent interacting with animated elements
├─ Wellness Impact: Whether animations support or distract from wellness goals
└─ Retention: Long-term user retention correlation with animation quality
```

---

*This comprehensive micro-interaction and animation system creates a cohesive, calming, and purposeful motion language that enhances ThriveSpace's wellness-focused user experience while maintaining excellent performance and accessibility standards.*