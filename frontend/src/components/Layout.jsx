import { Outlet } from "react-router-dom";
import Header from './Header.jsx';

export default function Layout() {
  return (
    <main>
      <div className="overlay"></div>
      <Header />
      <Outlet />
    </main>
  )
}
