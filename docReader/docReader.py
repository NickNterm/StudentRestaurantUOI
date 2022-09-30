from docx.api import Document
import re
import psycopg2
from datetime import datetime

conn = psycopg2.connect(database="StudentRestaurantUOI",
                        host="localhost",
                        user="postgres",
                        password="admin",
                        port="5432")
meals = {}


def read_meals():
    cursor = conn.cursor()
    postgreSQL_select_Query = "select * from meals"
    cursor.execute(postgreSQL_select_Query)
    meal_records = cursor.fetchall()
    for row in meal_records:
        meals[row[1].upper()] = row[0]


firstDishId = 0
mainDishId = 0
specialDishId = 0
sideDish1 = 0
sideDish2 = 0


def read_table(table):
    data = []

    keys = None
    for i, row in enumerate(table.rows):
        text = (cell.text for cell in row.cells[2:])
        if i == 0:
            keys = tuple(text)
            continue
        row_data = dict(zip(keys, text))
        data.append(row_data)
        foodType = ""
        if i == 1:
            foodType = "meal"
        elif i == 2:
            foodType = "dinner"
        if i == 1 or i == 2:
            for key in keys:
                if "ή" in str(row_data[key]):
                    
                    first_half, second_half = row_data[key].split("\nή\n")
                    first_half = re.sub('\n\n+', '\n\n', first_half)
                    first_dish, main_dish = first_half.split("\n\n")[:2]
                    second_half = re.sub('\n\n+', '\n\n', second_half)
                    special_dish, extra = second_half.split("\n\n")[:2]
                    extra = re.sub('\n+', '\n', extra)
                    extra1, extra2 = extra.split("\n")[:2]

                    firstDish = re.sub(' +', ' ', str(first_dish).replace("\n", " ")).strip()
                    mainDish = re.sub(' +', ' ', str(main_dish).replace("\n", " ")).strip()
                    specialDish = re.sub(' +', ' ', str(special_dish).replace("\n", " ")).strip()
                    sideDish1 = re.sub(' +', ' ', str(extra1).replace("\n", " ")).strip()
                    sideDish2 = re.sub(' +', ' ', str(extra2).replace("\n", " ")).strip()

                    all_fields_set = False
                    while not all_fields_set:
                        if firstDish.upper() in meals.keys():
                            firstDishId = meals[firstDish.upper()]
                        else:
                            sql_insert = "INSERT INTO meals (name) VALUES ('"+firstDish+"');"
                            cursor = conn.cursor()
                            cursor.execute(sql_insert)
                            conn.commit()
                            cursor.close()
                            read_meals()
                            continue
                        if mainDish.upper() in meals.keys():
                            mainDishId = meals[mainDish.upper()]
                        else:
                            sql_insert = "INSERT INTO meals (name) VALUES ('"+mainDish+"');"
                            cursor = conn.cursor()
                            cursor.execute(sql_insert)
                            conn.commit()
                            cursor.close()
                            read_meals()
                            continue
                        if specialDish.upper() in meals.keys():
                            specialDishId = meals[specialDish.upper()]
                        else:
                            sql_insert = "INSERT INTO meals (name) VALUES ('"+specialDish+"');"
                            cursor = conn.cursor()
                            cursor.execute(sql_insert)
                            conn.commit()
                            cursor.close()
                            read_meals()
                            continue
                        if sideDish1.upper() in meals.keys():
                            sideDish1Id = meals[sideDish1.upper()]
                        else:
                            sql_insert = "INSERT INTO meals (name) VALUES ('"+sideDish1+"');"
                            cursor = conn.cursor()
                            cursor.execute(sql_insert)
                            conn.commit()
                            cursor.close()
                            read_meals()
                            continue
                        if sideDish2.upper() in meals.keys():
                            sideDish2Id = meals[sideDish2.upper()]
                            all_fields_set = True
                        else:
                            sql_insert = "INSERT INTO meals (name) VALUES ('"+sideDish2+"');"
                            cursor = conn.cursor()
                            cursor.execute(sql_insert)
                            conn.commit()
                            cursor.close()
                            read_meals()
                            continue
                            # print("{")
                            # print('"date": "' + key + '",')
                            # print('"type": "' + foodType + '",')
                            # print('"first Dish" : "' + re.sub(' +', ' ', str(first_dish).replace("\n", " ")) + '",')
                            # print('"main Dish": "' + re.sub(' +', ' ', str(main_dish).replace("\n", " ")) + '",')
                            # print('"special Dish": "' + re.sub(' +', ' ', str(special_dish).replace("\n", " ")).strip() + '",')
                            # print('"extra1 Dish": "' + re.sub(' +', ' ', str(extra1).replace("\n", " ")) + '",')
                            # print('"extra2 Dish": "' + re.sub(' +', ' ', str(extra2).replace("\n", " ")) + '"')
                            # print("},")
                    dt = datetime.strptime(key+"/2022", "%d/%m/%Y")
                    print(dt)
                    sql = "INSERT INTO program (date, meal_type, first_dish, main_dish, special_dish, side_dish1, side_dish2) VALUES('"+str(dt)+"', '" + \
                        foodType+"', '"+str(firstDishId)+"', '"+str(mainDishId)+"', '"+str(specialDishId)+"', '"+str(sideDish1Id)+"', '"+str(sideDish2Id)+"')"
                    cursor = conn.cursor()
                    cursor.execute(sql)
                    conn.commit()
                    cursor.close()


read_meals()
document = Document('oktovrios-2022.docx')
for table in document.tables:
    read_table(table)

conn.close()
