
import './assets/App.css';
import Layout from './components/Layout.jsx';
import HomePage from './pages/HomePage.jsx';
import { Routes, Route } from 'react-router-dom';
import LoginPage from './pages/LoginPage.jsx';
import SignupPage from './pages/SignupPage.jsx';
import CreatePost from './pages/CreatePost.jsx';
import PostPage from './pages/PostPage.jsx';
import ToolPage from './pages/ToolPage.jsx';
// import { Navigate } from 'react-router-dom';

function App() {

  return (
    <Routes>
      <Route path='/' element = {<Layout />}>
        {/* <Route index element = { <HomePage /> }/> */}
        {/* <Route path='/' element = { <Navigate to="/blog" /> }/> */}
        <Route path='/blog' element = { <HomePage /> }/>
        <Route path='/tools' element = { <ToolPage /> }/>

        <Route path='/login' element = { <LoginPage /> }/>
        <Route path='/signup' element = { <SignupPage /> }/>
        <Route path='/blog/create' element = { <CreatePost /> }/>
        <Route path='/blog/posts/:id' element = { <PostPage /> }/>
      </Route>
    </Routes>
  );
}

export default App;
