
from pydantic import BaseModel, Field
from typing import Optional
import datetime

from .auth import AuthChecker


class SchemaUserCreate(AuthChecker):
    error: str = Field("", exclude=True) # hidden
    pass

class SchemaUserLogin(AuthChecker):
    email: str = Field("", exclude=True) # hidden
    error: str = Field("", exclude=True) # hidden
    pass



class RequestDetails(BaseModel):
    email:str
    password:str

class ChangePassword(BaseModel):
    email:str
    old_password:str
    new_password:str

class TokenCreate(BaseModel):
    id_user:str
    access_token:str
    refresh_token:str
    created_at:datetime.datetime
    status:bool
class TokenSchema(BaseModel):
    access_token: str
    refresh_token: str
