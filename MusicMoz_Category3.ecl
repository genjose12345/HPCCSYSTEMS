// Define the layout for MusicMoz dataset
EXPORT MusicMoz_Category3 := MODULE
    EXPORT Layout := RECORD
        STRING Genre;
        STRING Artist;
        STRING ReleaseDate;
    END;

    EXPORT File := DATASET('~music::moz', Layout, FLAT);

    // (A) Songs grouped by Genre
    EXPORT GenreCounts := TABLE(File, 
                        {Genre, 
                         INTEGER count := COUNT(GROUP)}, 
                        Genre);
    EXPORT First50Genres := CHOOSEN(GenreCounts, 50);
    EXPORT TotalGenres := COUNT(GenreCounts);

    // (B) Artist with most releases 2001-2010
    EXPORT FilteredByYear := File(ReleaseDate >= '2001' AND ReleaseDate <= '2010');
    EXPORT ArtistReleases := TABLE(FilteredByYear, 
                           {Artist, 
                            INTEGER ReleaseCount := COUNT(GROUP)}, 
                            Artist);
    EXPORT MostReleases := SORT(ArtistReleases, -ReleaseCount);
    EXPORT TopArtist := CHOOSEN(MostReleases, 1);
END;