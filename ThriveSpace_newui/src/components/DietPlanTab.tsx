import { MealCard } from "./MealCard";

export function DietPlanTab() {
  const meals = [
    {
      title: "Breakfast",
      time: "8:00 AM",
      foods: [
        { name: "Greek Yogurt", calories: 150, portion: "1 cup" },
        { name: "Blueberries", calories: 80, portion: "1/2 cup" },
        { name: "Granola", calories: 120, portion: "2 tbsp" }
      ]
    },
    {
      title: "Morning Snack",
      time: "10:30 AM",
      isEmpty: true
    },
    {
      title: "Lunch",
      time: "12:30 PM",
      foods: [
        { name: "Grilled Chicken Salad", calories: 280, portion: "1 serving" },
        { name: "Olive Oil Dressing", calories: 90, portion: "1 tbsp" }
      ]
    },
    {
      title: "Afternoon Snack",
      time: "3:30 PM",
      foods: [
        { name: "Apple", calories: 80, portion: "1 medium" },
        { name: "Almond Butter", calories: 95, portion: "1 tbsp" }
      ]
    },
    {
      title: "Dinner",
      time: "7:00 PM",
      isEmpty: true
    }
  ];

  const totalCalories = meals.reduce((total, meal) => {
    if (meal.foods) {
      return total + meal.foods.reduce((sum, food) => sum + food.calories, 0);
    }
    return total;
  }, 0);

  const calorieGoal = 2000;
  const remainingCalories = calorieGoal - totalCalories;

  const handleAddMeal = (mealTitle: string) => {
    console.log("Add meal for:", mealTitle);
    // Handle adding meal
  };

  const handleEditMeal = (mealTitle: string) => {
    console.log("Edit meal for:", mealTitle);
    // Handle editing meal
  };

  return (
    <div className="space-y-4">
      {/* Daily summary */}
      <div className="bg-muted/30 rounded-xl p-4">
        <h4 className="font-medium text-foreground mb-3">Today's Nutrition</h4>
        <div className="grid grid-cols-3 gap-4 text-center">
          <div>
            <div className="text-lg font-semibold text-teal">{totalCalories}</div>
            <div className="text-xs text-muted-foreground">Consumed</div>
          </div>
          <div>
            <div className="text-lg font-semibold text-purple">{remainingCalories}</div>
            <div className="text-xs text-muted-foreground">Remaining</div>
          </div>
          <div>
            <div className="text-lg font-semibold text-blue-500">{calorieGoal}</div>
            <div className="text-xs text-muted-foreground">Goal</div>
          </div>
        </div>
      </div>

      {/* Meals */}
      <div className="space-y-3">
        {meals.map((meal, index) => (
          <MealCard
            key={index}
            title={meal.title}
            time={meal.time}
            foods={meal.foods}
            isEmpty={meal.isEmpty}
            onAdd={() => handleAddMeal(meal.title)}
            onEdit={() => handleEditMeal(meal.title)}
          />
        ))}
      </div>

      {/* Nutrition tips */}
      <div className="bg-teal/5 border border-teal/20 rounded-xl p-4 mt-6">
        <h4 className="font-medium text-foreground mb-2">💡 Nutrition Tip</h4>
        <p className="text-sm text-muted-foreground leading-relaxed">
          Try to include a source of protein in every meal to help maintain stable blood sugar levels and keep you feeling satisfied longer.
        </p>
      </div>
    </div>
  );
}