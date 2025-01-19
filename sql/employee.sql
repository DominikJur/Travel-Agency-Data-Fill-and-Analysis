SELECT
    CONCAT(P.imie, P.nazwisko) as imie_i_nazwiako,
    P.data_zatrudnienia,
    P.stanowisko,
    P.wynagrodzenie
FROM Pracownicy P