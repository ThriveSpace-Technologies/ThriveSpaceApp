import { useState, useEffect } from "react";
import { Button } from "./ui/button";
import { Sun, Moon } from "lucide-react";

export function ThemeToggle() {
  const [isDark, setIsDark] = useState(false);

  useEffect(() => {
    // Check for saved theme preference or default to light mode
    const savedTheme = localStorage.getItem("theme");
    const prefersDark = window.matchMedia("(prefers-color-scheme: dark)").matches;
    
    const shouldUseDark = savedTheme === "dark" || (!savedTheme && prefersDark);
    setIsDark(shouldUseDark);
    
    if (shouldUseDark) {
      document.documentElement.classList.add("dark");
    } else {
      document.documentElement.classList.remove("dark");
    }
  }, []);

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
    <Button
      variant="ghost"
      size="icon"
      onClick={toggleTheme}
      className="fixed top-6 right-6 z-50 w-10 h-10 rounded-lg bg-white/80 backdrop-blur-sm border border-neutral-200/60 hover:bg-white dark:bg-neutral-800/80 dark:border-neutral-700/60 dark:hover:bg-neutral-700 transition-all duration-200 shadow-sm"
    >
      {isDark ? (
        <Sun className="w-4 h-4 text-neutral-600 dark:text-neutral-300" />
      ) : (
        <Moon className="w-4 h-4 text-neutral-600 dark:text-neutral-300" />
      )}
    </Button>
  );
}