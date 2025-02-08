// Define the layout for Million Song dataset
EXPORT MillionSongLayout := RECORD
    STRING Title;
    STRING Artist;
    INTEGER Year;
    REAL song_hotness;
END;

MillionSongDS := DATASET('~million::song', MillionSongLayout, FLAT);

// (A) Reverse sort by year
SortedByYear := SORT(MillionSongDS, -Year);
OUTPUT(COUNT(MillionSongDS), NAMED('TotalRecords'));
OUTPUT(CHOOSEN(SortedByYear, 50), NAMED('First50ByYear'));

// (B) Songs from 2010
Songs2010 := MillionSongDS(Year = 2010);
OUTPUT(COUNT(Songs2010), NAMED('Total2010Songs'));
OUTPUT(CHOOSEN(Songs2010, 50), NAMED('First50From2010'));

// (C) Prince songs from 1982
PrinceSongs := MillionSongDS(Artist = 'Prince' AND Year = 1982);
OUTPUT(COUNT(PrinceSongs), NAMED('PrinceSongsCount'));

// (D) Who sang Into Temptation
IntoTemptation := MillionSongDS(Title = 'Into Temptation');
OUTPUT(IntoTemptation, NAMED('IntoTemptationArtist'));

// (E) Sort by Artist and Title
SortedSongs := SORT(MillionSongDS, Artist, Title);
OUTPUT(CHOOSEN(SortedSongs, 100), NAMED('First100Sorted'));

// (F) Hottest songs by year
FilteredSongs := MillionSongDS(Year > 0 AND song_hotness > 0);
MaxHotness := MAX(FilteredSongs, song_hotness);
HottestSongs := FilteredSongs(song_hotness = MaxHotness);
OUTPUT(HottestSongs, NAMED('HottestSongs'));