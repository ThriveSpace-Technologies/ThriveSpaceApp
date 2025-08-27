import { Footprints, Moon, Flame, Target, Droplets, Heart } from "lucide-react";
import { AchievementCard } from "./AchievementCard";

export function DailyAchievementsTab() {
  const achievements = [
    {
      title: "Steps Taken",
      value: 8420,
      target: 10000,
      unit: "steps",
      icon: Footprints,
      color: "teal" as const
    },
    {
      title: "Sleep Quality",
      value: 7.5,
      target: 8,
      unit: "hrs",
      icon: Moon,
      color: "purple" as const
    },
    {
      title: "Calories Burned",
      value: 420,
      target: 500,
      unit: "cal",
      icon: Flame,
      color: "blue" as const
    },
    {
      title: "Active Minutes",
      value: 45,
      target: 60,
      unit: "min",
      icon: Target,
      color: "teal" as const
    },
    {
      title: "Water Intake",
      value: 6,
      target: 8,
      unit: "glasses",
      icon: Droplets,
      color: "blue" as const
    },
    {
      title: "Heart Rate Avg",
      value: 72,
      unit: "bpm",
      icon: Heart,
      color: "purple" as const
    }
  ];

  return (
    <div className="space-y-4">
      <div className="grid grid-cols-2 gap-3">
        {achievements.map((achievement, index) => (
          <AchievementCard key={index} {...achievement} />
        ))}
      </div>
      
      {/* Quick stats summary */}
      <div className="bg-muted/30 rounded-xl p-4 mt-6">
        <h4 className="font-medium text-foreground mb-3">Today's Summary</h4>
        <div className="grid grid-cols-3 gap-4 text-center">
          <div>
            <div className="text-lg font-semibold text-teal">84%</div>
            <div className="text-xs text-muted-foreground">Steps Goal</div>
          </div>
          <div>
            <div className="text-lg font-semibold text-purple">94%</div>
            <div className="text-xs text-muted-foreground">Sleep Goal</div>
          </div>
          <div>
            <div className="text-lg font-semibold text-blue-500">84%</div>
            <div className="text-xs text-muted-foreground">Calories Goal</div>
          </div>
        </div>
      </div>
    </div>
  );
}