
import { AuthChecker } from "./AuthChecker.js";


const SchemaUserCreate = (function() {
  function SchemaUserCreate(username, email, password, password_confirm) {
    this.username = username;
    this.email = email;
    this.password = password;
    this.password_confirm = password_confirm;
    this.error = "";
  }
  SchemaUserCreate.prototype.isValidUsername = function() {
    return AuthChecker.isValidUsername.call(this, this.username);
  };
  SchemaUserCreate.prototype.isValidEmail = function() {
    return AuthChecker.isValidEmail.call(this, this.email);
  };
  SchemaUserCreate.prototype.isValidPassword = function() {
    return AuthChecker.isValidPassword.call(this, this.password,
                                                  this.password_confirm);
  };
  return SchemaUserCreate;
})();


const SchemaUserLogin = (function() {
  function SchemaUserLogin(username, password) {
    this.username = username;
    this.password = password;
    this.error = "";
  }
  SchemaUserLogin.prototype.check = function(result) {
    if (!result) {
      this.error = "The login credentials are not correct. Please try again."
    }
    return result;
  };

  SchemaUserLogin.prototype.isValidUsername = function() {
    return this.check(AuthChecker.isValidUsername.call(this,this.username));
  };
  //SchemaUserLogin.prototype.isValidEmail = function() {
  //  return this.check(AuthChecker.isValidEmail(this.email));
  //};
  SchemaUserLogin.prototype.isValidPassword = function() {
    return this.check(AuthChecker.isValidPassword.call(this,this.password, this.password));
  };
  return SchemaUserLogin;
})();


export { SchemaUserCreate, SchemaUserLogin }
