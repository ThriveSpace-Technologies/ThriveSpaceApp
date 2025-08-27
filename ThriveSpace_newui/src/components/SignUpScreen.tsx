import { useState } from "react";
import { Button } from "./ui/button";
import { Input } from "./ui/input";
import { Label } from "./ui/label";
import { Separator } from "./ui/separator";
import { ArrowLeft, Mail, Lock, User, Eye, EyeOff } from "lucide-react";
import { SocialLoginButton } from "./SocialLoginButton";

interface SignUpScreenProps {
  onBack: () => void;
  onSignIn: () => void;
  onSignUp?: () => void;
}

export function SignUpScreen({ onBack, onSignIn, onSignUp }: SignUpScreenProps) {
  const [name, setName] = useState("");
  const [email, setEmail] = useState("");
  const [password, setPassword] = useState("");
  const [showPassword, setShowPassword] = useState(false);

  const handleSignUp = () => {
    // Handle sign up logic here
    console.log("Sign up with:", name, email, password);
    onSignUp?.();
  };

  return (
    <div className="min-h-screen w-full flex flex-col bg-background">
      {/* Header */}
      <div className="flex items-center pt-12 pb-8" style={{ paddingLeft: 'max(16px, env(safe-area-inset-left))', paddingRight: 'max(16px, env(safe-area-inset-right))' }}>
        <Button
          variant="ghost"
          size="icon"
          onClick={onBack}
          className="w-11 h-11 rounded-xl text-muted-foreground hover:text-foreground hover:bg-muted"
        >
          <ArrowLeft className="w-5 h-5" />
        </Button>
      </div>

      {/* Content */}
      <div className="flex-1 flex flex-col justify-center" style={{ paddingLeft: 'max(16px, env(safe-area-inset-left))', paddingRight: 'max(16px, env(safe-area-inset-right))' }}>
        <div className="w-full max-w-xs mx-auto space-y-6">
          {/* Welcome text */}
          <div className="text-center space-y-2">
            <h1>Join ThriveSpace</h1>
            <div className="text-muted-foreground space-y-1">
              <p>Start your</p>
              <p>mindful wellness</p>
              <p>journey today</p>
            </div>
          </div>

          {/* Social login buttons */}
          <div className="space-y-3">
            <SocialLoginButton provider="apple" />
            <SocialLoginButton provider="google" />
            <SocialLoginButton provider="facebook" />
          </div>

          {/* Divider */}
          <div className="flex items-center space-x-4">
            <Separator className="flex-1" />
            <span className="text-sm text-muted-foreground">or</span>
            <Separator className="flex-1" />
          </div>

          {/* Form fields */}
          <div className="space-y-4">
            <div className="space-y-2">
              <Label htmlFor="name">Full Name</Label>
              <div className="relative">
                <User className="absolute left-3 top-1/2 transform -translate-y-1/2 w-4 h-4 text-muted-foreground" />
                <Input
                  id="name"
                  type="text"
                  value={name}
                  onChange={(e) => setName(e.target.value)}
                  className="pl-10 h-12 rounded-2xl border-input-border bg-input-background focus:border-primary focus:ring-2 focus:ring-ring"
                  placeholder="Enter your full name"
                />
              </div>
            </div>

            <div className="space-y-2">
              <Label htmlFor="email">Email</Label>
              <div className="relative">
                <Mail className="absolute left-3 top-1/2 transform -translate-y-1/2 w-4 h-4 text-muted-foreground" />
                <Input
                  id="email"
                  type="email"
                  value={email}
                  onChange={(e) => setEmail(e.target.value)}
                  className="pl-10 h-12 rounded-2xl border-input-border bg-input-background focus:border-primary focus:ring-2 focus:ring-ring"
                  placeholder="Enter your email"
                />
              </div>
            </div>

            <div className="space-y-2">
              <Label htmlFor="password">Password</Label>
              <div className="relative">
                <Lock className="absolute left-3 top-1/2 transform -translate-y-1/2 w-4 h-4 text-muted-foreground" />
                <Input
                  id="password"
                  type={showPassword ? "text" : "password"}
                  value={password}
                  onChange={(e) => setPassword(e.target.value)}
                  className="pl-10 pr-12 h-12 rounded-2xl border-input-border bg-input-background focus:border-primary focus:ring-2 focus:ring-ring"
                  placeholder="Create a strong password"
                />
                <Button
                  type="button"
                  variant="ghost"
                  size="icon"
                  onClick={() => setShowPassword(!showPassword)}
                  className="absolute right-3 top-1/2 transform -translate-y-1/2 w-8 h-8 text-muted-foreground hover:text-foreground"
                >
                  {showPassword ? <EyeOff className="w-4 h-4" /> : <Eye className="w-4 h-4" />}
                </Button>
              </div>
              <p className="text-xs text-muted-foreground">
                Password must be at least 8 characters long
              </p>
            </div>
          </div>

          {/* Terms and privacy */}
          <p className="text-xs text-muted-foreground text-center leading-relaxed">
            By signing up, you agree to our{" "}
            <span className="text-primary hover:text-primary-hover underline cursor-pointer">Terms of Service</span> and{" "}
            <span className="text-primary hover:text-primary-hover underline cursor-pointer">Privacy Policy</span>
          </p>

          {/* Sign up button */}
          <div className="pt-4">
            <Button
              onClick={handleSignUp}
              className="w-full h-12 bg-primary hover:bg-primary-hover text-primary-foreground rounded-2xl"
            >
              Create Account
            </Button>
          </div>

          {/* Sign in link */}
          <div className="text-center pt-6 pb-8">
            <span className="text-muted-foreground">Already have an account? </span>
            <Button
              variant="link"
              onClick={onSignIn}
              className="text-primary hover:text-primary-hover p-0 h-auto"
            >
              Sign In
            </Button>
          </div>
        </div>
      </div>
    </div>
  );
}