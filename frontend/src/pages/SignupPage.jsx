import { useState } from "react"
import { Link } from "react-router-dom";
import { useNavigate } from 'react-router-dom';
import { SchemaUserCreate } from "../libs/Schemas.js"
import Msg from "../components/Msg.jsx"
import useOuterClick from "../libs/useOuterClick.jsx"
import "./LoginSignup.css";


export default function SignupPage() {
  const [username, setUsername] = useState('');
  const [email, setEmail] = useState('');
  const [password, setPassword] = useState('');
  const [password2, setPassword2] = useState('');
  const navigate = useNavigate();
  const outerClickRef = useOuterClick(ev => navigate(-2));

  // Msg
  const [msg, setMsg] = useState({key:0,info:[],success:[],warning:[],error:[]});
  const resetMsg = o => setMsg(msg => ({key:0,info:[],success:[],warning:[],error:[]}));
  const updateInfoMsg = (o,shake) => setMsg(msg => ({...msg, key:shake?Math.random():msg.key,    info:Object.values(o)}));
  const updateSuccessMsg = (o,shake) => setMsg(msg => ({...msg, key:shake?Math.random():msg.key, success:Object.values(o)}));
  const updateWarningMsg = (o,shake) => setMsg(msg => ({...msg, key:shake?Math.random():msg.key, warning:Object.values(o)}));
  const updateErrorMsg = (o,shake) => setMsg(msg => ({...msg, key:shake?Math.random():msg.key,   error:Object.values(o)}));


  async function signup(ev, shake) {
    ev.preventDefault();

    const response = await fetch('https://tensormaker.org/api/auth/signup', {
    //const response = await fetch('http://test.test/api/auth/signup', {
      method: 'POST',
      body: JSON.stringify({username, email, password}),
      headers: {'Content-Type': 'application/json'},
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
  }

  function localCheck(ev, shake) {
    ev.preventDefault();
    const schema = new SchemaUserCreate(username, email, password, password2);
    const errors = []
    if (!schema.isValidUsername()) errors.push(schema.error);
    if (!schema.isValidEmail()) errors.push(schema.error);
    if (!schema.isValidPassword()) errors.push(schema.error);
    if (Object.keys(errors).length > 0) {
      updateErrorMsg(errors, shake);
      return true;
    }
    return false;
  }

  function localCheckThenSignup(ev) {
    ev.preventDefault();
    // local verifiation
    if (localCheck(ev,true)) return;
    // server verification
    return signup(ev,true);
  }



  return (
    <div className="signup article-card-high" ref={outerClickRef}>
      <form onSubmit={localCheckThenSignup}>
        <h1>Sign up</h1>
        <input type="text"
              autoFocus
              placeholder="Username"
              maxlength="32"
              value={ username }
              onChange={ ev => {
                  //localCheck(ev)
                  return setUsername(ev.target.value)
                }
              }/>
        <input type="text"
              placeholder="Email"
              maxlength="64"
              value={ email }
              onChange={ ev => {
                  //localCheck(ev)
                  return setEmail(ev.target.value)
                }
              }/>
        <input type="password"
              placeholder="Password"
              maxlength="32"
              value={ password }
              onChange={ ev => {
                  //updateInfoMsg(["Weak password"]);
                  //localCheck(ev)
                  return setPassword(ev.target.value, true);
                }
               }/>
        <input type="password"
              placeholder="Password confirmation"
              maxlength="32"
              value={ password2 }
              onChange={ ev => setPassword2(ev.target.value) }/>

        <button class="button button-1"
                style={{margin:"30px 0px",width:"80%"}}>
          Sign up
        </button>
      </form>

      <Msg msg={msg}/>

      <div>
        Already have an account? <Link to="/login">Log in</Link>
      </div>
    </div>

  );
}



/*

    <div className="register article-card-bottom">
      Already have an account? <Link to="/login">Log in</Link>
    </div>



<>
{Object.values(success).map(value => (
  <div className="success">✔️ {value}</div>
))}
</>
<>
{Object.values(error).map(value => (
  <Title className="error">❌ {value}</Title>
))}
</>
*/
