"use client"

import LikeButton from "@/components/LikeButton";
import MediaItem from "@/components/MediaItem";
import useOnPlay from "@/hooks/useOnPlay";
import { Song } from "@/types";

interface SearchContentProps {
    songs: Song[];
}

const SearchContent: React.FC<SearchContentProps> = ({
    songs
}) => {
    const onPlay = useOnPlay(songs); //TODO: download if no song_path by running python using 'child_process'
    // TODO: lien entre le nom de la musique/auteur et le lien youtube
    // par exemple : https://www.youtube.com/results?search_query=Audio+Smack+That+Akon

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
                No songs found.
            </div>
        )
    }
    return (
        <div className="flex flex-col gap-y-2 w-full px-6">
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
}

export default SearchContent;