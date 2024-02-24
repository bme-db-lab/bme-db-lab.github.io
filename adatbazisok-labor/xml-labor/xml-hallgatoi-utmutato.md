---
layout: page
title: XML labor hallgatói útmutató
author: Marton József
---

Hallgatói útmutató az XML/XSLT méréshez

Környezet kialakítása a Rapid szerveren
=======================================

A minta alkalmazás a következő módon tölthető le és állítható be legegyszerűbben a Rapid szerveren, SSH kliensen (pl. PuTTY) keresztül történő belépés után.

```shell
export EXERCISE_CATEGORY_NAME=HAJO
curl -L https://db.bme.hu/r/xml/demo | sh
```

A fenti első parancsba helyettesítse be a feladattípusa nevét, pl. `HAJO` a *Hajózási felügyelet* c. feladatsor esetén. A parancsok futtatása során az aktuális könyvtárban létrejön egy `xml` nevű, mely tartalmazza a példaprogram legfrissebb verzióját.

A példaprogram futtatása a `SHIP.xml` alapértelmezett adatforrással:

```shell
scons
```

A saját megoldás elkészítése után a futtatáshoz meg kell adni az adatforrás (data source) nevét, ami megegyezik a feladattípus nagybetűs nevével, pl. `HAJO` feladatsor esetén:

```shell
scons DS=HAJO
```

A build eredményének törlése során szintén illik megadni a feladattípus nagybetűs nevét, pl. `HAJO` feladatsor esetén:

```shell
scons DS=HAJO -c
```


Az adatforrás
=============

Az XML adatforrások az SQL sémainicializáló szkriptek által létrehozott adatbázis egy XML reprezentációját tartalmazzák. Elérhetősége megtalálható a feladatlapon.

## Az XML szerkezete

 * a tag és attribútumnevek kisbetűsek
 * a feladattípus/tábla/rekord/mező hierarchiát egy  
   `/[@element-type="dataset"]/[@element-type="recordset"]/record[@element-type="record"]/*`  
   szerkezetű DOM tartalmazza
 * a gyökérelem neve a feladatsor rövid neve
 * a feladattípus minden táblájának egy `/*/[@element-type="recordset"]` részfa felel meg
 * a rekord egyszerű kulcsa a `record` tag XML attribútumaként jelenik meg, neve a mező nevével egyezik
 * a rekord többi mezője a mezőnév szerinti gyerekelemekben foglal helyet, melyben
    * egy `@is-null="False|True"` attribútum jelzi, hogy null van-e benne
    * date típusú, nem null értékű mező esetén `@date` és `@time` tartalmazza az ISO formátum szerinti dátum és óra-perc-másodperc komponenst
    * a többi típus esetén a tag tartalmában szerepel a mező értéke, ha az nem null

Beadandó anyagok
================

Az elvárt formátum, a korábbi mérésekhez hasonlóan, kötött. A beadott tömörített állományban az alábbi könyvtárstruktúrát várjuk el:

```
NEPTUN-5-CSOPKOD.zip:
  NEPTUN-5-CSOPKOD/
    NEPTUN-5-CSOPKOD.pdf
    lab5xml.zip
```

A `lab5xml.zip` fájlt a rapidon történő build során hozza létre a SCons,
és abba belekerülnek a `src/` könyvtárban szereplő forrásfájlok valamint
a `web/` könyvtárban létrejövő kimeneti fájlok.
A lényeg, hogy a `lab5xml.zip` fájlt kicsomagolva a munka futtatható legyen
a példaprogramban szereplő `SConstruct` fájl és a `lib/saxon9he.jar`
 osztálykönyvtár segítségével.

Formai követelmények
--------------------

 - Az összes forrásfájl és kimeneti fájl karakterkódolása kötelezően `UTF-8`

Értékelési szempontok
---------------------

 - A megoldásnak a példaprogramban szereplő, scons alapú verzérlőszkripttel
   a feladathoz tartozó adatforrással azonos szerkezetű és szemantikájú,
   de különböző tartalmú adatforráson is helyesen kell működnie.
 - A szintaktikai hibát tartalmazó forráskód nem értékelhető.
 - A feladatokban előírt formátumtól eltérő megoldás nem értékelhető.
 - A formai követelményeket sértő jegyzőkönyv nem értékelhető.

Szemelvények az XSL világából
=============================

Ebben a részben vázlatosan ismertetünk néhány olyan témát, ami a hallgatói segédletből
kimaradt, de hasznos lehet a mérés elvégzése során.

Az [XSL] az ún. Extensible Stylesheet Language rövidítése, ami valójában egy *nyelv család*
az XML dokumentumok transzformálása és megjelenítése során fellépő feladatokra. Három része:

 1. az [XSLT] (XSL Transformations) az XML transzformációk leírására szolgáló nyelv,
 2. az [XPath] (XML Path) egy, az XML dokumentum részeire történő hivatkozások leírására szolgáló nyelv, és a
 3. az [XSL-FO] (XSL Formatting Objects) az XML dokumentumok formázásával kapcsolatos elvrások leírására szolgáló
    szókészlet, mely részben hasonlít a CSS-re, de a szintaxisa különböző.

A laboron használt XSLT feldolgozó a [Saxon], amelynek *9.7 home edition* változata
az XSLT (2.0), XQuery (1.0, 3.0, és 3.1), and XPath (2.0, 3.0, és 3.1) nyelveket
támogatja a [W3C] által definiált ún. basic (alapvető) szinten.

## Navigáció az XML dokumentum csomópontjai között XPath segítségével

A magyarázat során az alábbi példa XML-t használjuk, melyben, az egyszerűség kedvéért
minden tag csak egyszer fordul elő, és a nevével a példányt hivatkozzuk.

```xml
<?xml version='1.0' encoding='UTF-8'?>
<vehicles>
  <ship ship_id="209">
    <name>Rabonbán II.</name>
    <built date="1936-01-01" />
    <type>sailing boat</type>
  </ship>
</vehicles>
```

Az XML dokumentumok ún. csomópontokból állnak, melyek lehetnek

 - elem típusúak: ezek az XML tag-ek példányai, a példában `ship`, `type` stb.
 - attribútum típusúak, a példában `ship_id` és `date`
 - szöveges csomópontok, a példában `sailing boat` ill. a `name` és a `built` közötti köz (szóköz, újsor karakter)

Az egyes csomópontokokból alkotott rendezett párok egymáshoz való viszonya az ún. *axis*. Néhány példa:

 - *child* (gyerek): (ship, name)
 - *parent* (szülő): (name, ship)
 - *descendant* (leszármazott): (vehicles, ship), (vehicles, name)
 - *ancestor* (felmenő): (ship, vehicles), (name, vehicles)
 - *attribute* (attribútum): (ship, ship_id)
 - *following-sibling*: (name, built)
 - *preceding-sibling*: (built, name)

Az XPath kifejezések kiértékelése mindig egy csomópont kontextusában történik.
A kontextus csomomópontból történő tovább-navigálás két részből áll: meg kell adni a
követendő viszonyt, és hogy az adott viszonyban álló csomópontok közül melyiket keressük.
A minta dokumentum `ship` elem típusú csomópontjának kontextusában például:

 - `child::built` a `built` nevű gyerek
 - `child::*` az összes gyerek
 - `attribute::ship_id` a `ship_id` nevű attribútum

Ha nem adjuk meg explicit a követendő viszonyt, akkor a `child` viszony a navigáció iránya.
Az `attribute::` viszony a `@` előtaggal rövidíthető, tehát `@*` az összes attribútum,
`@ship_id` pedig az adott nevű attribútum.

## Különbség az XPath `node()` és a `*` között

 - A `node()` minden csomópontot kijelöl, ami a megadott viszonyban áll.
 - A `*` azokat a csomópontokat jelöli ki, ami a megadott viszony szerint elsődleges típusú.
   Elsődleges típusú:
    - a `child` viszonyban az elem típusú csomópont
    - az `attribute` viszonyban az attribútum típusú csomópont
 - A `text()` a megadott viszonyban álló szöveges csomópontokat jelöli ki.
   Az `attribute` viszonyon keresztül ilyen nem érhető el.

A `*` és a `node()` között az `attribute` viszony esetén nincs különbség.
A `child` viszonyban a `node()` a szöveges és elem típusú gyerekcsomópontokra is illeszkedik,
a `*` csak az elem típusú gyerekcsomópontokra, tehát a különbség a `text()` által kijelölt,
szöveges csomópontok halmaza.

Az előző szakaszban szereplő példán az alábbi XSL stílusfájllal szemléltetjük
a különbséget, amelynek a kiíró sablonját a 209-es hajót leíró csomópontból elérhető
különböző csomópontokra hívjuk meg.

A kiíró sablon `#` jelekkel elválasztva kiírja

 - a feldolgozott csomópont nevét (szöveges csomópontok esetés üres)
 - `[` és `]` közé zárva a csomópont értékét

```xml
<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:functx="http://www.functx.com"
  xmlns:xs="http://www.w3.org/2001/XMLSchema"
  version="1.0">

  <xsl:output method="text" />

  <xsl:template match="/">

attribute::* - az attribútumai, röviden: @*
====================================================================
<xsl:apply-templates select="//ship[@ship_id='209']/attribute::*" />

attribute::node() - az attribútum viszonyban álló minden csomópont
====================================================================
<xsl:apply-templates select="//ship[@ship_id='209']/attribute::node()" />

child::* - az elem típusú gyerekcsomópontok, röviden: *
====================================================================
<xsl:apply-templates select="//ship[@ship_id='209']/child::*" />

child::text() - a szöveges típusú gyerekcsomópontok, röviden: text()
====================================================================
<xsl:apply-templates select="//ship[@ship_id='209']/child::text()" />

child::node() - minden gyerekcsomópont, röviden: node()
====================================================================
<xsl:apply-templates select="//ship[@ship_id='209']/child::node()" />
  </xsl:template>

<!-- kiíró sablon -->
<xsl:template match="child::node()|attribute::node()"
>#<xsl:value-of select="name()" />#[<xsl:value-of select="." />]
</xsl:template>

</xsl:stylesheet>
```

A stílusfájl alkalmazásával nyert kimeneten figyeljük meg,
hogy a `ship[@ship_id='209']` csomópontnak

 - három elem típusú gyerekcsomópontja van
 - négy szöveges típusú gyerekcsomópontja van (az első gyerek előtt,
   az utolsó után és az egymást követő gyerekek között)
 - összesen hét csomópont érhető el `child` viszonyon keresztül.

```
attribute::* - az attribútumai, röviden: @*
====================================================================
#ship_id#[209]


attribute::node() - az attribútum viszonyban álló minden csomópont
====================================================================
#ship_id#[209]


child::* - az elem típusú gyerekcsomópontok, röviden: *
====================================================================
#name#[Rabonbán II.]
#built#[]
#type#[sailing boat]


child::text() - a szöveges típusú gyerekcsomópontok, röviden: text()
====================================================================
##[
    ]
##[
    ]
##[
    ]
##[
  ]


child::node() - minden gyerekcsomópont, röviden: node()
====================================================================
##[
    ]
#name#[Rabonbán II.]
##[
    ]
#built#[]
##[
    ]
#type#[sailing boat]
##[
  ]
```


[Saxon]: http://saxon.sourceforge.net/
[W3C]: https://www.w3.org/
[XSL]: https://www.w3.org/Style/XSL/
[XSLT]: https://www.w3.org/TR/xslt
[XPath]: https://www.w3.org/TR/xpath
[XSL-FO]: https://www.w3.org/TR/xsl
