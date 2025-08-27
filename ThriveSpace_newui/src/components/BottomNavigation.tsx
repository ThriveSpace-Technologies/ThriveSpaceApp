import { Home, Search, BookOpen, TrendingUp, MessageCircle } from "lucide-react";
import { Button } from "./ui/button";

interface BottomNavigationProps {
  currentTab: "home" | "explore" | "learn" | "journey" | "messages";
  onTabChange: (tab: "home" | "explore" | "learn" | "journey" | "messages") => void;
}

export function BottomNavigation({ currentTab, onTabChange }: BottomNavigationProps) {
  const tabs = [
    { id: "home" as const, label: "Home", icon: Home },
    { id: "explore" as const, label: "Explore", icon: Search },
    { id: "learn" as const, label: "Learn", icon: BookOpen },
    { id: "journey" as const, label: "Journey", icon: TrendingUp },
    { id: "messages" as const, label: "Messages", icon: MessageCircle },
  ];

  return (
    <div className="fixed bottom-0 left-0 right-0 bg-background/95 backdrop-blur-sm border-t border-border z-50">
      <div className="max-w-md mx-auto px-4">
        <div className="flex items-center justify-between py-2">
          {tabs.map((tab) => {
            const Icon = tab.icon;
            const isActive = currentTab === tab.id;
            
            return (
              <Button
                key={tab.id}
                variant="ghost"
                onClick={() => onTabChange(tab.id)}
                className={`flex flex-col items-center justify-center h-12 flex-1 p-0 transition-colors duration-200 ${
                  isActive 
                    ? 'text-teal' 
                    : 'text-muted-foreground hover:text-foreground'
                }`}
              >
                <Icon className={`w-5 h-5 mb-1 ${isActive ? 'fill-current' : ''}`} />
                <span className="text-xs">{tab.label}</span>
              </Button>
            );
          })}
        </div>
      </div>
    </div>
  );
}