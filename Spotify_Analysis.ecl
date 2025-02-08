IMPORT $.Spotify_Category1;
IMPORT $.Spotify_Category2;
IMPORT $.Spotify_Category3;

// Category 1 Analysis
OUTPUT(Spotify_Category1.SortedByGenre, NAMED('SortedByGenre'));
OUTPUT(Spotify_Category1.TotalSongs, NAMED('TotalSongs'));
OUTPUT(Spotify_Category1.GarageSongs, NAMED('GarageSongs'));
OUTPUT(Spotify_Category1.PrinceSongs, NAMED('PrinceSongs'));
OUTPUT(Spotify_Category1.MostPopular, NAMED('MostPopularSong'));

// Category 2 Analysis
OUTPUT(Spotify_Category2.ColdplayPopular, NAMED('ColdplayPopularSongs'));
OUTPUT(Spotify_Category2.FilteredSongs, NAMED('FilteredSongs'));
OUTPUT(Spotify_Category2.NewDS, NAMED('SimplifiedDataset'));

// Category 3 Analysis
OUTPUT(Spotify_Category3.TransformedDS, NAMED('TransformedDataset'));
OUTPUT(Spotify_Category3.GenreCounts, NAMED('SongsByGenre'));
OUTPUT(Spotify_Category3.ArtistPopularity, NAMED('ArtistPopularity2023'));