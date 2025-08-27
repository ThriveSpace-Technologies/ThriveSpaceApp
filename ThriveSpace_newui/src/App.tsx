import { useState } from "react";
import { WelcomeScreen } from "./components/WelcomeScreen";
import { SignInScreen } from "./components/SignInScreen";
import { SignUpScreen } from "./components/SignUpScreen";
import { HomeScreen } from "./components/HomeScreen";
import { ExploreScreen } from "./components/ExploreScreen";
import { LearnScreen } from "./components/LearnScreen";
import { JourneyScreen } from "./components/JourneyScreen";
import { MessagesScreen } from "./components/MessagesScreen";
import { DesignSystemShowcase } from "./components/DesignSystemShowcase";
import { BottomNavigation } from "./components/BottomNavigation";
import { ThemeToggle } from "./components/ThemeToggle";

type Screen = "welcome" | "signin" | "signup" | "home" | "explore" | "learn" | "journey" | "messages" | "design-system";
type MainTab = "home" | "explore" | "learn" | "journey" | "messages";

export default function App() {
  const [currentScreen, setCurrentScreen] = useState<Screen>("welcome");
  const [currentTab, setCurrentTab] = useState<MainTab>("home");

  const handleForgotPassword = () => {
    // Handle forgot password logic
    console.log("Forgot password clicked");
  };

  const handleSignIn = () => {
    // Simulate successful sign in
    setCurrentScreen("home");
    setCurrentTab("home");
  };

  const handleSignUp = () => {
    // Simulate successful sign up
    setCurrentScreen("home");
    setCurrentTab("home");
  };

  const handleTabChange = (tab: MainTab) => {
    setCurrentTab(tab);
    setCurrentScreen(tab);
  };

  const isMainApp = ["home", "explore", "learn", "journey", "messages"].includes(currentScreen);

  return (
    <div className="min-h-screen relative">
      {/* Theme toggle - only show on auth screens */}
      {!isMainApp && <ThemeToggle />}
      
      {/* Screen content */}
      {isMainApp ? (
        <div className="pb-16">
          {currentScreen === "home" && <HomeScreen />}
          {currentScreen === "explore" && <ExploreScreen />}
          {currentScreen === "learn" && <LearnScreen />}
          {currentScreen === "journey" && <JourneyScreen />}
          {currentScreen === "messages" && <MessagesScreen />}
          
          <BottomNavigation 
            currentTab={currentTab} 
            onTabChange={handleTabChange} 
          />
        </div>
      ) : (
        <>
          {currentScreen === "design-system" && <DesignSystemShowcase />}
          
          {currentScreen === "welcome" && (
            <WelcomeScreen 
              onGetStarted={() => setCurrentScreen("signin")}
            />
          )}
          
          {currentScreen === "signin" && (
            <SignInScreen
              onBack={() => setCurrentScreen("welcome")}
              onSignUp={() => setCurrentScreen("signup")}
              onForgotPassword={handleForgotPassword}
              onSignIn={handleSignIn}
            />
          )}
          
          {currentScreen === "signup" && (
            <SignUpScreen
              onBack={() => setCurrentScreen("welcome")}
              onSignIn={() => setCurrentScreen("signin")}
              onSignUp={handleSignUp}
            />
          )}
        </>
      )}
    </div>
  );
}