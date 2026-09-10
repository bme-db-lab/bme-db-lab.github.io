---
layout: page
title: Oracle, mint rendszer labor
---

{% include adatbazisok-labor_kifuto_targy_figyelmeztetes.md %}

 Az 1. labor [felkészülési anyaga](oracle2017.pdf).

 - [Jegyzőkönyv írási tudnivalók és sablonok](/jegyzokonyv/tudnivalok/)


## Beadandó anyagok


Az elvárt formátum kötött. A beadott tömörített állományban az alábbi könyvtárstruktúrát várjuk el:

```
NEPTUN-1-CSOPKOD.zip:
  NEPTUN-1-CSOPKOD/
    NEPTUN-1-CSOPKOD.pdf, elsősorban szöveges tartalommal
```

A `CSOPKOD` szerkezete:

 - a mérés napjának egykarakteres kódja
 - a kezdés órája egy (pl. 8) vagy két számjegyen (pl. 10 vagy 17)
 - az iMSc csoportot jelölő *i* karakter
 - a csoport egyszámjegyű azonosítója időponton belül.

Például `S83` (szerda 8 órai 3-as csoport), `C172` (csütörtök 17 órai 2-es csoport), `H14i4` (hétfő 14 órai i4-es csoport, ahol *i=iMSc*).

A csoportkód a hallgatói csoportbeosztásban megtalálható. Az ott megtalálható csoportazonosítóból elhagyandó a kötőjel, de ez a fájl- és könyvtárnevek többi részét nem érinti.

## A mérési feladatokhoz kapcsolódóan futtatandó SQL kódok

Az alábbiakban azokat az SQL kódrészleteket tesszük közzé, amiket egyes feladatok megoldása során futtatni kell majd. A közzététel célja a hibamentes kódbeírás, de felhívjuk a figyelmet a kódok megértésének fontosságára!

```sql
-------------------------------------------------
-- BME VITMAB02 Adatbázisok labor 1. mérés, 2018.
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

-------------------------------------------------
-- 7. feladathoz tartozó, elemzendő SQL kód.
-------------------------------------------------
alter session set optimizer_adaptive_features=false;

select sz.igazolvany_szam, sz.nev, c.cim_tipus, c.iranyitoszam, c.varos
  from oktatas.szemely sz, oktatas.cim c
 where sz.igazolvany_szam = c.igazolvany_szam(+)
   and c.cim_tipus(+) = 1
   and sz.szuletesi_varos = c.varos(+)
   and substr(sz.igazolvany_szam,1,1) = '1'
;
select sz.igazolvany_szam, sz.nev, c.cim_tipus, c.iranyitoszam, c.varos
  from oktatas.szemely sz, oktatas.cim c
 where sz.igazolvany_szam = c.igazolvany_szam(+)
   and c.cim_tipus(+) = 1
   and sz.szuletesi_varos = c.varos(+)
   and sz.igazolvany_szam like '1%'
;
```
