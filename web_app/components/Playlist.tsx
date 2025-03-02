"use client";

import useAuthModal from "@/hooks/useAuthModal";
import useAddPlaylist from "@/hooks/useAddPlaylist";
import { useUser } from "@/hooks/useUser";
import { Song } from "@/types";
import { AiOutlinePlus } from "react-icons/ai";
import { TbPlaylist } from "react-icons/tb";
import MediaItem from "./MediaItem";
import useOnPlay from "@/hooks/useOnPlay";


interface PlaylistProps {
  songs: Song[];
}

const Playlist: React.FC<PlaylistProps> = ({
  songs
}) => {
  const { user } = useUser();
  const authModal = useAuthModal();
  const addPlaylist = useAddPlaylist();
  
  const onPlay = useOnPlay(songs);

  const onClick = () => {
    if (!user) {
      return authModal.onOpen();
    }
    return addPlaylist.onOpen();
  };
  return (
    <div className="flex flex-col">
      <div
        className="
                    flex
                    items-center
                    justify-between
                    px-5
                    pt-4
                "
      >
        <div
          className="
                        inline-flex
                        items-center
                        gap-x-2
                    "
        >
          <TbPlaylist className="text-secondary" size={26} />
          <p
            className="
                            text-secondary
                            font-medium
                            text-md
                        "
          >
            Your Playlists
          </p>
        </div>
        <AiOutlinePlus
          onClick={onClick}
          size={20}
          className="
                        text-secondary
                        cursor-pointer
                        hover:text-primary
                        transition
                    "
        />
      </div>
      <div
        className="
                    flex
                    flex-col
                    gap-y-2
                    mt-4
                    px-3
                "
      >
        {songs.map((item) => (
          <MediaItem
            onClick={(id: string) => onPlay(id)}
            key={item.id}
            data={item}
          />
        ))}
      </div>
    </div>
  );
};

export default Playlist;
