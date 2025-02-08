// Define the layout for MusicMoz dataset
EXPORT MusicMozLayout := RECORD
    STRING Genre;
    STRING Artist;
    STRING ReleaseDate;
END;

MusicMozDS := DATASET('~music::moz', MusicMozLayout, FLAT);

// (A) Songs grouped by Genre
GenreCounts := TABLE(MusicMozDS, 
                    {Genre, 
                     INTEGER count := COUNT(GROUP)}, 
                    Genre);
OUTPUT(CHOOSEN(GenreCounts, 50), NAMED('First50Genres'));
OUTPUT(COUNT(GenreCounts), NAMED('TotalGenres'));

// (B) Artist with most releases 2001-2010
FilteredByYear := MusicMozDS(ReleaseDate >= '2001' AND ReleaseDate <= '2010');
ArtistReleases := TABLE(FilteredByYear, 
                       {Artist, 
                        INTEGER ReleaseCount := COUNT(GROUP)}, 
                        Artist);
MostReleases := SORT(ArtistReleases, -ReleaseCount);
OUTPUT(CHOOSEN(MostReleases, 1), NAMED('ArtistMostReleases'));