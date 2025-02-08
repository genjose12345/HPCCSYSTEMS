// Define the layout for Million Song dataset
EXPORT MillionSong_Category1 := MODULE
    EXPORT Layout := RECORD
        STRING Title;
        STRING Artist;
        INTEGER Year;
        REAL song_hotness;
    END;

    EXPORT File := DATASET('~million::song', Layout, FLAT);

    // (A) Reverse sort by year
    EXPORT SortedByYear := SORT(File, -Year);
    EXPORT TotalRecords := COUNT(File);
    EXPORT First50ByYear := CHOOSEN(SortedByYear, 50);

    // (B) Songs from 2010
    EXPORT Songs2010 := File(Year = 2010);
    EXPORT Total2010Songs := COUNT(Songs2010);
    EXPORT First50From2010 := CHOOSEN(Songs2010, 50);

    // (C) Prince songs from 1982
    EXPORT PrinceSongs := File(Artist = 'Prince' AND Year = 1982);
    EXPORT PrinceSongsCount := COUNT(PrinceSongs);

    // (D) Who sang Into Temptation
    EXPORT IntoTemptation := File(Title = 'Into Temptation');

    // (E) Sort by Artist and Title
    EXPORT SortedSongs := SORT(File, Artist, Title);
    EXPORT First100Sorted := CHOOSEN(SortedSongs, 100);

    // (F) Hottest songs by year
    EXPORT FilteredSongs := File(Year > 0 AND song_hotness > 0);
    EXPORT MaxHotness := MAX(FilteredSongs, song_hotness);
    EXPORT HottestSongs := FilteredSongs(song_hotness = MaxHotness);
END;