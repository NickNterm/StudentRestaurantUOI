from ast import main
from asyncore import read
from docx.api import Document
import re
import psycopg2

conn = psycopg2.connect(database="StudentRestaurantUOI",
                        host="localhost",
                        user="postgres",
                        password="admin",
                        port="5432")


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
                    # print("{")
                    # print('"date": "' + key + '",')
                    # print('"type": "' + foodType + '",')
                    # print('"first Dish" : "' + re.sub(' +', ' ', str(first_dish).replace("\n", " ")) + '",')
                    # print('"main Dish": "' + re.sub(' +', ' ', str(main_dish).replace("\n", " ")) + '",')
                    # print('"special Dish": "' + re.sub(' +', ' ', str(special_dish).replace("\n", " ")).strip() + '",')
                    # print('"extra1 Dish": "' + re.sub(' +', ' ', str(extra1).replace("\n", " ")) + '",')
                    # print('"extra2 Dish": "' + re.sub(' +', ' ', str(extra2).replace("\n", " ")) + '"')
                    # print("},")
                    cursor = conn.cursor()
                    sql = "INSERT INTO meals (date, meal_type, first_dish, main_dish, special_dish, side_dish1, side_dish2) VALUES('"+key.strip()+"/2022', '" + \
                        foodType+"', '"+firstDish+"', '"+mainDish+"', '"+specialDish+"', '"+sideDish1+"', '"+sideDish2+"')"
                    cursor.execute(sql)
                    conn.commit()
                    cursor.close()


document = Document('lesxh.docx')
for table in document.tables:
    read_table(table)

conn.close()
