import { format } from "date-fns";
import { Link } from "react-router-dom";



//export default function Post({id, title, author, createdAt, category, summary, cover}) {
// <img src={"static/post/images/"+cover} alt="" />

export default function Post({id, title, cover, summary, published_at, username, category}) {

  return (
    <div className="post">
      <div className="image">
        <Link to={`/posts/${id}`}>
          <img src={process.env.PUBLIC_URL + "/posts/images/" + cover} alt="" />
        </Link>
      </div>

      <div className="texts">

        <Link to={`/posts/${id}`}>
          <h2>{title}</h2>
        </Link>

        <p className="info">
          <a className="author">{username}</a>
          <time>{"Le " + format(new Date(published_at), 'dd/MM/yyyy à HH:mm')}</time>
          <category>{category || "Uncategorized"}</category>
        </p>
        <p className="summary">{summary}</p>
      </div>
    </div>
  );
}
