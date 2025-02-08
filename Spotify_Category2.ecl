// Define the layout for Spotify dataset
EXPORT Spotify_Category2 := MODULE
    EXPORT Layout := RECORD
        STRING genre;
        STRING artist_name;
        STRING track_name;
        INTEGER year;
        INTEGER popularity;
    END;

    EXPORT File := DATASET('~spotify::songs', Layout, FLAT);

    // (A) Coldplay popular songs
    EXPORT ColdplayPopular := SORT(File(artist_name = 'Coldplay' AND popularity >= 75), track_name);
    EXPORT TotalColdplayPopular := COUNT(ColdplayPopular);

    // (B) Popular songs filter
    EXPORT FilteredSongs := File(popularity >= 80);
    EXPORT FilteredSongsCount := COUNT(FilteredSongs);

    // (C) New simplified dataset
    EXPORT NewLayout := RECORD
        STRING Artist;
        STRING Title;
        INTEGER Year;
    END;

    EXPORT NewLayout TransformRec(Layout L) := TRANSFORM
        SELF.Artist := L.artist_name;
        SELF.Title := L.track_name;
        SELF.Year := L.year;
    END;

    EXPORT NewDS := PROJECT(File, TransformRec(LEFT));
END;