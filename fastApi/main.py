from fastapi import FastAPI, Depends, Body
from typing import Optional, Union
from pydantic import BaseModel
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


class Program(BaseModel):
    date:  Union[datetime, None] = Body(default=None)
    mealType: str
    firstDish: int
    mainDish: int
    specialDish: int
    sideDish1: int
    sideDish2: int


class Meal(BaseModel):
    name: str
    image: str


def get_db():
    try:
        db = SessionLocal()
        yield db
    finally:
        db.close()


@app.get("/meals")  # , dependencies=[Depends(api_key_auth)])
def get_all_meals(db=Depends(get_db)):
    return db.query(models.Meal).all()


@app.get("/program")
def get_program(
    start_date: Optional[str] = "20/9/2022",
    end_date: Optional[str] = "22/9/2022",
    db=Depends(get_db),
):
    # return start_date
    return db.query(models.Program).filter(
        models.Program.date >= datetime.strptime(start_date, '%d/%m/%Y'),
        models.Program.date <= datetime.strptime(end_date, '%d/%m/%Y'),
    ).all()
