import { useState, useEffect, useRef  } from "react";
import { Link } from "react-router-dom";
import { useNavigate } from 'react-router-dom';
import { SchemaUserLogin } from "../libs/Schemas.js"
import Msg from "../components/Msg.jsx"
import useOuterClick from "../libs/useOuterClick.jsx"

import "./LoginSignup.css";


export default function LoginPage() {
  const [username, setUsername] = useState('');
  const [password, setPassword] = useState('');
  const [redirect, setRedirect] = useState(false);
  const navigate = useNavigate();
  const outerClickRef = useOuterClick(ev => navigate(-1));

  // Msg
  const [msg, setMsg] = useState({key:0,info:[],success:[],warning:[],error:[]});
  const resetMsg = o => setMsg(msg => ({key:0,info:[],success:[],warning:[],error:[]}));
  const updateInfoMsg = (o,shake) => setMsg(msg => ({...msg, key:shake?Math.random():msg.key,    info:Object.values(o)}));
  const updateSuccessMsg = (o,shake) => setMsg(msg => ({...msg, key:shake?Math.random():msg.key, success:Object.values(o)}));
  const updateWarningMsg = (o,shake) => setMsg(msg => ({...msg, key:shake?Math.random():msg.key, warning:Object.values(o)}));
  const updateErrorMsg = (o,shake) => setMsg(msg => ({...msg, key:shake?Math.random():msg.key,   error:Object.values(o)}));



  async function login(ev) {
    ev.preventDefault();
    const URL = `${process.env.REACT_APP_API_PROTOCOL}://${process.env.REACT_APP_API_DOMAIN}`;

    const response = await fetch(URL+'/api/auth/login', {
      method: 'POST',
      body: JSON.stringify({username, password}),
      headers: {'Content-Type': 'application/json'},
    });

    if (response.ok) {
      resetMsg();
      updateSuccessMsg(["Logged!"]);
      const jwtToken = await response.json();
      setRedirect(true);

      // Save JWT token in session storage
      sessionStorage.setItem('access_token', jwtToken['access_token']);
      sessionStorage.setItem('refresh_token', jwtToken['refresh_token']);

      // getters
      //var getObject = JSON.parse(sessionStorage.getItem("access_token"));

    } else {
      const result = await response.json();
      resetMsg();
      updateErrorMsg(result.detail);
      console.log("erreur!")
    }
  }

  function localCheck(ev, shake) {
    ev.preventDefault();
    const schema = new SchemaUserLogin(username, password);
    const errors = []
    if (!schema.isValidUsername()) errors.push(schema.error);
    if (!schema.isValidPassword()) errors.push(schema.error);
    if (Object.keys(errors).length > 0) {
      updateErrorMsg(errors, shake);
      return true;
    }
    return false;
  }


  function localCheckThenLogin(ev) {
    ev.preventDefault();
    // local verifiation
    if (localCheck(ev,true)) return;
    // server verification
    return login(ev);
  }


  if (redirect) {
    setTimeout(()=> { navigate("/"); }, 2000);
  }

  return (
    <div className="login article-card-high" ref={outerClickRef}>

      <form onSubmit = { localCheckThenLogin }>
        <h1>Login</h1>
        <input type = "text"
              autoFocus
              placeholder = "Username"
              value = { username }
              onChange = { ev => setUsername(ev.target.value) }/>
        <input type="password"
              placeholder="password"
              value = { password }
              onChange = { ev => setPassword(ev.target.value) }/>
        <button class="button button-1" disabled={redirect}
                style={{margin:"30px 0px",width:"80%"}}>
          Login
        </button>
      </form>

      <Msg msg={msg}/>

      Don’t have an account? <Link to="/signup">Sign up</Link>
    </div>

  )
}
