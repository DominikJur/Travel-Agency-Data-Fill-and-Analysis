# Dokumentacja projektu na bazy danych
Albert Janik, Dominik Jur, Szymon Klim, Kacper Samulski

## 1. Spis uzytych technologii
W trakcie projektu wykorzystane zostały następujące technologie:
- Baza danych MariaDB,
- DataGrip - Zarządzanie bazą danych i wygenerowanie grafu wizualizującego relacje między tabelami,
- Język programowania Python, przy czym uzyto następujących bibliotek;
    - Pandas - przetwarzanie danych tabelarycznych na potrzeby analizy danych,
    - Faker - generowanie danych do tabel,
    - MySQL Connector - Integracja bazy danych z python,
    - Numpy - Operacje numeryczne,
    - Matplotlib oraz Seaborn - wizualizacja danych, wykresy,
    - Biblioteki standardowe (os, sys, random, re, calendar, datetime,warnings, contextlib),
- Jupyter Notebook - środowisko do tworzenia i prezentacji notatek zawierających kod, tekst, wykresy, równania i inne elementy.

## 2.  Lista plików z opisem zawartości
 - analysis.ipynb - notebook jupyter zawierający kod potrzebny do wygenerowania raportu
 - fill_db.ipynb - notebook ze skryptem słuącym do generacji i uzupełnienia tabel

Powyzsze pliki znajdują się odpowiednio w folderach "analysis" i "fill".

 - Folder "schema":
    - schema.graphml - 
    - schema.png - plik przedstawiający wizualizację relacji między tabelami
 - Folder "src":
    - utils.py - plik zawierający funkcje do wysyłania zapytań na bazę danych i otrzymywanaia wyników w postaci pandas.DataFrame
 - plik ".env" - do stworzenia przez uzytkownika, powinien zawierać dane niezbędne do połączenia z bazą danych
 - req.txt - plik potrzebny do instalacji niezbędnych bibliotek do python przy uyciu komendy "pip install -r req.txt"

## 3. Kolejność i sposób otwierania plików 
Uruchomić notebook fill_db.ipynb w wybranym edytorze obsługującym notatniki jupyter, następnie analysis.ipynb utuchomić w ten sam sposób.

## 4. Schemat projektu bazy danych 

(Diagram przedstawiający schemat bazy danych w formacie .png znajduje się w folderze schema)

Tabele w bazie:
-  Kierunki
    -  id_kierunku
    -  miasto
    -  koszt
    -  kraj
-  Pracownicy
    -  id_pracownika
    -  imie
    -  nazwisko
    -  stanowisko
    -  wynagrodzenie
    -  data_zatrudnienia
    -  telefon
    -  email
-  Tematyki
    -  id_tematyki
    -  nazwa
    -  opis
    -  koszt
-  Transakcje
    -  id_transakcji
    -  id_pracownika
    -  id_uczestnika 
    -  id_wycieczki
    -  data_transakcji
    -  kwota
    -  sposob_platnosci 
-  Uczestnicy
    -  id_uczestnika
    -  imie
    -  nazwisko
    -  telefon
    -  email
    -  adres
    -  telefon_rodziny
    -  email_rodziny 
    -  relacja_z_rodzina
    -  plec
-  Wycieczki
    -  id_wycieczki 
    -  id_tematyki
    -  id_kierunku
    -  id_pracownika
    -  data_rozpoczecia
    -  data_zakonczenia
    -  koszt_organizacji
    -  zarobek
    -  ilosc_uczestnikow 
-  Wycieczki_Uczestnicy 
    -  id_wycieczki
    -  id_uczestnika
    -  kupujacy
    -  ocena
    -  opinia 

## 5. Uzasadnienie, ze baza spełnia EKNF
Przyjrzyjmy się po kolei postaciom głównym:
  -  1NF:
      -  Wszystkie kolumny w każdej tabeli przechowują wartości atomowe (tj. nierozkładalne na mniejsze części). - na przykładzie tabeli "Pracownicy" kolumna "data_zatrudnienia" nie jest podzielona na miesiąc zatrudnienia i rok
      -  Każdy rekord jest jednoznacznie identyfikowany przez klucz główny. - kademu ID pracownika przypisany jest jeden numer telefonu, nie ma list
      -  Nie ma powtarzających się grup danych. - nie ma dla przykładu kolumny informcującej jaką ktoś ma domenę w adresie e-mail, poniewaz juz jest kolumna dostarczajaca tej informacji

  -  2NF - Wszystkie kolumny niekluczowe są w pełni zależne od klucza głównego, czyli nie występują częściowe zależności od klucza w tabelach złożonymi kluczami. - na przykładzie tabeli "Wycieczki_Uczestnicy":
    Kolumny kupujacy, ocena, opinia są w pełni zależne od całego klucza, a nie od jego części.
    Brak częściowych zależności, np. ocena zależy od konkretnego uczestnika i konkretnej wycieczki.

  -  3NF - Żadne atrybuty niekluczowe nie zależą przechodnio od klucza głównego (tzn. każdy atrybut zależy tylko bezpośrednio od klucza głównego, a nie od innych atrybutów niekluczowych). - na przykładzie tabeli "Pracownicy": klucz główny id_pracownika jednoznacznie określa każdy inny atrybut.
Żaden atrybut niekluczowy (np. telefon) nie zależy przechodnio od innego atrybutu niekluczowego (np. email).
Wartości takie jak wynagrodzenie nie zależą od stanowiska, tylko od identyfikatora pracownika.

Zaleznosci funkcyjne w tabelach:
1. Tabela: Kierunki

    Klucz główny: id_kierunku
    Zależności funkcyjne:
    
    id_kierunku->(miasto,koszt,kraj) 
    
    Każdy id_kierunku jednoznacznie określa miasto, koszt i kraj.

2. Tabela: Pracownicy

    Klucz główny: id_pracownika
    Zależności funkcyjne:

    id_pracownika->(imie,nazwisko,stanowisko,wynagrodzenie,data_zatrudnienia,telefon,email) 
    
    Każdy id_pracownika jednoznacznie identyfikuje dane pracownika.

3. Tabela: Tematyki

    Klucz główny: id_tematyki
    Zależności funkcyjne:

    id_tematyki->(nazwa,opis,koszt) 
    
    Każda tematyka ma unikalny identyfikator determinujący pozostałe atrybuty.

4. Tabela: Transakcje

    Klucz główny: id_transakcji
    Zależności funkcyjne:

    id_transakcji->(id_pracownika,id_uczestnika,id_wycieczki,data_transakcji,kwota,sposob_platnosci) 
    
    Każda transakcja jest jednoznacznie określona przez id_transakcji, pozostałe atrybuty od niej zależą.

5. Tabela: Uczestnicy

    Klucz główny: id_uczestnika
    Zależności funkcyjne:

    id_uczestnika->(imie,nazwisko,telefon,email,adres,telefon_rodziny,email_rodziny,relacja_z_rodzina,plec) 
    
    Identyfikator uczestnika określa wszystkie dane kontaktowe.

6. Tabela: Wycieczki

    Klucz główny: id_wycieczki
    Zależności funkcyjne:

    id_wycieczki->(id_tematyki,id_kierunku,id_pracownika,data_rozpoczecia,data_zakonczenia,koszt_organizacji,zarobek,ilosc_uczestnikow) 
    
    Identyfikator wycieczki jednoznacznie określa wszystkie jej cechy.

7. Tabela: Wycieczki_Uczestnicy

    Klucz główny: (id_wycieczki, id_uczestnika)
    Zależności funkcyjne:

    (id_wycieczki,id_uczestnika)->(kupujacy,ocena,opinia) 
    
    Każda para wycieczka-uczestnik determinuje dodatkowe informacje o zakupie.

## 6. Co było najtrudniejsze podczas realizacji projektu

Przede wszystkim wygenerowanie realistycznych danych dla projektu, sam ten problem pochłonął ze wszystkich najwięcej czasu i wygenerował sporo dyskusji grupowych.

## 7. Sposób użytkowania projektu
Po zainstalowaniu wszystkich niezbędnych bibliotek, zawartych w pliku `req.txt`, należy uruchomić notebook `fill_db.ipynb`, który wygeneruje i uzupełni bazę danych. Następnie uruchomić notebook `analysis_and_raport.ipynb`, który zawiera kod potrzebny do wygenerowania raportu. W razie potrzeby wygenerowania nowego raportu, należy wpisać w terminalu komendę ` jupyter nbconvert --to html analysis_and_raport.ipynb` , która wygeneruje raport w formacie html.