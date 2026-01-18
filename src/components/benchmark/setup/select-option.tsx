import { Label } from "@/components/ui/label";
import {
  Select as UISelect,
  SelectContent,
  SelectItem,
  SelectTrigger,
  SelectValue,
} from "@/components/ui/select";
import { cn } from "@/lib/utils";

export type SelectOptionType<T extends string> = {
  label: string;
  value: T;
  customDisplay?: React.ReactNode;
};

interface SelectOptionProps<T extends string> {
  label: string;
  options: SelectOptionType<T>[];
  selectedValue: string;
  onChange: (value: T) => void;
  placeholder?: string;
  align?: "start" | "center" | "end";
  side?: "top" | "right" | "bottom" | "left";
}

export function SelectOption<T extends string>({
  label,
  options,
  selectedValue,
  onChange,
  placeholder,
  align,
  side,
}: SelectOptionProps<T>) {
  return (
    <div className="flex items-center gap-2">
      <Label htmlFor={`${label}-select`} className="text-sm font-normal">
        {label}
      </Label>
      <Select
        selectedValue={selectedValue}
        options={options}
        onChange={onChange}
        className="ml-auto"
        side={side}
        align={align}
        placeholder={placeholder}
      />
    </div>
  );
}

export function Select<T extends string>({
  selectedValue,
  options,
  onChange,
  className,
  placeholder,
  align = "start",
  side = "bottom",
}: Omit<SelectOptionProps<T>, "label"> & {
  className?: string;
}) {
  return (
    <UISelect value={selectedValue} onValueChange={onChange}>
      <SelectTrigger
        size="sm"
        className={cn(
          "hover:bg-accent dark:hover:bg-accent data-[state=open]:bg-accent dark:data-[state=open]:bg-accent w-fit border-none px-2 shadow-none hover:cursor-pointer dark:bg-transparent",
          className,
        )}
      >
        <SelectValue placeholder={placeholder ?? "Select option"} />
      </SelectTrigger>
      <SelectContent align={align} side={side}>
        {options.map((option) => (
          <SelectItem key={option.value} value={option.value}>
            {option.customDisplay ?? option.label}
          </SelectItem>
        ))}
      </SelectContent>
    </UISelect>
  );
}
