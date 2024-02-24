---
layout: page
title: SQL laborok
---


Az SQL laborok anyagát tartalmazó [segédlet ebben található](../files/hallgatoi-segedlet-teljes2022.pdf), ld. II. labor: Az SQL nyelv, 22-34. oldal. Ebből, valamint az előadáson a relációs lekérdező nyelvekről (rel. algbra, kalkulusok) elhangzottakból felkészülten kell érkezni a laborra, mert ezt ellenőrizzük, valamint a kapcsolódó ismereteket a laboron már alkalmazni kell.

Az egyes SQL laborokra(1-2-3) vonatkozóan ez azt jelenti, hogy:
 - SQL sémadefiníció:
    - segédlet:
       - 22-34. oldal 4. fejezete (Táblák létrehozása, törlése)
       - II. Függelék: Adatbázis kényszerek az Oracle-ben, benne teljes SQL DDL példával
    - Adatbázisok jegyzet 68-70. oldal
    - Adatbázisok jegyzet 1., 2., 4., 5.1 és 9.1 fejezetek
 - SQL lekérdezések:
    - segédlet 22-34. oldal 6. fejezete (Lekérdezések)
    - Adatbázisok jegyzet 1., 2., 4., 5.1, 5.2 és 5.3 fejezetek
 - SQL adatmódosítás:
    - segédlet 22-34. oldal egésze
    - Adatbázisok jegyzet 1., 2., 4., 5.1, 5.2 és 5.3 fejezetek

Jó munkát mindenkinek!

## 2. labor: SQL sémadefiníció


A beadandó anyag formátumáról, követelményeiről és az SQL-hez kapcsolódó tippekhez olvasd el a [hallgatói útmutatót](hallgatoi-utmutato) és a [dokumentálási tudnivalókat](/jegyzokonyv/tudnivalok), ahol a sablon is megtalálható!

A beadandó szkript [váza elérhető][sql-szkeleton].



## 3. labor: SQL lekérdezések

A laboron 15+1 pont érhető el, a ponthatárok a következők:

- 2: 6&lt;=
- 3: 9&lt;=
- 4: 11&lt;=
- 5: 13&lt;=

Beadandó 2 fájl:
- egy pdf formátumú labordokumentáció a [dokumentálási tudnivalók](/jegyzokonyv/tudnivalok) oldalon olvasható tudnivalók és sablon szerint, és
- egy SQL szkript, amely a feladatok megoldását tartalmazza.

A beadandó anyag formátumáról, követelményeiről és az SQL-hez kapcsolódó tippekhez olvasd el a [hallgatói útmutatót](hallgatoi-utmutato)!

A beadandó SQL szkript [váza elérhető][sql-szkeleton].
A [beadandó SQL szkript generátor][sql123-beadando-generator] segít, ha valaki nem kézzel rakná össze.


## 4. labor: SQL adatmódosítás

Beadandó 2 fájl:
- egy pdf formátumú labordokumentáció a [dokumentálási tudnivalók](/jegyzokonyv/tudnivalok) oldalon olvasható tudnivalók és sablon szerint, és
- egy SQL szkript, amely a feladatok megoldását tartalmazza.

A beadandó anyag formátumáról, követelményeiről és az SQL-hez kapcsolódó tippekhez továbbra is hasznos olvasmány a [hallgatói útmutatót](hallgatoi-utmutato).

A beadandó SQL szkript [váza elérhető][sql-szkeleton].
A [beadandó SQL szkript generátor][sql123-beadando-generator] segít, ha valaki nem kézzel rakná össze.

[sql123-beadando-generator]: https://db.bme.hu/r/sql/sql123-beadando-generator.html
[sql-szkeleton]: https://db.bme.hu/r/sql/SZKELETON

## Gyakorlófeladatok

Annak érdekében, hogy az elmélet (segédlet) tudása mellett némi gyakorlati tapasztalattal is felvértezve érkezhessetek a laborba, készítettünk egy szkriptet és néhány gyakorlófeladatot, amelyekkel próbálgathatjátok a szárnyaitokat, már a labor előtt, illetve az ínyencek nyugodtan találjanak ki minél kacifántosabb lekérdeznivalókat :)

Használati utasítás: Az [itt](https://www.db.bme.hu/databases/exercises.sql) elérhető szkriptet futtassátok developerben. Ez létrehoz két táblát és feltölti mindenféle adatokkal. Utána pedig kérdezzétek le ezeket:

- Összes ember neve
- Emberek és hozzájuk tartozó autók
- Autótlan emberek
- Autómárkák és a márka tulajdonosainak száma
- Egyes emberek autóinak száma, autószám szerinti csökkenő sorrendben
- Egyes emberek autóinak száma (minden embert tartalmazó lista), autószám szerinti növekvő sorrendben

Hozz létre egy táblát, ami azt tárolja, hogy melyik ember, mikor, melyik autót vezette (nemcsak a sajátját lehet)!

Végy fel példaadatokat az utóbbi táblába. Próbálj beilleszteni nemlétező emberhez vagy autóhoz tartozó rekordot! Hibaüzenetet kapsz? Ha nem, hozd létre a táblához a constrainteket is, amelyeket eddig nem hoztál létre.

Hajrá!
