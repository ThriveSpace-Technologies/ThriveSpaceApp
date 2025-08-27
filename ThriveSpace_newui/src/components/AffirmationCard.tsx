import { Heart, Play } from "lucide-react";
import { Button } from "./ui/button";
import { Card, CardContent } from "./ui/card";

interface AffirmationCardProps {
  title: string;
  affirmation: string;
  category: string;
  duration?: string;
  gradient: "teal" | "purple" | "blue" | "green";
  onPlay?: () => void;
  onLike?: () => void;
  isLiked?: boolean;
}

export function AffirmationCard({ 
  title, 
  affirmation, 
  category, 
  duration = "2 min",
  gradient,
  onPlay,
  onLike,
  isLiked = false
}: AffirmationCardProps) {
  const gradientClasses = {
    teal: "bg-gradient-to-br from-teal/20 to-teal-light/10 border-teal/20",
    purple: "bg-gradient-to-br from-purple/20 to-purple-light/10 border-purple/20",
    blue: "bg-gradient-to-br from-blue-500/20 to-blue-400/10 border-blue-500/20",
    green: "bg-gradient-to-br from-emerald-500/20 to-emerald-400/10 border-emerald-500/20"
  };

  const iconColors = {
    teal: "text-teal",
    purple: "text-purple", 
    blue: "text-blue-500",
    green: "text-emerald-500"
  };

  return (
    <Card className={`w-64 flex-shrink-0 ${gradientClasses[gradient]} transition-all duration-200 hover:shadow-md`}>
      <CardContent className="p-4">
        <div className="space-y-4">
          {/* Header */}
          <div className="flex items-start justify-between">
            <div className="space-y-1">
              <span className="text-xs text-muted-foreground uppercase tracking-wide">
                {category}
              </span>
              <h4 className="font-medium text-foreground leading-tight">
                {title}
              </h4>
            </div>
            
            <Button
              variant="ghost"
              size="icon"
              onClick={onLike}
              className="w-8 h-8 flex-shrink-0"
            >
              <Heart 
                className={`w-4 h-4 ${
                  isLiked 
                    ? `${iconColors[gradient]} fill-current` 
                    : 'text-muted-foreground hover:text-foreground'
                }`} 
              />
            </Button>
          </div>
          
          {/* Affirmation text */}
          <div className="min-h-[60px] flex items-center">
            <p className="text-sm text-foreground/90 leading-relaxed italic">
              "{affirmation}"
            </p>
          </div>
          
          {/* Footer */}
          <div className="flex items-center justify-between pt-2">
            <span className="text-xs text-muted-foreground">
              {duration}
            </span>
            
            <Button
              onClick={onPlay}
              size="sm"
              className={`h-8 px-3 bg-white/80 dark:bg-black/80 hover:bg-white dark:hover:bg-black border ${iconColors[gradient]} hover:${iconColors[gradient]}`}
              variant="outline"
            >
              <Play className="w-3 h-3 mr-1.5 fill-current" />
              Listen
            </Button>
          </div>
        </div>
      </CardContent>
    </Card>
  );
}