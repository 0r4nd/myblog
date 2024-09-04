
import { useEffect, useState } from "react";
import { useParams } from "react-router-dom"
import { format } from "date-fns"


const capitalize = s => s[0].toUpperCase() + s.slice(1);


export default function PostPage() {
  const [postInfo,setPostInfo] = useState(null);
  const {id} = useParams();

  useEffect(() => {
    fetch(`http://localhost:8000/posts/${id}`)
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

  return (
    <div className="post-page">
      <h1>{postInfo.title}</h1>

      <div className="signature-date">
        <div className="author">par {capitalize(postInfo.username)}</div>
        <time>{"Le " + format(new Date(postInfo.published_at), 'dd/MM/yyyy à HH:mm')}</time>
      </div>

      <div className="image">
        <img src={process.env.PUBLIC_URL + "/posts/images/" + postInfo.cover} alt="" />
      </div>

      <div className="content">
        <div className='ql-snow'>
          <div className="ql-editor" dangerouslySetInnerHTML={{__html:postInfo.content}}></div>
        </div>
      </div>
    </div>
  )
}
