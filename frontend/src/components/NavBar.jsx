

import { useState, useEffect } from "react";
import { Link } from "react-router-dom";
import useOuterClick from "../libs/useOuterClick.jsx"
import "./NavBar.css";


function setClass(id, strClass) {
  var elem = document.getElementById(id);
  elem.setAttribute("class", "")
  elem.classList.add(strClass);
}

export default function Navbar() {
  const [isActive, setIsActive] = useState(false);
  const outerClickRef = useOuterClick(ev => removeActive());

  function setOverlay(isActive=false) {
    var values = ["none", "rgba(0,0,0,0)", "0px"];
    if (isActive) values = ["auto", "rgba(0,0,0,0.5)", "10px"];
    const style = document.documentElement.style;
    style.setProperty('--overlay-pointer-events',values[0]);
    style.setProperty('--overlay-color', values[1]);
    style.setProperty('--overlay-blur', values[2]);
  }
  function removeActive() {
    setOverlay(false);
    setIsActive(false);
  }
  function toggleActiveClass() {
    setOverlay(!isActive);
    setIsActive(!isActive);
  }

  // close the menu when the windows is resized
  useEffect(() => {
    window.addEventListener("resize", removeActive);

    return () => {
      window.removeEventListener("resize", removeActive);
    };
  }, []);

  function ConditionalLink({ children, condition, ...props }) {
    return !!condition && props.to ? <Link {...props}>{children}</Link> : <>{children}</>
  }

  return (
    <nav className="navBar">

      {/* TODO: à finir */}
      <Link onClick={() => console.log(window.location.pathname)}/>

          <Link to="/" className="logo" onClick={() =>setClass("logo", "neon-blue")}>
          <h2 id="logo" className="neon-blue">TensorMaker</h2>
        </Link>


      <ul className={`navMenu ${isActive ? "active" : ""}`}>
        <li onClick={removeActive}>
          <Link to='tools' className="navLink">Tools</Link>
        </li>
        <li onClick={removeActive}>
          <Link to='/login' className="navLink">Login</Link>
        </li>
      </ul>
      <div className={`hamburger ${isActive ? "active" : ""}`} onClick={toggleActiveClass} ref={outerClickRef}>
        <span className="bar"></span>
        <span className="bar"></span>
        <span className="bar"></span>
      </div>
    </nav>
  );
}
