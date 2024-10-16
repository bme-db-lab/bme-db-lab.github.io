---
layout: page
title: Oracle, mint rendszer labor
---

Ismerkedés egy relációs adatbáziskezelő-rendszerrel

Az 1. labor anyaga [ebben található](../files/hallgatoi-segedlet-teljes2022.pdf), ld. I. Labor: az Oracle adatbázis-kezelő

Beadandó a laborfeladatok elvégzéséről készített dokumentáció egyetlen PDF fájl formájában, melynek elkészítése a [dokumentálási tudnivalók](/jegyzokonyv/tudnivalok) alapján, az ott található sablonnal történjen!

A beadandó fájl elnevezése az alábbi:

```
NEPTUN-1-CSOPKOD.pdf
```

A `CSOPKOD` szerkezete:

-   a mérés napjának egykarakteres kódja
-   a kezdés órája egy (pl. 8) vagy két számjegyen (pl. 10 vagy 17)
-   a csoport egyszámjegyű azonosítója időponton belül.
-   az iMSc csoportot jelölő *i* karakter
-   pl. S83 (szerda 8 órai 3-as csoport), C172 (csütörtök 17 órai 2-es csoport), H144i (hétfő 14 órai 4i jelű csoport, ahol *i=iMSc*)
-   A csoportkód a közzétett csoportbeosztásban megtalálható. Az ott megtalálható csoportazonosítóból elhagyandó a kötőjel, de ez a fájlnevek többi részét nem érinti.

## A mérési feladatokhoz kapcsolódóan futtatandó SQL kód

Az alábbiakban azt az SQL kódrészletet tesszük közzé, amit az 5. feladat megoldása után futtatni kell majd. A közzététel célja a hibamentes kódbeírás, de felhívjuk a figyelmet a kód által demonstrált dolgok észrevételezésére: az adatszótár.

```sql
-------------------------------------------------
-- BME VITMAB04 Adatbázisok. 1. mérés, 2019.
-------------------------------------------------
-- 5. feladathoz futtatandó SQL kód
-------------------------------------------------
column grantor format a8;
column grantee format a8;
column table_name format a20;
column privilege format a20;
select grantor
     , grantee
     , table_name
     , privilege
     , initcap(grantable) grant_opt
  from all_tab_privs
 where grantor = user
    or grantee = user
 order by grantor, grantee, table_name, privilege
;
```
