import getSongs from "./getSongs";

const getSongsWithShazam = async (title: string) => {

    if (!title) {
        const allSongs = await getSongs();
        return allSongs;
    }

    try {
        const response = await fetch(`https://www.shazam.com/services/amapi/v1/catalog/BE/search?types=songs&term=${title}&limit=10`);
        const data = await response.json();
        const songs = [];
        for (const song of data.results.songs.data) {
            songs.push({
                id: 4, // index créer par supabase
                created_at: '2024-04-29T16:51:55.85275+00:00', // à la création
                title: song.attributes.name,
                song_path: 'song-Locked Away-lvl75q7n', // à la création
                album: song.attributes.albumName,
                author: song.attributes.artistName,
                language: song.attributes.audioLocale, // pour playlist
                genre: song.attributes.genreNames, // pour playlist mais à améliorer par IA
                trackNumber: song.attributes.trackNumber,
                releaseDate: song.attributes.releaseDate,
                duration: song.attributes.durationInMillis,
                playCount: 0,
                user_id: '44e1979f-cbcb-420a-a433-a633f4b9953c' // à retirer
            });
        }
        console.log(songs);
        return songs as any || [];
    } catch (error) {
        console.error('Error fetching search results:', error);
    }
};

export default getSongsWithShazam;
