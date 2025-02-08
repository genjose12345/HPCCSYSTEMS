// Define the layout for Spotify dataset
EXPORT Spotify_Category1 := MODULE
    EXPORT Layout := RECORD
        STRING genre;
        STRING artist_name;
        STRING track_name;
        INTEGER year;
        INTEGER popularity;
    END;

    EXPORT File := DATASET('~spotify::songs', Layout, FLAT);

    SHARED GenreRec := RECORD
        STRING genre;
        INTEGER count := COUNT(GROUP);
    END;

    // (A) Sort and count by genre
    EXPORT SortedByGenre := SORT(File, genre);
    EXPORT TotalSongs := COUNT(File);

    // (B) Garage genre songs
    EXPORT GarageSongs := File(genre = 'garage');
    EXPORT TotalGarageSongs := COUNT(GarageSongs);

    // (C) Prince songs from 2001
    EXPORT PrinceSongs := File(artist_name = 'Prince' AND year = 2001);
    EXPORT PrinceSongsCount := COUNT(PrinceSongs);

    // (D) Find who sang Temptation to Exist
    EXPORT TemptationSong := File(track_name = 'Temptation to Exist');

    // (E) Sort by Artist and Track
    EXPORT SortedSongs := SORT(File, artist_name, track_name);

    // (F) Most popular song
    EXPORT MostPopular := TOPN(File, 1, -popularity);
END;