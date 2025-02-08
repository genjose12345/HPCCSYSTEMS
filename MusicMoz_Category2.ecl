// Define the layout for MusicMoz dataset
EXPORT MusicMozLayout := RECORD
    STRING TrackTitle;
    STRING Title;
    STRING Name;
    STRING ReleaseDate;
    STRING Artist;
    STRING GuestMusicians;
END;

MusicMozDS := DATASET('~music::moz', MusicMozLayout, FLAT);

// (A) U2 songs sorted by title
U2Songs := SORT(MusicMozDS(Artist = 'U2'), TrackTitle);
OUTPUT(U2Songs, NAMED('U2_Songs_Sorted'));
OUTPUT(COUNT(U2Songs), NAMED('Total_U2_Songs'));

// (B) Songs with guest musicians
GuestSongs := MusicMozDS(GuestMusicians <> '');
OUTPUT(GuestSongs, NAMED('Songs_With_Guests'));
OUTPUT(COUNT(GuestSongs), NAMED('Total_Guest_Songs'));

// (C) Create new dataset with renamed columns
NewLayout := RECORD
    STRING Track;
    STRING Release;
    STRING Artist;
    STRING Year;
END;

NewLayout TransformFields(MusicMozLayout L) := TRANSFORM
    SELF.Track := L.TrackTitle;
    SELF.Release := L.Title;
    SELF.Artist := L.Name;
    SELF.Year := L.ReleaseDate;
END;

NewDataset := PROJECT(MusicMozDS, TransformFields(LEFT));
OUTPUT(CHOOSEN(NewDataset, 50), NAMED('First_50_Transformed'));