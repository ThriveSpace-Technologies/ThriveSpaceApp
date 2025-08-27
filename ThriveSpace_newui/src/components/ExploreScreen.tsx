import { useState } from "react";
import { Sun, Moon, Heart, Activity, Brain, Apple } from "lucide-react";
import { Button } from "./ui/button";
import { Badge } from "./ui/badge";
import { ScrollArea } from "./ui/scroll-area";
import { SearchBar } from "./SearchBar";
import { CategoryCard } from "./CategoryCard";

// Mock data for explore content
const categories = [
  { id: "yoga", label: "Yoga", icon: Heart },
  { id: "mindfulness", label: "Mindfulness", icon: Brain },
  { id: "nutrition", label: "Nutrition", icon: Apple },
  { id: "workouts", label: "Workouts", icon: Activity },
];

const exploreContent = [
  {
    id: "1",
    title: "Morning Yoga Flow",
    subtitle: "Start your day with intention",
    image: "https://images.unsplash.com/photo-1635617240041-c95219c05542?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3Nzg4Nzd8MHwxfHNlYXJjaHwxfHx5b2dhJTIwcG9zZSUyMG1lZGl0YXRpb258ZW58MXx8fHwxNzU2MjY5OTYwfDA&ixlib=rb-4.1.0&q=80&w=1080",
    category: "yoga",
    size: "large" as const
  },
  {
    id: "2",
    title: "5-Minute Meditation",
    subtitle: "Quick mindfulness break",
    image: "https://images.unsplash.com/photo-1599744403700-b7330f3c4dbe?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3Nzg4Nzd8MHwxfHNlYXJjaHwxfHxtaW5kZnVsbmVzcyUyMHBlYWNlZnVsJTIwbmF0dXJlfGVufDF8fHx8MTc1NjI2OTk2MXww&ixlib=rb-4.1.0&q=80&w=1080",
    category: "mindfulness",
    size: "medium" as const
  },
  {
    id: "3",
    title: "Nutritious Bowl Recipes",
    subtitle: "Fuel your body right",
    image: "https://images.unsplash.com/photo-1670164745494-30747c120652?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3Nzg4Nzd8MHwxfHNlYXJjaHwxfHxoZWFsdGh5JTIwbnV0cml0aW9uJTIwZm9vZHxlbnwxfHx8fDE3NTYxOTg3Njd8MA&ixlib=rb-4.1.0&q=80&w=1080",
    category: "nutrition",
    size: "medium" as const
  },
  {
    id: "4",
    title: "HIIT Workout",
    subtitle: "20 minutes to stronger you",
    image: "https://images.unsplash.com/photo-1634788699201-77bbb9428ab6?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3Nzg4Nzd8MHwxfHNlYXJjaHwxfHxmaXRuZXNzJTIwd29ya291dCUyMGV4ZXJjaXNlfGVufDF8fHx8MTc1NjIzNTE4Nnww&ixlib=rb-4.1.0&q=80&w=1080",
    category: "workouts",
    size: "small" as const
  },
  {
    id: "5",
    title: "Mindful Living",
    subtitle: "Present moment awareness",
    image: "https://images.unsplash.com/photo-1611800065908-233b597db552?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3Nzg4Nzd8MHwxfHNlYXJjaHwxfHx3ZWxsbmVzcyUyMGxpZmVzdHlsZSUyMHBlYWNlZnVsfGVufDF8fHx8MTc1NjI2OTk2NXww&ixlib=rb-4.1.0&q=80&w=1080",
    category: "mindfulness",
    size: "small" as const
  },
  {
    id: "6",
    title: "Zen Meditation",
    subtitle: "Find your inner peace",
    image: "https://images.unsplash.com/photo-1755960899429-0b9becb76144?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3Nzg4Nzd8MHwxfHNlYXJjaHwxfHxtZWRpdGF0aW9uJTIwemVuJTIwY2FsbXxlbnwxfHx8fDE3NTYyNjk5NjV8MA&ixlib=rb-4.1.0&q=80&w=1080",
    category: "mindfulness",
    size: "medium" as const
  },
  {
    id: "7",
    title: "Smoothie Bowls",
    subtitle: "Colorful nutrition",
    image: "https://images.unsplash.com/photo-1592503469196-3a7880cc2d05?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3Nzg4Nzd8MHwxfHNlYXJjaHwxfHxoZWFsdGh5JTIwc21vb3RoaWUlMjBib3dsfGVufDF8fHx8MTc1NjI2OTk2NXww&ixlib=rb-4.1.0&q=80&w=1080",
    category: "nutrition",
    size: "small" as const
  },
  {
    id: "8",
    title: "Gentle Stretching",
    subtitle: "Release tension naturally",
    image: "https://images.unsplash.com/photo-1600881333290-31fdbdfbe493?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3Nzg4Nzd8MHwxfHNlYXJjaHwxfHxzdHJldGNoaW5nJTIwd2VsbG5lc3MlMjBleGVyY2lzZXxlbnwxfHx8fDE3NTYyNjk5NjV8MA&ixlib=rb-4.1.0&q=80&w=1080",
    category: "yoga",
    size: "medium" as const
  }
];

export function ExploreScreen() {
  const [selectedCategory, setSelectedCategory] = useState<string | null>(null);
  const [searchQuery, setSearchQuery] = useState("");
  const [isDark, setIsDark] = useState(() => {
    if (typeof window !== 'undefined') {
      return document.documentElement.classList.contains('dark');
    }
    return false;
  });

  const filteredContent = exploreContent.filter(item => {
    const matchesCategory = !selectedCategory || item.category === selectedCategory;
    const matchesSearch = !searchQuery || 
      item.title.toLowerCase().includes(searchQuery.toLowerCase()) ||
      item.subtitle?.toLowerCase().includes(searchQuery.toLowerCase());
    return matchesCategory && matchesSearch;
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

  const handleCategoryClick = (categoryId: string) => {
    setSelectedCategory(selectedCategory === categoryId ? null : categoryId);
  };

  const handleSearch = (query: string) => {
    setSearchQuery(query);
  };

  const handleCardClick = (itemId: string) => {
    console.log("Card clicked:", itemId);
    // Handle navigation to content detail
  };

  return (
    <div className="min-h-screen bg-background">
      {/* Header */}
      <div className="sticky top-0 z-40 bg-background/95 backdrop-blur-sm border-b border-border">
        <div className="flex items-center justify-between px-4 py-3">
          <h1 className="font-semibold text-lg text-foreground">Explore</h1>
          
          <Button 
            variant="ghost" 
            size="icon" 
            onClick={toggleTheme}
            className="w-9 h-9 text-muted-foreground hover:text-foreground"
          >
            {isDark ? <Sun className="w-4 h-4" /> : <Moon className="w-4 h-4" />}
          </Button>
        </div>

        {/* Search Bar */}
        <div className="px-4 pb-4">
          <SearchBar 
            placeholder="Search wellness content..."
            onChange={setSearchQuery}
            onSearch={handleSearch}
          />
        </div>

        {/* Category Filter */}
        <div className="px-4 pb-4">
          <ScrollArea className="w-full">
            <div className="flex space-x-3 pb-2">
              {categories.map((category) => {
                const Icon = category.icon;
                const isSelected = selectedCategory === category.id;
                
                return (
                  <Button
                    key={category.id}
                    variant={isSelected ? "default" : "outline"}
                    onClick={() => handleCategoryClick(category.id)}
                    className={`flex-shrink-0 h-9 px-4 rounded-full transition-all duration-200 ${
                      isSelected 
                        ? 'bg-teal text-white hover:bg-teal-light' 
                        : 'border-border hover:border-teal/50 hover:bg-teal/5'
                    }`}
                  >
                    <Icon className="w-4 h-4 mr-2" />
                    {category.label}
                  </Button>
                );
              })}
            </div>
          </ScrollArea>
        </div>
      </div>

      {/* Content Grid */}
      <div className="max-w-md mx-auto">
        <ScrollArea className="h-[calc(100vh-240px)]">
          <div className="p-4">
            {/* Results count */}
            {(selectedCategory || searchQuery) && (
              <div className="mb-4">
                <p className="text-sm text-muted-foreground">
                  {filteredContent.length} results
                  {selectedCategory && ` in ${categories.find(c => c.id === selectedCategory)?.label}`}
                  {searchQuery && ` for "${searchQuery}"`}
                </p>
              </div>
            )}

            {/* Masonry-style grid */}
            <div className="grid grid-cols-2 gap-3">
              {filteredContent.map((item, index) => (
                <div 
                  key={item.id}
                  className={`${
                    item.size === 'large' && index === 0 ? 'col-span-2' : 
                    item.size === 'medium' ? 'row-span-1' : 
                    'row-span-1'
                  }`}
                >
                  <CategoryCard
                    title={item.title}
                    subtitle={item.subtitle}
                    image={item.image}
                    size={item.size}
                    onClick={() => handleCardClick(item.id)}
                  />
                </div>
              ))}
            </div>

            {/* Empty state */}
            {filteredContent.length === 0 && (
              <div className="text-center py-12">
                <div className="w-16 h-16 mx-auto mb-4 rounded-full bg-muted flex items-center justify-center">
                  <Brain className="w-8 h-8 text-muted-foreground" />
                </div>
                <h3 className="font-medium text-foreground mb-2">No content found</h3>
                <p className="text-sm text-muted-foreground">
                  Try adjusting your search or category filter
                </p>
              </div>
            )}
          </div>
        </ScrollArea>
      </div>
    </div>
  );
}