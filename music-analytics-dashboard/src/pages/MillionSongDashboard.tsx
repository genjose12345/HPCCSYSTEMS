import { Card } from '@radix-ui/themes'
import { BarChart, Bar, XAxis, YAxis, CartesianGrid, Tooltip, Legend, ResponsiveContainer, LineChart, Line } from 'recharts'

// Temporary mock data - will be replaced with actual data from ECL
const mockData = [
  { year: '2000', count: 1200 },
  { year: '2001', count: 1800 },
  { year: '2002', count: 2400 },
  { year: '2003', count: 2900 },
  { year: '2004', count: 3500 },
  { year: '2005', count: 4200 },
]

const MillionSongDashboard = () => {
  return (
    <div className="space-y-6">
      <div className="flex justify-between items-center">
        <h2 className="text-3xl font-bold text-gray-800 dark:text-white">MillionSong Dataset Analysis</h2>
      </div>

      <div className="grid grid-cols-1 md:grid-cols-2 gap-6">
        <Card className="p-6">
          <h3 className="text-xl font-semibold mb-4">Songs by Year</h3>
          <div className="h-[400px]">
            <ResponsiveContainer width="100%" height="100%">
              <BarChart data={mockData}>
                <CartesianGrid strokeDasharray="3 3" />
                <XAxis dataKey="year" />
                <YAxis />
                <Tooltip />
                <Legend />
                <Bar dataKey="count" fill="#8884d8" />
              </BarChart>
            </ResponsiveContainer>
          </div>
        </Card>

        <Card className="p-6">
          <h3 className="text-xl font-semibold mb-4">Trend Analysis</h3>
          <div className="h-[400px]">
            <ResponsiveContainer width="100%" height="100%">
              <LineChart data={mockData}>
                <CartesianGrid strokeDasharray="3 3" />
                <XAxis dataKey="year" />
                <YAxis />
                <Tooltip />
                <Legend />
                <Line type="monotone" dataKey="count" stroke="#8884d8" />
              </LineChart>
            </ResponsiveContainer>
          </div>
        </Card>
      </div>

      <div className="mt-6">
        <Card className="p-6">
          <h3 className="text-xl font-semibold mb-4">Key Metrics</h3>
          <div className="grid grid-cols-1 md:grid-cols-3 gap-4">
            <div className="bg-white dark:bg-gray-800 p-4 rounded-lg shadow">
              <h4 className="text-sm text-gray-500 dark:text-gray-400">Total Songs</h4>
              <p className="text-2xl font-bold">1,000,000</p>
            </div>
            <div className="bg-white dark:bg-gray-800 p-4 rounded-lg shadow">
              <h4 className="text-sm text-gray-500 dark:text-gray-400">Unique Artists</h4>
              <p className="text-2xl font-bold">44,745</p>
            </div>
            <div className="bg-white dark:bg-gray-800 p-4 rounded-lg shadow">
              <h4 className="text-sm text-gray-500 dark:text-gray-400">Year Range</h4>
              <p className="text-2xl font-bold">2000-2005</p>
            </div>
          </div>
        </Card>
      </div>
    </div>
  )
}

export default MillionSongDashboard 