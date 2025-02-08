// Define the layout for Million Song dataset
EXPORT MillionSong_Category2 := MODULE
    EXPORT Layout := RECORD
        STRING Title;
        STRING Artist_Name;
        STRING Release_Name;
        INTEGER Year;
        REAL song_hotness;
        REAL artist_hotness;
        REAL Duration;
        REAL familiarity;
        REAL barsstartdev;
        REAL beatsstartdev;
    END;

    EXPORT File := DATASET('~million::song', Layout, FLAT);

    // (A) Coldplay hot songs
    EXPORT ColdplayHot := SORT(File(Artist_Name = 'Coldplay' AND song_hotness >= 0.75), Title);
    EXPORT TotalColdplayHot := COUNT(ColdplayHot);

    // (B) Duration and hotness filter
    EXPORT FilteredSongs := File(Duration >= 200 AND Duration <= 250 AND 
                                song_hotness <> 0 AND familiarity > 0.9);
    EXPORT FilteredSongsCount := COUNT(FilteredSongs);

    // (C) New dataset with selected fields
    EXPORT NewLayout := RECORD
        STRING Title;
        STRING Artist_Name;
        STRING Release_Name;
        INTEGER Year;
    END;

    EXPORT NewDataset := PROJECT(File, NewLayout);

    // (D) Correlations
    EXPORT SongArtistCorr := CORRELATION(File, song_hotness, artist_hotness);
    EXPORT BarsBeatsCorr := CORRELATION(File, barsstartdev, beatsstartdev);
END;