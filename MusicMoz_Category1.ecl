// Import the MusicMoz dataset (assuming it's available in your cluster)
// Define the layout for MusicMoz dataset
EXPORT MusicMozLayout := RECORD
    STRING TrackTitle;
    STRING Artist;
    STRING Genre;
    INTEGER ReleaseYear;
    STRING name;
    STRING description;
    // Add other fields as needed
END;

MusicMozDS := DATASET('~music::moz', MusicMozLayout, FLAT);

// (A) Count total records
OUTPUT(COUNT(MusicMozDS), NAMED('TotalRecords'));

// (B) Sort by name and show first 50
SortedByName := SORT(MusicMozDS, name);
OUTPUT(CHOOSEN(SortedByName, 50), NAMED('First50SortedByName'));

// (C) Rock genre songs
RockSongs := MusicMozDS(Genre = 'Rock');
OUTPUT(CHOOSEN(RockSongs, 50), NAMED('First50RockSongs'));
OUTPUT(COUNT(RockSongs), NAMED('TotalRockSongs'));

// (D) Depeche Mode songs 1980-1989
DepecheSongs := MusicMozDS(Artist = 'Depeche Mode' AND 
                          ReleaseYear >= 1980 AND 
                          ReleaseYear <= 1989);
OUTPUT(COUNT(DepecheSongs), NAMED('DepecheModeCount'));

// (E) My Way songs
MyWaySongs := MusicMozDS(TrackTitle = 'My Way');
OUTPUT(MyWaySongs, NAMED('MyWaySongsList'));
OUTPUT(COUNT(MyWaySongs), NAMED('MyWaySongsCount'));

// (F) Songs with longest description
// First get the maximum description length
MaxDescLen := MAX(MusicMozDS, LENGTH(description));
// Then find songs matching that length
LongestDesc := MusicMozDS(LENGTH(description) = MaxDescLen);
OUTPUT(LongestDesc, NAMED('SongsWithLongestDesc'));