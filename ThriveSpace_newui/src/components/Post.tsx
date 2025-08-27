import { useState } from "react";
import { Heart, MessageCircle, Share, MoreHorizontal } from "lucide-react";
import { Button } from "./ui/button";
import { Avatar, AvatarFallback, AvatarImage } from "./ui/avatar";
import { ImageWithFallback } from "./figma/ImageWithFallback";

interface PostProps {
  id: string;
  user: {
    name: string;
    username: string;
    avatar: string;
  };
  content: string;
  image?: string;
  likes: number;
  comments: number;
  timestamp: string;
  isLiked?: boolean;
}

export function Post({ 
  user, 
  content, 
  image, 
  likes, 
  comments, 
  timestamp, 
  isLiked = false 
}: PostProps) {
  const [liked, setLiked] = useState(isLiked);
  const [likeCount, setLikeCount] = useState(likes);

  const handleLike = () => {
    setLiked(!liked);
    setLikeCount(prev => liked ? prev - 1 : prev + 1);
  };

  return (
    <div className="bg-card rounded-xl border border-border shadow-sm hover:shadow-md transition-shadow duration-200 overflow-hidden">
      {/* Header */}
      <div className="flex items-center justify-between p-4 pb-3">
        <div className="flex items-center space-x-3">
          <Avatar className="w-10 h-10">
            <AvatarImage src={user.avatar} alt={user.name} />
            <AvatarFallback className="bg-teal/10 text-teal">
              {user.name.split(' ').map(n => n[0]).join('').toUpperCase()}
            </AvatarFallback>
          </Avatar>
          <div>
            <h3 className="font-medium text-card-foreground">{user.name}</h3>
            <p className="text-sm text-muted-foreground">@{user.username} • {timestamp}</p>
          </div>
        </div>
        <Button variant="ghost" size="icon" className="w-8 h-8 text-muted-foreground">
          <MoreHorizontal className="w-4 h-4" />
        </Button>
      </div>

      {/* Content */}
      <div className="px-4 pb-3">
        <p className="text-card-foreground leading-relaxed">{content}</p>
      </div>

      {/* Image */}
      {image && (
        <div className="px-4 pb-3">
          <div className="rounded-lg overflow-hidden">
            <ImageWithFallback
              src={image}
              alt="Post image"
              className="w-full h-48 object-cover"
            />
          </div>
        </div>
      )}

      {/* Actions */}
      <div className="flex items-center justify-between px-4 py-3 border-t border-border/50">
        <div className="flex items-center space-x-4">
          <Button
            variant="ghost"
            size="sm"
            onClick={handleLike}
            className={`h-8 px-3 ${
              liked 
                ? 'text-red-500 hover:text-red-600' 
                : 'text-muted-foreground hover:text-red-500'
            }`}
          >
            <Heart className={`w-4 h-4 mr-2 ${liked ? 'fill-current' : ''}`} />
            {likeCount}
          </Button>
          
          <Button variant="ghost" size="sm" className="h-8 px-3 text-muted-foreground hover:text-teal">
            <MessageCircle className="w-4 h-4 mr-2" />
            {comments}
          </Button>
        </div>

        <Button variant="ghost" size="icon" className="w-8 h-8 text-muted-foreground hover:text-teal">
          <Share className="w-4 h-4" />
        </Button>
      </div>
    </div>
  );
}