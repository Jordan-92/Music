"use client";

import useAuthModal from "@/hooks/useAuthModal";
import { useUser } from "@/hooks/useUser";

interface LanguageFilterProps {
  all_languages: string[];
}

const LanguageFilter: React.FC<LanguageFilterProps> = ({ button_name}) => {
  const authModal = useAuthModal();
  const { user } = useUser();
  const languages = [];

  const onClick = () => {
    if (!user) {
      return authModal.onOpen();
    }
    // todo
  };
  return (
    <div
        className="
            mt-5
            relative
            group
            items-center
            rounded-full
            overflow-hidden
            bg-neutral-100/10
            flex
        "
    >
        <button
            onClick={onClick}
            className="
                py-3
                w-1/4
                rounded-l-full
                hover:bg-neutral-100/20
                transition
            "
        >
            {button_name[0]}
        </button>
        <button
            onClick={onClick}
            className="
                py-3
                w-1/4
                hover:bg-neutral-100/20
                transition
            "
        >
            {button_name[1]}
        </button>
        <button
            onClick={onClick}
            className="
                py-3
                w-1/4
                hover:bg-neutral-100/20
                transition
            "
        >
            {button_name[2]}
        </button>
        <button
            onClick={onClick}
            className="
                py-3
                w-1/4
                rounded-r-full
                hover:bg-neutral-100/20
                transition
            "
        >
            {button_name[3]}
        </button>
    </div>

    
  
  );
};

export default LanguageFilter;
