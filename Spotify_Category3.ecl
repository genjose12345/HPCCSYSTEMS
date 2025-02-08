// Define the layout for Spotify dataset
EXPORT SpotifyLayout := RECORD
    STRING Track_Name;
    STRING Artist_Name;
    STRING Genre;
    INTEGER Popularity;
    REAL Loudness;
    REAL Danceability;
    INTEGER Year;
END;

SpotifyDS := DATASET('~spotify::songs', SpotifyLayout, FLAT);

// (A) Create transformed dataset
NewLayout := RECORD
    STRING Song;
    STRING Artist;
    BOOLEAN isPopular;
    INTEGER Funkiness;
END;

NewLayout TransformRec(SpotifyLayout L) := TRANSFORM
    SELF.Song := L.Track_Name;
    SELF.Artist := L.Artist_Name;
    SELF.isPopular := L.Popularity > 80;
    SELF.Funkiness := (INTEGER)(L.Loudness + L.Danceability);
END;

TransformedDS := PROJECT(SpotifyDS, TransformRec(LEFT));
OUTPUT(TransformedDS, NAMED('TransformedDataset'));

// (B) Songs by Genre
GenreCounts := TABLE(SpotifyDS, 
                    {Genre, 
                     INTEGER SongCount := COUNT(GROUP)}, 
                     Genre);
OUTPUT(GenreCounts, NAMED('SongsByGenre'));
OUTPUT(COUNT(GenreCounts), NAMED('TotalGenres'));

// (C) Average Danceability 2023
Songs2023 := SpotifyDS(Year = 2023);
ArtistDance := TABLE(Songs2023,
                    {Artist_Name,
                     REAL AvgDanceability := AVE(GROUP, Danceability)},
                     Artist_Name);
OUTPUT(ArtistDance, NAMED('ArtistDanceability2023'));