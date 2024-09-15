
import { useEffect, useState } from "react";
import { useParams } from "react-router-dom"
import { format } from "date-fns"
import { Link } from "react-router-dom";
import ArrayToLinkTags from "../components/ArrayToLinkTags.jsx";

import "./PostPage.css"

const capitalize = s => s[0].toUpperCase() + s.slice(1);



export default function PostPage() {
  const [postInfo,setPostInfo] = useState(null);
  const {id} = useParams();
  const URL = `${process.env.REACT_APP_API_PROTOCOL}://${process.env.REACT_APP_API_DOMAIN}`;

  useEffect(() => {

    fetch(`${URL}/api/blog/posts/${id}`)
      .then(response => {
        response.json().then(postInfo => {
          setPostInfo(postInfo);
        });
      });

  }, []);


  // Title neon off
  function setClass(strClass) {
    var elem = document.getElementById('logo');
    elem.setAttribute("class", "")
    elem.classList.add(strClass);
  }
  useEffect(() => setClass("neon-off"));

  if (!postInfo) {
    return "";
  }

  const category_layout = {
    array: postInfo.category.split("|").map(s => capitalize(s.trim())),
    className: "category",
    separator: " · ",
    to: [".",".",".",".","."]
  };

  return (
    <div className="post-page">
      <h1>{postInfo.title}</h1>

      <p className="info">
        <Link to="." className="author">{postInfo.username}</Link>
        <time>{"Le " + format(new Date(postInfo.published_at), 'dd/MM/yyyy à HH:mm')}</time>
        <ArrayToLinkTags {...category_layout}/>
      </p>

      <div className="image">
        <img src={process.env.PUBLIC_URL + "/uploads/blog/posts/images/" + postInfo.cover} alt="" />
      </div>

      <div className="content">
        <div className='ql-snow'>
          <div className="ql-editor" dangerouslySetInnerHTML={{__html:postInfo.content}}></div>
        </div>
      </div>
    </div>
  )
}
