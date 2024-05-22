"use client"

import useGetSongById from "@/hooks/useGetSongById";
import useLoadSongUrl from "@/hooks/useLoadSongUrl";
import usePlayer from "@/hooks/usePlayer";
import PayerContent from "./PlayerContent";

const Player = () => {
    const player = usePlayer();
    const { song } = useGetSongById(player.activeId);
    // TODO: Count how many times a song is played

    // const songUrl = useLoadSongUrl(song!);

    if(!song || !song.song_path || !player.activeId) {
        return null;
    }

    return (
        <div
            className="
                fixed
                bottom-0
                bg-player
                w-full
                py-2
                h-[80px]
                px-4
            "
        >
            <PayerContent
                key={song.song_path}
                song={song}
                songUrl={song.song_path}
            />
        </div>
    );
}

export default Player;