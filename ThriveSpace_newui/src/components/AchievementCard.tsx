import { LucideIcon } from "lucide-react";
import { Card, CardContent } from "./ui/card";
import { Progress } from "./ui/progress";

interface AchievementCardProps {
  title: string;
  value: string | number;
  unit?: string;
  target?: number;
  icon: LucideIcon;
  color: "teal" | "purple" | "blue";
  className?: string;
}

export function AchievementCard({ 
  title, 
  value, 
  unit, 
  target, 
  icon: Icon, 
  color,
  className = "" 
}: AchievementCardProps) {
  const colorClasses = {
    teal: "bg-teal/10 text-teal",
    purple: "bg-purple/10 text-purple", 
    blue: "bg-blue-500/10 text-blue-500"
  };

  const progressColorClasses = {
    teal: "bg-teal",
    purple: "bg-purple",
    blue: "bg-blue-500"
  };

  const currentValue = typeof value === 'string' ? parseFloat(value) || 0 : value;
  const progressPercentage = target ? Math.min((currentValue / target) * 100, 100) : 0;

  return (
    <Card className={`border-border/50 hover:shadow-sm transition-shadow duration-200 ${className}`}>
      <CardContent className="p-4">
        <div className="space-y-3">
          {/* Header */}
          <div className="flex items-center justify-between">
            <div className={`w-8 h-8 rounded-lg flex items-center justify-center ${colorClasses[color]}`}>
              <Icon className="w-4 h-4" />
            </div>
            {target && (
              <span className="text-xs text-muted-foreground">
                /{target}{unit && ` ${unit}`}
              </span>
            )}
          </div>
          
          {/* Value */}
          <div>
            <div className="flex items-baseline space-x-1">
              <span className="text-xl font-semibold text-foreground">
                {typeof value === 'number' ? value.toLocaleString() : value}
              </span>
              {unit && !target && (
                <span className="text-sm text-muted-foreground">{unit}</span>
              )}
            </div>
            <p className="text-sm text-muted-foreground mt-1">{title}</p>
          </div>

          {/* Progress bar */}
          {target && (
            <div className="space-y-1">
              <Progress 
                value={progressPercentage} 
                className="h-1.5"
                style={{
                  // @ts-ignore
                  '--progress-background': `var(--color-${color})`
                }}
              />
              <div className="flex justify-between text-xs text-muted-foreground">
                <span>{Math.round(progressPercentage)}%</span>
                <span>{target - currentValue > 0 ? `${Math.round(target - currentValue)} to go` : 'Goal reached!'}</span>
              </div>
            </div>
          )}
        </div>
      </CardContent>
    </Card>
  );
}