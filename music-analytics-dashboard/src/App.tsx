import { Theme } from '@radix-ui/themes'
import '@radix-ui/themes/styles.css'
import { BrowserRouter as Router } from 'react-router-dom'
import { QueryClient, QueryClientProvider } from '@tanstack/react-query'
import Layout from './components/Layout'

const queryClient = new QueryClient()

function App() {
  return (
    <QueryClientProvider client={queryClient}>
      <Theme appearance="dark" accentColor="violet" radius="medium">
        <Router>
          <Layout />
        </Router>
      </Theme>
    </QueryClientProvider>
  )
}

export default App
