// Define the layout for Spotify dataset
EXPORT SpotifyLayout := RECORD
    STRING genre;
    STRING Artist_name;
    STRING track_name;
    INTEGER year;
    INTEGER Popularity;
END;

SpotifyDS := DATASET('~spotify::songs', SpotifyLayout, FLAT);

// (A) Sort and count by genre
SortedByGenre := SORT(SpotifyDS, genre);
OUTPUT(SortedByGenre, NAMED('SongsByGenre'));
OUTPUT(COUNT(SpotifyDS), NAMED('TotalSongs'));

// (B) Garage genre songs
GarageSongs := SpotifyDS(genre = 'garage');
OUTPUT(GarageSongs, NAMED('GarageSongs'));
OUTPUT(COUNT(GarageSongs), NAMED('TotalGarageSongs'));

// (C) Prince songs from 2001
PrinceSongs := SpotifyDS(Artist_name = 'Prince' AND year = 2001);
OUTPUT(COUNT(PrinceSongs), NAMED('PrinceSongsCount'));

// (D) Find who sang Temptation to Exist
TemptationSong := SpotifyDS(track_name = 'Temptation to Exist');
OUTPUT(TemptationSong, NAMED('TemptationArtist'));

// (E) Sort by Artist and Track
SortedSongs := SORT(SpotifyDS, Artist_name, track_name);
OUTPUT(SortedSongs, NAMED('SortedByArtistTrack'));

// (F) Most popular song
MostPopular := TOPN(SpotifyDS, 1, -Popularity);
OUTPUT(MostPopular, NAMED('MostPopularSong'));