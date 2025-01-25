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

