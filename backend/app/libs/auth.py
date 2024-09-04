

import jwt
from jwt.exceptions import InvalidTokenError

from passlib import pwd
from passlib.context import CryptContext
from fastapi.security import OAuth2PasswordBearer, OAuth2PasswordRequestForm

from datetime import datetime, timedelta, timezone
from typing import Union, Any

import os
from pathlib import Path
from dotenv import load_dotenv

from pydantic import BaseModel, Field
import re

from .auth_ban_words import is_forbidden_username


env_path = Path('.') / '.env'
load_dotenv(dotenv_path=env_path)


ACCESS_TOKEN_EXPIRE_MINUTES = 30  # 30 minutes
REFRESH_TOKEN_EXPIRE_MINUTES = 60 * 24 * 7 # 7 days

class Auth:
    def __init__(self, schemes=["bcrypt"]):
        self.context = CryptContext(schemes=schemes, deprecated="auto")
        self.oauth2_scheme = OAuth2PasswordBearer(tokenUrl="token")
        self.pepper = os.getenv("PASSWORD_PEPPER", "")
        self.secret_key = os.getenv("JWT_SECRET_KEY")
        self.refresh_secret_key = os.getenv("JWT_REFRESH_SECRET_KEY")
        self.encode_algorithm = os.getenv("JWT_ENCODE_ALGORITHM")

    def get_password_hash(self, password):
        return self.context.hash(password + self.pepper)

    def verify_password(self, password, hashed_password):
        return self.context.verify(password + self.pepper, hashed_password)

    def create_activation_key(self):
        return pwd.genword(length=32)

    def create_access_token(self, data:dict, expires_delta = 0):
        to_encode = data.copy()
        if expires_delta:
            expire = datetime.now(timezone.utc) + expires_delta
        else:
            expire = datetime.now(timezone.utc) + timedelta(minutes=ACCESS_TOKEN_EXPIRE_MINUTES)
        to_encode.update({"exp": expire})
        return jwt.encode(to_encode, self.secret_key, algorithm=self.encode_algorithm)

    def create_refresh_token(self, data:dict, expires_delta = 0):
        to_encode = data.copy()
        if expires_delta:
            expire = datetime.now(timezone.utc) + expires_delta
        else:
            expire = datetime.now(timezone.utc) + timedelta(minutes=REFRESH_TOKEN_EXPIRE_MINUTES)
        to_encode.update({"exp": expire})
        return jwt.encode(to_encode, self.refresh_secret_key, algorithm=self.encode_algorithm)

    def decode_access_token(self, token: str):
        try:
            decoded_token = jwt.decode(token, self.secret_key, algorithm=self.encode_algorithm)
            return decoded_token
        except InvalidTokenError:
            return None

    def decode_refresh_token(self, token: str):
        try:
            decoded_token = jwt.decode(token, self.refresh_secret_key, algorithm=self.encode_algorithm)
            return decoded_token
        except InvalidTokenError:
            return None




from fastapi import Request, HTTPException
from fastapi.security import HTTPBearer, HTTPAuthorizationCredentials

class JWTBearer(HTTPBearer):
    def __init__(self, auto_error: bool = True):
        super(JWTBearer, self).__init__(auto_error=auto_error)

    async def __call__(self, request: Request):
        credentials: HTTPAuthorizationCredentials = await super(JWTBearer, self).__call__(request)
        if credentials:
            if not credentials.scheme == "Bearer":
                raise HTTPException(status_code=403, detail="Invalid authentication scheme.")
            if not self.verify_jwt(credentials.credentials):
                raise HTTPException(status_code=403, detail="Invalid token or expired token.")
            return credentials.credentials
        else:
            raise HTTPException(status_code=403, detail="Invalid authorization code.")

    def verify_jwt(self, jwtoken: str) -> bool:
        isTokenValid: bool = False
        #try:
        #    payload = decodeJWT(jwtoken)
        #except:
        #    payload = None
        #if payload:
        #    isTokenValid = True
        return isTokenValid


"""
def create_access_token(subject: Union[str, Any], expires_delta: int = None) -> str:
    if expires_delta is not None:
        expires_delta = datetime.utcnow() + expires_delta

    else:
        expires_delta = datetime.utcnow() + timedelta(minutes=ACCESS_TOKEN_EXPIRE_MINUTES)


    to_encode = {"exp": expires_delta, "sub": str(subject)}
    encoded_jwt = jwt.encode(to_encode, JWT_SECRET_KEY, ALGORITHM)

    return encoded_jwt

def create_refresh_token(subject: Union[str, Any], expires_delta: int = None) -> str:
    if expires_delta is not None:
        expires_delta = datetime.utcnow() + expires_delta
    else:
        expires_delta = datetime.utcnow() + timedelta(minutes=REFRESH_TOKEN_EXPIRE_MINUTES)

    to_encode = {"exp": expires_delta, "sub": str(subject)}
    encoded_jwt = jwt.encode(to_encode, JWT_REFRESH_SECRET_KEY, ALGORITHM)
    return encoded_jwt
"""



USERNAME_MIN_LENGTH = 4
USERNAME_MAX_LENGTH = 32

EMAIL_MIN_LENGTH = 5
EMAIL_MAX_LENGTH = 64
EMAIL_REGEX = re.compile(r"(^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$)")

PASSWORD_MIN_LENGTH = 6
PASSWORD_MAX_LENGTH = 32

class AuthChecker(BaseModel):
    username: str
    email: str
    password: str
    error: str

    @staticmethod
    def is_letter(c:str):
        return c.lower() != c.upper()
    @staticmethod
    def is_letter_or_digit(c:str):
        return (c >= '0' and c <= '9') or AuthChecker.is_letter(c)
    @staticmethod
    def is_digit_only(string:str):
        for c in string:
            if not (c >= '0' and c <= '9'):
                return False
        return True
    @staticmethod
    def is_letter_only(string:str):
        for c in string:
            if not (c.lower() != c.upper()):
                return False
        return True

    def is_valid_username(self):
        if len(self.username) == 0:
            self.error = "Username can't be empty"
            return False
        if AuthChecker.is_digit_only(self.username):
            self.error = "Username can't have only numbers"
            return False
        if len(self.username) < USERNAME_MIN_LENGTH:
            self.error = "Username must be at least {} characters long".format(USERNAME_MIN_LENGTH)
            return False
        if len(self.username) > USERNAME_MAX_LENGTH:
            self.error = "Username must not exceed {} characters".format(USERNAME_MAX_LENGTH)
            return False
        for c in self.username:
            if not AuthChecker.is_letter_or_digit(c) and c != '_':
                self.error = "Username can only contain letters, numbers and _ character"
                return False
        if is_forbidden_username(self.username):
            self.error = "Username is not valid"
            return False
        return True

    def is_valid_email(self):
        if len(self.email) == 0:
            self.error = "Email can't be empty"
            return False
        if len(self.email) < EMAIL_MIN_LENGTH:
            self.error = "Email must be at least {} characters long".format(EMAIL_MIN_LENGTH)
            return False
        if len(self.email) > EMAIL_MAX_LENGTH:
            self.error = "Email must not exceed {} characters".format(EMAIL_MAX_LENGTH)
            return False
        if EMAIL_REGEX.match(self.email) == None:
            self.error = "Email is malformed"
            return False
        return True

    def is_valid_password(self):
        if len(self.password) == 0:
            self.error = "Password can't be empty"
            return False
        if len(self.password) < PASSWORD_MIN_LENGTH:
            self.error = "Password must be at least {} characters long".format(PASSWORD_MIN_LENGTH)
            return False
        if len(self.password) > PASSWORD_MAX_LENGTH:
            self.error = "Password must not exceed {} characters".format(PASSWORD_MAX_LENGTH)
            return False
        if AuthChecker.is_digit_only(self.password):
            self.error = "Password must have at least one letter and one number"
            return False
        if AuthChecker.is_letter_only(self.password):
            self.error = "Password must have at least one letter and one number"
            return False
        return True
