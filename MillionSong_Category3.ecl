// Define the layout for Million Song dataset
EXPORT MillionSong_Category3 := MODULE
    EXPORT Layout := RECORD
        STRING Title;
        STRING Artist_name;
        REAL song_hotness;
        REAL Loudness;
        INTEGER Year;
    END;

    EXPORT File := DATASET('~million::song', Layout, FLAT);

    // (A) Create new dataset with conditions
    EXPORT NewLayout := RECORD
        STRING Song;
        STRING Artist;
        BOOLEAN isPopular;
        BOOLEAN IsTooLoud;
    END;

    EXPORT NewLayout TransformRec(Layout L) := TRANSFORM
        SELF.Song := L.Title;
        SELF.Artist := L.Artist_name;
        SELF.isPopular := L.song_hotness > 0.80;
        SELF.IsTooLoud := L.Loudness > 0;
    END;

    EXPORT NewDS := PROJECT(File, TransformRec(LEFT));
    EXPORT First50Transformed := CHOOSEN(NewDS, 50);

    // (B) Songs per Year
    EXPORT YearCounts := TABLE(File, 
                       {Year, 
                        INTEGER TotalSongs := COUNT(GROUP)}, 
                        Year);
    EXPORT TotalYears := COUNT(YearCounts);

    // (C) Hottest Artist 2006-2007
    EXPORT FilteredYears := File(Year IN [2006, 2007]);
    EXPORT ArtistHotness := TABLE(FilteredYears,
                          {Artist_name,
                           REAL AvgHotness := AVE(GROUP, song_hotness)},
                           Artist_name);
    EXPORT SortedHotness := SORT(ArtistHotness, -AvgHotness);
    EXPORT HottestArtist := CHOOSEN(SortedHotness, 1);
END;