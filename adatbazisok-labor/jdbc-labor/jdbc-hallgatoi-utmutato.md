---
layout: page
title: JDBC labor hallgatói útmutató
author: Varsányi Márton
---

Hallgatói útmutató a JDBC méréshez


Környezet kialakítása a Rapid szerveren
=======================================

A JDBC mérés keretében egy Java Web Start alkalmazást fogunk írni. Ehhez
egy példa alkalmazást bocsátunk a hallgatók rendelkezésére, mely
sablonként, kiindulási alapként szolgál a mérés során elkészítendő
alkalmazáshoz.

A minta alkalmazás a következő módon tölthető le és állítható be
legegyszerűbben a Rapid szerveren, SSH kliensen (pl. PuTTY) keresztül
történő belépés után.

```shell
curl -L https://db.bme.hu/r/jdbc/demo | sh
```

A fenti parancs futtatása után az aktuális könyvtárban létrejön
egy `jdbc` nevű, mely tartalmazza a példakód legfrissebb verzióját, egészen
pontosan azon részeit, amik minden feladatsorra megegyeznek. A többi részt
a preproc.sh fogja letölteni, lásd később.

Az előző mérés során létrehozott táblákra, adatokra szükségünk lesz,
ennek biztosítása érdekében **futtassuk le újra az SQL mérésen már
megismert inicializáló scriptet** (ez a 0. feladat is)

Dolgozni a lokális, illetve a `rapid.eik.bme.hu` nevű gépen fogunk,
ahova a labor elején mindenki megkapja a bejelentkezési nevét és
jelszavát. Az első bejelentkezés alkalmával ezt meg kell változtatni.
Elkerülvén az elfelejtett adatbázis-jelszavakból adódó problémákat, a
laborra mindenki úgy érkezzen, hogy be tud lépni az adatbázisba!

A fejlesztéshez használható a Rapidon található JDK (8-ás verzió).

A labor elején a környezetbeállítás és a minta alkalmazás kipróbálása
során, valamint később a fejlesztés során az alábbi lépések szerint
járjunk el:

  1. Próbáljuk ki a minta alkalmazást (szkeletont), melynek egy példánya
     a következő URL-en érhető el (az oldalon található hivatkozás
     segítségével indíthatjuk az alkalmazást):  
     <https://rapid.eik.bme.hu/~marton/jdbc>
  2. Csatlakozzunk az adatbázis szerverhez, a minta alkalmazás felületén
     megadva az adatbázishoz való kapcsolódáshoz szükséges
     felhasználónevünket és jelszavunkat.  
     Az említett felhasználónév és jelszó ahhoz az adatbázis fiókhoz
     tartozik, melyet az elmúlt két mérés alkalmával is használtunk (pl.:
     SQLDeveloper-ben megadva).
     **A jelszó nem összekeverendő az óra elején (a
     feladatlap fejlécében) kiosztott Rapid-os jelszóval.**
  3. Jelentkezzünk be a Rapid szerverre SSH vagy pl. PuTTY
     kliensen keresztül. Bejelentkezést követően automatikusan a `$HOME`
     könyvtárunkba kerülünk.
  4. Töltsük le a minta alkalmazást az alábbi parancs futtatásával:  
     **Fontos, hogy amennyiben korábban már futtattuk a parancsot, úgy
     *ne futtassuk le újból* (ellenkező esetben furcsa hibákkal
     szembesülhetünk)! Amennyiben erre mégis szükség lenne, úgy előtte
     töröljük a \$HOME könyvtárunkban létrehozott alkönyvtárakat
     (jdbc, public\_html) – szükség esetén előtte biztonsági mentést
     készítve munkánkról!**

     `curl -L https://db.bme.hu/r/jdbc/demo | sh`
    
     A parancs egyrészt letölti a minta alkalmazást az aktuális
     könyvtárba (ez bejelentkezést követően a `$HOME` könyvtárunk),
     másrészt beállítja a környezetet, mely során a következő lényegesebb
     lépések történnek:
      -  Minta alkalmazás tömörített „csomagjának” letöltése és
         kicsomagolása a `jdbc` könyvtárba
      -  Megfelelő jogosultságok beállítása a `$HOME` könyvtáron, a `jdbc`
         könyvtáron és alkönyvtárain
      -  `$HOME/public_html` könyvtár létrehozása
      -  `$HOME/public_html` megfelelő jogosultsági beállítása
      -  Végül a `$HOME/public_html` könyvtárban szimbolikus link
         létrehozása jdbc néven a
         `<letöltés során aktuális könyvtár – alapesetben a $HOME>/jdbc/web`
         könyvtárra
      -  Ennek megfelelően a ./jdbc/web könyvtárba kerülő alkalmazás
         elérhetővé válik a következő címen:
         `https://rapid.eik.bme.hu/~neptun/jdbc`

  5. Az előbbi pontban lefuttatott környezetbeállító script szimbolikus
     linket készít a Rapid-on található közös JDBC meghajtó példányra.
     Amennyiben ez valamilyen oknál fogva sikertelen lenne, úgy tegyük
     manuálisan a meghajtót a `jdbc/lib` könyvtárba. (A JDBC driver az
     `ojdbc7.jar` nevet viseli.)
  6. Lépjünk be a `jdbc` könyvtárba (`cd jdbc`), majd hozzuk létre a
     `conf/preproc.config.sh` scriptet a `conf/preproc.config.sh.sample`
     script másolásával. Az újonnan létrehozott (konfigurációs célt
     szolgáló fájlban) állítsuk be a címet, neptun kódunkat (Rapid
     felhasználó neve), stb.
      -  **A neptun kódunk *csupa kisbetűvel* írandó!**
      -  **A feladatsor neve *csupa nagybetűvel* írandó!**
      -  A konfigurációs script változóinak értékében ne használjunk
         speciális karaktert, entert.
      -  A fenti script konfigurálja a következő lépésben futtatandó
         előfeldolgozó scriptet.
  7. Futtassuk le az előfeldolgozó (preprocesszor) scriptet, vagyis
     futtassuk a `./util/preproc.sh` fájlt.
      -  A preprocesszor script testreszabja a szkeleton alkalmazást, vagyis
         beállítja a minta alkalmazás HTML fájljában, a MANIFEST és a JNLP
         fájlban az alkalmazás nevét, címét, rövid leírását, valamint a
         hallgató nevét, neptun kódját, illetve opcionálisan a Oracle JDBC
         meghajtó elérési útvonalát az előbbi pontban létrehozott
         konfigurációnak megfelelően.
      -  Letölti a mintaalkalmazás azon részeit, amelyek függenek a hallgatóhoz
         rendelt feladatsortól.
      -  Fontos megjegyezni, hogy a preprocesszor script csak
         szöveghelyettesítést végez, vagyis lecseréli a placeholdereket az
         érintett fájlokban a `conf/preproc.config.sh` szerinti értékekre.
         Ennek megfelelően másodjára, harmadjára stb. futtatva a scriptet,
         az már hatástalan lesz.
      -  Ha valami miatt mégis szükséges a preprocesszor script újbóli
         futtatása, úgy munkánk biztonsági mentését követően töröljük
         `$HOME` könyvtárunkból a létrehozott alkönyvtárakat (`jdbc`,
         `public_html`), majd kezdjük elölről a deploy-olást. Ehhez a már
         ismert parancs használható (`curl -L https://db.bme.hu/r/jdbc/demo | sh`).
      -  **Az alkalmazás sikeres fordításához és működéséhez szükséges a
         konfigurációs script fájl létrehozása és beállítása, valamint a
         preprocesszor script lefuttatása!**
  8. Ezt követően lehetővé válik az alkalmazás build-elése, mely
     (továbbra is) a `jdbc` könyvtárban állva az alábbi parancs
     futtatásával történhet:

     `scons`

     Fontos, hogy a lefordított fájlra legyen olvasási joga az
     „other” csoportba tartozó felhasználónak. (Ezt a scons elvégzi,
     egyébként `chmod 644 <fajlnev>`)
  9. Amennyiben a korábbi build eredményét (pl.: létrehozott
     `.class` fájlok) szeretnénk eltakarítani, úgy az a `scons -c` parancs
     segítségével történhet.
  10. Ezt követően a böngészőből futtathatóvá válik az alkalmazás.
      Próbáljuk ki az alkalmazást, melynek elérhetősége:
 
      `https://rapid.eik.bme.hu/~neptun/jdbc`
 
      Adjuk meg az adatbázishoz való kapcsolódáshoz szükséges
      felhasználónevünket és jelszavunkat.

      Amennyiben a böngészőben történő futtatás során „Found unsigned
      entry in resource:” kezdetű hibaüzenetet kapunk (ennek
      megjelenítéséhez a felugró üzenetablakban kattintsunk a Details
      gombra), úgy indítsuk el a Java Control Panel-jét (`javacpl.exe`) és
      ellenőrizzük, hogy a beállításoknál (General/Settings...) a Keep
      temporary files on my computer pont be legyen pipálva.
 
  11. Módosítsuk, bővítsük a szkeletont a feladatoknak megfelelően, majd
      folytassuk a folyamatot a 8. lépéstől.

Aki a lokális gépen fejleszt, az a fájlrendszeren belül hozzon létre egy
mappát és oda töltse le a szükséges fenti állományokat. A
munkaállományait a mérés végén azonban töltse majd át a UNIX-ra (pl.
WinSCP segítségével), ahol a mérésvezetők majd ellenőrizni tudják a
mérés eredményét. Fontos, hogy a lokális gépen használt HTML fájl
általában a UNIX-on is használható, de mivel a mérésvezetők a UNIX-on
található eredményt fogják ellenőrizni, fontos, hogy ott is ki legyen
próbálva a megoldás!

A fordításhoz a korábbiakban leírtaknak megfelelően szükség van az
`ojdbc7.jar` fájlra, ami a JDBC drivert tartalmazza.

Általános elvárás, hogy a lefordított program JRE 1.8
futtatókörnyezettel kompatibilis legyen. Ez a Rapidon történő fejlesztés
esetén egyértelműen teljesül, mivel ott ilyen verziójú Java környezet
található (1.8.0\_73). Lokális gépen történő fordítás esetén erre külön
kell figyelni. Például Windowsban nem mindegy, hogy melyik verziójú Java
környezet szerepel előbb a `PATH` változóban!

Tesztelés böngészőből (IE, Chrome, Mozilla)
===========================================

A Rapidról letöltött alkalmazások a program külön beállítása nélkül
futnak böngészőből. Ennek a legfontosabb feltétele, hogy az alkalmazás
mellett található Web Start protokoll leíró fájl (JNLP) megfelelő
elérési útvonallal és fájl elnevezésekkel kerüljön feltöltésre (ez
alapesetben a preprocesszor script futtatása után teljesül).

**Fontos probléma**, hogy a Java 7u51-es frissítés nem teszi lehetővé
többek között Web Start alkalmazások futtatását sem, amennyiben azok nem
rendelkeznek megbízható CA által aláírt tanúsítvánnyal (az önaláírt sem
jó). Bővebben a [hivatalos blogon][1].

A probléma egy lehetséges megoldása az ún. [exception site list][2]-ek
használata.
A megoldás lényege, hogy a Java Control Panel-jén explicite engedélyezni
kell a kívánt alkalmazást, oly módon, hogy az URL-jét fel kell venni egy
kivétel listára.
Ehhez a Java Control Panel (javacpl.exe) „Security” fülén az „Edit Site
List...” lehetőséget kell választani, majd a „Location” alatti mezőbe
felvenni az alkalmazás URL-jét, végül az „Add” gombbal hozzáadni. Az URL
megadásakor a tartalmazó HTML oldal nevének vagy a konkrét JNLP fájlnak
nem kell szerepelnie.

Például ha a próbaalkalmazás a
`https://rapid.eik.bme.hu/~marton/jdbc/application.jnlp` címen érhető
el, ekkor a listába a `https://rapid.eik.bme.hu/~marton/jdbc/` URL=t
kell felvenni (a végén lévő perjel fontos)!

Az ezt követő futtatáskor a Java még egy figyelmeztető ablakot fel fog
dobni, de ezután már működik az alkalmazás.

Futtatás előtt állítsuk át a következőket: Java Control Panel → General
→ Temporary Internet Files → Settings… → Keep temporary files on my
computer pontot pipáljuk be, majd OK.

Frissen újrafordított program vagy módosított JNLP fájl esetében
előfordul, hogy a Java tárolja a korábbi programváltozatot. Ilyenkor a
[Java plugin cache][3]-t kell törölni: Java Control Panel → General → Settings… →
Delete Files… → OK.

A HSZK kliensgépein a Microsoft App-V alkalmazás virtualizációs
rendszer van telepítve. Az említett munkaállomásokon két fajta Java
futtatókörnyezet is telepítésre került, az egyik az alkalmazás
virtualizációs rendszerben érhető el, a másik ettől függetlenül. Utóbbi
verzió a `C:\Program Files\Java\` könyvtárból kiindulva érhető el. A
munkaállomásokon telepített böngészők az alkalmazás virtualizációs
rendszer „feletti” Java futtatókörnyezetet érik el, így a biztonsági
beállítások megadásához és az alkalmazás futtatásához (engedélyezéséhez)
a módosításokat is értelemszerűen az App-V-s futtatókörnyezetben
szükséges megadni (ellenkező esetben, pl. ha a `C:\Program Files\Java\`
könyvtár alatti `javacpl.exe` binárist használjuk, úgy a változtatásaink
érthető módon hatástalanok maradnak).

A fentieknek megfelelően sikeres beállításhoz az alkalmazás
virtualizációs rendszer „feletti” Java RE control panel-jén kell
elvégezni a változtatást. A control panel eléréséhez a következő két
megoldás egyikét javasoljuk a HSZK-ban:

 -  Start menü/Run indítása, majd a javaws -viewer parancs futtatása
    VAGY
 -  Task managerben a File/New Task opció választása, majd szintén a
    `javaws -viewer` parancs futtatása

Mindkét parancs hatására amennyiben be van állítva a cachelés Java-ban,
úgy egy "Java Cache View" ablak jelenik meg, mely mögött betöltődik a
Java Control Panel ablaka is, így a cache view-t csak be kell zárni, ezt
követően már módosíthatunk a control panelen.

A változtatások érvénybe léptetését követően futnia kell az
alkalmazásunknak (böngészőből betöltve).

(Egy másik megoldás lehet a JNLP fájlban hivatkozott alkalmazás JAR fájl
letöltése a lokális gépünkre, majd onnan történő futtatása. (Ekkor nincs
szükség a biztonsági beállítások módosítására a control panelen.))

Fordítás a Rapidon, Scons
=========================

A Rapid szerveren történő fordítás a Scons névre hallgató alkalmazás
segítségével történik. A Scons egy nyílt forráskódú, automatikus
buildelést lehetővé tevő eszköz.

A Scons néhány fontosabb jellemzője:

 -  A fordítás menetét leíró konfigurációs fájlok Python scriptek, ahogy
    maga az alkalmazás is Python nyelven íródott
 -  Megbízható, automatikus függőség-analízist és beépített támogatást
    (buildereken keresztül) tesz lehetővé számos programnyelvhez
 -  Megbízhatóan detektálja a fájlok változtatásait a fájlok MD5
    lenyomata alapján
 -  A buildelés egyszerűen a scons parancs kiadásával történhet abban a
    könyvtárban, ahol a fordítás menetét leíró állomány is található
 -  A fordítás menetét leíró állomány (Python script) a SConstruct nevet
    viseli
 -  Teljesen automatikusan és inkrementálisan buildel és egy sqlite
    állományban követi, hogy milyen fájlokat hozott létre, így a „clean”
    targetet sem kell megírnunk (a „takarításhoz” egyszerűen elég a
    `scons -c` parancsot futtatnunk)
 -  Cross-platform

A labor során kiadott minta alkalmazás (szkeleton) forráskódja, a
fordításhoz és működéshez szükséges állományai a következő
könyvtárstruktúrában kerültek elhelyezésre:

 -  projekt könyvtár/
     -  `conf/`: a konfigurációs fájlokat tartalmazó könyvtár
         -  `MANIFEST.MF`: az alkalmazás JDBC driverrel való fordításához
            szükséges állomány
         -  `preproc.config.sh.sample`: a minta konfigurációs script a
            preprocesszor script konfigurálásához
            (lemásolandó `preproc.config.sh`: néven)
         -  `webstart.keystore`: az alkalmazás és a JDBC driver
            aláírásához szükséges kulcs tárolója
     -  `lib/`: ebbe a könyvtárba linkelődik a JDBC driver JAR fájlja
     -  `resources/`: az alkalmazás felületét XML nyelven leíró fájl(ok)
        helye
         -  `View.fxml`: az alkalmazás felületét XML nyelven leíró fájl
     -  `src/`: az alkalmazás Java forráskódját tartalmazó könyvtár
         -  `application`: Az alkalmazás Controller és View rétegét tartalmazó package.
             -  `AppMain.java`: az alkalmazás belépési pontját tartalmazó 
                osztály forráskódja
             -  `ComboBoxItem.java` – A legördülő menükhöz társítható modell osztály
             -  `Controller.java` – Az alkalmazás vezérlő rétegét (controller) megvalósító osztály forráskódja
         -  `dal` -  Az alkalmazás adatelérési rétégét tartalmazó package
             -  `DataAccessLayer.java` – Az adatelérési réteg generikus interfészét tartalmazó forrásfájl
             -  `ActionResult.java` – Enum az adatmódosító feladatok eredményének jelzésére
         -  `dal.exceptions` – Az adatelérési rétegben definiált kivételeket tartalmazó package
         -  `dal.impl` – Ebben a packageben várjuk el a hallgatótól, hogy implementálja a DataAccessLayer interfészt
         -  `model` – Ebben a packagebe tartoznak a megjelenítendő entitásokat reprezentáló POJO osztályok
     -  `util/`: a környezetbeállító és a preprocesszor scriptet
        tartalmazó könyvtár
         -  `deploy.sh`: az alkalmazás letöltését és a környezetbeállítást leíró shell script
         -  `preproc.sh`: – Az alkalmazás előfeldolgozásáért (testreszabásáért) felelős script
     -  `web/`: a webszerver által kiszolgálandó fájlokat tartalmazó
        könyvtár
         -  `.htaccess`: a webszerver számára szolgáló könyvtár-szintű
            konfigurációs állomány
         -  `application.jnlp`: a Java WebStart alkalmazás leíró
            állománya (megadja, hogy az alkalmazást megvalósító JAR
            fájlt, illetve a JDBC drivert honnan kell betölteni)
         -  `index.html`: a `https://rapid.eik.bme.hu/~neptun/jdbc` címről
            elérhető HTML fájl. Hivatkozást tartalmaz a JNLP fájlra és
            így közvetett módon az alkalmazásra.
         -  `logo.png`: – Az előbbi HTML oldal közepén megjelenő képfájl
     -  `SConstruct`: az alkalmazás buildelésének lépéseit Python nyelven
        leíró állomány (a fájlban leírt lépések hajtódnak végre a scons
        parancs futtatásának hatására)

A Rapid-on történő fordítás a `scons` parancs kiadásával történhet, a
lefordított fájlok törléséhez a `scons -c` parancsot használhatjuk. A
buildelés során végső soron is az src és resources könyvtárak tartalma
fordítódik le és készül belőle JAR fájl, mely már a futtatható
alkalmazás. Az alkalmazás, valamint a JDBC driver a web könyvtárban
kerül automatikusan elhelyezésre, melyek kiegészülve a JNLP fájllal, egy
komplett Java WebStart alkalmazást eredményeznek. A web könyvtárban
található HTML fájl erre a JNLP fájlra tartalmaz hivatkozást, mely a
`https://rapid.eik.bme.hu/~neptun/jdbc` URL-en elérhető és innen indulva
futtathatjuk az alkalmazást.

A fentieknek megfelelően a feladatok megoldása során alapvetően az `src/`
és `resources/` könyvtárak tartalmát, a bennük található Java és
felületleíró XML fájlokat kell módosítani, bővíteni.

MVC architektúra, JavaFX
========================

A minta alkalmazás felépítése a klasszikus MVC (Model-View-Controller)
architektúrát követi. Ennek megfelelően az alkalmazás forrásfájljai a
következő architekturális rétegeknek felelnek meg:

 -  `src/application/AppMain.java`
     -  Az alkalmazás belépési pontját tartalmazó osztály forráskódja
     -  Inicializálja a kontroller (controller) és a
        megjelenítési (GUI/view) réteget
 -  `src/Model/*.java`
     -  Az alkalmazás modell rétegét megvalósító osztályok forráskódja
     -  Gyakorlatilag POJO oszályok, amik az adatok tárolását és 
             ellenőrzését valósítja meg. 
 -  `src/application/Controller.java`
     -  Az alkalmazás kontroller rétegét megvalósító osztály forráskódja
     -  Példányosítja az adatelérési réteget és összekapcsolja a nézetet 
        a modellekkel.
     -  Továbbítja a nézetből érkező eseményeket a modell 
        réteg/adatelérési réteg felé, majd visszaadja a „válaszokat” 
        a nézetnek (View.fxml)
 -  `resources/View.fxml`
     -  Az alkalmazás felületét leíró XML fájl, mely XML (Extensible
        Markup Language) nyelven reprezentálja az alkalmazás felületén
        (az ablakban) elhelyezett GUI elemeket
     -  Kapcsolódik a Controller osztályhoz (referenciát tartalmaz rá),
        melynek eseményeket küldhet

A JavaFX-es alkalmazások MVC modelljének, illetve az XML alapú felület
jobb megértéséhez hasznos lehet a következő [JavaFX Tutorial] átolvasása.

Az FXML fájl szerkesztéséhez referenciaként szolgálhat az [FXML bevezető].

Implementációs követelmények
============================

A feladatok megoldásakor a minta alkalmazás módosítása során a következő
szempontokat ***KÖTELEZŐ*** betartani:

 -  A modell osztályok ne kommunikáljanak egyetlen másik réteggel sem. Az adatelérési 
    réteg csak a modelleket ismerje, a Controller az adatelérési réteget és 
    a modelleket, a View pedig csak a Controlleren keresztül kommunikáljon 
    a többi komponenssel.
 -  A feladatok elvégzésénél a Controller, a megkezdett DataAccessLayer implementáció 
    és a modell osztályok üres függvényeit kell implementálni a View.fxml 
    kiegészítése mellett. JavaFx-specifikus importokat csak a Controller 
    osztály tartalmazhat. Szükség esetén a Controller osztályba új (publikus) metódusok
    felvetők.
 -  A 4.1-es feladatnál csak és kizárólag a tranzakcióban részt vevő másik tábla 
    elsődleges kulcsának oszlopát kell bekérni a felhasználótól.
 -  A formátum ellenőrzés a Controller rétegben történjen a modell osztályok 
    parseXXX(String input) fejlécű metódusaival. Ha a validáció során hiba 
    keletkezett, akkor az adatelérési réteget már ne hívjuk meg! 
 -  Az eredmények jelzésére használjuk a már előre definiált kivételeket!
 -  Ha egy modell osztályt a View-ból származó adatokkal töltjük fel a Controllerben, akkor a 
    parseXXX metódusokat használjuk, hogyha pedig a DataAccessLayerből 
    töltjük fel, akkor a setXXX metódusokat használjuk! Kivétel ez alól az, ha valaki nem oldja
    meg a 3-as feladatot, akkor használhatóak a setter metódusok.
 -  A validációs kivételek eldobásakor adjuk meg a konstruktorban a tagváltozó nevét!
 -  A laborok során a dátumokat a Java 8-as java.time.LocalDate osztállyal kezeljük.
 -  Az interfész metódusainak fejlécén ne módosítsunk, ha újfajta hibát akarunk bevezetni, 
    használjunk RuntimeExceptionöket! Ugyanígy a modell osztályok metódusainak fejlécét se írjuk át,
    ezek is az alkalmazásunk adatelérési rétegének interfészéhez tartoznak!


További tudnivalók
==================

A megfelelő hitelesítő adatok megadása után a kapcsolódás gombra nyomva,
majd a keresőfelületen tetszőleges keresőszót megadva az 
`OKTATAS.SZEMELYEK` tábla első 20 emberének nevét és személyi számát 
listázza ki névsorban.

**Kérjük, hogy a kapcsolódáshoz használt felhasználónév-jelszó párost
mindenki feltétlenül tüntesse fel a beadott jegyzőkönyvében.**

A további feladatok megoldásához a kivételek elkapása kötelező, a
programon kívülre nem juthat kivétel! A nem megfelelő bemeneteket
szintén le kell kezelni, a program írja ki, hogy mi a hiba és hol
történt (felhasználói hibakezelés szükséges - pl. a bemeneti mező szám,
túl hosszú szöveg, megoldás lehet például egy dialógusablak feldobása a Controllerből).

A megoldás során támaszkodjunk a mintakódban már kialakított struktúrára
és elnevezésekre, a mintaalkalmazás kiindulási alapnak tekintendő.

Törekedjünk a biztonságos kódra, használjunk PreparedStatementet, SQL
kivételeket, parseInt függvényt!

A beadandó állományról
----------------------

A mérés értékeléséhez egy `NEPTUN-3-CSOPKOD.zip` nevű állomány feltöltése
szükséges a Laboradmin rendszerbe, amelyen belül egy azonos nevű
könyvtár található. A könyvtár az alábbiakat tartalmazza:

 -  A teljes forráskódot `lab5jdbc.zip` fájlnévvel.
    Ezt **automatikusan megkapjuk az aktuális könyvtárban
    a scons parancs futtatása (vagyis a fordítás) során**  
    A ZIP állományba az alábbi fájlok kerülnek:
     -  `src/` könyvtár tartalma
     -  `resources/` könyvtár tartalma
     -  `web/` könyvtár tartalma, szintén a JDBC meghajtó kivételével
 -  A jegyzőkönyvet (PDF formátumban), amiben megtalálhatóak (NEPTUN-3-CSOPKOD.pdf):
     -  rövid (fél oldalas, 6-8 mondatos) felhasználói útmutató az
        alkalmazás használatához
     -  a felhasználónév-jelszó páros
     -  a megoldás során használt SQL utasítás(ok)
     -  a feladat megoldásának magyarázata
     -  a működő alkalmazás elérhetőségének címe:
        `https://rapid.eik.bme.hu/~neptun/jdbc/`
     -  A jegyzőkönyv fejlécében feltétlenül szerepeljenek
        a megoldott feladatok sorszámai!
        **Ennek hiányában a jegyzőkönyv nem értékelhető.**
 - A beadandó állomány struktúrája tehát:
     -  `NEPTUN-3-CSOPKOD.zip/`
         -  `NEPTUN-3-CSOPKOD/`
              -  `lab5jdbc.zip`
              -  `NEPTUN-3-CSOPKOD.pdf`

A jegyzőkönyvhöz a honlapon található jegyzőkönyvminták használandók, a
feladatokra elegendő azok számával hivatkozni, **a feladatok szövege ne
szerepeljen a jegyzőkönyvben**!

A mérés teljesítésének szükséges, de korántsem elégséges feltétele, hogy
a Rapidon sikerrel fordítható és működő alkalmazás kapcsolódjon az
adatbázishoz. Tehát ha a jegyzőkönyvben megadott címen nem található
minimális működést produkáló alkalmazás, akkor a jegyzőkönyv nem kerül
értékelésre.

A mérés értékeléséről
---------------------

A feladatok elkészítése során figyelembe veendő szempontok, hibaforrások:

 -  Az elkészített forráskódnak le kell fordulnia, a nem leforduló kód
    nem értékelhető!
 -  A Rapidon nem elérhető alkalmazás nem értékelhető!
 -  A jegyzőkönyv fejlécében legyenek feltüntetve a megoldott
    feladatok sorszámai és pontszámai. Ezek hiányában a jegyzőkönyv nem
    értékelhető!
 -  A kód legyen megfelelően strukturált, átlátható és megfelelően
    kommentezett, a kommentezés azonban ne menjen az
    átláthatóság rovására.
 -  Az alkalmazáshoz a jegyzőkönyvben készüljön rövid felhasználói
    útmutató is (elmaradása -1 jegy)!
 -  A jegyzőkönyvben szerepeljen a felhasználónév-jelszó páros!
 -  A jegyzőkönyvben le kell írni az egyes feladatok megoldásának
    logikáját és a megoldás során meghozott tervezői döntéseket, azok
    indoklásával együtt.
 -  A paraméteres lekérdezésekben PreparedStatement használata elvárt
    (ha elmarad, akkor a feladatra adható pontszám az egyébként adható max.
    50%-a lehet).
 -  Az eredmények előállításához szükséges logika (pl.: átlag, maximum,
    top N db számítása), ahol csak lehet, az SQL utasítás része legyen,
    és ne Java-ban kerüljön megvalósításra (ha ott kerül megvalósításra, akkor a feladatra adható 
    pontszám az egyébként adható max. 50%-a lehet).
 -  A megoldásnak a futás során megjelenő kivételeket le kell kezelnie.
    Kivétel nem juthat a kimenetre. A kivételkezelés megvalósításakor
    ügyeljünk arra, hogy nem csak SQLException történhet, a catch-ágakat
    különítsük el (kivételkezelés elmaradása -20%).
 -  Igényes kód készítése esetén max. + 20% pontszám adható.
 -  Különösen szép kivételkezelés esetén (pl. az Oracle
    hibakódok feloldása) max. + 2 pont
 -  Az SQL utasításokban a sémanevek használata TILOS!

A ponthatárok
-------------

A mérésen a feladatok megoldására 50+5 pont kapható. Az idén alkalmazott
értékelési rendszerhez igazodva a pontszámokhoz tartozó érdemjegyek
a következők:

  ----------- --------
  Jeles       41-50p
  Jó          34-40p
  Közepes     27-33p
  Elégséges   20-26p
  Elégtelen   0-19p
  ----------- --------

**Figyelem!** A jegyzőkönyv fejlécének tartalmaznia kell a megoldott
feladatok sorszámát és pontszámát!

iMSc pontozás
-------------
Az iMSc pontok számítása összhangban az előző mérések pontszámításával:
akkor jogosult a hallgató iMSc pontok szerzésére, hogyha a 4.2-es 
feladat pontszáma 0-nál nagyobb, illetve a többi feladatból szerzett pontok
száma eléri a 42,5-et. Ekkor hozzáadódik a 4.2-es feladat pontszáma a 
szorgalmi feladat nélküli pontszámhoz, és a 85% feletti részből százalékpontonként
1 iMSc pontot kap a hallgató, de legfeljebb 10-et.

További segédanyagok
--------------------

Java Database Connectivity: (a példák hasznosak lehetnek a
PreparedStatement jobb megértéséhez és típusfüggvények használatához)

 -  <http://hu.wikipedia.org/wiki/Java_Database_Connectivity>
 -  <http://en.wikipedia.org/wiki/Java_Web_Start>

Szemelvények a JDBC API-ból
===========================

Ebben a részben vázlatosan ismertetünk néhány olyan témát, ami a hallgatói segédletből
kimaradt, de hasznos lehet.

Időpontok (dátumok) kezelése
----------------------------

Ebben a szakaszban *időpont* alatt a dátum-idő-tengely egy pontjának valamilyen felbontású
leírását értjük. Ebben az értelemben tehát a *dátum* egy *nap felbontású időpont* (`1848-03-15`),
de beszélhetünk perc (pl. `1848-03-15 15:00`) vagy másodperc felbontású időpontról is.

Hagyományosan a Java SE platformon az időpontok kezelése a [java.util.Date] osztályon alapul,
amely milliszekundumos felbontású időpont tárolására alkalmas.
Időzóna információt [java.util.TimeZone] és a [java.util.Calendar] osztályokkal kombinálva lehet kezelni.

A JDBC API-ban a [java.util.Date] osztályra építve
a [java.sql.Date], [java.sql.Timestamp] és [java.sql.Time] ún. *wrapper* osztályok teszik lehetővé
időzóna-támogatás nélkül rendre a nap felbontású időpont, a nanoszekundum felbontású dőpont
és a dátum nélküli, milliszekundumos felbontású idő kezelését.

A Java SE 8-as főverziójában  a [JEP 150] javaslat szerint bevezettek egy új API-t a dátumok és időpontok
kezelésére, ami a [java.time] csomagban kapott helyet, és egységes keretben támogatja a dátum és időkezelés
olyan problémáit, mint az időzóna nélküli és az időzónát tartalmazó különböző felbontású időpontok,
csonka dátumok (pl. hónap-nap a [java.time.MonthDay] osztályban) és időintervallumok kezelése.

Az *időzóna nélküli* eseteket támogató néhány osztály:

 * a [java.time.LocalDate] a nap felbontású időpontok (dátumok),
 * a [java.time.LocalDateTime] a nanoszekundum felbontású időpontok, míg
 * a [java.time.LocalTime] a dátum nélküli idő kezelésére való.

A JDBC 4.2 ugyan a [JEP 170] szerint támogatja ezek kezelését
a generics-alapú [`<T> ResultSet.getObject(int, Class<T>)`] kiolvasó és
az általános [`void PreparedStatement.setObject(int, Object)`] paraméter-beállító
metódusokon keresztül, de ezt sajnos még nem minden driver implementálja.

Az Oracle JDBC Driver labor során használt 12.1 thin verziója jelenleg (2017. március)
ezt nem támogatja, így típuskonverzióra van szükség a mintaalkalmazás
[LocalDate][java.time.LocalDate] típusú mezői és a JDBC API között.
A típuskonverzió bemutatására készítettünk egy [JDBC LocalDate mintakód]ot,
amely bemutat néhány esetet.
Közülük az alábbiakra térünk ki:

Egy [LocalDate][java.time.LocalDate] típusú paraméter beállítására a `Date java.sql.Date.valueOf(LocalDate)`
metódussal elvégzett típuskonverzió után a `PreparedStatement.setDate(int, Date)`
használható, l. [JDBC LocalDate mintakód, setDate].

Egy [ResultSet][java.sql.ResultSet]-ből lekérdezett dátum értéket a `LocalDate java.sql.Date.toLocalDate()`
metódussal konvertálhatunk `LocalDate` típusúvá,
l. [JDBC LocalDate mintakód, getDate(int).toLocalDate()].

Az Oracle adatbázis `Date` típusa másodperc felbontású időpontot tartalmaz,
amit hagyományosan a [java.sql.Timestamp] kezel, az új API-ban pedig
a [LocalDateTime][java.time.LocalDateTime] osztály való erre.
[ResultSet][java.sql.ResultSet] eredményhalmazból lekérdezésére
l. [JDBC LocalDate mintakód, getTimestamp(int).toLocalDateTime()].

Generált kulcsmezők lekérdezése SQL `INSERT` után
-------------------------------------------------

Új rekord beillesztésekor a mesterséges kulcsot gyakran az adatbáziskezelő
generálja. Oracle Database esetén ez tipikusan ún. *sequence* objektumra
alapozva történik az insert utasításban szereplő explicit `sequence.nextval` hívással,
vagy a táblán definiált triggerrel.
Az Oracle Database 12cR1 verzióban bevezetett ún. *identity* oszlop mögött
is egy sequence objektum húzódik meg.
Gyakori igény, hogy rekord beszúrása után lekérdezzük a létrejött rekord
generált kulcsmezőjét.

A különböző SQL nyelvjárások erre különböző lehetőséget adnak,
a JDBC API 3.0 verziója azonban bevezetett erre egy gyártófüggetlen interfészt.
Ebben egy `String` tömb formájában megadható, hogy az `INSERT` utasítás
végrehajtása után a rekord melyik mezőit szeretnénk visszakapni.
Megjegyzés: a megoldásnak bár vannak korlátai, nem csak generált
mesterséges kulcs lekérdezésére használható.

A [JDBC LocalDate mintakód] erre vonatkozóan is tartalmaz példát.
A három legfontosabb metódus:

 1. Az [`int java.sql.Statement.executeUpdate(String, String[])`] hívás egy `INSERT` utasítás
    végrehajtása után a második paraméterben kért oszlopok értékeit teszi elérhetővé.
 2. A [`PreparedStatement java.sql.Connection.prepareStatement(String, String[])`]
    metódus olyan `PreparedStatement` objektumot ad vissza, amely az `INSERT`
    végrehajtása után - (1)-hez hasonlóan - a második paraméterben szereplő oszlopok
    értékeit teszi elérhetővé.
    L. a mintakód [prepareStatement][getGeneratedKeys mintakód, prepareStatement] hívásánál.
 3. A [`ResultSet java.sql.Statement.getGeneratedKeys()`] a végrehajtás után
    adja vissza az (1) ill. (2) során kért és elérhetővé tett mezőket
    egy [ResultSet][java.sql.ResultSet] formájában.
    L. a mintakód [generált kulcsokat lekérdező ciklusában][getGeneratedKeys mintakód, getGeneratedKeys].


**Jó munkát!**

[1]: https://blogs.oracle.com/java-platform-group/entry/new\_security\_requirements\_for\_rias
[2]: https://blogs.oracle.com/java-platform-group/entry/upcoming_exception_site_list_in
[3]: http://www.java.com/en/download/help/plugin_cache.xml
[JavaFX Tutorial]: http://docs.oracle.com/javafx/2/get_started/fxml_tutorial.htm
[FXML bevezető]: http://docs.oracle.com/javafx/2/api/javafx/fxml/doc-files/introduction_to_fxml.html

[JEP 150]: http://openjdk.java.net/jeps/150
[JEP 170]: http://openjdk.java.net/jeps/170
[java.util.Calendar]: http://docs.oracle.com/javase/8/docs/api/java/util/Calendar.html
[java.util.Date]: http://docs.oracle.com/javase/8/docs/api/java/util/Date.html
[java.util.TimeZone]: http://docs.oracle.com/javase/8/docs/api/java/util/TimeZone.html
[java.sql.Date]: http://docs.oracle.com/javase/8/docs/api/java/sql/Date.html
[java.sql.ResultSet]: http://docs.oracle.com/javase/8/docs/api/java/sql/ResultSet.html
[java.sql.Time]: http://docs.oracle.com/javase/8/docs/api/java/sql/Time.html
[java.sql.Timestamp]: http://docs.oracle.com/javase/8/docs/api/java/sql/Timestamp.html
[java.time]: https://docs.oracle.com/javase/8/docs/api/java/time/package-summary.html
[java.time.LocalDate]: http://docs.oracle.com/javase/8/docs/api/java/time/LocalDate.html
[java.time.LocalDateTime]: http://docs.oracle.com/javase/8/docs/api/java/time/LocalDateTime.html
[java.time.LocalTime]: http://docs.oracle.com/javase/8/docs/api/java/time/LocalTime.html
[java.time.MonthDay]: http://docs.oracle.com/javase/8/docs/api/java/time/MonthDay.html
[`<T> ResultSet.getObject(int, Class<T>)`]: http://docs.oracle.com/javase/8/docs/api/java/sql/ResultSet.html#getObject-int-java.lang.Class-
[`void PreparedStatement.setObject(int, Object)`]: http://docs.oracle.com/javase/8/docs/api/java/sql/PreparedStatement.html#setObject-int-java.lang.Object-
[JDBC LocalDate mintakód]: https://gist.github.com/jmarton/5320cbcfa8a382c83ae2ae28d77d4237?ts=2
[JDBC LocalDate mintakód, setDate]: https://gist.github.com/jmarton/5320cbcfa8a382c83ae2ae28d77d4237?ts=2#file-localdatetestjdbc-java-L82
[JDBC LocalDate mintakód, getDate(int).toLocalDate()]: https://gist.github.com/jmarton/5320cbcfa8a382c83ae2ae28d77d4237?ts=2#file-localdatetestjdbc-java-L122
[JDBC LocalDate mintakód, getTimestamp(int).toLocalDateTime()]: https://gist.github.com/jmarton/5320cbcfa8a382c83ae2ae28d77d4237?ts=2#file-localdatetestjdbc-java-L123
[`int java.sql.Statement.executeUpdate(String, String[])`]: http://docs.oracle.com/javase/8/docs/api/java/sql/Statement.html#executeUpdate-java.lang.String-java.lang.String:A-
[`ResultSet java.sql.Statement.getGeneratedKeys()`]: http://docs.oracle.com/javase/8/docs/api/java/sql/Statement.html#getGeneratedKeys--
[`PreparedStatement java.sql.Connection.prepareStatement(String, String[])`]: http://docs.oracle.com/javase/8/docs/api/java/sql/Connection.html#prepareStatement-java.lang.String-java.lang.String:A-
[getGeneratedKeys mintakód, prepareStatement]: https://gist.github.com/jmarton/5320cbcfa8a382c83ae2ae28d77d4237?ts=2#file-localdatetestjdbc-java-L56-L57
[getGeneratedKeys mintakód, getGeneratedKeys]: https://gist.github.com/jmarton/5320cbcfa8a382c83ae2ae28d77d4237?ts=2#file-localdatetestjdbc-java-L103-L110
