import { useState } from "react";
import { Sun, Moon, BookOpen, Heart, Lightbulb } from "lucide-react";
import { Button } from "./ui/button";
import { ScrollArea } from "./ui/scroll-area";
import { DailyInsightCard } from "./DailyInsightCard";
import { AffirmationCard } from "./AffirmationCard";
import { QuoteCard } from "./QuoteCard";

// Mock data
const dailyInsight = {
  title: "The Power of Morning Gratitude",
  description: "Discover how starting your day with gratitude can transform your mindset and set a positive tone for everything that follows.",
  image: "https://images.unsplash.com/photo-1630406866478-a2fca6070d25?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3Nzg4Nzd8MHwxfHNlYXJjaHwxfHxwZWFjZWZ1bCUyMHN1bnJpc2UlMjBtZWRpdGF0aW9ufGVufDF8fHx8MTc1NjI3MDM5MXww&ixlib=rb-4.1.0&q=80&w=1080",
  date: "Today",
  readTime: "5 min read"
};

const affirmations = [
  {
    id: "1",
    title: "Self Love",
    affirmation: "I am worthy of love and respect, starting with the love I give myself.",
    category: "CONFIDENCE",
    duration: "2 min",
    gradient: "teal" as const
  },
  {
    id: "2", 
    title: "Inner Peace",
    affirmation: "I release what I cannot control and find peace in the present moment.",
    category: "MINDFULNESS",
    duration: "3 min",
    gradient: "purple" as const
  },
  {
    id: "3",
    title: "Abundance",
    affirmation: "I am grateful for all the abundance that flows into my life daily.",
    category: "GRATITUDE",
    duration: "2 min",
    gradient: "blue" as const
  },
  {
    id: "4",
    title: "Strength",
    affirmation: "I have the strength to overcome any challenge that comes my way.",
    category: "RESILIENCE", 
    duration: "3 min",
    gradient: "green" as const
  }
];

const quotes = [
  {
    id: "1",
    quote: "The present moment is the only time over which we have dominion.",
    author: "Thích Nhất Hạnh",
    category: "MINDFULNESS",
    type: "quote" as const
  },
  {
    id: "2",
    quote: "Start each day with 5 minutes of deep breathing. This simple practice helps regulate your nervous system and sets a calm foundation for your day.",
    category: "WELLNESS TIP",
    type: "tip" as const
  },
  {
    id: "3",
    quote: "What lies behind us and what lies before us are tiny matters compared to what lies within us.",
    author: "Ralph Waldo Emerson", 
    category: "INSPIRATION",
    type: "quote" as const
  },
  {
    id: "4",
    quote: "Practice the 3-3-3 rule when feeling anxious: Name 3 things you can see, 3 sounds you can hear, and move 3 parts of your body.",
    category: "WELLNESS TIP",
    type: "tip" as const
  },
  {
    id: "5",
    quote: "Be yourself; everyone else is already taken.",
    author: "Oscar Wilde",
    category: "SELF-LOVE",
    type: "quote" as const
  }
];

export function LearnScreen() {
  const [likedAffirmations, setLikedAffirmations] = useState<Set<string>>(new Set());
  const [bookmarkedQuotes, setBookmarkedQuotes] = useState<Set<string>>(new Set());
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

  const handleAffirmationLike = (id: string) => {
    setLikedAffirmations(prev => {
      const newSet = new Set(prev);
      if (newSet.has(id)) {
        newSet.delete(id);
      } else {
        newSet.add(id);
      }
      return newSet;
    });
  };

  const handleQuoteBookmark = (id: string) => {
    setBookmarkedQuotes(prev => {
      const newSet = new Set(prev);
      if (newSet.has(id)) {
        newSet.delete(id);
      } else {
        newSet.add(id);
      }
      return newSet;
    });
  };

  const handleQuoteShare = (id: string) => {
    console.log("Share quote:", id);
    // Handle share functionality
  };

  const handleReadInsight = () => {
    console.log("Read daily insight");
    // Handle navigation to full article
  };

  const handlePlayAffirmation = (id: string) => {
    console.log("Play affirmation:", id);
    // Handle audio playback
  };

  return (
    <div className="min-h-screen bg-background">
      {/* Header */}
      <div className="sticky top-0 z-40 bg-background/95 backdrop-blur-sm border-b border-border">
        <div className="flex items-center justify-between px-4 py-3">
          <div className="flex items-center space-x-3">
            <div className="w-8 h-8 rounded-lg bg-teal/10 flex items-center justify-center">
              <BookOpen className="w-4 h-4 text-teal" />
            </div>
            <h1 className="font-semibold text-lg text-foreground">Learn</h1>
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
          <div className="p-4 space-y-8">
            
            {/* Daily Insight */}
            <section>
              <div className="flex items-center space-x-2 mb-4">
                <div className="w-6 h-6 rounded-md bg-teal/10 flex items-center justify-center">
                  <Sun className="w-3 h-3 text-teal" />
                </div>
                <h2 className="font-medium text-foreground">Daily Insight</h2>
              </div>
              
              <DailyInsightCard
                {...dailyInsight}
                onRead={handleReadInsight}
              />
            </section>

            {/* Affirmations */}
            <section>
              <div className="flex items-center space-x-2 mb-4">
                <div className="w-6 h-6 rounded-md bg-purple/10 flex items-center justify-center">
                  <Heart className="w-3 h-3 text-purple" />
                </div>
                <h2 className="font-medium text-foreground">Affirmations</h2>
              </div>
              
              <ScrollArea className="w-full">
                <div className="flex space-x-4 pb-2">
                  {affirmations.map((affirmation) => (
                    <AffirmationCard
                      key={affirmation.id}
                      {...affirmation}
                      isLiked={likedAffirmations.has(affirmation.id)}
                      onLike={() => handleAffirmationLike(affirmation.id)}
                      onPlay={() => handlePlayAffirmation(affirmation.id)}
                    />
                  ))}
                </div>
              </ScrollArea>
            </section>

            {/* Wisdom & Tips */}
            <section>
              <div className="flex items-center space-x-2 mb-4">
                <div className="w-6 h-6 rounded-md bg-teal/10 flex items-center justify-center">
                  <Lightbulb className="w-3 h-3 text-teal" />
                </div>
                <h2 className="font-medium text-foreground">Wisdom & Tips</h2>
              </div>
              
              <div className="space-y-4">
                {quotes.map((quote) => (
                  <QuoteCard
                    key={quote.id}
                    {...quote}
                    isBookmarked={bookmarkedQuotes.has(quote.id)}
                    onBookmark={() => handleQuoteBookmark(quote.id)}
                    onShare={() => handleQuoteShare(quote.id)}
                  />
                ))}
              </div>
            </section>

            {/* Bottom spacing for navigation */}
            <div className="h-4" />
          </div>
        </ScrollArea>
      </div>
    </div>
  );
}