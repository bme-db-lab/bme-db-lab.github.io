---
layout: page
title: Hallgatói útmutató a Relációs lekérdezések optimalizálása c. méréshez
---

A mérés célja
=============

A mérés célja betekintést nyerni a relációs lekérdezések optimalizálásának gyakorlati aspektusaiba.
A megoldandó feladatok központjában végrehajtási tervek elemzése fog állni.

Ebben a laborban találkozik egymással

 - számos, a relációs adatmodellhez kapcsolódó definíció,
 - a fizikai adatszervezésnél megismert adatszerkezetek,
 - az optimalizálás előadásokon és gyakorlaton előkerült algoritmusok, valamint
 - a relációs lekérdezések írásával kapcsolatos ismeretek.

A labor sikeres teljesítéséhez mindezeket ismerni és érteni kell.

## Elmélet vs. gyakorlat

Az elméleti ismeretek megszerzése során bizonyos feltételezésekkel éltünk annak érdekében, hogy a lényeg világosabban látsszon.
Egy valódi adatbáziskezelőben néhány dolog ennél komplexebb képet mutat. Ehhez kapcsolódóan néhány gondolat:

 - a lekérdezési terveken látható dolgokat mindig vessék össze az előadáson tanultakkal
 - az előadáshoz képest fontos különbség az Oracle Database költségfüggvénye, mely az alábbiakat tartalmazó mennyiség:
   ([dokumentáció](https://docs.oracle.com/en/database/oracle/oracle-database/19/tgsql/query-optimizer-concepts.html#GUID-9D0BF31B-7215-4BD8-B45D-A8BF2B4DB7E5))
    - erőforrásfelhasználás (becsült I/O, CPU és memória-felhasználás)
    - a (rész)eredmény becsült rekordszáma
    - input adatok mennyisége
    - input adatok eloszlása
    - használt segédstruktúrák
  - az Oracle Database adott lekérdezés lépéseihez a konkrét környezetben rendel egy relatív mennyiséget, amelyekből végül felépíti a teljes lekérdezés költségét.
    Ily módon egy adatbázison belül hasonlíthatók össze a különböző végrehajtási tervek.
    ([dokumentáció](https://docs.oracle.com/database/121/TGSQL/tgsql_optcncpt.htm#TGSQL195))
  - a végrehajtási tervek egyes lépéseinél a *Cost* oszlopban a lekérdezés becsült költsége, míg a *Cardinality* oszlopban a becsült rekordszám szerepel

Környezet az adatbázisban
=========================

Ezen a mérésen az adatokat előre elhelyeztük az adatbázisban.
Mindenki a feladatlapja fejlécében megtalálja annak a két sémának a nevét, ahol a feladatok megoldásához szükséges táblák és indexek találhatók.
A két sémában a táblák szerkezete megegyezik az SQL-2,3 méréseken megismert szerkezettel, de azok nagy mennyiségű, generált adatot tartalmaznak.

 - Az első, ún. *noindex sémában* csak a táblák üzleti és mesterséges kulcsaihoz tartozik index.
 - A második, ún. *indexelt sémában* további indexek kerültek felvételre.

Megjegyzés: a generált adatok szemantikája a megoldandó feladatoknak megfelel, de mélyebb összefüggéseket nem érdemes vizsgálni benne.

Az Oracle Database 12cR1 verzió újdonságaként jelent meg az adaptív végrehajtási tervek készítése, amelyet a későbbi kiadások tovább finomítottak.
Ennek lényege, hogy a statisztikák alapján kiválasztott illesztési algoritmust bizonyos feltételek mellett futásidőben megváltoztathatja a DBMS,
ha a végrehajtás során, a valódi adatok egy részét feldolgozva úgy találja: jobbat is választhat.  
**Figyelem!** Ez a lehetőség túlmutat a labor keretein, ezért az adatbázishoz csatlakozás után minden alkalommal kapcsolja ki a következő SQL utasítással:
```sql
alter session set optimizer_adaptive_plans=false;
```

Beadandó anyagok
================

Beadandó a labordokumentáció egyetlen PDF fájl formájában, melynek elnevezése:
`NEPTUN-5-CSOPKOD.pdf`

Kérjük figyelmesen elolvasni a [dokumentálási tudnivalók]at! Külön kiemeljük, hogy:

 - a beadott forráskódrészletek szöveges tartalomként, igényes tördelés és formázás mellett jelenjenek meg. Opcionálisan szintaxiskiemelés is alkalmazható.
 - a képernyőképek megfelelően legyenek körbevágva annak érdekében, hogy csak a lényeg látszódjon rajta, de az jól látható legyen.

Értékelési szempontok
---------------------

 - Az egyes részfeladatokhoz tartozó kódrészletek, képernyőképek és magyarázatok legyenek jól azonosíthatóak.
 - A szintaktikai hibát tartalmazó forráskód és a vonatkozó részfeladat nem értékelhető.
 - A lekérdezéseiben használt táblaneveket lássa el sémakvalifikációval!
 - A végrehajtási lépéseknél a használt algoritmus dokumentálásához hozzátartozik az esetleg felhasznált segédstruktúra is.
 - A formai követelményeket sértő labordokumentáció nem értékelhető.

Tippek az SQL Developer használatához
=====================================

 - Egy SQL Worksheet ablakban az SQL lekérdezéseket válasszuk el pontosvesszővel egymástól.  
   Ha így teszünk, akkor nem kell kijelölni a végrehajtandó lekérdezést. Elég a lekérdezés törzsébe pozicionálni a kurzort, majd:
    - `F10` megmutatja a végrehajtási tervet
    - `F9` vagy `Ctrl+Enter` végrehajtja a lekérdezést
 - A végrehajtási terveket mutató ablakrész az első ikonnal odaszögelhető, így a következő terv új fülön jelenik meg.
 - Ha egynél több végrehajtási terv látszik, akkor a fülre jobb klikk, és a megjelenő menüből hívható a *Compare with...* funkció tervek összehasonlítására.
 - A feladatok megoldása során használt sémákat szűrő segítségével könnyen kiemelheti a több száz tételes listából.  
   Ehhez kattintson a *Connections* fülön megjelenő, az adatbázist objektumait reprezentáló fa-gráfban az *Other users* csomópontra, majd a fül tetején levő *Filter* (tölcsér) ikonra, és állítsa be a következőket:
    - Criteria: Match any
    - *Schema = `<egyik séma neve>`*
    - a zöld plusszal egy újabb feltételsor hozzáadása, abban:
    - *Schema = `<másik séma neve>`*

[dokumentálási tudnivalók]: https://www.db.bme.hu/jegyzokonyv/tudnivalok/
