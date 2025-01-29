create table Kierunki
(
    id_kierunku int auto_increment
        primary key,
    miasto      varchar(100)                not null,
    koszt       decimal(10, 2)              not null,
    kraj        varchar(25) charset utf8mb3 null
);

create table Pracownicy
(
    id_pracownika     int auto_increment
        primary key,
    imie              varchar(50)    not null,
    nazwisko          varchar(50)    not null,
    stanowisko        varchar(50)    null,
    wynagrodzenie     decimal(10, 2) not null,
    data_zatrudnienia date           not null,
    telefon           varchar(15)    null,
    email             varchar(100)   null
);

create table Tematyki
(
    id_tematyki int auto_increment
        primary key,
    nazwa       varchar(100)   not null,
    opis        text           null,
    koszt       decimal(10, 2) not null
);

create table Uczestnicy
(
    id_uczestnika     int auto_increment
        primary key,
    imie              varchar(100)               not null,
    nazwisko          varchar(100)               not null,
    telefon           varchar(15)                null,
    email             varchar(100)               null,
    adres             text                       null,
    telefon_rodziny   varchar(15)                null,
    email_rodziny     varchar(100)               null,
    relacja_z_rodzina varchar(50)                null,
    plec              varchar(1) charset utf8mb3 null
);

create table Wycieczki
(
    id_wycieczki      int auto_increment
        primary key,
    id_tematyki       int            null,
    id_kierunku       int            null,
    id_pracownika     int            null,
    data_rozpoczecia  date           null,
    data_zakonczenia  date           null,
    koszt_organizacji decimal(10, 2) null,
    ilosc_uczestnikow int            null,
    constraint Wycieczki_ibfk_1
        foreign key (id_tematyki) references Tematyki (id_tematyki),
    constraint Wycieczki_ibfk_2
        foreign key (id_kierunku) references Kierunki (id_kierunku),
    constraint Wycieczki_ibfk_3
        foreign key (id_pracownika) references Pracownicy (id_pracownika)
);

create table Transakcje
(
    id_transakcji    int auto_increment
        primary key,
    id_pracownika    int            null,
    id_uczestnika    int            null,
    id_wycieczki     int            null,
    data_transakcji  date           null,
    kwota            decimal(10, 2) null,
    sposob_platnosci varchar(50)    null,
    constraint Transakcje_ibfk_1
        foreign key (id_pracownika) references Pracownicy (id_pracownika),
    constraint Transakcje_ibfk_2
        foreign key (id_uczestnika) references Uczestnicy (id_uczestnika),
    constraint Transakcje_ibfk_3
        foreign key (id_wycieczki) references Wycieczki (id_wycieczki)
);

create index id_pracownika
    on Transakcje (id_pracownika);

create index id_wycieczki
    on Transakcje (id_wycieczki);

create index id_kierunku
    on Wycieczki (id_kierunku);

create index id_pracownika
    on Wycieczki (id_pracownika);

create index id_tematyki
    on Wycieczki (id_tematyki);

create table Wycieczki_Uczestnicy
(
    id_wycieczki  int                          not null,
    id_uczestnika int                          not null,
    kupujacy      tinyint                      null,
    ocena         int                          null,
    opinia        varchar(500) charset utf8mb3 null,
    primary key (id_wycieczki, id_uczestnika),
    constraint Wycieczki_Uczestnicy_ibfk_1
        foreign key (id_wycieczki) references Wycieczki (id_wycieczki),
    constraint Wycieczki_Uczestnicy_ibfk_2
        foreign key (id_uczestnika) references Uczestnicy (id_uczestnika)
);

create index id_klienta
    on Wycieczki_Uczestnicy (id_uczestnika);


