import { Plus, Edit3, Clock, Flame } from "lucide-react";
import { Button } from "./ui/button";
import { Card, CardContent } from "./ui/card";
import { Badge } from "./ui/badge";

interface MealCardProps {
  title: string;
  time: string;
  calories?: number;
  foods?: Array<{
    name: string;
    calories: number;
    portion: string;
  }>;
  isEmpty?: boolean;
  onAdd?: () => void;
  onEdit?: () => void;
}

export function MealCard({ 
  title, 
  time, 
  calories, 
  foods = [], 
  isEmpty = false,
  onAdd,
  onEdit 
}: MealCardProps) {
  const totalCalories = foods.reduce((sum, food) => sum + food.calories, 0) || calories || 0;

  if (isEmpty) {
    return (
      <Card className="border-border/50 border-dashed hover:border-border transition-colors duration-200">
        <CardContent className="p-4">
          <div className="flex items-center justify-between mb-3">
            <div>
              <h4 className="font-medium text-foreground">{title}</h4>
              <div className="flex items-center space-x-1 mt-1">
                <Clock className="w-3 h-3 text-muted-foreground" />
                <span className="text-sm text-muted-foreground">{time}</span>
              </div>
            </div>
          </div>
          
          <Button
            onClick={onAdd}
            variant="ghost"
            className="w-full h-16 border-2 border-dashed border-border/50 hover:border-teal/50 hover:bg-teal/5 transition-colors duration-200"
          >
            <div className="flex flex-col items-center space-y-1">
              <Plus className="w-5 h-5 text-muted-foreground" />
              <span className="text-sm text-muted-foreground">Add meal</span>
            </div>
          </Button>
        </CardContent>
      </Card>
    );
  }

  return (
    <Card className="border-border/50 hover:shadow-sm transition-shadow duration-200">
      <CardContent className="p-4">
        <div className="space-y-3">
          {/* Header */}
          <div className="flex items-center justify-between">
            <div>
              <h4 className="font-medium text-foreground">{title}</h4>
              <div className="flex items-center space-x-1 mt-1">
                <Clock className="w-3 h-3 text-muted-foreground" />
                <span className="text-sm text-muted-foreground">{time}</span>
              </div>
            </div>
            
            <div className="flex items-center space-x-2">
              {totalCalories > 0 && (
                <Badge variant="secondary" className="bg-teal/10 text-teal border-teal/20">
                  <Flame className="w-3 h-3 mr-1" />
                  {totalCalories} cal
                </Badge>
              )}
              <Button
                onClick={onEdit}
                variant="ghost"
                size="icon"
                className="w-8 h-8 text-muted-foreground hover:text-foreground"
              >
                <Edit3 className="w-4 h-4" />
              </Button>
            </div>
          </div>

          {/* Foods */}
          {foods.length > 0 && (
            <div className="space-y-2">
              {foods.map((food, index) => (
                <div key={index} className="flex items-center justify-between py-2 px-3 bg-muted/30 rounded-lg">
                  <div>
                    <span className="text-sm font-medium text-foreground">{food.name}</span>
                    <span className="text-xs text-muted-foreground ml-2">({food.portion})</span>
                  </div>
                  <span className="text-xs text-muted-foreground">{food.calories} cal</span>
                </div>
              ))}
            </div>
          )}

          {/* Add more button */}
          <Button
            onClick={onAdd}
            variant="ghost"
            size="sm"
            className="w-full h-8 text-teal hover:text-teal-light hover:bg-teal/5"
          >
            <Plus className="w-3 h-3 mr-1" />
            Add food
          </Button>
        </div>
      </CardContent>
    </Card>
  );
}