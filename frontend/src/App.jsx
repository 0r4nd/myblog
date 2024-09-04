
import './assets/App.css';
import Layout from './layouts/Layout.jsx';
import IndexPage from './pages/IndexPage.jsx';
import { Routes, Route } from 'react-router-dom';
import LoginPage from './pages/LoginPage.jsx';
import SignupPage from './pages/SignupPage.jsx';
import CreatePost from './pages/CreatePost.jsx';
import PostPage from './pages/PostPage.jsx';

function App() {
  return (
    <Routes>
      <Route path='/' element = {<Layout />}>
        <Route index element = { <IndexPage /> }/>
        <Route path='/login' element = { <LoginPage /> }/>
        <Route path='/signup' element = { <SignupPage /> }/>
        <Route path='/create' element = { <CreatePost /> }/>
        <Route path='/posts/:id' element = { <PostPage /> }/>
      </Route>
    </Routes>
  );
}

export default App;
