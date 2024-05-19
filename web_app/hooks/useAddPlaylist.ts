import { create } from "zustand";

interface AddPlaylistStore {
  isOpen: boolean;
  onOpen: () => void;
  onClose: () => void;
}

const useAddPlaylist = create<AddPlaylistStore>((set) => ({
  isOpen: false,
  onOpen: () => set({ isOpen: true }),
  onClose: () => set({ isOpen: false }),
}));

export default useAddPlaylist;
