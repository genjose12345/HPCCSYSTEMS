// Define the layout for Million Song dataset
EXPORT MillionSongLayout := RECORD
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

MillionSongDS := DATASET('~million::song', MillionSongLayout, FLAT);

// (A) Coldplay hot songs
ColdplayHot := SORT(MillionSongDS(Artist_Name = 'Coldplay' AND song_hotness >= 0.75), Title);
OUTPUT(ColdplayHot, NAMED('ColdplayHotSongs'));
OUTPUT(COUNT(ColdplayHot), NAMED('TotalColdplayHot'));

// (B) Duration and hotness filter
FilteredSongs := MillionSongDS(Duration >= 200 AND Duration <= 250 AND 
                             song_hotness <> 0 AND familiarity > 0.9);
OUTPUT(COUNT(FilteredSongs), NAMED('FilteredSongsCount'));

// (C) New dataset with selected fields
NewLayout := RECORD
    STRING Title;
    STRING Artist_Name;
    STRING Release_Name;
    INTEGER Year;
END;

NewDataset := PROJECT(MillionSongDS, NewLayout);
OUTPUT(NewDataset, NAMED('SimplifiedDataset'));

// (D) Correlations
SongArtistCorr := CORRELATION(MillionSongDS, song_hotness, artist_hotness);
BarsBeatsCorr := CORRELATION(MillionSongDS, barsstartdev, beatsstartdev);
OUTPUT(SongArtistCorr, NAMED('SongArtistHotnessCorrelation'));
OUTPUT(BarsBeatsCorr, NAMED('BarsBeatsCorrelation'));