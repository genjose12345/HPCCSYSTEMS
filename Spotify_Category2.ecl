// Define the layout for Spotify dataset
EXPORT SpotifyLayout := RECORD
    STRING Artist_name;
    STRING track_name;
    INTEGER year;
    INTEGER Popularity;
    INTEGER duration_ms;
    REAL Speechiness;
    REAL Liveness;
    REAL Loudness;
    REAL Energy;
END;

SpotifyDS := DATASET('~spotify::songs', SpotifyLayout, FLAT);

// (A) Coldplay popular songs
ColdplayPopular := SORT(SpotifyDS(Artist_name = 'Coldplay' AND Popularity >= 75), track_name);
OUTPUT(ColdplayPopular, NAMED('ColdplayPopularSongs'));
OUTPUT(COUNT(ColdplayPopular), NAMED('TotalColdplayPopular'));

// (B) Duration and Speechiness filter
FilteredSongs := SpotifyDS(duration_ms >= 200000 AND duration_ms <= 250000 AND 
                          Speechiness > 75);
OUTPUT(COUNT(FilteredSongs), NAMED('FilteredSongsCount'));

// (C) New simplified dataset
NewLayout := RECORD
    STRING Artist;
    STRING Title;
    INTEGER Year;
END;

NewLayout TransformRec(SpotifyLayout L) := TRANSFORM
    SELF.Artist := L.Artist_name;
    SELF.Title := L.track_name;
    SELF.Year := L.year;
END;

NewDS := PROJECT(SpotifyDS, TransformRec(LEFT));
OUTPUT(NewDS, NAMED('SimplifiedDataset'));

// (D) Correlations
PopLiveCorr := CORRELATION(SpotifyDS, Popularity, Liveness);
LoudEnergyCorr := CORRELATION(SpotifyDS, Loudness, Energy);
OUTPUT(PopLiveCorr, NAMED('PopularityLivenessCorrelation'));
OUTPUT(LoudEnergyCorr, NAMED('LoudnessEnergyCorrelation'));