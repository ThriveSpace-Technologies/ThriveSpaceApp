import { Sunrise, ChevronRight } from "lucide-react";
import { Button } from "./ui/button";
import { Card, CardContent } from "./ui/card";
import { ImageWithFallback } from "./figma/ImageWithFallback";

interface DailyInsightCardProps {
  title: string;
  description: string;
  image: string;
  date: string;
  readTime?: string;
  onRead?: () => void;
}

export function DailyInsightCard({ 
  title, 
  description, 
  image, 
  date, 
  readTime = "3 min read",
  onRead 
}: DailyInsightCardProps) {
  return (
    <Card className="overflow-hidden border-border/50 shadow-sm hover:shadow-md transition-shadow duration-200">
      <div className="relative">
        <ImageWithFallback
          src={image}
          alt={title}
          className="w-full h-40 object-cover"
        />
        
        {/* Gradient overlay */}
        <div className="absolute inset-0 bg-gradient-to-t from-black/40 via-transparent to-transparent" />
        
        {/* Date badge */}
        <div className="absolute top-3 left-3">
          <div className="flex items-center space-x-2 bg-white/90 dark:bg-black/90 backdrop-blur-sm rounded-lg px-3 py-1.5">
            <Sunrise className="w-4 h-4 text-teal" />
            <span className="text-sm font-medium text-foreground">{date}</span>
          </div>
        </div>
      </div>
      
      <CardContent className="p-5">
        <div className="space-y-3">
          <div>
            <h3 className="font-semibold text-foreground leading-tight mb-2">
              {title}
            </h3>
            <p className="text-muted-foreground text-sm leading-relaxed">
              {description}
            </p>
          </div>
          
          <div className="flex items-center justify-between pt-2">
            <span className="text-xs text-muted-foreground">
              {readTime}
            </span>
            
            <Button
              onClick={onRead}
              variant="ghost"
              size="sm"
              className="text-teal hover:text-teal-light hover:bg-teal/5 h-8 px-3"
            >
              Read Now
              <ChevronRight className="w-4 h-4 ml-1" />
            </Button>
          </div>
        </div>
      </CardContent>
    </Card>
  );
}