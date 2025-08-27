import { Button } from "./ui/button";
import { Heart } from "lucide-react";

interface WelcomeScreenProps {
  onGetStarted: () => void;
}

export function WelcomeScreen({ onGetStarted }: WelcomeScreenProps) {
  return (
    <div className="min-h-screen w-full flex flex-col items-center justify-center bg-background" style={{ paddingLeft: 'max(16px, env(safe-area-inset-left))', paddingRight: 'max(16px, env(safe-area-inset-right))' }}>
      <div className="flex flex-col items-center space-y-8 w-full max-w-xs">
        
        {/* Logo */}
        <div className="w-16 h-16 rounded-2xl bg-muted flex items-center justify-center">
          <Heart className="w-8 h-8 text-primary" fill="currentColor" />
        </div>

        {/* App name */}
        <div className="text-center space-y-2">
          <h1>ThriveSpace</h1>
          <p className="text-muted-foreground">
            Mindful Wellness,<br />Anytime
          </p>
        </div>

        {/* Description */}
        <div className="text-center text-muted-foreground leading-relaxed space-y-1">
          <p>Discover</p>
          <p>inner peace</p>
          <p>and build</p>
          <p>healthy</p>
          <p>habits with</p>
          <p>personalized</p>
          <p>wellness</p>
          <p>guidance</p>
        </div>

        {/* Primary action */}
        <div className="pt-6">
          <Button
            onClick={onGetStarted}
            className="bg-primary hover:bg-primary-hover text-primary-foreground rounded-2xl px-8 py-3"
          >
            Get Started
          </Button>
        </div>
      </div>
    </div>
  );
}