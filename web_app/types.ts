export interface Song {
  id: string;
  user_id: string;
  author: string;
  title: string;
  song_path: string;
  image_path: string;
  language : string;
}

export interface Playlist {
  id: string;
  songs: Song;
}