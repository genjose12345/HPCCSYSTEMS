import { Card } from '@radix-ui/themes'
import { PieChart, Pie, Cell, ResponsiveContainer, Treemap, Tooltip } from 'recharts'

// Temporary mock data - will be replaced with actual Musicmoz data
const genreDistributionMock = [
  { name: 'Rock', value: 400 },
  { name: 'Pop', value: 300 },
  { name: 'Jazz', value: 200 },
  { name: 'Classical', value: 150 },
  { name: 'Electronic', value: 250 },
]

const subgenreTreeMapMock = [
  {
    name: 'Rock',
    children: [
      { name: 'Alternative Rock', size: 100 },
      { name: 'Hard Rock', size: 80 },
      { name: 'Indie Rock', size: 70 },
      { name: 'Progressive Rock', size: 50 },
    ],
  },
  {
    name: 'Electronic',
    children: [
      { name: 'House', size: 90 },
      { name: 'Techno', size: 70 },
      { name: 'Ambient', size: 40 },
      { name: 'Drum and Bass', size: 60 },
    ],
  },
]

const COLORS = ['#8884d8', '#83a6ed', '#8dd1e1', '#82ca9d', '#a4de6c']

const MusicmozDashboard = () => {
  return (
    <div className="space-y-6">
      <div className="flex justify-between items-center">
        <h2 className="text-3xl font-bold text-gray-800 dark:text-white">Musicmoz Analysis</h2>
      </div>

      <div className="grid grid-cols-1 md:grid-cols-2 gap-6">
        <Card className="p-6">
          <h3 className="text-xl font-semibold mb-4">Genre Distribution</h3>
          <div className="h-[400px]">
            <ResponsiveContainer width="100%" height="100%">
              <PieChart>
                <Pie
                  data={genreDistributionMock}
                  cx="50%"
                  cy="50%"
                  labelLine={false}
                  label={({ name, percent }) => `${name} (${(percent * 100).toFixed(0)}%)`}
                  outerRadius={150}
                  fill="#8884d8"
                  dataKey="value"
                >
                  {genreDistributionMock.map((entry, index) => (
                    <Cell key={`cell-${index}`} fill={COLORS[index % COLORS.length]} />
                  ))}
                </Pie>
                <Tooltip />
              </PieChart>
            </ResponsiveContainer>
          </div>
        </Card>

        <Card className="p-6">
          <h3 className="text-xl font-semibold mb-4">Subgenre Distribution</h3>
          <div className="h-[400px]">
            <ResponsiveContainer width="100%" height="100%">
              <Treemap
                data={subgenreTreeMapMock}
                dataKey="size"
                aspectRatio={4 / 3}
                stroke="#fff"
                fill="#8884d8"
              >
                <Tooltip />
              </Treemap>
            </ResponsiveContainer>
          </div>
        </Card>
      </div>

      <div className="mt-6">
        <Card className="p-6">
          <h3 className="text-xl font-semibold mb-4">Database Statistics</h3>
          <div className="grid grid-cols-1 md:grid-cols-3 gap-4">
            <div className="bg-white dark:bg-gray-800 p-4 rounded-lg shadow">
              <h4 className="text-sm text-gray-500 dark:text-gray-400">Total Genres</h4>
              <p className="text-2xl font-bold">219</p>
            </div>
            <div className="bg-white dark:bg-gray-800 p-4 rounded-lg shadow">
              <h4 className="text-sm text-gray-500 dark:text-gray-400">Total Artists</h4>
              <p className="text-2xl font-bold">25,431</p>
            </div>
            <div className="bg-white dark:bg-gray-800 p-4 rounded-lg shadow">
              <h4 className="text-sm text-gray-500 dark:text-gray-400">Active Contributors</h4>
              <p className="text-2xl font-bold">1,245</p>
            </div>
          </div>
        </Card>
      </div>
    </div>
  )
}

export default MusicmozDashboard 