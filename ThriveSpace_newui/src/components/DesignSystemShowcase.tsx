import { useState } from "react";
import { Button } from "./ui/button";
import { Input } from "./ui/input";
import { Card } from "./ui/card";
import { Badge } from "./ui/badge";
import { Avatar } from "./ui/avatar";
import { Progress } from "./ui/progress";
import { 
  Heart, 
  Sun, 
  Moon, 
  Star, 
  CheckCircle, 
  AlertCircle,
  Info,
  Zap,
  Calendar,
  Clock
} from "lucide-react";

export function DesignSystemShowcase() {
  const [isDark, setIsDark] = useState(() => {
    if (typeof window !== 'undefined') {
      return document.documentElement.classList.contains('dark');
    }
    return false;
  });

  const toggleTheme = () => {
    const newIsDark = !isDark;
    setIsDark(newIsDark);
    
    if (newIsDark) {
      document.documentElement.classList.add("dark");
      localStorage.setItem("theme", "dark");
    } else {
      document.documentElement.classList.remove("dark");
      localStorage.setItem("theme", "light");
    }
  };

  return (
    <div className="min-h-screen bg-background">
      {/* Header */}
      <div className="border-b border-border bg-background/95 backdrop-blur-sm sticky top-0 z-10">
        <div className="max-w-4xl mx-auto px-6 py-4">
          <div className="flex items-center justify-between">
            <div>
              <h1 className="text-2xl font-bold text-foreground">ThriveSpace Design System</h1>
              <p className="text-muted-foreground">Professional, minimal, calming components</p>
            </div>
            <Button 
              variant="outline"
              onClick={toggleTheme}
              className="flex items-center gap-2"
            >
              {isDark ? <Sun className="w-4 h-4" /> : <Moon className="w-4 h-4" />}
              {isDark ? 'Light' : 'Dark'} Mode
            </Button>
          </div>
        </div>
      </div>

      <div className="max-w-4xl mx-auto px-6 py-8 space-y-12">
        
        {/* Colors Section */}
        <section>
          <h2 className="text-xl font-bold text-foreground mb-6">Color Palette</h2>
          <div className="grid grid-cols-2 md:grid-cols-4 gap-4">
            <ColorSwatch name="Primary (Teal)" color="var(--primary)" />
            <ColorSwatch name="Secondary (Purple)" color="var(--secondary)" />
            <ColorSwatch name="Success" color="var(--success)" />
            <ColorSwatch name="Destructive" color="var(--destructive)" />
            <ColorSwatch name="Background" color="var(--background)" />
            <ColorSwatch name="Card" color="var(--card)" />
            <ColorSwatch name="Muted" color="var(--muted)" />
            <ColorSwatch name="Border" color="var(--border)" />
          </div>
        </section>

        {/* Typography Section */}
        <section>
          <h2 className="text-xl font-bold text-foreground mb-6">Typography</h2>
          <Card className="p-6 space-y-4">
            <div>
              <h1 className="mb-2">Large Heading (24px, Bold)</h1>
              <p className="text-sm text-muted-foreground">Screen titles, main headings</p>
            </div>
            <div>
              <h2 className="mb-2">Heading (20px, Bold)</h2>
              <p className="text-sm text-muted-foreground">Section titles, card headers</p>
            </div>
            <div>
              <h3 className="mb-2">Subheading (18px, Semibold)</h3>
              <p className="text-sm text-muted-foreground">Component titles, feature names</p>
            </div>
            <div>
              <p className="mb-2">Body text (16px, Regular) - This is the standard text used for main content and descriptions. It has optimal line height for comfortable reading.</p>
              <p className="text-sm text-muted-foreground">Main content, descriptions</p>
            </div>
            <div>
              <p className="text-sm mb-2">Small text (14px, Regular) - Used for meta information and secondary content.</p>
              <p className="text-sm text-muted-foreground">Meta information, secondary content</p>
            </div>
            <div>
              <p className="text-xs text-muted-foreground mb-2">Caption/Label (12px, Light) - Helper text and timestamps</p>
              <p className="text-sm text-muted-foreground">Timestamps, helper text, form labels</p>
            </div>
          </Card>
        </section>

        {/* Buttons Section */}
        <section>
          <h2 className="text-xl font-bold text-foreground mb-6">Buttons</h2>
          <div className="grid grid-cols-1 md:grid-cols-3 gap-6">
            <Card className="p-6">
              <h3 className="font-semibold mb-4">Primary Buttons</h3>
              <div className="space-y-3">
                <Button className="w-full bg-primary hover:bg-primary-hover text-primary-foreground">
                  <Heart className="w-4 h-4 mr-2" />
                  Primary Action
                </Button>
                <Button className="w-full bg-secondary hover:bg-secondary-hover text-secondary-foreground">
                  <Star className="w-4 h-4 mr-2" />
                  Secondary Action
                </Button>
              </div>
            </Card>

            <Card className="p-6">
              <h3 className="font-semibold mb-4">Secondary Buttons</h3>
              <div className="space-y-3">
                <Button variant="outline" className="w-full border-primary text-primary hover:bg-primary/5">
                  <Calendar className="w-4 h-4 mr-2" />
                  Outline Primary
                </Button>
                <Button variant="outline" className="w-full border-secondary text-secondary hover:bg-secondary/5">
                  <Clock className="w-4 h-4 mr-2" />
                  Outline Secondary
                </Button>
              </div>
            </Card>

            <Card className="p-6">
              <h3 className="font-semibold mb-4">Ghost Buttons</h3>
              <div className="space-y-3">
                <Button variant="ghost" className="w-full text-primary hover:bg-primary/5">
                  <Info className="w-4 h-4 mr-2" />
                  Ghost Primary
                </Button>
                <Button variant="ghost" className="w-full text-muted-foreground hover:bg-accent">
                  <Zap className="w-4 h-4 mr-2" />
                  Ghost Default
                </Button>
              </div>
            </Card>
          </div>
        </section>

        {/* Form Elements Section */}
        <section>
          <h2 className="text-xl font-bold text-foreground mb-6">Form Elements</h2>
          <Card className="p-6">
            <div className="grid grid-cols-1 md:grid-cols-2 gap-6">
              <div className="space-y-4">
                <div>
                  <label className="block text-sm font-medium text-foreground mb-2">
                    Email Address
                  </label>
                  <Input 
                    type="email" 
                    placeholder="Enter your email"
                    className="bg-input-background border-input-border"
                  />
                </div>
                <div>
                  <label className="block text-sm font-medium text-foreground mb-2">
                    Password
                  </label>
                  <Input 
                    type="password" 
                    placeholder="Enter your password"
                    className="bg-input-background border-input-border"
                  />
                </div>
              </div>
              <div className="space-y-4">
                <div>
                  <label className="block text-sm font-medium text-foreground mb-2">
                    Wellness Goal
                  </label>
                  <select className="w-full bg-input-background border border-input-border rounded-xl px-4 py-3 text-foreground">
                    <option>Stress Management</option>
                    <option>Better Sleep</option>
                    <option>Mindfulness</option>
                    <option>Physical Health</option>
                  </select>
                </div>
                <div>
                  <label className="block text-sm font-medium text-foreground mb-2">
                    Daily Meditation Minutes
                  </label>
                  <Input 
                    type="number" 
                    placeholder="15"
                    className="bg-input-background border-input-border"
                  />
                </div>
              </div>
            </div>
          </Card>
        </section>

        {/* Cards & Layout Section */}
        <section>
          <h2 className="text-xl font-bold text-foreground mb-6">Cards & Layout</h2>
          <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
            <Card className="p-6">
              <div className="flex items-center gap-3 mb-4">
                <Avatar className="w-10 h-10">
                  <div className="w-full h-full bg-gradient-to-br from-primary to-primary-hover flex items-center justify-center text-white font-medium">
                    SC
                  </div>
                </Avatar>
                <div>
                  <h3 className="font-semibold">Sarah Chen</h3>
                  <p className="text-sm text-muted-foreground">Wellness Coach</p>
                </div>
              </div>
              <p className="text-muted-foreground mb-4">
                "Mindfulness has transformed my daily routine. Start small and be consistent."
              </p>
              <div className="flex items-center gap-2">
                <Badge className="bg-primary/10 text-primary">Meditation</Badge>
                <Badge className="bg-secondary/10 text-secondary">Coaching</Badge>
              </div>
            </Card>

            <Card className="p-6">
              <div className="flex items-center justify-between mb-4">
                <h3 className="font-semibold">Weekly Progress</h3>
                <CheckCircle className="w-5 h-5 text-success" />
              </div>
              <div className="space-y-3">
                <div>
                  <div className="flex justify-between text-sm mb-1">
                    <span>Meditation</span>
                    <span>7/7 days</span>
                  </div>
                  <Progress value={100} className="h-2" />
                </div>
                <div>
                  <div className="flex justify-between text-sm mb-1">
                    <span>Exercise</span>
                    <span>5/7 days</span>
                  </div>
                  <Progress value={71} className="h-2" />
                </div>
                <div>
                  <div className="flex justify-between text-sm mb-1">
                    <span>Sleep Goal</span>
                    <span>6/7 nights</span>
                  </div>
                  <Progress value={86} className="h-2" />
                </div>
              </div>
            </Card>

            <Card className="p-6">
              <div className="flex items-center gap-2 mb-4">
                <AlertCircle className="w-5 h-5 text-secondary" />
                <h3 className="font-semibold">Daily Insight</h3>
              </div>
              <p className="text-muted-foreground mb-4">
                Taking three deep breaths before meals can improve digestion and mindful eating.
              </p>
              <Button variant="outline" className="w-full" size="sm">
                Learn More
              </Button>
            </Card>
          </div>
        </section>

        {/* States & Feedback Section */}
        <section>
          <h2 className="text-xl font-bold text-foreground mb-6">States & Feedback</h2>
          <div className="grid grid-cols-1 md:grid-cols-2 gap-6">
            <Card className="p-6">
              <h3 className="font-semibold mb-4">Success States</h3>
              <div className="space-y-3">
                <div className="flex items-center gap-3 p-3 rounded-lg bg-success/10 border border-success/20">
                  <CheckCircle className="w-5 h-5 text-success" />
                  <span className="text-success font-medium">Goal completed successfully!</span>
                </div>
                <Badge className="bg-success/10 text-success border-success/20">
                  Meditation streak: 7 days
                </Badge>
              </div>
            </Card>

            <Card className="p-6">
              <h3 className="font-semibold mb-4">Error States</h3>
              <div className="space-y-3">
                <div className="flex items-center gap-3 p-3 rounded-lg bg-destructive/10 border border-destructive/20">
                  <AlertCircle className="w-5 h-5 text-destructive" />
                  <span className="text-destructive font-medium">Please check your internet connection</span>
                </div>
                <Badge className="bg-destructive/10 text-destructive border-destructive/20">
                  Sync failed
                </Badge>
              </div>
            </Card>
          </div>
        </section>

        {/* Spacing Guidelines */}
        <section>
          <h2 className="text-xl font-bold text-foreground mb-6">Spacing Guidelines</h2>
          <Card className="p-6">
            <div className="space-y-4">
              <div className="grid grid-cols-2 md:grid-cols-6 gap-4 text-center">
                <SpacingBox size="xs" label="4px" />
                <SpacingBox size="sm" label="8px" />
                <SpacingBox size="base" label="16px" />
                <SpacingBox size="lg" label="24px" />
                <SpacingBox size="xl" label="32px" />
                <SpacingBox size="2xl" label="48px" />
              </div>
              <div className="mt-6 text-sm text-muted-foreground">
                <p><strong>Base (16px):</strong> Standard component padding and margins</p>
                <p><strong>Large (24px):</strong> Section spacing and card gaps</p>
                <p><strong>XL (32px+):</strong> Major section breaks and layout spacing</p>
              </div>
            </div>
          </Card>
        </section>
      </div>
    </div>
  );
}

function ColorSwatch({ name, color }: { name: string; color: string }) {
  return (
    <div className="text-center">
      <div 
        className="w-full h-20 rounded-lg border border-border mb-2"
        style={{ backgroundColor: color }}
      />
      <p className="text-sm font-medium text-foreground">{name}</p>
      <p className="text-xs text-muted-foreground">{color}</p>
    </div>
  );
}

function SpacingBox({ size, label }: { size: string; label: string }) {
  const sizeMap = {
    xs: 'w-1 h-1',
    sm: 'w-2 h-2', 
    base: 'w-4 h-4',
    lg: 'w-6 h-6',
    xl: 'w-8 h-8',
    '2xl': 'w-12 h-12'
  };

  return (
    <div className="flex flex-col items-center gap-2">
      <div className={`bg-primary ${sizeMap[size as keyof typeof sizeMap]} rounded`} />
      <span className="text-xs text-muted-foreground">{label}</span>
    </div>
  );
}