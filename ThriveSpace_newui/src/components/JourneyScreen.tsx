import { useState } from "react";
import { Sun, Moon, TrendingUp } from "lucide-react";
import { Button } from "./ui/button";
import { Tabs, TabsContent, TabsList, TabsTrigger } from "./ui/tabs";
import { ScrollArea } from "./ui/scroll-area";
import { OverviewChart } from "./OverviewChart";
import { DailyAchievementsTab } from "./DailyAchievementsTab";
import { DietPlanTab } from "./DietPlanTab";
import { WorkoutPlanTab } from "./WorkoutPlanTab";

// Mock data for the overview chart
const chartData = [
  { day: "Mon", wellness: 75, activity: 68, nutrition: 82 },
  { day: "Tue", wellness: 80, activity: 75, nutrition: 78 },
  { day: "Wed", wellness: 85, activity: 82, nutrition: 85 },
  { day: "Thu", wellness: 78, activity: 70, nutrition: 80 },
  { day: "Fri", wellness: 88, activity: 85, nutrition: 90 },
  { day: "Sat", wellness: 92, activity: 90, nutrition: 88 },
  { day: "Sun", wellness: 85, activity: 78, nutrition: 85 }
];

export function JourneyScreen() {
  const [activeTab, setActiveTab] = useState("achievements");
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
      <div className="sticky top-0 z-40 bg-background/95 backdrop-blur-sm border-b border-border">
        <div className="flex items-center justify-between px-4 py-3">
          <div className="flex items-center space-x-3">
            <div className="w-8 h-8 rounded-lg bg-teal/10 flex items-center justify-center">
              <TrendingUp className="w-4 h-4 text-teal" />
            </div>
            <h1 className="font-semibold text-lg text-foreground">My Journey</h1>
          </div>
          
          <Button 
            variant="ghost" 
            size="icon" 
            onClick={toggleTheme}
            className="w-9 h-9 text-muted-foreground hover:text-foreground"
          >
            {isDark ? <Sun className="w-4 h-4" /> : <Moon className="w-4 h-4" />}
          </Button>
        </div>
      </div>

      {/* Content */}
      <div className="max-w-md mx-auto">
        <ScrollArea className="h-[calc(100vh-240px)]">
          <div className="p-4 space-y-6">
            
            {/* Overview Chart */}
            <OverviewChart data={chartData} title="Weekly Progress" />

            {/* Tabs */}
            <Tabs value={activeTab} onValueChange={setActiveTab} className="w-full">
              <TabsList className="grid w-full grid-cols-3 bg-muted/30">
                <TabsTrigger 
                  value="achievements"
                  className="text-xs data-[state=active]:bg-background data-[state=active]:text-foreground"
                >
                  Daily Stats
                </TabsTrigger>
                <TabsTrigger 
                  value="diet"
                  className="text-xs data-[state=active]:bg-background data-[state=active]:text-foreground"
                >
                  Diet Plan
                </TabsTrigger>
                <TabsTrigger 
                  value="workout"
                  className="text-xs data-[state=active]:bg-background data-[state=active]:text-foreground"
                >
                  Workouts
                </TabsTrigger>
              </TabsList>
              
              <div className="mt-4">
                <TabsContent value="achievements" className="m-0">
                  <DailyAchievementsTab />
                </TabsContent>
                
                <TabsContent value="diet" className="m-0">
                  <DietPlanTab />
                </TabsContent>
                
                <TabsContent value="workout" className="m-0">
                  <WorkoutPlanTab />
                </TabsContent>
              </div>
            </Tabs>

            {/* Bottom spacing for navigation */}
            <div className="h-4" />
          </div>
        </ScrollArea>
      </div>
    </div>
  );
}