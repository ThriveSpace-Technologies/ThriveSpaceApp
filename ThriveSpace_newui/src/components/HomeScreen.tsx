import { useState } from "react";
import { Bell, Sun, Moon } from "lucide-react";
import { Button } from "./ui/button";
import { Avatar, AvatarFallback, AvatarImage } from "./ui/avatar";
import { Tabs, TabsContent, TabsList, TabsTrigger } from "./ui/tabs";
import { ScrollArea } from "./ui/scroll-area";
import { Badge } from "./ui/badge";
import { Post } from "./Post";
import { FloatingActionButton } from "./FloatingActionButton";

// Mock data for posts
const mockPosts = [
  {
    id: "1",
    user: {
      name: "Emma Chen",
      username: "emmawellness",
      avatar: "https://images.unsplash.com/photo-1494790108755-2616b612b647?w=150&h=150&fit=crop&crop=face"
    },
    content: "Starting my morning with 10 minutes of meditation has completely transformed my day. The peace I feel carries through everything I do. 🧘‍♀️✨",
    image: "https://images.unsplash.com/photo-1635545999375-057ee4013deb?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3Nzg4Nzd8MHwxfHNlYXJjaHwxfHxtZWRpdGF0aW9uJTIwd2VsbG5lc3MlMjBtaW5kZnVsbmVzc3xlbnwxfHx8fDE3NTYyNjk3MjV8MA&ixlib=rb-4.1.0&q=80&w=1080",
    likes: 24,
    comments: 8,
    timestamp: "2h",
    isLiked: false
  },
  {
    id: "2",
    user: {
      name: "Marcus Johnson",
      username: "marcusyoga",
      avatar: "https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=150&h=150&fit=crop&crop=face"
    },
    content: "Yoga in nature hits differently. The fresh air, birds chirping, and feeling connected to the earth - this is what wellness means to me.",
    image: "https://images.unsplash.com/photo-1701416050721-2e8a9f765ac2?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3Nzg4Nzd8MHwxfHNlYXJjaHwxfHx5b2dhJTIwcGVhY2VmdWwlMjBuYXR1cmV8ZW58MXx8fHwxNzU2MjY5NzI1fDA&ixlib=rb-4.1.0&q=80&w=1080",
    likes: 42,
    comments: 12,
    timestamp: "4h",
    isLiked: true
  },
  {
    id: "3",
    user: {
      name: "Sarah Williams",
      username: "sarahwellness",
      avatar: "https://images.unsplash.com/photo-1438761681033-6461ffad8d80?w=150&h=150&fit=crop&crop=face"
    },
    content: "Remember: self-care isn't selfish. Taking time for yourself allows you to show up better for others. What's one thing you're doing for yourself today?",
    likes: 67,
    comments: 23,
    timestamp: "6h",
    isLiked: false
  },
  {
    id: "4",
    user: {
      name: "Dr. Alex Park",
      username: "drpark_wellness",
      avatar: "https://images.unsplash.com/photo-1559209172-d0d45d8d1ce8?w=150&h=150&fit=crop&crop=face"
    },
    content: "The science is clear: just 15 minutes of daily mindfulness practice can reduce stress hormones by up to 23%. Small habits, big impact.",
    image: "https://images.unsplash.com/photo-1601921386176-d6b3206b6ace?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3Nzg4Nzd8MHwxfHNlYXJjaHwxfHxtZW50YWwlMjBoZWFsdGglMjBzZWxmJTIwY2FyZXxlbnwxfHx8fDE3NTYyNjk3MjZ8MA&ixlib=rb-4.1.0&q=80&w=1080",
    likes: 89,
    comments: 31,
    timestamp: "8h",
    isLiked: true
  },
  {
    id: "5",
    user: {
      name: "Luna Rodriguez",
      username: "lunaheals",
      avatar: "https://images.unsplash.com/photo-1544005313-94ddf0286df2?w=150&h=150&fit=crop&crop=face"
    },
    content: "Meal prep Sunday is self-care Sunday. Nourishing my body with colorful, whole foods sets me up for a week of energy and vitality 🥗💚",
    image: "https://images.unsplash.com/photo-1613637069737-2cce919a4ab7?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3Nzg4Nzd8MHwxfHNlYXJjaHwxfHxoZWFsdGh5JTIwbGlmZXN0eWxlJTIwd2VsbG5lc3N8ZW58MXx8fHwxNzU2MjUzMDMyfDA&ixlib=rb-4.1.0&q=80&w=1080",
    likes: 35,
    comments: 15,
    timestamp: "12h",
    isLiked: false
  }
];

export function HomeScreen() {
  const [activeTab, setActiveTab] = useState("foryou");
  const [isDark, setIsDark] = useState(() => {
    if (typeof window !== 'undefined') {
      return document.documentElement.classList.contains('dark');
    }
    return false;
  });

  const handleNewPost = () => {
    console.log("New post clicked");
    // Handle new post creation
  };

  const handleNotifications = () => {
    console.log("Notifications clicked");
    // Handle notifications
  };



  const handleProfileClick = () => {
    console.log("Profile clicked");
    // Handle profile navigation
  };

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

  return (
    <div className="min-h-screen bg-background">
      {/* Header */}
      <div className="sticky top-0 z-40 bg-background/95 backdrop-blur-sm border-b border-border">
        <div className="flex items-center justify-between px-4 py-3">
          {/* Profile Avatar */}
          <Button 
            variant="ghost" 
            onClick={handleProfileClick}
            className="w-10 h-10 rounded-full p-0"
          >
            <Avatar className="w-10 h-10">
              <AvatarImage 
                src="https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?w=150&h=150&fit=crop&crop=face" 
                alt="Your profile" 
              />
              <AvatarFallback className="bg-teal/10 text-teal">YU</AvatarFallback>
            </Avatar>
          </Button>

          {/* App Title */}
          <h1 className="font-semibold text-lg text-foreground">ThriveSpace</h1>

          {/* Right Actions */}
          <div className="flex items-center space-x-1">
            <Button 
              variant="ghost" 
              size="icon" 
              onClick={toggleTheme}
              className="w-9 h-9 text-muted-foreground hover:text-foreground"
            >
              {isDark ? <Sun className="w-4 h-4" /> : <Moon className="w-4 h-4" />}
            </Button>
            
            <Button 
              variant="ghost" 
              size="icon" 
              onClick={handleNotifications}
              className="w-9 h-9 text-muted-foreground hover:text-foreground relative"
            >
              <Bell className="w-4 h-4" />
              <Badge className="absolute -top-0.5 -right-0.5 w-4 h-4 p-0 flex items-center justify-center bg-red-500 text-white text-xs">
                3
              </Badge>
            </Button>
          </div>
        </div>

        {/* Sub-tabs */}
        <Tabs value={activeTab} onValueChange={setActiveTab} className="w-full">
          <TabsList className="w-full h-12 bg-transparent p-0 border-b border-border rounded-none">
            <TabsTrigger 
              value="foryou" 
              className="flex-1 h-full rounded-none border-b-2 border-transparent data-[state=active]:border-teal data-[state=active]:bg-transparent data-[state=active]:text-teal"
            >
              For You
            </TabsTrigger>
            <TabsTrigger 
              value="following" 
              className="flex-1 h-full rounded-none border-b-2 border-transparent data-[state=active]:border-teal data-[state=active]:bg-transparent data-[state=active]:text-teal"
            >
              Following
            </TabsTrigger>
            <TabsTrigger 
              value="news" 
              className="flex-1 h-full rounded-none border-b-2 border-transparent data-[state=active]:border-teal data-[state=active]:bg-transparent data-[state=active]:text-teal"
            >
              Wellness News
            </TabsTrigger>
          </TabsList>
        </Tabs>
      </div>

      {/* Content */}
      <div className="max-w-md mx-auto">
        <Tabs value={activeTab} className="w-full">
          <TabsContent value="foryou" className="mt-0">
            <ScrollArea className="h-[calc(100vh-200px)]">
              <div className="space-y-4 p-4 pb-4">
                {mockPosts.map((post) => (
                  <Post key={post.id} {...post} />
                ))}
              </div>
            </ScrollArea>
          </TabsContent>
          
          <TabsContent value="following" className="mt-0">
            <ScrollArea className="h-[calc(100vh-200px)]">
              <div className="space-y-4 p-4 pb-4">
                {mockPosts.filter(post => post.user.username === 'emmawellness' || post.user.username === 'marcusyoga').map((post) => (
                  <Post key={post.id} {...post} />
                ))}
              </div>
            </ScrollArea>
          </TabsContent>
          
          <TabsContent value="news" className="mt-0">
            <ScrollArea className="h-[calc(100vh-200px)]">
              <div className="space-y-4 p-4 pb-4">
                {mockPosts.filter(post => post.user.username === 'drpark_wellness').map((post) => (
                  <Post key={post.id} {...post} />
                ))}
                <div className="text-center py-8">
                  <p className="text-muted-foreground">More wellness news coming soon...</p>
                </div>
              </div>
            </ScrollArea>
          </TabsContent>
        </Tabs>
      </div>

      {/* Floating Action Button */}
      <FloatingActionButton onClick={handleNewPost} />
    </div>
  );
}