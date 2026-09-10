---
layout: page
title: Adatbáziskezelés (VITMA027)
---
A TTK matematika szakos BSc hallgatói számára.

A tárgy kódja 2021. őszétől kezdve VITMA027, a tantárgy adatlap [itt](https://portal.vik.bme.hu/kepzes/targyak/VITMA027/) található. 

   A vizsga anyaga alapvetően az Adatbázisok c. jegyzetben található meg, természetesen kiegészítve azzal, ami az előadásokon vagy a gyakorlatokon elhangzott. A jegyzetből mindent kell tudni, kivéve a hálós adatmodellt (7),az objektum-orientált adatbázis-kezelő rendszereket (8), a többértékű függőségeket (9.2.8) és a tranzakciókezelést (10).

Felkészülési segédanyagok, javaslat:

 - Jegyzet: Gajdos S.: Adatbázisok 2019-2025. Az ezt megelőző évek kiadásai szintén használhatók, viszont 2015. után a legkevesebb sajtóhibát az egyre későbbi kiadások tartalmaznak.  
   Letölthető a jegyzet [innen](https://db.bme.hu/~gajdos/Adatbazisok2019.pdf).
 - Ajánlott: The Social Dilemma, Netflix 2020, megnézhető pl. [itt](https://videa.hu/videok/film-animacio/tarsadalmi-dilemma-the-social-2020-94-perc-filmdrama-gwsTG8mnV5dgwgd5).
 - A tantárgy adatlapban jelzett tankönyveken túlmenően  javasolt a jegyzet feladatgyűjteménye releváns részének  önálló feldolgozása, továbbá – kellő körültekintéssel – használhatóak a [Wiki Adatbázisok oldalai](https://wiki.sch.bme.hu/Adatb%C3%A1zisok) és az ott olvasható [tippek](https://wiki.sch.bme.hu/Adatb%C3%A1zisok#Tippek) is.
 - Rossz módszer: típusfeladatok megoldásának betanulása. Ez garantáltan nem lesz eredményes, ha nem párosul az elmélet elmélyült megértésével és alkalmazásának képességével. Mivel a vizsgán az alkotóképes tudást kívánjuk lemérni, ezért teljesen felesleges egy áttanult éjszaka után vizsgával próbálkozni. A memóriából előhívott emléktöredékek a sikeres vizsgához nem elegendőek.
 - [Gyakran ismételt kérdések](../adatbazisok/files/AB_GYIK_v1.3.pdf) a tanulásról
 - [Gyakorlóalkalmazás](files/gyakorlo.zip)


## Félév-specifikus információk
### 2025. õsz

A tárgyhoz - dinamikus ütemezéssel - kiscsoportos gyakorlatok, ill. számítógépes laboratóriumi foglalkozások is tartoznak, az előadások előrehaladásának függvényében. Minden előadás/gyakorlat/labor az IL105 laborban lesz. 

#### Laborok

A laborokon felkészülten kell részt venni. A laborokhoz szükséges felkészülési és egyéb anyagok [ITT](../adatbazisok/labor) találhatók. Egyetlen labor sem mulasztható, a laborvezetõ beugrót írat, a laborok teljesítésének feltétele a beugró sikeressége. A beugrók általában a laborhoz kapcsolódó ELMÉLETI ISMERETEKBŐL tartalmaznak kérdéseket, hiszen itt a cél nem programozási készség megszerzése, hanem annak a bemutatása, hogy a tanult elmélet (egy része) hogyan jelenik meg a gyakorlatban. Laborpótlás a pótlási héten lesz mindegyik labor esetén azok számára, akik legfeljebb egy kötelezõ labort nem teljesítettek bármely okból kifolyólag.  A pontos hely és a pótlás szükségessége a [Laboradmin rendszerbõl](https://fecske.db.bme.hu) fog kiderülni, ezt kérjük, hogy mindenki ellenõrizze, és bármilyen eltérést mielõbb jelezzen a tárgyfelelõsnek a gajdos_at_db.bme.hu cimen. A pótlaborok azonosak a reguláris laborokkal, kivéve, hogy mindenki egy számára új feladattípushoz tartozó feladatsort fog kapni.
 
#### Gyakorlatok
 
A gyakorlatokon is felkészülten kell megjelenni. A gyakorlatvezetõ a részvételt ellenõrzi, kiszárthelyiket írathat a felkészülés tesztelésére. Ezek elsõsorban a hallgatóknak szolgálnak visszacsatolásul, hogy az elõismereteik megfelelõk-e a gyakorlatok anyagának hatékony elsajátításához.  A gyakorlatokhoz szükséges feladatsorok és egyéb tudásfoszlányok [ITT](../adatbazisok/gyakorlat) érhetõk el, a kisZH-eredmények pedig [ITT](../adatbazisok/eredmenyek)). A gyakorlatokon nem adunk ki papíralapú segédanyagokat, így a feladatsort valamilyen formában mindenki vigye magával az órára.

#### Vizsgák

 - Anyaga: lásd fentebb.
 - A vizsgák beugróval kezdõdnek. Öt [fogalomból](https://db.bme.hu/~gajdos/Fogalomjegyzek.doc) (ld. a jegyzetben "A fejezet új fogalmai" c. szakaszokat) kell legalább hármat helyesen definiálni/értelmezni ahhoz, hogy a vizsga a szóbelivel folytatható legyen, ellenkező esetben a vizsga elégtelen. A szóbeli vizsgán tételt kell húzni, a felkészülésre kb. 15 perc áll rendelkezésre. Lehetõség szerint – de nem törvényszerûen – a hallgatók a gyakorlatvezetõiknél szóbeliznek, akik a teljes tananyagból tetszõleges sorrendben is tesznek fel kérdéseket, hogy a hallgató felkészültségérõl, leginkább a tananyag _megértésérõl_ meggyõzõdjenek.<br>
 - A vizsga értékelése:<br>
   **Jeles:** ha a hallgató a teljes tananyagot alaposan és összefüggéseiben ismeri, és ismereteit önállóan és biztosan tudja alkalmazni.<br>
   **Jó:** ha a hallgató a teljes tananyagot alaposan ismeri, és ismereteit biztonságosan tudja alkalmazni. <br>
   **Közepes:** ha a hallgató a tananyag lényeges részeit jól ismeri, és ismereteit megfelelő biztonsággal tudja alkalmazni. <br>
   **Elégséges:** ha a hallgató a tananyag lényeges részeit elfogadható módon ismeri, és az ismeretek alkalmazásában elfogadható jártasságot mutat. <br>
   **Elégtelen:** ha a hallgató a továbbhaladáshoz vagy a szakmájának gyakorlásához feltétlenül szükséges elméleti és gyakorlati ismeretekkel nem rendelkezik. <br>
 - Akiknek bármely méltánylandó okból már decemberben vizsgázniuk kell, lépjenek kapcsolatba a tárgyfelelõssel.
 - Januárban szinte minden nap lesz vizsgalehetõség, ez azonban nem jelenti azt, hogy egymás utáni napokon is érdemes próbálkozni. A tapasztalat azt mutatja, hogy a megismételt vizsga sikerességéhez érdemes két vizsgakísérlet között legalább három napnak eltelnie.
 - A szóbeli vizsgán nem szükséges alkalmi öltözetben megjelenni, de az igényesség és ápoltság itt is elvárt. 

