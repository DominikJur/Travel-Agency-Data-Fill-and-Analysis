import pandas as pd
import mysql.connector as mysql


def get_analysis_data(**params):
    query = """
    SELECT W.id_wycieczki,
       W.ilosc_uczestnikow,
       T.kwota,
       DATEDIFF(W.data_zakonczenia, W.data_rozpoczecia) as ilosc_dni,
       K.miasto,
       K.kraj,
       T2.nazwa as tematyka,
       W.data_rozpoczecia,
       T.kwota - (T2.koszt * DATEDIFF(W.data_zakonczenia, W.data_rozpoczecia) - K.koszt) * W.ilosc_uczestnikow zysk,
       T.data_transakcji
    FROM Wycieczki W
        JOIN team20.Transakcje T on W.id_wycieczki = T.id_wycieczki
        JOIN team20.Kierunki K on K.id_kierunku = W.id_kierunku
        JOIN team20.Tematyki T2 on T2.id_tematyki = W.id_tematyki;
    """
    user, password, host, database = params.values()
    with mysql.connect(
        user=user, password=password, host=host, database=database
    ) as conn:
        data = pd.read_sql(query, conn)
    return data


def get_emploee_data(**params):
    query = """
    SELECT
        CONCAT(P.imie, P.nazwisko) as imie_i_nazwiako,
        P.data_zatrudnienia,
        P.stanowisko,
        P.wynagrodzenie
    FROM Pracownicy P;
    """
    user, password, host, database = params.values()
    with mysql.connect(
        user=user, password=password, host=host, database=database
    ) as conn:
        data = pd.read_sql(query, conn)
    return data


def get_trip_counts_data(**params):
    query = """
SELECT
    count(*) as ilosc_wyjazdow,
    id_uczestnika
FROM 
    Wycieczki_Uczestnicy
GROUP BY
    id_uczestnika;
    """
    user, password, host, database = params.values()
    with mysql.connect(
        user=user, password=password, host=host, database=database
    ) as conn:
        data = pd.read_sql(query, conn)
    return data


def get_returns_data(**params):
    query = """
SELECT K.kraj, T2.nazwa as tematyka, AVG((
    SELECT COUNT(*)-1
    FROM  Wycieczki_Uczestnicy WU2
    WHERE U.id_uczestnika = WU2.id_uczestnika
    GROUP BY WU2.id_uczestnika))as powroty
FROM Wycieczki_Uczestnicy
    JOIN team20.Uczestnicy U on U.id_uczestnika = Wycieczki_Uczestnicy.id_uczestnika
    JOIN team20.Wycieczki W on W.id_wycieczki = Wycieczki_Uczestnicy.id_wycieczki
    JOIN team20.Kierunki K on K.id_kierunku = W.id_kierunku
    JOIN team20.Tematyki T2 on T2.id_tematyki = W.id_tematyki
GROUP BY
    K.kraj, T2.nazwa
ORDER BY powroty DESC;
"""
    user, password, host, database = params.values()
    with mysql.connect(
        user=user, password=password, host=host, database=database
    ) as conn:
        data = pd.read_sql(query, conn)
    return data


def get_profit_data(**params):
    query = """SELECT
    K.kraj,
    T2.nazwa as tematyka,
    (T.kwota - (T2.koszt * DATEDIFF(W.data_zakonczenia, W.data_rozpoczecia) + K.koszt)
        * W.ilosc_uczestnikow)
        /W.ilosc_uczestnikow
        /DATEDIFF(W.data_zakonczenia, W.data_rozpoczecia) AS profit_na_os_na_dzien
FROM Wycieczki W
    JOIN Tematyki T2 ON W.id_tematyki = T2.id_tematyki
    JOIN Kierunki K ON W.id_kierunku = K.id_kierunku
    JOIN Transakcje T ON W.id_wycieczki = T.id_wycieczki
WHERE T2.nazwa = 'Parkur po cudzych balkonach'
AND K.kraj = 'Polska';
"""
    user, password, host, database = params.values()
    with mysql.connect(
        user=user, password=password, host=host, database=database
    ) as conn:
        data = pd.read_sql(query, conn)
    return data


def get_rating_data(**params):
    query = """
SELECT
    ocena
FROM Wycieczki_Uczestnicy
"""
    user, password, host, database = params.values()
    with mysql.connect(
        user=user, password=password, host=host, database=database
    ) as conn:
        data = pd.read_sql(query, conn)
    return data
