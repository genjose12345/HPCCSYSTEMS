IMPORT STD;

// Define the combined layout as specified
EXPORT CombMusicLayout := RECORD
    UNSIGNED RECID;
    STRING   SongTitle;
    STRING   AlbumTitle;
    STRING   Artist;
    STRING4  ReleaseYear;
    STRING4  Genre;
    STRING4  Source;
END;

// Transform for MusicMoz data
CombMusicLayout TransformMoz(MusicMoz_Category1.Layout L) := TRANSFORM
    SELF.RECID := 0;  // Will be sequenced later
    SELF.SongTitle := L.TrackTitle;
    SELF.AlbumTitle := L.Title;
    SELF.Artist := L.Artist;
    SELF.ReleaseYear := (STRING4)L.ReleaseYear;
    SELF.Genre := L.Genre[1..4];  // Take first 4 characters
    SELF.Source := 'MOZ';
END;

// Transform for Million Song data
CombMusicLayout TransformMSD(MillionSong_Category1.Layout L) := TRANSFORM
    SELF.RECID := 0;
    SELF.SongTitle := L.Title;
    SELF.AlbumTitle := '';  // Not available in this dataset
    SELF.Artist := L.Artist;
    SELF.ReleaseYear := (STRING4)L.Year;
    SELF.Genre := '';  // Not available in this dataset
    SELF.Source := 'MSD';
END;

// Transform for Spotify data
CombMusicLayout TransformSpot(Spotify_Category2.Layout L) := TRANSFORM
    SELF.RECID := 0;
    SELF.SongTitle := L.track_name;
    SELF.AlbumTitle := '';  // Not available in this dataset
    SELF.Artist := L.artist_name;
    SELF.ReleaseYear := (STRING4)L.year;
    SELF.Genre := L.genre[1..4];
    SELF.Source := 'SPOT';
END;

// Project each dataset to common format
mozData := PROJECT(MusicMoz_Category1.File, TransformMoz(LEFT));
msdData := PROJECT(MillionSong_Category1.File, TransformMSD(LEFT));
spotData := PROJECT(Spotify_Category2.File, TransformSpot(LEFT));

// Combine all datasets
combinedData := mozData + msdData + spotData;

// Remove duplicates based on SongTitle and Artist
deduped := DEDUP(
    SORT(combinedData, SongTitle, Artist),
    SongTitle, Artist
);

// Add sequence numbers
CombMusicLayout AddSequence(deduped L, UNSIGNED C) := TRANSFORM
    SELF.RECID := C;
    SELF := L;
END;

finalDataset := PROJECT(deduped, AddSequence(LEFT, COUNTER));

// Output results
OUTPUT(COUNT(finalDataset), NAMED('TotalUniqueRecords'));
OUTPUT(finalDataset, NAMED('CombinedMusicDataset'));