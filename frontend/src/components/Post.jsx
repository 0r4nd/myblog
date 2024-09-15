import { format } from "date-fns";
import { Link } from "react-router-dom";
import ArrayToLinkTags from "./ArrayToLinkTags.jsx";

import "./Post.css"


export default function Post({id, title, cover, summary, published_at, username, category}) {

  const capitalize = s => s[0].toUpperCase() + s.slice(1);

  const category_layout = {
    array: category.split("|").map(s => capitalize(s.trim())),
    className: "category",
    separator: " · ",
    to: [".",".",".",".","."]
  };

  return (
    <div className="post">
      <div className="image">
        <Link to={`/blog/posts/${id}`}>
          <img src={process.env.PUBLIC_URL + "/uploads/blog/posts/images/" + cover} alt="" />
        </Link>
      </div>

      <div className="texts">

        <Link to={`/blog/posts/${id}`}>
          <h2>{title}</h2>
        </Link>

        <p className="info">
          <Link to="." className="author">{username}</Link>
          <time>{"Le " + format(new Date(published_at), 'dd/MM/yyyy à HH:mm')}</time>
          <ArrayToLinkTags {...category_layout}/>
        </p>
        <p className="summary">{summary}</p>
      </div>
    </div>
  );
}
