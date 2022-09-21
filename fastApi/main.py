from pyexpat import model
from fastapi import FastAPI, Depends, Body
from typing import Optional, Union
from pydantic import BaseModel
from sqlalchemy import desc
import models
from database import engine, SessionLocal
from fastapi.security import OAuth2PasswordBearer
from datetime import *

api_keys = [
    "vP33IqweAwoS2v20xczvMOKDGrNDS8Y3Bb7ZV33lh6Y9Hn6w07mVSw3076GXVkkE"
]

oauth2_scheme = OAuth2PasswordBearer(tokenUrl="token")


def api_key_auth(api_key: str = Depends(oauth2_scheme)):
    if api_key not in api_keys:
        raise HTTPException(
            status_code=status.HTTP_401_UNAUTHORIZED,
            detail="Forbidden"
        )


app = FastAPI()

models.Base.metadata.create_all(bind=engine)


class Meal(BaseModel):
    date: Union[datetime, None] = Body(default=None)
    mealType: str
    firstDish: str
    mainDish: str
    specialDish: str
    sideDish1: str
    sideDish2: str


def get_db():
    try:
        db = SessionLocal()
        yield db
    finally:
        db.close()


@app.get("/")  # , dependencies=[Depends(api_key_auth)])
def get_all_meals(db=Depends(get_db)):
    return db.query(models.Meal).order_by(
        desc(models.Meal.id)
    ).all()
