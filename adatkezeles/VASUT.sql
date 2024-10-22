DROP TABLE megall CASCADE CONSTRAINTS PURGE;
DROP TABLE allomas CASCADE CONSTRAINTS PURGE;
DROP TABLE jarat CASCADE CONSTRAINTS PURGE;
DROP TABLE varos CASCADE CONSTRAINTS PURGE;

-- jarat tábla létrehozása
CREATE TABLE jarat (
    jarat_szam NUMBER(5,0) NOT NULL,
    tipus NVARCHAR2(7) NOT NULL,
    nap VARCHAR2(7) DEFAULT '1111111' NOT NULL,
    kezd DATE,
    vege DATE,
    megjegyzes NVARCHAR2(40),
    CONSTRAINT "JARAT_KOD_PK" PRIMARY KEY(jarat_szam),
    CONSTRAINT "JARAT_TIPUS_CK" CHECK (tipus IN ('Szemely','Gyors','IC','EC')),
    CONSTRAINT "JARAT_DATUM_CK" CHECK (kezd < vege
                                       OR vege IS NULL)
);

-- allomas tábla létrehozása
CREATE TABLE allomas (
     id number(5,0),
     nev NVARCHAR2(40) NOT NULL,
     varos NVARCHAR2(40),
     atlagutas NUMBER(5,0) DEFAULT 0 NOT NULL,
     sztrajkutas NUMBER(5,0) DEFAULT 0 NOT NULL,
     CONSTRAINT "ALLOMAS_ID_PK" PRIMARY KEY(id)
);

-- megall tábla létrehozása
CREATE TABLE megall (
    id NUMBER(5,0) NOT NULL,
    jarat_szam NUMBER(5,0) NOT NULL,
    allomas_id NUMBER(6,0) NOT NULL,
    erk NUMBER(4,0),
    ind NUMBER(4,0),
    CONSTRAINT "MEGALL_ID_PK" PRIMARY KEY(id),
    CONSTRAINT "MEGALL_JARAT_FK" FOREIGN KEY(jarat_szam) REFERENCES jarat(jarat_szam),
    CONSTRAINT "MEGALL_ALLOMAS_FK" FOREIGN KEY(allomas_id) REFERENCES allomas(id),
    CONSTRAINT "MEGALL_ERK_CK" CHECK (FLOOR(erk/100)<=23 AND MOD(erk,100)<=59 AND erk>=0),
    CONSTRAINT "MEGALL_IND_CK" CHECK (FLOOR(ind/100)<=23 AND MOD(ind,100)<=59 AND ind>=0),
    CONSTRAINT "MEGALL_ERK_IND_CK" CHECK (erk<ind),
    CONSTRAINT "MEGALL_ERK_IND_NOTNULL_CK" CHECK (erk IS NOT NULL OR ind IS NOT NULL)
);

-- Járatok
INSERT INTO jarat VALUES (213,'EC','0100100',null,null,null);
INSERT INTO jarat VALUES (214,'EC','0010010',null,null,null);
INSERT INTO jarat VALUES (327,'IC','1111000',null,TO_DATE('2022-10-31','YYYY-MM-DD'),null);
INSERT INTO jarat VALUES (328,'IC','1111000',null,TO_DATE('2022-10-31','YYYY-MM-DD'),null);
INSERT INTO jarat VALUES (553,'IC','0010100',TO_DATE('2022-01-01','YYYY-MM-DD'),TO_DATE('2022-08-31','YYYY-MM-DD'),'Büfé nélkül');
INSERT INTO jarat VALUES (554,'IC','1010100',TO_DATE('2022-01-01','YYYY-MM-DD'),TO_DATE('2022-08-31','YYYY-MM-DD'),'Büfé nélkül');
INSERT INTO jarat VALUES (469,'IC','0000101',null,null,null);
INSERT INTO jarat VALUES (470,'IC','0000101',null,null,null);
INSERT INTO jarat VALUES (163,'IC','1111111',null,null,null);
INSERT INTO jarat VALUES (164,'IC','1111111',null,null,null);
INSERT INTO jarat VALUES (2113,'Gyors','1110000',TO_DATE('2022-11-01','YYYY-MM-DD'),null,'új járat');
INSERT INTO jarat VALUES (4581,'Szemely','1111111',null,null,null);
INSERT INTO jarat VALUES (6666,'IC','1110011',null,null,null);
INSERT INTO jarat VALUES (9567,'Szemely','1111111',null,null,null);
INSERT INTO jarat VALUES (3323,'Szemely','1000000',null,null,'lassú');
INSERT INTO jarat VALUES (1145,'Gyors','1111111',null,null,null);
INSERT INTO jarat VALUES (1146,'Gyors','1111111',null,null,'büdös');
INSERT INTO jarat VALUES (2265,'IC','1111100',null,null,null);
INSERT INTO jarat VALUES (2266,'IC','1111100',null,null,null);

-- Állomások
INSERT INTO allomas VALUES (1,'Budapest-Keleti','Budapest',40000,2000);
INSERT INTO allomas VALUES (2,'Budapest-Nyugati','Budapest',30000,2000);
INSERT INTO allomas VALUES (3,'Budapest-Déli','Budapest',40000,2000);
INSERT INTO allomas VALUES (4,'Budapest-Kelenföld','Budapest',10000,1000);
INSERT INTO allomas VALUES (5,'Budapest-Ferencváros','Budapest',10000,1000);
INSERT INTO allomas VALUES (6,'Törökbálint','Törökbálint',6000,200);
INSERT INTO allomas VALUES (7,'Biatorbágy','Biatorbágy',6000,200);
INSERT INTO allomas VALUES (8,'Bicske','Bicske',6000,200);
INSERT INTO allomas VALUES (9,'Tatabánya','Tatabánya',10000,300);
INSERT INTO allomas VALUES (10,'Vértesszõlõs','Vértesszõlõs',1000,200);
INSERT INTO allomas VALUES (11,'Tata','Tata',10000,200);
INSERT INTO allomas VALUES (12,'Almásfüzitõ','Almásfüzitõ',2000,100);
INSERT INTO allomas VALUES (13,'Komárom','Komárom',15000,300);
INSERT INTO allomas VALUES (14,'Ács','Ács',1500,100);
INSERT INTO allomas VALUES (15,'Gyõr','Gyõr',20000,400);
INSERT INTO allomas VALUES (16,'Hegyeshalom','Hegyeshalom',1700,100);
INSERT INTO allomas VALUES (17,'Wien-Südbahnhof','Bécs',40000,1400);

INSERT INTO allomas VALUES (18,'Enese','Enese',1000,100);
INSERT INTO allomas VALUES (19,'Kóny','Kóny',2000,100);
INSERT INTO allomas VALUES (20,'Csorna','Csorna',1000,100);
INSERT INTO allomas VALUES (21,'Kapuvár','Kapuvár',1000,100);
INSERT INTO allomas VALUES (22,'Fertõszentmiklós','Fertõszentmiklós',1000,100);
INSERT INTO allomas VALUES (23,'Balf','Balf',1000,100);
INSERT INTO allomas VALUES (24,'Sopron','Sopron',10000,100);

INSERT INTO allomas VALUES (25,'Dunakeszi','Dunakeszi',3000, 200);
INSERT INTO allomas VALUES (26,'Göd','Göd',2500,250);
INSERT INTO allomas VALUES (27,'Szõdliget','Szõdliget',1500,100);
INSERT INTO allomas VALUES (28,'Vác','Vác',3000,300);
INSERT INTO allomas VALUES (29,'Verõcemaros','Verõcemaros',2000,100);
INSERT INTO allomas VALUES (30,'Nagymaros','Nagymaros',1500,100);
INSERT INTO allomas VALUES (31,'Zebegény','Zebegény',1000,100);
INSERT INTO allomas VALUES (32,'Szob','Szob',2300,100);
INSERT INTO allomas VALUES (33,'Debrecen','Debrecen',20000,500);
INSERT INTO allomas VALUES (34,'Elhagyatott','Elhagyatott', 0, 0);
INSERT INTO allomas VALUES (35,'Kisalföld szervíz', null, 0, 0);
INSERT INTO allomas VALUES (36,'Szervíz', null, 0, 0);

INSERT INTO allomas VALUES (37,'Székesfehérvár', 'Székesfehérvár', 8000, 300);
INSERT INTO allomas VALUES (38,'Siófok', 'Siófok', 6000, 200);
INSERT INTO allomas VALUES (39,'Keszthely', 'Keszthely', 5000, 200);
INSERT INTO allomas VALUES (40,'Zalaegerszeg', 'Zalaegerszeg', 8000, 400);
INSERT INTO allomas VALUES (41,'Szombathely', 'Szombathely', 9000, 400);

-- Megállók
-- BP-Keleti -> BP-Kelenföld -> Györ -> Hegyeshalom -> Wien
INSERT INTO megall VALUES (1,213,1,null,0900);
INSERT INTO megall VALUES (2,213,4,0915,0920);
INSERT INTO megall VALUES (3,213,15,1025,1028);
INSERT INTO megall VALUES (4,213,16,1043,1045);
INSERT INTO megall VALUES (5,213,17,1145,null);
-- Wien -> Hegyeshalom -> Györ -> BP-Kelenföld -> BP-Keleti
INSERT INTO megall VALUES (6,214,17,null,1400);
INSERT INTO megall VALUES (7,214,16,1500,1502);
INSERT INTO megall VALUES (8,214,15,1535,1540);
INSERT INTO megall VALUES (9,214,4,1630,1635);
INSERT INTO megall VALUES (10,214,1,1650,null);
-- Bp-Keleti -> Bp-Kelenföld -> Tatabánya -> Komárom -> Györ -> Csorna -> Sopron
INSERT INTO megall VALUES (11,327,1,null,1115);
INSERT INTO megall VALUES (12,327,4,1130,1137);
INSERT INTO megall VALUES (13,327,9,1223,1226);
INSERT INTO megall VALUES (14,327,13,1242,1245);
INSERT INTO megall VALUES (15,327,15,1306,1310);
INSERT INTO megall VALUES (16,327,20,1338,1340);
INSERT INTO megall VALUES (17,327,24,1420,null);
-- Sopron -> Csorna -> Györ -> Komárom -> Tatabánya -> Bp-Kelenföld -> Bp-Keleti
INSERT INTO megall VALUES (18,328,24,null,1520);
INSERT INTO megall VALUES (19,328,20,1600,1605);
INSERT INTO megall VALUES (20,328,15,1632,1635);
INSERT INTO megall VALUES (21,328,13,1655,1658);
INSERT INTO megall VALUES (22,328,9,1731,1734);
INSERT INTO megall VALUES (23,328,4,1815,1820);
INSERT INTO megall VALUES (24,328,1,1835,null);
-- BP-Nyugati -> Dunakeszi -> Göd -> Szõdliget -> Vác -> Veröcemaros
-- -> Nagymaros -> Zebegény -> Szob
INSERT INTO megall VALUES (25,9567,2,null,1120);
INSERT INTO megall VALUES (26,9567,25,1145,1200);
INSERT INTO megall VALUES (27,9567,26,1223,1230);
INSERT INTO megall VALUES (28,9567,27,1250,1300);
INSERT INTO megall VALUES (29,9567,28,1320,1335);
INSERT INTO megall VALUES (30,9567,29,1400,1410);
INSERT INTO megall VALUES (31,9567,30,1440,1443);
INSERT INTO megall VALUES (32,9567,31,1507,1510);
INSERT INTO megall VALUES (33,9567,32,1535,null);
-- Bp-Keleti -> Bp-Kelenföld -> Tatabánya -> Komárom -> Györ -> Csorna -> Sopron
INSERT INTO megall VALUES (34,469,1,null,1115);
INSERT INTO megall VALUES (35,469,4,1130,1137);
INSERT INTO megall VALUES (36,469,9,1223,1226);
INSERT INTO megall VALUES (37,469,13,1242,1245);
INSERT INTO megall VALUES (38,469,15,1306,1310);
INSERT INTO megall VALUES (39,469,20,1338,1340);
INSERT INTO megall VALUES (40,469,24,1420,null);
-- Sopron -> Csorna -> Györ -> Komárom -> Tatabánya -> Bp-Kelenföld -> Bp-Keleti
INSERT INTO megall VALUES (41,470,24,null,1520);
INSERT INTO megall VALUES (42,470,20,1600,1605);
INSERT INTO megall VALUES (43,470,15,1632,1635);
INSERT INTO megall VALUES (44,470,13,1655,1658);
INSERT INTO megall VALUES (45,470,9,1731,1734);
INSERT INTO megall VALUES (46,470,4,1815,1820);
INSERT INTO megall VALUES (47,470,1,1835,null);
-- Bp-Déli -> Bp-Kelenföld -> Tatabánya -> Komárom -> Györ
INSERT INTO megall VALUES (48,163,3,null,1225);
INSERT INTO megall VALUES (49,163,4,1230,1237);
INSERT INTO megall VALUES (50,163,9,1323,1326);
INSERT INTO megall VALUES (51,163,13,1342,1345);
INSERT INTO megall VALUES (52,163,15,1406,null);
-- Györ -> Komárom -> Tatabánya -> Bp-Kelenföld -> Bp-Déli
INSERT INTO megall VALUES (53,164,15,null,1735);
INSERT INTO megall VALUES (54,164,13,1755,1758);
INSERT INTO megall VALUES (55,164,9,1831,1834);
INSERT INTO megall VALUES (56,164,4,1915,1920);
INSERT INTO megall VALUES (57,164,3,1925,null);
-- Bp-Déli -> Bp-Kelenföld -> Tatabánya -> Komárom -> Györ
INSERT INTO megall VALUES (58,553,3,null,0725);
INSERT INTO megall VALUES (59,553,4,0730,0737);
INSERT INTO megall VALUES (60,553,9,0823,0826);
INSERT INTO megall VALUES (61,553,13,0842,0845);
INSERT INTO megall VALUES (62,553,15,0906,null);
-- Györ -> Komárom -> Tatabánya -> Bp-Kelenföld -> Bp-Déli
INSERT INTO megall VALUES (63,554,15,null,1235);
INSERT INTO megall VALUES (64,554,13,1255,1258);
INSERT INTO megall VALUES (65,554,9,1331,1334);
INSERT INTO megall VALUES (66,554,4,1415,1420);
INSERT INTO megall VALUES (67,554,3,1425,null);
-- Bp-Keleti -> Bp-Ferencváros -> Bp-Kelenföld -> Törökbálint -> Biatorbágy
-- -> Bicske -> Tatabánya -> Vértesszölös -> Tata -> Alamsfuzito -> Komárom
-- -> Ács -> Györ -> Ense -> Kóny -> Csorna -> Kapuvár -> Fertöszentmiklós
-- -> Balf -> Sopron
INSERT INTO megall VALUES (68,4581,1,null,1315);
INSERT INTO megall VALUES (69,4581,5,1320,1325);
INSERT INTO megall VALUES (70,4581,4,1335,1345);
INSERT INTO megall VALUES (71,4581,6,1400,1403);
INSERT INTO megall VALUES (72,4581,7,1418,1420);
INSERT INTO megall VALUES (73,4581,8,1432,1434);
INSERT INTO megall VALUES (74,4581,9,1449,1457);
INSERT INTO megall VALUES (75,4581,10,1510,1514);
INSERT INTO megall VALUES (76,4581,11,1522,1527);
INSERT INTO megall VALUES (77,4581,12,1540,1542);
INSERT INTO megall VALUES (78,4581,13,1557,1600);
INSERT INTO megall VALUES (79,4581,14,1608,1610);
INSERT INTO megall VALUES (80,4581,15,1625,1640);
INSERT INTO megall VALUES (81,4581,18,1703,1705);
INSERT INTO megall VALUES (82,4581,19,1713,1716);
INSERT INTO megall VALUES (83,4581,20,1732,1735);
INSERT INTO megall VALUES (84,4581,21,1755,1803);
INSERT INTO megall VALUES (85,4581,22,1814,1816);
INSERT INTO megall VALUES (86,4581,23,1830,1832);
INSERT INTO megall VALUES (87,4581,24,1847,null);
-- Bp-Nyugati -> Göd -> Vác -> Veröcemaros -> Zebegény
INSERT INTO megall VALUES (88,2113,2,null,1920);
INSERT INTO megall VALUES (89,2113,26,1923,1930);
INSERT INTO megall VALUES (90,2113,28,2020,2035);
INSERT INTO megall VALUES (91,2113,29,2100,2110);
INSERT INTO megall VALUES (92,2113,31,2145,null);
-- Bp-Keleti -> Debrecen
INSERT INTO megall VALUES (93,6666,1,null,2010);
INSERT INTO megall VALUES (94,6666,33,2245,null);
-- Budapest-Déli -> Szekesfehérvár -> Siófok -> Keszthely -> Zalaegerszeg
-- -> Szombathely -> Sopron
INSERT INTO megall VALUES (95,1145,3,null,0920);
INSERT INTO megall VALUES (96,1145,37,1010,1015);
INSERT INTO megall VALUES (97,1145,38,1115,1120);
INSERT INTO megall VALUES (98,1145,39,1215,1225);
INSERT INTO megall VALUES (99,1145,40,1358,1403);
INSERT INTO megall VALUES (100,1145,41,1445,1450);
INSERT INTO megall VALUES (101,1145,24,1530,null);
-- Sopron -> Szombathely -> Zalaegerszeg -> Keszthely -> Siófok ->
-- Szekesfehérvár -> Budapest-Déli
INSERT INTO megall VALUES (102,1146,24,null,1550);
INSERT INTO megall VALUES (103,1146,41,1630,1635);
INSERT INTO megall VALUES (104,1146,40,1715,1720);
INSERT INTO megall VALUES (105,1146,39,1750,1800);
INSERT INTO megall VALUES (106,1146,38,1900,1905);
INSERT INTO megall VALUES (107,1146,37,1955,2000);
INSERT INTO megall VALUES (108,1146,3,2100,null);
-- Budapest-Déli -> Györ -> Sopron -> Szombathely
INSERT INTO megall VALUES (109,2265,3,null,0930);
INSERT INTO megall VALUES (110,2265,15,1030,1036);
INSERT INTO megall VALUES (111,2265,24,1150,1155);
INSERT INTO megall VALUES (112,2265,41,1235,null);
-- Szombathely -> Sopron -> Györ -> Budapest-Déli
INSERT INTO megall VALUES (113,2266,41,null,1300);
INSERT INTO megall VALUES (114,2266,24,1340,1345);
INSERT INTO megall VALUES (115,2266,15,1500,1505);
INSERT INTO megall VALUES (116,2266,3,1605,null);


COMMIT;
