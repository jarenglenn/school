import {
  Input as DaisyInput,
  InputProps as DaisyInputProps,
} from "react-daisyui";

interface TextInputProps extends DaisyInputProps {
  label: string;
  labelClassName?: string;
}

export function Input(props: TextInputProps) {
  const defaultClassName =
    "flex flex-col text-sm font-medium text-accent-content ";

  return (
    <label className={defaultClassName + props.className}>
      <p className="text-lg">{props.label}</p>
      <DaisyInput className="mt-1 w-96" {...props} />
    </label>
  );
}
