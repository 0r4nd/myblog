
import { Link } from "react-router-dom";

/*
const input = {
  array:     ["a", "b"],
  separator: " - ",
  to:        ["/linkA", "/linkB"]
};
<ArrayToLinkTags { ...input } />


output:
  <Link to="/linkA">a</Link>
  <a> - </a>
  <Link to="/linkB">b</Link>
*/
export default function ArrayToLinkTags({array,className,separator,to=[]}) {
  const isLast = (i,a) => (i+1) >= a.length;
  return(
    <div>
      {
        array.map((elem,index,arr) => (
          <>
            <Link className={className} to={`${to[index]||""}`}>{elem}</Link>
            {separator&&!isLast(index,arr)? <a>{separator}</a>:<></>}
          </>
        ))
      }
    </div>
  )
}
