
import { isForbiddenUsername } from "./auth_ban_words.js";


const USERNAME_MIN_LENGTH = 4;
const USERNAME_MAX_LENGTH = 32;

const EMAIL_MIN_LENGTH = 5;
const EMAIL_MAX_LENGTH = 64;
const EMAIL_REGEX = /^[-a-z0-9~!$%^&*_=+}{'?]+(\.[-a-z0-9~!$%^&*_=+}{'?]+)*@([a-z0-9_][-a-z0-9_]*(\.[-a-z0-9_]+)*\.(aero|arpa|biz|com|coop|edu|gov|info|int|mil|museum|name|net|org|pro|travel|mobi|[a-z][a-z])|([0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}))(:[0-9]{1,5})?$/i;

const PASSWORD_MIN_LENGTH = 6;
const PASSWORD_MAX_LENGTH = 32;


const AuthChecker = (function() {

  function AuthChecker() {
    this.error = "";
  }
  AuthChecker.isLetter = function(c) {
    return c.toLowerCase() !== c.toUpperCase();
  };
  AuthChecker.isLetterOrDigit = function(c) {
    return (c >= '0' && c <= '9') ||  AuthChecker.isLetter(c);
  };
  AuthChecker.isDigitOnly = function(str) {
    for (var i = 0; i < str.length; i++) {
      var c = str[i];
      if (!(c >= '0' && c <= '9')) return false;
    }
    return true;
  };
  AuthChecker.isLetterOnly = function(str) {
    for (var i = 0; i < str.length; i++) {
      var c = str[i];
      if (c.toLowerCase() === c.toUpperCase()) return false;
    }
    return true;
  };

  AuthChecker.isValidUsername = function(username) {
    if (username.length === 0) {
      this.error = "Username can't be empty";
      return false;
    }
    if (AuthChecker.isDigitOnly(username)) {
      this.error = "Username can't have only numbers";
      return false;
    }
    if (username.length < USERNAME_MIN_LENGTH) {
      this.error = `Username must be at least ${USERNAME_MIN_LENGTH} characters long`;
      return false;
    }
    if (username.length > USERNAME_MAX_LENGTH) {
      this.error = `Username must not exceed ${USERNAME_MAX_LENGTH} characters`;
      return false;
    }
    for (var i = 0; i < username.length; i++) {
      var c =  username[i];
      if (!AuthChecker.isLetterOrDigit(c) && c !== '_') {
        this.error = "Username can only contain letters, numbers and '_' characters";
        return false;
      }
    }
    if (isForbiddenUsername(username)) {
      this.error = "Username is not valid";
      return false;
    }

    return true;
  };

  AuthChecker.isValidEmail = function(email) {
    if (email.length === 0) {
      this.error = "Email can't be empty";
      return false;
    }
    if (email.length < EMAIL_MIN_LENGTH) {
      this.error = `Email must be at least ${EMAIL_MIN_LENGTH} characters long`;
      return false;
    }
    if (email.length > EMAIL_MAX_LENGTH) {
      this.error = `Email must not exceed ${EMAIL_MAX_LENGTH} characters`;
      return false;
    }
    if (email.match(EMAIL_REGEX) == null) {
      this.error = "Email is malformed";
      return false;
    }
    return true;
  };

  AuthChecker.isValidPassword = function(password, password_confirm) {
    if (password.length === 0) {
      this.error = "Password can't be empty";
      return false;
    }
    if (password.length < PASSWORD_MIN_LENGTH) {
      this.error = `Password must be at least ${PASSWORD_MIN_LENGTH} characters long`;
      return false;
    }
    if (password.length > PASSWORD_MAX_LENGTH) {
      this.error = `Password must not exceed ${PASSWORD_MAX_LENGTH} characters`;
      return false;
    }
    if (AuthChecker.isDigitOnly(password)) {
      this.error = "Password must have at least one letter and one number";
      return false;
    }
    if (AuthChecker.isLetterOnly(password)) {
      this.error = "Password must have at least one letter and one number";
      return false;
    }
    if (password !== password_confirm) {
      this.error = "Password does not match the confirmation password";
      return false;
    }
    return true;
  };

  return AuthChecker;
})();


export { AuthChecker }
