
import { useEffect, useState } from "react";
import Post from "../components/Post.jsx";


export default function IndexPage() {
  const [posts,setPosts] = useState([]);
  const [categories,setCategories] = useState([]);
  const URL = `${process.env.REACT_APP_SERVER_PROTOCOL}://${process.env.REACT_APP_SERVER_DOMAIN}`;

  useEffect(() => {

    // old version -> too slow
    //fetch('http://localhost:8000/blog/posts')
    //  .then(response => response.json())
    //  .then(posts => {
    //    setPosts(posts);
    //    console.log(posts)
    //    return Promise.all(posts.map(post => {
    //      console.log("post", post)
    //      return fetch(`http://localhost:8000/blog/categories/${post.id}`)
    //        .then(response => response.json())
    //    }))
    //  })
    //  .then(categories => {
    //    setCategories(categories);
    //    console.warn(categories);
    //  })

    fetch(URL + '/api/blog/posts')
      .then(response => response.json())
      .then(posts => {
        setPosts(posts);
      })

  }, []);





  return (
    <>
      {posts.length > 0 && posts.map((post,index) => (
        <Post { ...post } />
      ))}
    </>
  )
}
