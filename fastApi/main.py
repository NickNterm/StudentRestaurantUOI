from fastapi import FastAPI, Depends, Body
from typing import Optional, Union
from pydantic import BaseModel
import models
from database import engine, SessionLocal
from fastapi.security import OAuth2PasswordBearer
from datetime import *
from fastapi.middleware.cors import CORSMiddleware

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

origins = ["*"]

app.add_middleware(
    CORSMiddleware,
    allow_origins=origins,
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)


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
    start_date: Optional[str] = "1/1/2000",
    end_date: Optional[str] = "1/1/2100",
    db=Depends(get_db),
):
    # return start_date
    return db.query(models.Program).filter(
        models.Program.date >= datetime.strptime(start_date, '%d/%m/%Y'),
        models.Program.date <= datetime.strptime(end_date, '%d/%m/%Y'),
    ).all()


@app.get("/special")
def get_special():
    return {
        [
            {
                "name": "Valentines Day",
                "date": "14/02/2021",
                "opacity": 0.5,
                "background_image": "https://images.unsplash.com/photo-1604147706283-d7119b5b822c?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Nnx8d2hpdGV8ZW58MHx8MHx8&w=1000&q=80",
            },

        ]
    }
