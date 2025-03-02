"use client";

import LikeButton from "@/components/LikeButton";
import MediaItem from "@/components/MediaItem";
import useOnPlay from "@/hooks/useOnPlay";
import { useUser } from "@/hooks/useUser";
import { Song } from "@/types";
import { useRouter } from "next/navigation";
import { useEffect } from "react";

interface LikedSongsProps {
    songs: Song[];
    languages: string[];
}

const LikedSongs: React.FC<LikedSongsProps> = ({ songs, languages }) => {
    const router = useRouter();
    const { isLoading, user } = useUser();

    const onPlay = useOnPlay(songs);

    useEffect(() => {
        if (!isLoading && !user) {
            router.replace('/');
        }
    }, [isLoading, user, router]);

    if (languages.length !== 0) {
        let filteredSongs = songs.filter(song => languages.includes(song.language));
        if (languages.includes("Others")) {
            filteredSongs = [
                ...filteredSongs,
                ...songs.filter(song => !["English", "Spanish", "French"].includes(song.language))
            ];
        }
        songs = filteredSongs;
    }

    if (songs.length === 0) {
        return (
            <div
                className="
                    flex
                    flex-col
                    gap-y-2
                    w-full
                    px-6
                    text-secondary
                "
            >
                No liked songs.
            </div>
        );
    }

    return (
        <div className="flex flex-col gap-y-2 w-full p-6">
            {songs.map((song) => (
                <div
                    key={song.id}
                    className="flex items-center gap-x-4 w-full"
                >
                    <div className="flex-1">
                        <MediaItem
                            onClick={(id: string) => onPlay(id)}
                            data={song}
                        />
                    </div>
                    <LikeButton songId={song.id} />
                </div>
            ))}
        </div>
    );
};

export default LikedSongs;
