---
layout: page
title: Hatékony lekérdezések az adatbázison
author: Marton József, Milanovits Richárd
date: 2013. március
---

Hatékony lekérdezések az adatbázison

Nagy adatmennyiségek kezelése esetén kiemelten fontos, hogy egy igen
kritikus paramétert, a lekérdezések erőforrás-igényét (és az azzal
szorosan összefüggő futásidőt) a lehető legalacsonyabb értéken tartsuk.
Az alábbiakban azt mutatjuk be, hogy három alapelv szem előtt tartásával
a futásidő jelentős mértékben, akár nagyságrendekkel is csökkenthető.

Az adatok tárolási struktúrájának kialakítása
=============================================

Az adatbázis tábláinak tervezésénél és létrehozásánál is tehetünk olyan
lépéseket, amelyek majd a későbbi műveletek futását gyorsítani tudják.
Az adatok optimális tárolási struktúrájának, sémájának tervezése és
kialakítása alapvetően függ attól, hogy az adatokon milyen műveleteket
és azok milyen arányú kombinációját kívánjuk futtatni.

Ebbe a kérdéskörbe tartozik az Adatbázisok tárgy relációs sémák logikai
tervezése („normalizálás”) témaköre is. Ott annak a kérdéseit
tárgyaltuk, hogy a normálforma emelésével hogyan lehet
tranzakció-feldolgozó (OLTP) rendszerek számára hatékonyabb, míg a
normálforma alacsonyabban tartásával a lekérdezés-orientált, ún.
analitikus alkalmazások (OLAP) számára kedvezőbb adatbázissémát
tervezni.

Nagyméretű rekordokat tartalmazó táblák esetében, ha a lekérdező és
módosító műveletek tipikusan csak a rekordok egy lényegesen kisebb
méretű, közös szeletét érintik, megfontolandó a tábla kettévágása oly
módon, hogy a két tábla rekordjai „pontosan egy:pontosan egy”
kapcsolatban állnak egymással, amely kapcsolatot a közös elsődleges
kulcsuk teremt meg. Ekkor az illesztésük ennek segítségével hatékonyan
megoldható, de ha csak a kisebb részre van szükség, akkor lényegesen
kevesebb blokkot kell a háttértárról beolvasnunk. Bizonyos feltételek
mellett ezt az adatbázis-kezelő az alkalmazásprogramozó elől
transzparens módon elrejtve magától megteszi, és léteznek ún.
oszlop-orientált adatbázis-kezelők is, amelyek minden táblát
attribútum(csoport)onként külön tárolva csak a művelet által érintett
attribútumokat olvassák be a háttértárról.

A heap-szervezésű állományokon végzett műveleteket megfelelően
kiválasztott indexállományokkal támogathatjuk (l. a következő
szakaszban). Bizonyos adatbázis-kezelő rendszerek más állományszervezési
módokat is a rendelkezésünkre bocsájtanak. Az Oracle Database
eszközkészletéből két példát hozunk. Az egyik az adattáblák ún.
particionálása, amikor a tábla valamely attribútumaiban tárolt érték
alapján (pl. dátum-intervallumonként, vagy aktív/historikus jelző) az
egyes rekordok külön-külön állományban foglalnak helyet. A műveletek
elvégzésekor ez az alkalmazásprogramozó számára transzparens, de ha a
művelet elemzésekor az optimalizáló megállapítja, hogy elegendő egy vagy
néhány partícióhoz hozzáférni a művelet elvégzéséhez, akkor a kisebb
megmozgatott adattömeg miatt hatékonyabb lehet a végrehajtás. Az ún.
index-szervezésű tábla (IOT, index-organized table) az Oracle Database
olyan állományszervezési módja, amikor a rekordok egy index
levélcsomópontjaiban foglalnak helyet. Ezek használata akkor lehet
hatékony, ha az állomány rekordjai kicsik, és legtöbbször a struktúrát
tartalmazó index-szel támogatható művelet során férünk hozzá.

Az indexek megfelelő megválasztása
==================================

A struktúra megtervezésén túl fontos a táblákon elhelyezett indexek
megfelelő megválasztása is. Ez azonban az egyik legnehezebb feladat az
adatbázis tervezése során. Egy bizonyos attribútum(lista) szerinti index
nagymértékben növeli azon lekérdezések futási sebességét, amelyekben az
adott attribútumlista (kezdőszeletének) értékét ismerjük. Ezzel szemben,
minden egyes index adminisztrálása növeli a beszúrás, módosítás és
törlés műveletek időigényét.

Általános alapelv, hogy ha egy reláción sokkal többször végzünk
lekérdezést, mint módosítást, javasolt az indexek használata, ha pedig a
lekérdezések várható számossága nincsen nagyságrendi eltérésben a
beszúrás, módosítás, törlés műveletek számával, megfontolandó az
elhelyezésük. Tekintve, hogy az egyes módosítási műveletek végrehajtása
is kereséssel kezdődhet (pl. olyan módosítás vagy törlés, amely WHERE
feltételhez kötött), nem triviális megjósolni, mely adatbázis-műveletek
lesznek a többihez képest magasabb előfordulásúak.

Az Oracle Database adatbázis-kezelő az elsődleges kulcsként (primary
key) jelölt attribútumokra mindig, az egyediséget előíró kényszerek
(unique) esetén pedig alapértelmezésben indexet épít. Ezekre is
figyelemmel kell lenni az esetleges további indexek definiálásakor.

Több tábla illesztését (főleg ha az veszteségmentes sémadekompozíció
során létrejött táblák illesztése) tipikusan a táblákon definiált idegen
kulcsok mentén végezzük. Az Oracle Database rendszerben az idegen kulcs
mindig elsődleges vagy egyedi kulcsra mutat, így az előzőek értelmében
alapértelmezésben az optimalizáló rendelkezésére áll index az
illesztések támogatására. Annak érdekében, hogy az indexek ne csak az
idegen kulcs „irányába” által megadott illesztési sorrendet
támogathassák, hanem az ellenkező irányt is (amivel nagyobb teret adunk
az optimalizálónak), sokszor érdemes megfontolni az idegen kulcsként
jelölt attribútum(listák)ra is index építését (ami természetesen a
legtöbbször nem lesz egyediséget biztosító index).

Hatékony SQL utasítások megfogalmazása
======================================

A tárolási struktúrák és indexek helyes megtervezésén túl legalább
annyira kritikus kérdés a futtatni kívánt SQL utasítások optimalitása
is. Amennyiben betartunk pár alapelvet (és ezzel elég nagy szabadságot
hagyunk az Oracle lekérdezés-optimalizáló eljárásának), jelentős
futásidő-csökkenést tapasztalhatunk.

Indexek használata, ha lehetséges
---------------------------------

Ahogy arra az első mérésben is láthattunk példát, egy lekérdezés
sebessége nagyban függ attól, hogy az Oracle tudja-e használni a táblára
definiált indexeket vagy sem.

A relációs sémák (a példáinkban erre utalunk, az oktatas séma szemelyek
és igazolvanyok nagyobb tábláin hasonló kérdések fogalmazhatók meg):

 * `SZEMELY(IGAZOLVANY_SZAM, NEV, SZULETESI_DATUM, SZULETESI_VAROS)`  
   ahol `igazolvany_szam` a kulcs.
 * `CIM(IGAZOLVANY_SZAM, CIM_TIPUS, IRANYITOSZAM, VAROS, UTCA)`  
   ahol az `igazolvany_szam` a szemely táblára mutató idegen kulcs,
   és az `igazolvany_szam + cim_tipus` együtt a kulcs.

Kérdezzük le
azon személyek adatait, akik ugyanabban a városban van az állandó
lakcímük, mint ahol születtek, és igazolványszámuk 1-es számjeggyel
kezdődik!

```sql
select sz.igazolvany_szam, sz.nev, c.cim_tipus, c.iranyitoszam, c.varos
  from oktatas.szemely sz, oktatas.cim c
 where sz.igazolvany_szam = c.igazolvany_szam(+)
   and c.cim_tipus(+) = 1
   and sz.szuletesi_varos = c.varos(+)
   and substr(sz.igazolvany_szam,1,1) = '1';
```

```sql
select sz.igazolvany_szam, sz.nev,
       c.cim_tipus, c.iranyitoszam, c.varos
  from oktatas.szemely sz, oktatas.cim c
 where sz.igazolvany_szam = c.igazolvany_szam(+)
   and c.cim_tipus(+) = 1
   and sz.szuletesi_varos = c.varos(+)
   and sz.igazolvany_szam like '1%';
```

A feladat két lekérdezése ugyanazt az eredményhalmazt határozta meg, a
futási sebességük azonban különbözött. A személy tábla igazolványszám
attribútumának első karakterére történű megkötés logikailag egy
intervallumkeresés, amit a `SZEMELY_PK` index támogathat. Az első
megfogalmazásban ezt a `SUBSTR` függvény segítségével fogalmaztuk meg,
ekkor az optimalizáló nem ismerte fel, hogy használhatná az indexet.
(Egy speciális, ún. függvényalapú index létrehozásával ezt is
támogathattuk volna, de ez a fent írottak szerint adminisztrációs
többletteher, amit értékelni kell. A függvényalapú indexekről bővebben
l. az Oracle Database Performance Tuning Guide c. dokumentáció
Designing and Developing for Performance/[Application Design Principles fejezetében][1].

A szűrési feltétel `LIKE` kulcsszót tartalmazó megfogalmazásakor az
optimalizáló igénybe tudta venni a táblára definiált index segítségét.
Ez a végrehajtási tervek különbségéből kitűnt, és nagyobb adathalmaz
esetén a futásidő-különbség is szembetűnő lett volna.

Halmazműveletek helyett illesztések
-----------------------------------

Több tábla adataival dolgozó lekérdezést olykor a megszokott
halmazműveletek (unió, metszet, különbség) segítségével és
illesztésekkel is megfogalmazhatunk. A halmazműveletekkel operáló
változat al-lekérdezésekkel dolgozik, amivel az optimalizáló számára
praktikusan előírja a részműveletek egy végrehajtási sorrendjét. Ekkor
kevesebb teret kap az optimalizáló, így potenciálisan kizárhatjuk a
részműveletek olyan végrehajtási sorrendjeit, amivel hatékonyabban tudná
az eredményt előállítani.

Másik szempont, hogy az al-lekérdezések eredményein végrehajtott
halmazműveletek (ez főleg a metszet és különbség esetén fontos) nem
támogathatók indexekkel, hiszen a részeredményekre a séma nem tartalmaz
indexet. Ha ugyanazt az eredményt meg tudjuk fogalmazni joinnal is,
akkor az optimalizálót nem fosztjuk meg a segédstruktúrák alkalmazásából
adódó potenciális előnyöktől.

Ez természetesen csak ökölszabály, ami alól számos kivétellel
találkoznak az adatbázis-kezeléssel foglalkozó szakemberek a munkájuk
során. Fontos mindig a konkrét eset vizsgálata, és a fejlesztési, futási
és karbantartási kényszerek ismeretében dönteni a halmazműveletes, az
illesztéses vagy éppen egy harmadik megoldás alkalmazásáról.

### `UNION ALL` vs. outer join

Az *outer join* vagy *külső (fél)illesztés* lényege,
hogy azok a rekordok is megjelennek az eredményhalmazban,
amelyekhez nem található pár a másik táblából. Ez a viselkedés szimulálható
két lekérdezés `UNION ALL` művelettel történő összekötésével.
Az outer join használata esetén az optimalizáló tipikusan nagyobb szabadságfokkal dolgozik.
További szempont, hogy a `UNION ALL` esetén az input relációkhoz
többször kellhet hozzáférni (adott esetben lineáris keresés (full table
scan) vagy éppen indexelt hozzáférés használatával).

A fenti személy és cím táblákban keressük
azokat az embereket (minden adatával) értesítési címükkel (`cim_tipus=2`).
Azokat is keressük, akikhez nincs értesítési cím rögzítve.
Íme a külső illesztést használó változat a hagyományos, *Oracle-szintaxis* használatával:

```sql
select sz.*, c.*
  from oktatas.szemely sz, oktatas.cim c
 where sz.igazolvany_szam = c.igazolvany_szam (+)
   and c.cim_tipus (+) = 2
```

Ugyanez ANSI SQL-szintaxis használatával:

```sql
select sz.*, c.*
  from oktatas.szemely sz left join oktatas.cim c
    on (sz.igazolvany_szam = c.igazolvany_szam and c.cim_tipus = 2)
```

### Allekérdezés helyett join

A fenti személy és cím táblákban keressük azokat az embereket (minden
adatával), akikhez a nyilvántartásunkban szerepel értesítési cím
(`cim_tipus=2`). Íme az illesztést használó változat.

```sql
select sz.*
  from oktatas.szemely sz, oktatas.cim c
 where sz.igazolvany_szam = c.igazolvany_szam
   and c.cim_tipus = 2;
```

### `MINUS` helyett anti-join

A fenti személy és cím táblákban keressük
azokat az embereket (minden adatával), akikhez a nyilvántartásunkban nem
szerepel értesítési cím (`cim_tipus=2`). Íme az illesztést használó
változat.

```sql
select sz.*
  from oktatas.szemely sz, oktatas.cim c
 where sz.igazolvany_szam = c.igazolvany_szam (+)
   and c.cim_tipus (+) = 2
    -- Primary key részével, vagy más, not null attribútummal ismerhetők fel
    -- a külső illesztés által behozott "null-sorok".
    -- Ennél (és csak ennél!) a vizsgálatnál elmaradhat
    -- a külső illesztés jelölése.
   and c.igazolvany_szam is null;
```

[1]: http://docs.oracle.com/database/121/TGDBA/pfgrf_design.htm#TGDBA-GUID-38FC5A9F-89E6-4812-8EE4-F9949B69BCFC
