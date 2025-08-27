import { ImageWithFallback } from "./figma/ImageWithFallback";

interface CategoryCardProps {
  title: string;
  subtitle?: string;
  image: string;
  size?: "small" | "medium" | "large";
  onClick?: () => void;
}

export function CategoryCard({ 
  title, 
  subtitle, 
  image, 
  size = "medium", 
  onClick 
}: CategoryCardProps) {
  const sizeClasses = {
    small: "aspect-square",
    medium: "aspect-[3/4]",
    large: "aspect-[4/5]"
  };

  return (
    <button
      onClick={onClick}
      className={`relative overflow-hidden rounded-xl bg-card border border-border hover:shadow-md transition-all duration-200 group ${sizeClasses[size]}`}
    >
      <ImageWithFallback
        src={image}
        alt={title}
        className="w-full h-full object-cover group-hover:scale-105 transition-transform duration-300"
      />
      
      {/* Gradient overlay */}
      <div className="absolute inset-0 bg-gradient-to-t from-black/60 via-black/20 to-transparent" />
      
      {/* Content */}
      <div className="absolute bottom-0 left-0 right-0 p-3">
        <h3 className="text-white font-medium text-sm leading-tight">
          {title}
        </h3>
        {subtitle && (
          <p className="text-white/80 text-xs mt-1 leading-tight">
            {subtitle}
          </p>
        )}
      </div>
    </button>
  );
}