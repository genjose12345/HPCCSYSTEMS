// Define the layout for MusicMoz dataset
EXPORT MusicMoz_Category2 := MODULE
    EXPORT Layout := RECORD
        STRING TrackTitle;
        STRING Title;
        STRING Name;
        STRING ReleaseDate;
        STRING Artist;
        STRING GuestMusicians;
    END;

    EXPORT File := DATASET('~music::moz', Layout, FLAT);

    // (A) U2 songs sorted by title
    EXPORT U2Songs := SORT(File(Artist = 'U2'), TrackTitle);
    EXPORT Total_U2_Songs := COUNT(U2Songs);

    // (B) Songs with guest musicians
    EXPORT GuestSongs := File(GuestMusicians <> '');
    EXPORT Total_Guest_Songs := COUNT(GuestSongs);

    // (C) Create new dataset with renamed columns
    EXPORT NewLayout := RECORD
        STRING Track;
        STRING Release;
        STRING Artist;
        STRING Year;
    END;

    EXPORT NewLayout TransformFields(Layout L) := TRANSFORM
        SELF.Track := L.TrackTitle;
        SELF.Release := L.Title;
        SELF.Artist := L.Name;
        SELF.Year := L.ReleaseDate;
    END;

    EXPORT NewDataset := PROJECT(File, TransformFields(LEFT));
    EXPORT First_50_Transformed := CHOOSEN(NewDataset, 50);
END;