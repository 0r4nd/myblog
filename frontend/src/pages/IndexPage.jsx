
import { useEffect, useState } from "react";
import Post from "../components/Post.jsx";


export default function IndexPage() {
  const [posts,setPosts] = useState([]);
  useEffect(() => {
    fetch('http://localhost:8000/posts').then(response => {
      response.json().then(posts => {
        setPosts(posts);
        console.log(posts);
      });
    });
  }, []);

  return (
    <>
      {posts.length > 0 && posts.map(post => (
        <Post {...post} />
      ))}
    </>
  )
}
