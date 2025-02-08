// Define the layout for Million Song dataset
EXPORT MillionSongLayout := RECORD
    STRING Title;
    STRING Artist_name;
    REAL song_hotness;
    REAL Loudness;
    INTEGER Year;
END;

MillionSongDS := DATASET('~million::song', MillionSongLayout, FLAT);

// (A) Create new dataset with conditions
NewLayout := RECORD
    STRING Song;
    STRING Artist;
    BOOLEAN isPopular;
    BOOLEAN IsTooLoud;
END;

NewLayout TransformRec(MillionSongLayout L) := TRANSFORM
    SELF.Song := L.Title;
    SELF.Artist := L.Artist_name;
    SELF.isPopular := L.song_hotness > 0.80;
    SELF.IsTooLoud := L.Loudness > 0;
END;

NewDS := PROJECT(MillionSongDS, TransformRec(LEFT));
OUTPUT(CHOOSEN(NewDS, 50), NAMED('First50Transformed'));

// (B) Songs per Year
YearCounts := TABLE(MillionSongDS, 
                   {Year, 
                    INTEGER TotalSongs := COUNT(GROUP)}, 
                    Year);
OUTPUT(YearCounts, NAMED('SongsPerYear'));
OUTPUT(COUNT(YearCounts), NAMED('TotalYears'));

// (C) Hottest Artist 2006-2007
FilteredYears := MillionSongDS(Year IN [2006, 2007]);
ArtistHotness := TABLE(FilteredYears,
                      {Artist_name,
                       REAL AvgHotness := AVE(GROUP, song_hotness)},
                       Artist_name);
SortedHotness := SORT(ArtistHotness, -AvgHotness);
OUTPUT(CHOOSEN(SortedHotness, 1), NAMED('HottestArtist'));