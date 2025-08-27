import { useState } from "react";
import { Button } from "./ui/button";
import { Input } from "./ui/input";
import { Label } from "./ui/label";
import { Separator } from "./ui/separator";
import { ArrowLeft, Mail, Lock, Eye, EyeOff } from "lucide-react";
import { SocialLoginButton } from "./SocialLoginButton";

interface SignInScreenProps {
  onBack: () => void;
  onSignUp: () => void;
  onForgotPassword: () => void;
  onSignIn?: () => void;
}

export function SignInScreen({ onBack, onSignUp, onForgotPassword, onSignIn }: SignInScreenProps) {
  const [email, setEmail] = useState("");
  const [password, setPassword] = useState("");
  const [showPassword, setShowPassword] = useState(false);

  const handleSignIn = () => {
    // Handle sign in logic here
    console.log("Sign in with:", email, password);
    onSignIn?.();
  };

  return (
    <div className="min-h-screen w-full flex flex-col bg-background">
      {/* Header with back button */}
      <div className="flex items-center justify-between pt-12 pb-8" style={{ paddingLeft: 'max(16px, env(safe-area-inset-left))', paddingRight: 'max(16px, env(safe-area-inset-right))' }}>
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
            <h1>Welcome Back</h1>
            <div className="text-muted-foreground space-y-1">
              <p>Continue</p>
              <p>your</p>
              <p>wellness</p>
              <p>journey</p>
            </div>
          </div>

          {/* Social login buttons */}
          <div className="space-y-3 pt-4">
            <SocialLoginButton provider="apple" />
            <SocialLoginButton provider="google" />
            <SocialLoginButton provider="facebook" />
          </div>

          {/* Divider */}
          <div className="flex items-center space-x-4 py-2">
            <Separator className="flex-1" />
            <span className="text-sm text-muted-foreground">or</span>
            <Separator className="flex-1" />
          </div>

          {/* Email and password form */}
          <div className="space-y-4">
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
                  placeholder="Enter your password"
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
            </div>

            <div className="flex justify-center pt-2">
              <Button
                variant="link"
                onClick={onForgotPassword}
                className="text-primary hover:text-primary-hover p-0 h-auto"
              >
                Forgot Password?
              </Button>
            </div>
          </div>

          {/* Sign in button */}
          <div className="pt-4">
            <Button
              onClick={handleSignIn}
              className="w-full h-12 bg-primary hover:bg-primary-hover text-primary-foreground rounded-2xl"
            >
              Sign In
            </Button>
          </div>

          {/* Sign up link */}
          <div className="text-center pt-6 space-y-1">
            <p className="text-muted-foreground">Don't</p>
            <p className="text-muted-foreground">have</p>
            <p className="text-muted-foreground">an</p>
            <Button
              variant="link"
              onClick={onSignUp}
              className="text-primary hover:text-primary-hover p-0 h-auto"
            >
              account?
            </Button>
          </div>
        </div>
      </div>
    </div>
  );
}