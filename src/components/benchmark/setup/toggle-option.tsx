import { Label } from "@/components/ui/label";
import { Switch } from "@/components/ui/switch";
import { cn } from "@/lib/utils";

interface ToggleOptionProps {
  label: string;
  isEnabled?: boolean;
  onToggle?: (checked: boolean) => void;
  className?: string;
}
export function ToggleOption({
  label,
  isEnabled,
  onToggle,
  className,
}: ToggleOptionProps) {
  const key = `${label}-switch`;
  return (
    <div className="flex h-8 items-center">
      <Label
        htmlFor={key}
        className={cn("w-full pr-2 text-sm font-normal", className)}
      >
        {label}
      </Label>
      <Switch
        id={key}
        checked={isEnabled}
        onCheckedChange={onToggle}
        className="cursor-pointer"
      />
    </div>
  );
}
