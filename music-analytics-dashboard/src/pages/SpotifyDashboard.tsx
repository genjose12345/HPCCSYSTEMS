import { Card } from '@radix-ui/themes'
import { RadarChart, PolarGrid, PolarAngleAxis, PolarRadiusAxis, Radar, ResponsiveContainer, ScatterChart, Scatter, XAxis, YAxis, CartesianGrid, Tooltip, Legend } from 'recharts'

// Temporary mock data - will be replaced with actual Spotify data
const audioFeaturesMock = [
  { feature: 'danceability', value: 0.8 },
  { feature: 'energy', value: 0.7 },
  { feature: 'valence', value: 0.6 },
  { feature: 'acousticness', value: 0.3 },
  { feature: 'instrumentalness', value: 0.2 },
  { feature: 'liveness', value: 0.4 },
]

const popularityScatterMock = [
  { popularity: 85, followers: 15000000, name: 'Artist A' },
  { popularity: 75, followers: 8000000, name: 'Artist B' },
  { popularity: 90, followers: 20000000, name: 'Artist C' },
  { popularity: 65, followers: 5000000, name: 'Artist D' },
  { popularity: 70, followers: 10000000, name: 'Artist E' },
]

const SpotifyDashboard = () => {
  return (
    <div className="space-y-6">
      <div className="flex justify-between items-center">
        <h2 className="text-3xl font-bold text-gray-800 dark:text-white">Spotify Analytics</h2>
      </div>

      <div className="grid grid-cols-1 md:grid-cols-2 gap-6">
        <Card className="p-6">
          <h3 className="text-xl font-semibold mb-4">Audio Features Analysis</h3>
          <div className="h-[400px]">
            <ResponsiveContainer width="100%" height="100%">
              <RadarChart data={audioFeaturesMock}>
                <PolarGrid />
                <PolarAngleAxis dataKey="feature" />
                <PolarRadiusAxis angle={30} domain={[0, 1]} />
                <Radar name="Audio Features" dataKey="value" stroke="#8884d8" fill="#8884d8" fillOpacity={0.6} />
              </RadarChart>
            </ResponsiveContainer>
          </div>
        </Card>

        <Card className="p-6">
          <h3 className="text-xl font-semibold mb-4">Popularity vs Followers</h3>
          <div className="h-[400px]">
            <ResponsiveContainer width="100%" height="100%">
              <ScatterChart>
                <CartesianGrid strokeDasharray="3 3" />
                <XAxis type="number" dataKey="popularity" name="Popularity" />
                <YAxis type="number" dataKey="followers" name="Followers" />
                <Tooltip cursor={{ strokeDasharray: '3 3' }} />
                <Legend />
                <Scatter name="Artists" data={popularityScatterMock} fill="#8884d8" />
              </ScatterChart>
            </ResponsiveContainer>
          </div>
        </Card>
      </div>

      <div className="mt-6">
        <Card className="p-6">
          <h3 className="text-xl font-semibold mb-4">Trending Metrics</h3>
          <div className="grid grid-cols-1 md:grid-cols-3 gap-4">
            <div className="bg-white dark:bg-gray-800 p-4 rounded-lg shadow">
              <h4 className="text-sm text-gray-500 dark:text-gray-400">Average Popularity</h4>
              <p className="text-2xl font-bold">77.2</p>
            </div>
            <div className="bg-white dark:bg-gray-800 p-4 rounded-lg shadow">
              <h4 className="text-sm text-gray-500 dark:text-gray-400">Total Streams</h4>
              <p className="text-2xl font-bold">1.2B</p>
            </div>
            <div className="bg-white dark:bg-gray-800 p-4 rounded-lg shadow">
              <h4 className="text-sm text-gray-500 dark:text-gray-400">Avg. Track Duration</h4>
              <p className="text-2xl font-bold">3:45</p>
            </div>
          </div>
        </Card>
      </div>
    </div>
  )
}

export default SpotifyDashboard 