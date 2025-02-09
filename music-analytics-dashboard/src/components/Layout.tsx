import { Routes, Route, NavLink } from 'react-router-dom'
import { NavigationMenu, NavigationMenuList, NavigationMenuItem, NavigationMenuLink } from '@radix-ui/react-navigation-menu'
import MillionSongDashboard from '../pages/MillionSongDashboard'
import SpotifyDashboard from '../pages/SpotifyDashboard'
import MusicmozDashboard from '../pages/MusicmozDashboard'

const Layout = () => {
  return (
    <div className="flex h-screen bg-gray-100 dark:bg-gray-900">
      {/* Sidebar */}
      <div className="w-64 bg-white dark:bg-gray-800 shadow-lg">
        <div className="p-4">
          <h1 className="text-2xl font-bold text-gray-800 dark:text-white">Music Analytics</h1>
        </div>
        <NavigationMenu className="w-full">
          <NavigationMenuList className="flex flex-col space-y-2 p-4">
            <NavigationMenuItem>
              <NavLink 
                to="/million-song" 
                className={({ isActive }) => 
                  `block p-2 rounded-lg ${isActive ? 'bg-violet-500 text-white' : 'text-gray-600 dark:text-gray-300 hover:bg-gray-100 dark:hover:bg-gray-700'}`
                }
              >
                MillionSong Dataset
              </NavLink>
            </NavigationMenuItem>
            <NavigationMenuItem>
              <NavLink 
                to="/spotify" 
                className={({ isActive }) => 
                  `block p-2 rounded-lg ${isActive ? 'bg-violet-500 text-white' : 'text-gray-600 dark:text-gray-300 hover:bg-gray-100 dark:hover:bg-gray-700'}`
                }
              >
                Spotify Analysis
              </NavLink>
            </NavigationMenuItem>
            <NavigationMenuItem>
              <NavLink 
                to="/musicmoz" 
                className={({ isActive }) => 
                  `block p-2 rounded-lg ${isActive ? 'bg-violet-500 text-white' : 'text-gray-600 dark:text-gray-300 hover:bg-gray-100 dark:hover:bg-gray-700'}`
                }
              >
                Musicmoz Data
              </NavLink>
            </NavigationMenuItem>
          </NavigationMenuList>
        </NavigationMenu>
      </div>

      {/* Main Content */}
      <div className="flex-1 overflow-auto">
        <div className="p-8">
          <Routes>
            <Route path="/" element={<MillionSongDashboard />} />
            <Route path="/million-song" element={<MillionSongDashboard />} />
            <Route path="/spotify" element={<SpotifyDashboard />} />
            <Route path="/musicmoz" element={<MusicmozDashboard />} />
          </Routes>
        </div>
      </div>
    </div>
  )
}

export default Layout 