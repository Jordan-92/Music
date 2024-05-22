"use client";

import LikedSongs from "@/components/LikedSongs";
import useAuthModal from "@/hooks/useAuthModal";
import { useUser } from "@/hooks/useUser";
import { Song } from "@/types";
import { useState } from "react";

interface LikedContentProps {
    songs: Song[];
}

const LikedContent: React.FC<LikedContentProps> = ({ songs }) => {
    const languages = ["English", "Spanish", "French", "Others"];
    const [languageSelection, setLanguageSelection] = useState<string[]>([]);

    const authModal = useAuthModal();
    const { user } = useUser();

    const onClick = (language: string) => {
        if (!user) {
            return authModal.onOpen();
        }

        setLanguageSelection(prevSelection => {
            if (prevSelection.includes(language)) {
                return prevSelection.filter(item => item !== language);
            } else {
                return [...prevSelection, language];
            }
        }); // TODO: Filter on genre & year
    };

    return (
        <div
            className="
                bg-background
                rounded-lg
                h-full
                w-full
                overflow-hidden
                overflow-y-auto
            "
        >
            <div
                className="
                    mt-5
                    relative
                    group
                    items-center
                    rounded-full
                    overflow-hidden
                    bg-brightened/10
                    flex
                "
            >
                {languages.map((language, index) => {
                    const isSelected = languageSelection.includes(language);
                    return (
                        <button
                            key={index}
                            onClick={() => onClick(language)}
                            className={`
                                py-3
                                w-1/4
                                ${index === 0 ? 'rounded-l-full' : ''}
                                ${index === languages.length - 1 ? 'rounded-r-full' : ''}
                                ${isSelected ? 'bg-gradient2 text-primary' : 'hover:bg-button/10'}
                                transition
                            `}
                        >
                            {language}
                        </button>
                    );
                })}
            </div>
            <LikedSongs songs={songs} languages={languageSelection} />
        </div>
    );
};

export default LikedContent;
