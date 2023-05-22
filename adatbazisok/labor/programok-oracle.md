---
layout: page
title: Oracle kliensprogramok
---

Oracle kliensprogramok

-   A labor során preferált kliens: [Oracle SQL Developer 20.4.1
    Win64-hez beépített JDK 8
    Java környezettel](https://db.bme.hu/r/sqldeveloper/sqldeveloper-20.4.1.407.0006-x64.zip),
    és - várhatóan a 2. labortól kezdődően - [SQLcl 21.1.1, Java környezet
    nélkül](https://db.bme.hu/r/sqldeveloper/sqlcl-21.1.1.113.1704.zip),
    használatához elég a JRE.
    -   SQL Developer futtatása: ha a teljes kicsomagolás után létrejövő
        sqldeveloper\\sqldeveloper.exe-vel nem indul, akkor futtassuk a
        sqldeveloper\\sqldeveloper\\bin\\sqldeveloper.bat fájlt.
    -   Amennyiben "The program can’t start because MSVCR71.dll is
        missing from your computer. Try reinstalling the program to fix
        this" hibaüzenettel nem indul az SQL Developer, az
        sqldeveloper\\jdk\\jre\\bin\\ könyvtárból másoljuk a MSVCR71.dll
        fájlt a 32 bites windows esetén a system32 mappába (Win 7/8: a
        rendszermeghajtó gyökerében, WinXP: a windows könyvtárban
        található), a 64 bites Windows esetén pedig a rendszermeghajtó
        gyökerében levő SysWOW64 mappába.
    -   További platformokra letölthető az OTN [SQL Developer
        oldaláról](http://www.oracle.com/technetwork/developer-tools/sql-developer/overview/index.html) indulva.
        Figyelem! Az Oracle oldalán 2021. augusztus 11. óta az SQL Developer
        21.2.1 stabil változata érhető el, a labor során azonban a 20.4.1
        verziót használjuk. A verziók közti különbségekből adódó
        jelentős probléma eddig nem ismert, de mindenkit a 20.4.1 verzió
        használatára kérünk. A verziókülönbségekből adódó esetleges
        problémákban nem feltétlenül tudunk segíteni.
    -   SQLcl használata: útmutató az azt használó mérés előtt
        jelenik meg.
-   [Oracle SQL Developer 20.4.1 kliens Java
    környezet nélkül.](https://db.bme.hu/r/sqldeveloper/sqldeveloper-20.4.1.407.0006-no-jre.zip)
    Ezt a Win64-től különböző platformokon tudod használni, ha mögé
    teszel megfelelő Java 8 JDK környezetet.

A kliensprogramok használata
----------------------------

SQL Developer, Basic típusú kapcsolat paraméterek

-   Hostname: rapid.eik.bme.hu
-   Port: 1521
-   SID: szglab


SQLcl használata

- a program indítása: `sqlcl /nolog`
- kapcsolódás az adatbázis szerverhez: `CONNECT felhasznalonev@//rapid.eik.bme.hu:1521/szglab`
- szkript futtatása fájlból: `START initszkript-helye/neve.sql`
- kimenet fájlba mentése:
  - a mentés megkezdése: `SPOOL fajlnev.txt`
  - a mentés befejezése: `SPOOL OFF`


Amire a telepítésnél érdemes figyelni
-------------------------------------

SQL Developer

-   A .zip fájlt alkönyvtárakkal együtt kell kicsomagolni,
    és (Windows-on) az sqldeveloper könyvtárban levő sqldeveloper.exe
    programot kell indítani
-   20.4.1-es: 8-as Java SE JDK (minimum 1.8 update 171) környezet szükséges
    a használatához.

Instant kliens 11gR2 telepítése és használata SQL Developerből

-   Erre alapesetben nincs szükség. Akkor kell letölteni, ha az SQL
    Developerből olyan funkciót használnál, amit önmagában nem támogat.
    **A méréseken ezt igénylő feladat nem lesz.**
-   Csomagold ki a .zip fájlt egy mappába (pl. instantclient).
-   Tedd elérhetővé a dinamikus linker számára az instantclient
    mappát (pl. írd be Windowson a `PATH` környezeti változóba, UNIX/Linux
    rendszereken az `LD_LIBRARY_PATH` környezeti változóba)
-   Ezután indítsd az SQL Developert
-   A Tools/Preferences menüben a Database/Advanced alatt jelöld be,
    hogy "Use Oracle Client", majd a következő sorban Configure, és meg
    kell adni a kliens típusát illetve a könyvtárat, ahol található. OK,
    majd az SQL Developer újraindítása következik (erre figyelmeztet is
    a rendszer).
-   A lejárt és le nem járt jelszavak megváltoztatását egyaránt (jobb
    klikk a definiált kapcsolatra, majd Reset Password) egyből támogatni
    fogja az SQL Developer a kapcsolat bezárt állapota mellett.
-   Ahhoz, hogy a kapcsolat során is az instant klienst használjuk, az
    SQL Developerben a Tools/Preferences menüben a Database/Advanced
    jelöld be a Use OCI/Thick driver pontot.
