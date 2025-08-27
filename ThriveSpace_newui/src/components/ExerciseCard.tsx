import { Play, Check, Clock, Repeat, Target } from "lucide-react";
import { Button } from "./ui/button";
import { Card, CardContent } from "./ui/card";
import { Progress } from "./ui/progress";
import { Badge } from "./ui/badge";

interface ExerciseCardProps {
  name: string;
  type: "cardio" | "strength" | "flexibility" | "balance";
  duration?: string;
  sets?: number;
  reps?: string;
  completed?: boolean;
  progress?: number;
  difficulty: "beginner" | "intermediate" | "advanced";
  onStart?: () => void;
  onComplete?: () => void;
}

export function ExerciseCard({ 
  name, 
  type, 
  duration, 
  sets, 
  reps, 
  completed = false,
  progress = 0,
  difficulty,
  onStart,
  onComplete 
}: ExerciseCardProps) {
  const typeColors = {
    cardio: "bg-purple/10 text-purple border-purple/20",
    strength: "bg-teal/10 text-teal border-teal/20",
    flexibility: "bg-blue-500/10 text-blue-500 border-blue-500/20",
    balance: "bg-emerald-500/10 text-emerald-500 border-emerald-500/20"
  };

  const difficultyColors = {
    beginner: "bg-green-500/10 text-green-600 border-green-500/20",
    intermediate: "bg-yellow-500/10 text-yellow-600 border-yellow-500/20", 
    advanced: "bg-red-500/10 text-red-600 border-red-500/20"
  };

  return (
    <Card className={`border-border/50 transition-all duration-200 ${
      completed ? 'bg-teal/5 border-teal/20' : 'hover:shadow-sm'
    }`}>
      <CardContent className="p-4">
        <div className="space-y-4">
          {/* Header */}
          <div className="flex items-start justify-between">
            <div className="space-y-2">
              <h4 className={`font-medium leading-tight ${
                completed ? 'text-foreground/70 line-through' : 'text-foreground'
              }`}>
                {name}
              </h4>
              
              <div className="flex items-center space-x-2">
                <Badge variant="outline" className={typeColors[type]}>
                  {type}
                </Badge>
                <Badge variant="outline" className={difficultyColors[difficulty]}>
                  {difficulty}
                </Badge>
              </div>
            </div>
            
            {completed ? (
              <div className="w-8 h-8 rounded-full bg-teal/20 flex items-center justify-center">
                <Check className="w-4 h-4 text-teal" />
              </div>
            ) : (
              <Button
                onClick={onStart}
                variant="ghost"
                size="icon"
                className="w-8 h-8 text-purple hover:text-purple-light hover:bg-purple/5"
              >
                <Play className="w-4 h-4 fill-current" />
              </Button>
            )}
          </div>

          {/* Stats */}
          <div className="flex items-center space-x-4 text-sm text-muted-foreground">
            {duration && (
              <div className="flex items-center space-x-1">
                <Clock className="w-3 h-3" />
                <span>{duration}</span>
              </div>
            )}
            
            {sets && reps && (
              <div className="flex items-center space-x-1">
                <Repeat className="w-3 h-3" />
                <span>{sets} sets × {reps}</span>
              </div>
            )}
            
            {progress > 0 && !completed && (
              <div className="flex items-center space-x-1">
                <Target className="w-3 h-3" />
                <span>{progress}% done</span>
              </div>
            )}
          </div>

          {/* Progress */}
          {progress > 0 && !completed && (
            <div className="space-y-2">
              <Progress value={progress} className="h-1.5" />
              <div className="flex justify-between items-center">
                <span className="text-xs text-muted-foreground">
                  {progress}% complete
                </span>
                <Button
                  onClick={onComplete}
                  variant="ghost"
                  size="sm"
                  className="h-6 px-2 text-xs text-teal hover:text-teal-light hover:bg-teal/5"
                >
                  Mark complete
                </Button>
              </div>
            </div>
          )}
        </div>
      </CardContent>
    </Card>
  );
}