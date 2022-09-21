from sqlalchemy import Boolean, Column, Integer, String
from database import Base


class Meal(Base):
    __tablename__ = "meals"

    id = Column(Integer, primary_key=True, index=True)
    date = Column(String)
    meal_type = Column(String)
    first_dish = Column(String)
    main_dish = Column(String)
    special_dish = Column(String)
    side_dish1 = Column(String)
    side_dish2 = Column(String)
