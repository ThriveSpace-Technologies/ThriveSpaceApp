import { useState } from "react";
import { MessageCircle, Users, Club, Search, Plus, Sun, Moon } from "lucide-react";
import { Button } from "./ui/button";
import { Input } from "./ui/input";
import { Avatar } from "./ui/avatar";
import { Badge } from "./ui/badge";

type MessageSection = "direct" | "groups" | "clubs";

interface ChatItem {
  id: string;
  name: string;
  avatar: string;
  lastMessage: string;
  timestamp: string;
  unreadCount?: number;
  isOnline?: boolean;
  type: MessageSection;
}

const mockChats: ChatItem[] = [
  // Direct Messages
  {
    id: "1",
    name: "Dr. Sarah Chen",
    avatar: "SC",
    lastMessage: "How are you feeling today?",
    timestamp: "2m",
    unreadCount: 2,
    isOnline: true,
    type: "direct"
  },
  {
    id: "2",
    name: "Maya Wellness Coach",
    avatar: "MW",
    lastMessage: "Great progress on your mindfulness goals!",
    timestamp: "1h",
    isOnline: true,
    type: "direct"
  },
  {
    id: "3",
    name: "Alex Rodriguez",
    avatar: "AR",
    lastMessage: "Thanks for the meditation recommendation",
    timestamp: "3h",
    type: "direct"
  },
  
  // Groups
  {
    id: "4",
    name: "Mindful Mornings",
    avatar: "MM",
    lastMessage: "Emma: Starting my day with gratitude 🙏",
    timestamp: "15m",
    unreadCount: 5,
    type: "groups"
  },
  {
    id: "5",
    name: "Anxiety Support Circle",
    avatar: "AS",
    lastMessage: "James: Breathing exercises really helped today",
    timestamp: "45m",
    unreadCount: 3,
    type: "groups"
  },
  {
    id: "6",
    name: "Sleep Better Together",
    avatar: "SB",
    lastMessage: "Lisa: Shared a new bedtime routine",
    timestamp: "2h",
    type: "groups"
  },
  
  // Clubs
  {
    id: "7",
    name: "ThriveSpace Community",
    avatar: "TC",
    lastMessage: "Welcome to our wellness community! 🌱",
    timestamp: "1d",
    unreadCount: 12,
    type: "clubs"
  },
  {
    id: "8",
    name: "Meditation Masters",
    avatar: "M",
    lastMessage: "Weekly challenge: 10 minutes daily meditation",
    timestamp: "2d",
    unreadCount: 7,
    type: "clubs"
  },
  {
    id: "9",
    name: "Nutrition & Wellness",
    avatar: "NW",
    lastMessage: "Recipe share: Anti-inflammatory smoothie",
    timestamp: "3d",
    type: "clubs"
  }
];

export function MessagesScreen() {
  const [activeSection, setActiveSection] = useState<MessageSection>("direct");
  const [searchQuery, setSearchQuery] = useState("");
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

  const sections = [
    { id: "direct" as const, label: "Direct", icon: MessageCircle },
    { id: "groups" as const, label: "Groups", icon: Users },
    { id: "clubs" as const, label: "Clubs", icon: Club },
  ];

  const filteredChats = mockChats
    .filter(chat => chat.type === activeSection)
    .filter(chat => 
      chat.name.toLowerCase().includes(searchQuery.toLowerCase()) ||
      chat.lastMessage.toLowerCase().includes(searchQuery.toLowerCase())
    );

  return (
    <div className="min-h-screen bg-background">
      {/* Header */}
      <div className="sticky top-0 z-10 bg-background/95 backdrop-blur-sm border-b border-border">
        <div className="px-6 py-4">
          <div className="flex items-center justify-between mb-4">
            <h1 className="text-2xl font-medium text-foreground">Messages</h1>
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
          <div className="relative mb-4">
            <Search className="absolute left-3 top-1/2 transform -translate-y-1/2 text-muted-foreground w-4 h-4" />
            <Input
              placeholder="Search messages..."
              value={searchQuery}
              onChange={(e) => setSearchQuery(e.target.value)}
              className="pl-10 bg-input-background border-border"
            />
          </div>
          
          {/* Section Tabs */}
          <div className="flex bg-muted rounded-lg p-1">
            {sections.map((section) => {
              const Icon = section.icon;
              const isActive = activeSection === section.id;
              const sectionChatCount = mockChats.filter(chat => chat.type === section.id).length;
              
              return (
                <Button
                  key={section.id}
                  variant="ghost"
                  onClick={() => setActiveSection(section.id)}
                  className={`flex-1 relative transition-all duration-200 ${
                    isActive 
                      ? 'bg-background shadow-sm text-foreground' 
                      : 'text-muted-foreground hover:text-foreground'
                  }`}
                >
                  <Icon className="w-4 h-4 mr-2" />
                  {section.label}
                  <span className="ml-2 text-xs bg-muted-foreground/20 text-muted-foreground px-1.5 py-0.5 rounded-full">
                    {sectionChatCount}
                  </span>
                </Button>
              );
            })}
          </div>
        </div>
      </div>

      {/* Chat List */}
      <div className="px-6 py-2 pb-20">
        {filteredChats.length === 0 ? (
          <div className="text-center py-12">
            <MessageCircle className="w-12 h-12 text-muted-foreground mx-auto mb-4" />
            <h3 className="text-lg font-medium text-foreground mb-2">
              {searchQuery ? 'No messages found' : `No ${activeSection} messages yet`}
            </h3>
            <p className="text-muted-foreground">
              {searchQuery 
                ? 'Try adjusting your search terms' 
                : `Start a conversation to see your ${activeSection} messages here`
              }
            </p>
          </div>
        ) : (
          <div className="space-y-1">
            {filteredChats.map((chat) => (
              <ChatListItem key={chat.id} chat={chat} />
            ))}
          </div>
        )}
      </div>

      {/* Floating Action Button */}
      <Button 
        className="fixed bottom-20 right-6 w-14 h-14 rounded-full bg-teal hover:bg-teal-light text-white shadow-lg hover:shadow-xl transition-all duration-200 z-40"
        onClick={() => {
          // Handle new message action
          console.log(`Start new ${activeSection} conversation`);
        }}
      >
        <Plus className="w-6 h-6" />
      </Button>
    </div>
  );
}

interface ChatListItemProps {
  chat: ChatItem;
}

function ChatListItem({ chat }: ChatListItemProps) {
  return (
    <div className="flex items-center gap-3 p-4 rounded-xl bg-card hover:bg-accent/50 transition-colors duration-200 cursor-pointer border border-transparent hover:border-border/50">
      {/* Avatar */}
      <div className="relative">
        <Avatar className="w-12 h-12">
          <div className="w-full h-full bg-gradient-to-br from-teal to-teal-light flex items-center justify-center text-white font-medium">
            {chat.avatar}
          </div>
        </Avatar>
        {chat.isOnline && (
          <div className="absolute -bottom-0.5 -right-0.5 w-4 h-4 bg-green-500 border-2 border-background rounded-full"></div>
        )}
      </div>
      
      {/* Chat Info */}
      <div className="flex-1 min-w-0">
        <div className="flex items-center justify-between mb-1">
          <h3 className="font-medium text-foreground truncate">{chat.name}</h3>
          <span className="text-xs text-muted-foreground flex-shrink-0 ml-2">
            {chat.timestamp}
          </span>
        </div>
        <p className="text-sm text-muted-foreground truncate">
          {chat.lastMessage}
        </p>
      </div>
      
      {/* Unread Badge */}
      {chat.unreadCount && chat.unreadCount > 0 && (
        <Badge 
          variant="default" 
          className="bg-teal text-primary-foreground ml-2 min-w-[20px] h-5 flex items-center justify-center px-1.5"
        >
          {chat.unreadCount > 99 ? '99+' : chat.unreadCount}
        </Badge>
      )}
    </div>
  );
}