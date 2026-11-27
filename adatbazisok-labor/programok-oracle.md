---
layout: page
title: Oracle kliensprogramok
---

Oracle kliensprogramok

-   A labor során preferált kliens: [Oracle SQL Developer 4.2.0
    Win64-hez beépített JDK 8
    Java környezettel](https://db.bme.hu/r/sqldeveloper/sqldeveloper-4.2.0.17.089.1709-x64.zip),
    és - várhatóan a 2. méréstől kezdődően - [SQLcl 4.2, Java környezet
    nélkül](https://db.bme.hu/r/sqldeveloper/sqlcl-4.2.0.17.097.0719-no-jre.zip),
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
        Figyelem! Az Oracle oldalán 2018. ápr. 5. óta az SQL Developer
        18.1 stabil változata érhető el, a labor során azonban a 4.2
        verziót használjuk. A verziók közti különbségekből adódó
        jelentős probléma eddig nem ismert, de mindenkit a 4.2 verzió
        használatára kérünk. A verziókülönbségekből adódó esetleges
        problémákban nem feltétlenül tudunk segíteni.
    -   SQLcl használata: útmutató az azt használó mérés előtt
        jelenik meg.
-   [Oracle SQL Developer 4.2.0 kliens Java
    környezet nélkül.](https://db.bme.hu/r/sqldeveloper/sqldeveloper-4.2.0.17.089.1709-no-jre.zip)
    Ezt a Win64-től különböző platformokon tudod használni, ha mögé
    teszel megfelelő Java 8 JDK környezetet.
-   Az Oracle 12cR1 "hagyományos" klienst letöltheted az [OTN Oracle
    Database letöltési
    oldaláról](http://www.oracle.com/technetwork/database/enterprise-edition/downloads/index.html).
    A kiválasztott verzió és operációs rendszer mellett levő See All
    pontra kattintva jutsz a részletezőoldalra, ahol a
    kliens letölthető. (Erre nem feltétlenül lesz szükséged a
    labor során)

Network beállítások otthonra
----------------------------

SQL Developer, Basic típusú kapcsolathoz

-   Hostname: rapid.eik.bme.hu
-   Port: 1521
-   SID: szglab


Amire a telepítésnél érdemes figyelni
-------------------------------------

SQL Developer

-   A .zip fájlt alkönyvtárakkal együtt kell kicsomagolni,
    és (Windows-on) az sqldeveloper könyvtárban levő sqldeveloper.exe
    programot kell indítani
-   4.1-es és 4.2-es verzió: 8-as Java SE JDK környezet szükséges
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

