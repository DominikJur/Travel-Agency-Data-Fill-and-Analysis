import mysql.connector
import random


# Połączenie z bazą 
conn = mysql.connector.connect(
    host="giniewicz.it",
    user="team20",
    password="te@mzazo",
    database="team20"
)
cursor = conn.cursor()

miasta = [
    "Warszawa", "Kraków", "Wrocław", "Poznań", 
    "Gdańsk", "Łódź", "Szczecin", "Lublin", 
    "Katowice", "Bydgoszcz"
]

for i in range(1, 10):
    miasto = miasta[i-1]  
    koszt = random.randint(500, 1500)  
    zarobek_factor = random.choice([2, 2.5, 3])  # Losuj mnożnik dla zarobku
    zarobek = round(koszt * zarobek_factor)  

    # Wstawianie do tabeli
    cursor.execute('''
        INSERT INTO Kierunki (id_kierunku, miasto, koszt, zarobek)
        VALUES (%s, %s, %s, %s);
    ''', (i, miasto, koszt, zarobek))

conn.commit()

print("Dane zostały dodane do tabeli Kierunki.")


cursor.close()
conn.close()
