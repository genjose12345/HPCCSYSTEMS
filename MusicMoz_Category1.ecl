// Import the MusicMoz dataset (assuming it's available in your cluster)
// Define the layout for MusicMoz dataset
EXPORT MusicMoz_Category1 := MODULE
    EXPORT Layout := RECORD
        STRING TrackTitle;
        STRING Artist;
        STRING Genre;
        INTEGER ReleaseYear;
        STRING name;
        STRING description;
        // Add other fields as needed
    END;

    EXPORT File := DATASET('~music::moz', Layout, FLAT);

    // (A) Count total records
    EXPORT TotalRecords := COUNT(File);

    // (B) Sort by name and show first 50
    EXPORT SortedByName := SORT(File, name);
    EXPORT First50SortedByName := CHOOSEN(SortedByName, 50);

    // (C) Rock genre songs
    EXPORT RockSongs := File(Genre = 'Rock');
    EXPORT First50RockSongs := CHOOSEN(RockSongs, 50);
    EXPORT TotalRockSongs := COUNT(RockSongs);

    // (D) Depeche Mode songs 1980-1989
    EXPORT DepecheSongs := File(Artist = 'Depeche Mode' AND 
                               ReleaseYear >= 1980 AND 
                               ReleaseYear <= 1989);
    EXPORT DepecheModeCount := COUNT(DepecheSongs);

    // (E) My Way songs
    EXPORT MyWaySongs := File(TrackTitle = 'My Way');
    EXPORT MyWaySongsCount := COUNT(MyWaySongs);

    // (F) Songs with longest description
    EXPORT MaxDescLen := MAX(File, LENGTH(description));
    EXPORT LongestDesc := File(LENGTH(description) = MaxDescLen);
END;