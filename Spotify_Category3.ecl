// Define the layout for Spotify dataset
EXPORT Spotify_Category3 := MODULE
    EXPORT Layout := RECORD
        STRING genre;
        STRING artist_name;
        STRING track_name;
        INTEGER year;
        INTEGER popularity;
    END;

    EXPORT File := DATASET('~spotify::songs', Layout, FLAT);

    EXPORT NewLayout := RECORD
        STRING Song;
        STRING Artist;
        BOOLEAN isPopular;
        STRING Genre;
    END;

    SHARED NewLayout TransformRec(Layout L) := TRANSFORM
        SELF.Song := L.track_name;
        SELF.Artist := L.artist_name;
        SELF.isPopular := L.popularity > 80;
        SELF.Genre := L.genre;
    END;

    EXPORT TransformedDS := PROJECT(File, TransformRec(LEFT));

    SHARED GenreRec := RECORD
        STRING genre := File.genre;
        INTEGER SongCount := COUNT(GROUP);
    END;

    EXPORT GenreCounts := TABLE(File, GenreRec, genre);
    EXPORT TotalGenres := COUNT(GenreCounts);

    SHARED ArtistRec := RECORD
        STRING artist_name := File.artist_name;
        STRING genre := File.genre;
        INTEGER AvgPopularity := AVE(GROUP, File.popularity);
    END;

    EXPORT Songs2023 := File(year = 2023);
    EXPORT ArtistPopularity := TABLE(Songs2023, ArtistRec, artist_name);
END;