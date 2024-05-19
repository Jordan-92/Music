"use client";

import FilterButton from "@/components/FilterButton";
import LikeButton from "@/components/LikeButton";
import LikedSongs from "@/components/LikedSongs";
import MediaItem from "@/components/MediaItem";
import useAuthModal from "@/hooks/useAuthModal";
import useOnPlay from "@/hooks/useOnPlay";
import { useUser } from "@/hooks/useUser";
import { Song } from "@/types";
import { useRouter } from "next/navigation";
import { useEffect, useState } from "react";

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
                bg-neutral-900
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
                    bg-neutral-100/10
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
                                ${isSelected ? 'bg-blue-600 text-white' : 'hover:bg-neutral-100/20'}
                                transition
                            `}
                            style={{
                                backgroundColor: isSelected ? '#267BF1' : 'initial',
                                color: isSelected ? 'white' : 'initial',
                            }}
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
