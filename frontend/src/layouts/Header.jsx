import { Link } from "react-router-dom";
import { useEffect } from "react";

export default function Header() {

  function setClass(strClass) {
    var elem = document.getElementById('logo');
    elem.setAttribute("class", "")
    elem.classList.add(strClass);
  }

  return (
    <header>
      <Link to="/" className="logo" onClick={() => setClass("neon-on")}>
      <h2 id="logo" className="neon-on">
      TensorMaker
      </h2>
      </Link>
      <nav>

      <Link to="/login">
        <button class="button button-1">
          Log in
        </button>
      </Link>

      </nav>
    </header>
  );
}
