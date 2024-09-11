import { Link } from "react-router-dom";
import { FaBars } from "react-icons/fa";
import { useEffect, useState } from "react";

import Navbar, { NavBar } from "./NavBar";

import "./Header.css";


export default function Header() {

  return (
    <header className="header">
      <Navbar></Navbar>
    </header>
  )

}
