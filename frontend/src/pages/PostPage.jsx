
import { useEffect, useState } from "react";
import { useParams } from "react-router-dom"
import { format } from "date-fns"
import { Link } from "react-router-dom";
import ArrayToLinkTags from "../components/ArrayToLinkTags.jsx";

import "./PostPage.css"

const capitalize = s => s[0].toUpperCase() + s.slice(1);



/* async function getPost() {

  //fetch('http://localhost:8000/blog/posts')
  const response = await fetch('http://test.test/blog/api/posts/${id}')
  //fetch(`http://localhost:8000/blog/posts/${id}`)
  //fetch('https://tensormaker.org/blog/api/posts/${id}')
    .then(response => {
      response.json().then(postInfo => {
        setPostInfo(postInfo);
      });
    });

    if (response.status === 200) {
      const result = await response.json();
      resetMsg();
      updateSuccessMsg(["Success! a mail has been sent!"], shake);
    } else {
      const result = await response.json();
      resetMsg();
      updateErrorMsg(result.detail, shake);
    }


} */





export default function PostPage() {
  const [postInfo,setPostInfo] = useState(null);
  const {id} = useParams();


  useEffect(() => {

    //fetch(`http://localhost:8000/blog/posts/${id}`)
    fetch(`http://test.test/blog/api/posts/${id}`)
    //fetch(`http://localhost:8000/blog/posts/${id}`)
    //fetch(`https://tensormaker.org/blog/api/posts/${id}`)
      .then(response => {
        response.json().then(postInfo => {
          setPostInfo(postInfo);
        });
      });

  }, []);



  const capitalize = s => s[0].toUpperCase() + s.slice(1);


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

  // <div className="category">{postInfo.category}</div>

  return (
    <div className="post-page">
      <h1>{postInfo.title}</h1>

{/*       <div className="signature-date">
        <div className="author">par {capitalize(postInfo.username)}</div>
        <time>{"Le " + format(new Date(postInfo.published_at), 'dd/MM/yyyy à HH:mm')}</time>
        <ArrayToLinkTags {...category_layout}/>
      </div> */}

        <p className="info">
          <Link to="." className="author">{postInfo.username}</Link>
          <time>{"Le " + format(new Date(postInfo.published_at), 'dd/MM/yyyy à HH:mm')}</time>
          <ArrayToLinkTags {...category_layout}/>
        </p>


      <div className="image">
        <img src={process.env.PUBLIC_URL + "/blog/posts/images/" + postInfo.cover} alt="" />
      </div>

      <div className="content">
        <div className='ql-snow'>
          <div className="ql-editor" dangerouslySetInnerHTML={{__html:postInfo.content}}></div>
        </div>
      </div>
    </div>
  )
}
