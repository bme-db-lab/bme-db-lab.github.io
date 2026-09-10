---
layout: page
title: Oracle kliensprogramok
---

Oracle kliensprogramok

-   A labor során használt kliens: [Oracle SQL Developer 24.3.1
    Win64-hez beépített JDK 17
    Java környezettel](https://www.oracle.com/database/sqldeveloper/technologies/download/),
    és - várhatóan a 2. labortól kezdődően - SQLcl.
    -   Az SQLcl használható az SQL Developer csomagból a sqldeveloper\\bin\\sql futtatásával, ilyenkor az SQL Developerherel azonos verziót kapjuk. A laborfoglalkozásokon ezt használjuk! Önálló használatra letölthető [önálló SQLcl csomag](https://www.oracle.com/database/sqldeveloper/technologies/sqlcl/download/) Java környezet nélkül, használatához elég a JRE.
    -   SQL Developer futtatása: ha a teljes kicsomagolás után létrejövő
        sqldeveloper\\sqldeveloper.exe-vel nem indul, akkor futtassuk a
        sqldeveloper\\sqldeveloper\\bin\\sqldeveloper.bat fájlt.
    -   További platformokra is letölthető az OTN [SQL Developer
        oldaláról](https://www.oracle.com/database/sqldeveloper/technologies/download/) indulva.
    -   Figyelem! Előfordulhat, hogy az Oracle oldalán már frissebb verzió érhető el, mint a laborban használt verziószámok.
        A "Previous version" vagy "Previous release" linkeket követve elérhető a nálunk használt verzió is.
        A verziók közti különbségekből adódó jelentős probléma általában nem merül fel, de mindenkit a fent közölt verzió használatára kérünk!
        A verziókülönbségekből adódó esetleges problémákban nem feltétlenül tudunk segíteni.

A kliensprogramok használata
----------------------------

SQL Developer, Basic típusú kapcsolat paraméterek

-   Hostname: rapid.eik.bme.hu
-   Port: 1521
-   SID: szglab


SQLcl használata

- a program indítása: `sqlcl /nolog` vagy `sql /nolog`
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
-   24.3.1-es: 17-es Java SE JDK környezet szükséges a használatához.
-   Amennyiben "The program can’t start because MSVCR71.dll is
    missing from your computer. Try reinstalling the program to fix
    this" hibaüzenettel nem indul az SQL Developer, az
    sqldeveloper\\jdk\\jre\\bin\\ könyvtárból másoljuk a MSVCR71.dll
    fájlt a 32 bites windows esetén a system32 mappába (Win 7/8: a
    rendszermeghajtó gyökerében, WinXP: a windows könyvtárban
    található), a 64 bites Windows esetén pedig a rendszermeghajtó
    gyökerében levő SysWOW64 mappába.


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
