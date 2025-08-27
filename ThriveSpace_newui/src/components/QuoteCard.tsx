import { Quote, Bookmark, Share2 } from "lucide-react";
import { Button } from "./ui/button";
import { Card, CardContent } from "./ui/card";

interface QuoteCardProps {
  quote: string;
  author?: string;
  category: string;
  type: "quote" | "tip";
  onBookmark?: () => void;
  onShare?: () => void;
  isBookmarked?: boolean;
}

export function QuoteCard({ 
  quote, 
  author, 
  category, 
  type,
  onBookmark,
  onShare,
  isBookmarked = false
}: QuoteCardProps) {
  const isQuote = type === "quote";
  
  return (
    <Card className="border-border/50 hover:shadow-md transition-all duration-200 hover:border-border">
      <CardContent className="p-5">
        <div className="space-y-4">
          {/* Header */}
          <div className="flex items-center justify-between">
            <div className="flex items-center space-x-2">
              <div className={`w-8 h-8 rounded-lg flex items-center justify-center ${
                isQuote 
                  ? 'bg-purple/10 text-purple' 
                  : 'bg-teal/10 text-teal'
              }`}>
                {isQuote ? (
                  <Quote className="w-4 h-4" />
                ) : (
                  <div className="w-2 h-2 rounded-full bg-current" />
                )}
              </div>
              
              <div>
                <span className="text-xs text-muted-foreground uppercase tracking-wide">
                  {category}
                </span>
              </div>
            </div>
            
            <div className="flex items-center space-x-1">
              <Button
                variant="ghost"
                size="icon"
                onClick={onBookmark}
                className="w-8 h-8"
              >
                <Bookmark 
                  className={`w-4 h-4 ${
                    isBookmarked 
                      ? 'text-teal fill-current' 
                      : 'text-muted-foreground hover:text-foreground'
                  }`} 
                />
              </Button>
              
              <Button
                variant="ghost"
                size="icon"
                onClick={onShare}
                className="w-8 h-8 text-muted-foreground hover:text-foreground"
              >
                <Share2 className="w-4 h-4" />
              </Button>
            </div>
          </div>
          
          {/* Content */}
          <div className="space-y-3">
            <div className="min-h-[60px] flex items-center">
              <p className={`leading-relaxed ${
                isQuote 
                  ? 'text-foreground italic' 
                  : 'text-foreground'
              }`}>
                {isQuote ? `"${quote}"` : quote}
              </p>
            </div>
            
            {author && (
              <div className="pt-2 border-t border-border/30">
                <p className="text-sm text-muted-foreground">
                  — {author}
                </p>
              </div>
            )}
          </div>
        </div>
      </CardContent>
    </Card>
  );
}