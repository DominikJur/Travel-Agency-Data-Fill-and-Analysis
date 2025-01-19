# DELETE FROM Uczestnicy;
# DELETE FROM Wycieczki_Uczestnicy;
# DELETE FROM Wycieczki;
#  DELETE FROM Pracownicy;
#  DELETE FROM Tematyki;
#  DELETE FROM Kierunki;
# DELETE FROM Transakcje;


SELECT COUNT(*) as liczba_panów
FROM Uczestnicy
WHERE imie LIKE '%Pan%'
# # ;
# SELECT AVG(num_of_ppl) AS avg_num_of_ppl
# FROM (
#     SELECT COUNT(*) AS num_of_ppl
#     FROM Wycieczki_Uczestnicy
#     GROUP BY id_wycieczki
# ) AS subquery;
# ;
# select count(*) FROM Wycieczki;
#  select count(*) FROM Pracownicy;
#  select count(*) FROM Tematyki;
#  select count(*) FROM Kierunki;
#  select count(*) FROM Transakcje;
