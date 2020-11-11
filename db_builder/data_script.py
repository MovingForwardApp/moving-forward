#!/usr/bin/env python

import sqlite3
import csv
import os

from os import remove, replace
from os import path

#Create db schema
os.system('sqlite3 database.db < db.schema')
print('Create db schema')

#Open categories and resources csv
f_cat=open('categories.csv','r')
reader_cat = csv.reader(f_cat)

f_res=open('resources.csv','r')
reader_res = csv.reader(f_res)

#Connect to db
sql = sqlite3.connect('database.db')
cur = sql.cursor()

#Fill db with categories
#for row in reader_cat:
#    cur.execute("INSERT INTO categories VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)", (row[0], row[1], row[2], row[3], row[4], row[5], row[6], row[7], row[8], row[9], row[10], row[11]))
cur.executemany("INSERT INTO categories VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)", reader_cat)

#Print saved rows
#print('Categories:')
#for row in cur.execute('SELECT * FROM categories'):
#    print(row)
print('Categories:', len(list(cur.execute('SELECT * FROM categories'))))

#Fill db with resources and resources by category
for row in reader_res:
    cur.execute("INSERT INTO resources VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)", (row[0], row[9], row[10], row[11], row[12], row[13], row[14], row[15], row[16], row[17], row[18], row[19], row[20], row[21], row[22], row[23], row[24]))

    categories = [row[1], row[2], row[3], row[4], row[5], row[6], row[7], row[8]]
    for category_id, value in enumerate(categories, start=1):
        if value == "TRUE":
            cur.execute("INSERT INTO resource_category VALUES (?, ?)", (row[0], category_id))

#Print saved rows
#print('Resources:')
#for row in cur.execute('SELECT * FROM resources'):
#    print(row)
print('Resources:', len(list(cur.execute('SELECT * FROM resources'))))

#Print saved rows
#print('Resources by category:')
#for row in cur.execute('SELECT * FROM resource_category'):
#    print(row)
print('Resources by category:', len(list(cur.execute('SELECT * FROM resource_category'))))

#Close file and conection
f_cat.close()
f_res.close()
sql.commit()
sql.close()

#Delete database.db if exists
if path.exists('../assets/database.db'):
    remove('../assets/database.db')
    print('Delete db')

#Move database.db to /assets
os.replace('database.db', '../assets/database.db')
print('Move database.db to ../assets')
