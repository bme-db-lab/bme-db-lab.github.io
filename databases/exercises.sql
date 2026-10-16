drop table cars;
drop table persons;
drop sequence carseq;
create table persons as
select nev name, szemelyi_szam personID, sysdate-trunc(dbms_random.value(1,30000)) birthdate from oktatas.szemelyek;
create sequence carseq start with 10000 increment by 1;
create table cars as
select carseq.nextval carID, personID,
 case trunc(dbms_random.value(1,10))
  when 1 then 'Oltcit'
  when 2 then 'Skoda'
  when 3 then 'Lada'
  when 4 then 'Trabant'
  when 5 then 'Wartburg'
  when 6 then 'Zaporozsec'
  when 7 then 'Moszkvics'
  when 8 then 'Polski Fiat'
  else 'Zastava'
 end manufacturer
from (select personID from persons order by dbms_random.value FETCH FIRST 3000 ROWS ONLY);