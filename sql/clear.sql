DELETE U
FROM Uczestnicy U
LEFT JOIN Wycieczki_Uczestnicy WU
ON U.id_uczestnika = WU.id_uczestnika
WHERE WU.id_wycieczki IS NULL;