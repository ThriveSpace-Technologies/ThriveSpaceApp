import { ExerciseCard } from "./ExerciseCard";

export function WorkoutPlanTab() {
  const exercises = [
    {
      name: "Morning Walk",
      type: "cardio" as const,
      duration: "30 min",
      difficulty: "beginner" as const,
      completed: true
    },
    {
      name: "Push-ups",
      type: "strength" as const,
      sets: 3,
      reps: "10-15",
      difficulty: "intermediate" as const,
      progress: 75
    },
    {
      name: "Yoga Flow",
      type: "flexibility" as const,
      duration: "20 min",
      difficulty: "beginner" as const,
      progress: 0
    },
    {
      name: "Squats",
      type: "strength" as const,
      sets: 3,
      reps: "15-20",
      difficulty: "beginner" as const,
      progress: 0
    },
    {
      name: "Meditation Balance",
      type: "balance" as const,
      duration: "10 min",
      difficulty: "beginner" as const,
      progress: 0
    },
    {
      name: "Plank Hold",
      type: "strength" as const,
      duration: "60 sec",
      sets: 3,
      reps: "1 min",
      difficulty: "intermediate" as const,
      progress: 0
    }
  ];

  const completedCount = exercises.filter(ex => ex.completed).length;
  const totalExercises = exercises.length;
  const completionPercentage = Math.round((completedCount / totalExercises) * 100);

  const handleStartExercise = (name: string) => {
    console.log("Start exercise:", name);
    // Handle starting exercise
  };

  const handleCompleteExercise = (name: string) => {
    console.log("Complete exercise:", name);
    // Handle completing exercise
  };

  return (
    <div className="space-y-4">
      {/* Workout summary */}
      <div className="bg-muted/30 rounded-xl p-4">
        <h4 className="font-medium text-foreground mb-3">Today's Workout</h4>
        <div className="grid grid-cols-3 gap-4 text-center">
          <div>
            <div className="text-lg font-semibold text-teal">{completedCount}</div>
            <div className="text-xs text-muted-foreground">Completed</div>
          </div>
          <div>
            <div className="text-lg font-semibold text-purple">{totalExercises - completedCount}</div>
            <div className="text-xs text-muted-foreground">Remaining</div>
          </div>
          <div>
            <div className="text-lg font-semibold text-blue-500">{completionPercentage}%</div>
            <div className="text-xs text-muted-foreground">Progress</div>
          </div>
        </div>
      </div>

      {/* Exercises */}
      <div className="space-y-3">
        {exercises.map((exercise, index) => (
          <ExerciseCard
            key={index}
            {...exercise}
            onStart={() => handleStartExercise(exercise.name)}
            onComplete={() => handleCompleteExercise(exercise.name)}
          />
        ))}
      </div>

      {/* Workout tip */}
      <div className="bg-purple/5 border border-purple/20 rounded-xl p-4 mt-6">
        <h4 className="font-medium text-foreground mb-2">🏋️ Workout Tip</h4>
        <p className="text-sm text-muted-foreground leading-relaxed">
          Remember to warm up before exercising and cool down afterwards. Listen to your body and rest when needed.
        </p>
      </div>
    </div>
  );
}