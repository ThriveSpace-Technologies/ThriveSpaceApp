import { Plus } from "lucide-react";
import { Button } from "./ui/button";

interface FloatingActionButtonProps {
  onClick: () => void;
}

export function FloatingActionButton({ onClick }: FloatingActionButtonProps) {
  return (
    <Button
      onClick={onClick}
      className="fixed bottom-6 right-6 w-14 h-14 rounded-full bg-teal hover:bg-teal-light text-white shadow-lg hover:shadow-xl transition-all duration-200 z-50"
      size="icon"
    >
      <Plus className="w-6 h-6" />
    </Button>
  );
}