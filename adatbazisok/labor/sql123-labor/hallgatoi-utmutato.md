---
layout: page
title: Hallgatói útmutató az SQL labor méréseihez
---


Áttekintés
==========

A mérés célja a relációs adatbázisok szabványos lekérdezőnyelve, az SQL nyelv koncepciójának elsajátítása, és alapvető nyelvi szerkezeteinek illetve ahhoz kapcsolódó jó gyakorlatok megismerése.

Ezeken a laborokon találkozik egymással a relációs adatbázisok lekérdezőnyelveinek elmélete és a gyakorlat. A segédlet SQL-re vonatkozó részéből valamint az előadáson elhangzottakból felkészülten kell érkezni a laborra, mivel ezeket az ismereteket ott már alkalmazni kell. A részletes oldal- és fejezetszámokat lásd az [SQL laborok áttekintő lapján](./).

Az SQL laborok három laboralkalmat tartalmaz, amelyek a következők:

 - SQL sémadefiníció, a továbbiakban: **SQL-1**
 - SQL lekérdezések, a továbbiakban **SQL-2**
 - SQL adatmódosítás, a továbbiakban: **SQL-3**

A legfontosabb tudnivalókat összeszedtük a laborokon használandó [Oracle kliens programokhoz](../programok-oracle).

Az SQL-2 és SQL-3 laborokhoz a feladat típusához kapcsolódó *inicializáló szkriptet* teszünk közzé:

 - Az URL a feladatsoron olvasható, ahonnan egy *UTF-8* kódolású szövegfájlként tölthető le a szkript.
 - A megnyitáshoz az SQL Developer (File/Open) illetve modern text editor használatát javasoljuk (ami kezeli a unix-os sorvége jeleket).
 - Futtatás: SQL Developerben a Run Script (F5) paranccsal, SQLcl-ben a `START initszkript-helye/neve.sql` formájú paranccsal.


Beadandó anyagok követelményei
==============================

A SQL laborok során beadandó egy-egy:

 - egy speciálisan formázott SQL szkript, amely a kiadott sablonnak felel meg, és
 - egy pdf formátumú labordokumentáció

A labordokumentácóban az elvégzett munkát kell az elvárható igényességgel dokumentálnia,
egyértelműen és explicite derüljön belőle ki a feladatok megoldása. Szerepeljenek benne a megoldás során meghozott tervezői döntések, a megoldás koncepciója, és az SQL-1 laboron a megtervezett ER-diagram valamint az abból származtatott relációs séma.


## A beadandó SQL szkriptről

A beadandó SQL szkript váza, illetve az SQL-2, SQL-3 laborokhoz kapcsolódóan egy beadandó generátor alkalmazás elérhető az [SQL laborok áttekintő lapján](./).

A beadott SQL szkripttel kapcsolatos tudnivalók az alábbiak.

Tartalmi követelmények:

 - A szkript nem használhat procedurális PL/SQL elemeket. Ami az [Oracle Database SQL
referenciájában][ORA-SQLREF] szerepel, az használható, kivéve ha jelzi, hogy ez egy PL/SQL elem.
   **Figyelem!** Az SQL referencia helyenként a [PL/SQL referenciára][ORA-PLSQLREF] hivatkozik, amit ott olvashattok, az már procedurális elem lehet. (Tehát pl. a create procedure utasításról szól az SQL referencia is, de a PL/SQL referenciára hivatkozással indul. Úgy fogalmaz: "Procedures are defined using PL/SQL. Therefore, this section provides some general information but refers to Oracle Database PL/SQL Language Reference for details of syntax and semantics." Ezek az elemek a SQL-2,3 laborok során nem használhatók!
 - A szkript SQL utasításaiban TILOS a sémanevek használata az objektumnevek előtt.
 - Eredményoszlopokat átnevezni akkor kell és csak akkor szabad, ha a feladat szövege ezt egyértelműen tartalmazza (pl. meg van adva az eredményoszlop neve, és az alapértelmezetten - átnevezés nélkül – más néven jelenne meg).

Formai követelmények:

 - Egyértelműen jelölni kell a feladat sorszámával, hogy melyik utasítás melyik feladat megoldása. A feladatsorszámok a feladatlapon találhatók. **Figyelem!** Az SQL-1 labor feladatsorszámai pontot nem tartalmaznak, míg az SQL-2 és SQL-3 laborok feladatsorszámai pontot tartalmaznak.
 - A szkriptnek a kiadott sablonnak kell megfelelnie. Ha nem felel meg a sablonnak, a beadott megoldás értéktelen.
 - A feladatokat a feladatlapon szereplő sorrendben kell tartalmaznia.
 - A szkript **UTF-8 kódolású** legyen!
 - A szkript a futása elején NE hívja meg az inicializáló szkriptet. (SQL-1 labornál még nincs
inicializáló szkript azt csak a SQL-2 és SQL-3 laboroknál használjuk)
 - Többszöri futtatás követelménye:
    - SQL-1 labor: ha a megoldásszkriptet többször lefuttatjuk ebben a sorendben egymás után, ugyanazt az eredményt kell kapnunk. Ennek érdekében a szkriptet úgy szervezzük, hogy az a saját objektumok törlésével kezdődjön (`DROP TABLE`..., stb.). A saját objektumokat tehát magunknak explicite kell törölni.
    - SQL-2 és SQL-3 laborokhoz: ha az inicializáló és megoldásszkriptet többször lefuttatjuk ebben a sorendben egymás után, ugyanazt az eredményt kell kapnunk. Ennek érdekében a szkriptet úgy szervezzük, hogy az a feladatok megoldása során létrehozott saját objektumok törlésével kezdődjön (`DROP TABLE` stb.). A saját objektumokat tehát magunknak explicite kell törölni. Az inicializáló szkript törli a hivatalos objektumokat.
 - A végleges, összeállt szkriptnek SQLcl-ben futnia kell megfelelően, tehát ezt is ellenőrizzük! Az SQL-2 és SQL-3 laborok esetén a saját szkript előtt futtassuk az inicializáló szkriptet! Az SQL-1 labor esetén a saját szkript előtt nem kell futtatni az inicializáló szkriptet.
 - Ellenőrizzük, hogy a **beadott szkriptünk** illetve **annak kimenete** jólformált XML (az alábbi megjegyzés mellett):
    - **Megjegyzés:** mind a megoldás szkriptből, mind annak a kimenetéből a `<tasks>` és a `</tasks>` karakterláncok és azok közötti rész kivágásával nyert állománynak kell jólformált XML-nek lenni
    - XML szerkezet:
      - gyökérelem `<tasks>`
      - azon belül `<task>` elemek
      - azon belül a szkript adott feladathoz tartozó kimenete `<![CDATA[kimenet]]>` módon jelenjen meg!
 - A **jólformáltság ellenőrzése** a következő módon történik a két fájl esetében:
    - Vágjuk ki a fent említett, `<tasks>` és `</tasks>` határolók közötti szakaszát, beleértve a jelzett határolókat is, és helyezzük egy-egy xml kiterjesztésű állományba.
    - Az XML állományt nyissunk meg egy böngészőben (Firefox, Chrome vagy IE)!
    - Ha szépen megjelenik hierarchikusan fa formátumban az eredmény, akkor jólformált.
    - Ha hibát kapunk és/vagy nem fa formátumban jelenik meg a fájl tartalma, akkor nem jólformált a fájl.


Formai követelmények, amiben a beadandó generátor segít (de ellenőrizni a hallgató felelőssége!):

 - A szkriptnek végeredményben egy XML formátumú megoldást kell kiírnia a kimenetre. Ennek érdekében a kapott szkript vázhoz a következő pontokon szükséges hozzányúlni:
 - A `prompt <tasks>` sor előtt kerüljön sor a saját objektumok eldobására.
 - Minden feladat megoldásának a `prompt <tasks>` és a `prompt </tasks>` sorok közé kell kerülnie a feladatlap szerinti sorrendben.
 - Minden feladat megoldását a következő két sornak kell bevezetnie. Az `n` attribútum a feladat feladatlapon szereplő sorszáma, jelen példában `2.1` Ez feladatonként változtatandó; minden feladatnál a feladatlapon adott sorszámmal kell egyeznie. **Figyelem!** Az SQL-1 labor feladatsorszámai pontot nem tartalmaznak, míg az SQL-2 és SQL-3 laborok feladatsorszámai pontot tartalmaznak.

```
prompt <task n="2.1">
prompt <![CDATA[
```
 - Ezután következhet maga az SQL utasítás.
 - Az SQL utasítás után jön a következő két sor (minden esetben változatlanul):

```
prompt ]]>
prompt </task>
```

 - Meg nem oldott feladatok bevezető és lezáró prompt üzenetei ne maradjanak üresen a szkriptben, azokat távolítsuk el!
 - Az adatmanipulációs feladatok előtt a szkriptnek ki kell adnia a `set feedback on`, utána pedig a `set feedback off` utasítást.


Végül egy megjegyzés: Több helyen kérjük, hogy az oszlopnevek felsorolása nélkül oldódjék meg az adott feladat. Ez nem azt jelenti, hogy a kimeneten ne jelenjenek meg oszlopnevek, csupán azt, hogy ezek a lekérdezésben magában ne legyenek felsorolva.


A labor értékelése
==================

A laborok általános tudnivalói az SQL-1,2,3 laborok esetén a következőkkel egészülnek ki:

 - Ha a szkript nem felel meg a fenti formai illetve tartalmi követelmények mindegyikének, a beadott munka értékelhetetlen.
 - Az SQL laborokon a feladatokat megoldó SQL kódot a hallgató írja. Generált kód beadása esetén az adott részfeladat értékelhetetlen.
 - Ügyeljünk arra, hogy a megoldásunk elkerülje a hatékonyságot befolyásoló illetve ellenjavallt szerkezeteket, illetve hibákat, mert ezek pontlevonással járhatnak. Ilyenek például:
   - beágyazott `SELECT` használata `HAVING` feltétel helyett
   - beágyazott `SELECT` használata illesztés helyett
   - `UNION`, `UNION ALL`, `MINUS`, `INTERSECT` halmazműveletek indokolatlan használata (főleg az utóbbi kettő gyakran hatékonyabban írható le illesztéssel)
   - külső illesztés helyett belső illesztés használata
   - `NULL` érték vizsgálata nem az `IS NULL` operátorral


Néhány tipp és megjegyzés az SQL nyelv használatához
====================================================

Lekérdezések anatómiája:

 - A legtöbb lekérdezés `SELECT` - `FROM` - `[WHERE]` - `[GROUP BY]` - `[HAVING]` - `[ORDER BY]`
sorrendben íródik, és a `[]` jellel jelölt részek opcionálisak. A részeket sokszor *klóz*nak nevezzük.
 - A hierarchikus lekérdezések az előbbitől eltérően az opcionális `WHERE` után a `CONNECT BY ... [START WITH ...]` klózzal folytatódnak.
 - A hierarchikus lekérdezésben a `CONNECT BY` klózban megadott feltételt kielégítő rekordpárok a hierarchiában szülő-gyerek viszonyban vannak. A `PRIOR` kulcsszóval jelölt kifejezés a szülő rekordon értelmezett. A `PRIOR` attribútumhoz köt, azaz nem állhat operátor vagy függvény a hatáskörében, csak és kizárólag attribútumnév követheti.
 - A relációs algebrai kifejezések kanonikus alakjával párhuzamba állítva, az SQL `SELECT` - `FROM` - `WHERE` klózok jó közelítéssel a projekció, Descartes-szorzat, szelekció műveleteknek felelnek meg. A legfontosabb **különbség**, hogy míg a relációs algebra műveletei halmazműveletek (azaz nincsenek ismétlődések az eredményhalmazban), addig SQL esetén a `SELECT` helyett a `SELECT DISTINCT` utasítást kell alkalmaznunk az ismétlődések szűréséhez.
 - A `SELECT` után álló valamennyi nem aggregátumot a `GROUP BY` paraméterében meg kell
adni, egyébként a lekérdezés nem értelmezhető.
 - A `HAVING` és `WHERE` között a különbség: a `HAVING` aggregátumra vonatkozik, azaz `SUM`, `AVG`, `COUNT` stb. függvényt tartalmazó kifejezésre, vagy - ritkábban - a `GROUP BY` klózban szereplő kifejezésekre vonatkozó feltételt határoz meg.
 - A `UNION` alapesetben különböző rekordok halmazát adja, és ez az egyetlen SQL utasítás,
amelynek ez az alapértelmezése. Ha ismétlést is szeretnénk látni, akkor a `UNION ALL`
utasítást kell alkalmazni.

 - Az `AS` kulcsszó kifejezések (oszlopok) átnevezésre szolgál, és kiírása nem kötelező a `SELECT` listában. A `FROM` listában a táblák átnevezésekor pedig nem szabad használni.
 - A `FROM` klózban is állhat beágyazott lekérdezés, ilyenkor zárójelbe kell tenni.
 - Az attribútum- és objektum-nevek opcionálisan *idézőjelek* közé zárhatók. Ennek **használatát javasoljuk mellőzni**, kivéve, ha valaki pontosan végiggondolta ennek a következményeit! (Idézőjelek használata esetén a nevek kis- és nagybetű helyesen (case-sensitive módon) kerülnek figyelembe vételre, míg idézőjelek használata nélkül a neveket nagybetűsre konvertálja az SQL értelmező.)
 - Általában az SQL utasításokban nem kell a táblákhoz megadni a sémaneveket (pl. a felhasználó nevét), a labor beadandókban pedig egyenesen TILOS!
 - Egyértelmű esetekben a táblanevet vagy annak átnevezett nevét sem kell kiírni az attribútumok neve elé.


Illesztések:

 - A külső illesztés (outer join) hagyományos Oracle szintaxisa (a `(+)` jel használatával) ill. a szabvány szerinti szintaxis is használható. Egy lekérdezésen belül javasoljuk egyféle szintaxis használatát!
 - A külső illesztés hagyományos Oracle szintaxisa esetén:
   - a `(+)` jelet mindig az után a kifejezés után kell írni, ahol NULL érték megjelenhet, ha nincs illeszkedő rekord.
   - a `(+)` jelet ki kell tenni a lekérdezésben szereplő valamennyi olyan attribútum után, amely a *külső* (csupa NULL-rekorddal kiegészített) táblához tartozik. Kivételt képez ez
alól a többszörös külső illesztésben a további külső illesztés megadása. Magyarázatként álljon itt egy példa, ahol az **A** táblának a rekordjaihoz külső illesztéssel illesztjük a **B** tábla rekordjait, majd ehhez a **C** rekordjait olyan kifejezéssel, amiben **B** és **C** tábla attribútumai szerepelnek.

```sql
select a.id, b.id, c.id
  from a, b, c
 where
    -- join
       a.id = b.a_id (+)
   and b.c_id = c.id (+)
    -- szűrések, itt már kell a (+) b és c összes előfordulásához
   and b.szin (+) in ('piros', 'zöld')
;
```

Kifejezések, feltételvizsgálatok:

 - Egy kifejezés értékét a `NULL` értékre, illetve attól eltérő vizsgálni a `<kifejezés> IS [NOT] NULL` formában kell!
   **FIgyelem!** a `<kifejezés> = NULL`, `<kifejezés> <> NULL` feltételvizsgálat egyaránt hamis (pontosabban UNKNOWN értékű). Mivel a lekérdezés csak azokat a rekordokat adja vissza, amelyekre a `WHERE` ill. `HAVING` klózban megadott feltétel igaz, az ilyen formában írt feltételek legtöbbször nem a várt eredményt adják.  – az UNKNOWN elemek nem kerülnek az eredményhalmazba.
 - A `CHAR` és `VARCHAR2` adattípusok között nagy különbség van: az előző fix méretű, az utóbbi változó méretű sztring. Jelentősége a mintaillesztésnél szembeötlő, hiszen pl. `CHAR(5)` esetében az L betűre végződő hárombetűs szavak valójában nem L betűre, hanem két SPACE karakterre végződnek.
 - Néhány hasznos függvény, amelyek részletes leírása az [Oracle SQL kézikönyv][ORA-SQLREF] *Functions* fejezetében olvasható:
   - A `TO_DATE` és `TO_CHAR` függvények sztring és dátum közötti konverziót valósítanak meg.
   - Az `NVL` és az `NVL2` függvény, amely paraméterezése a következő:
     - `NVL(<kifejezés>, eredmény_null_érték_esetén)`
     - `NVL2(<kifejezés>, eredmény_nem_null_érték_esetén, eredmény_null_érték_esetén)`
   - Az előző kettő általánosítása a `DECODE` függvény, amellyel diszkrét függvényszerű transzformációt lehet leírni.


Kényszerek:

 - `PRIMARY KEY` = `UNIQUE` + `NOT NULL`, de míg a baloldaliból csak 1 lehet minden táblában, addig a jobboldaliból „tetszőlegesen” sok.
 - A `UNIQUE` kényszer előírása nem zárja ki a `NULL` értéket.


{% include kozos-linkek.md %}
