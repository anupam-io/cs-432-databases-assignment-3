import mysql.connector

mydb = mysql.connector.connect(
  host="localhost",
  user="root@localhost"
)

print(mydb)