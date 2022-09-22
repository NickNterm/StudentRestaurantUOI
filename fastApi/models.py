from sqlalchemy import Boolean, Column, Integer, String, ForeignKey, DateTime
from sqlalchemy.orm import relationship
from database import Base


class Meal(Base):
    __tablename__ = "meals"

    id = Column(Integer, primary_key=True, index=True)
    name = Column(String)
    image = Column(String)


class Program(Base):
    __tablename__ = "program"

    id = Column(Integer, primary_key=True, index=True)
    date = Column(DateTime)
    meal_type = Column(String)
    first_dish = Column(Integer, ForeignKey("meals.id"))
    main_dish = Column(Integer, ForeignKey("meals.id"))
    special_dish = Column(Integer, ForeignKey("meals.id"))
    side_dish1 = Column(Integer, ForeignKey("meals.id"))
    side_dish2 = Column(Integer, ForeignKey("meals.id"))
