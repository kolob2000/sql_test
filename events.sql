-- 1. Задача
select min(date) as 'start',
       max(date) as 'end',
       (select count(distinct cid)
        from events
        where (date >= (select min(ev.date)
                        from events ev
                        where (select cid from (select * from events e order by date limit 1)) = cid))
          and (date <= (select max(ev.date)
                        from events ev
                        where (select cid from (select * from events e order by date limit 1)) = cid)))
                 as 'count'
from (select *
      from events ev
      where (select cid from (select * from events e order by date limit 1)) = cid);


-- 2. Задача
select min(date) as 'start',
       max(date) as 'end',
       (select count(distinct cid)
        from events
        where (date >= (select min(ev.date)
                        from events ev
                        where (select cid from (select * from events e order by date desc limit 1)) = cid))
          and (date <= (select max(ev.date)
                        from events ev
                        where (select cid from (select * from events e order by date desc limit 1)) = cid)))
                 as 'count'
from (select *
      from events ev
      where (select cid from (select * from events e order by date desc limit 1)) = cid);

-- 3. Задача
-- в третьей задаче не совсем понял, что именно хотели в задании.
-- сделать в одну строку вывод. или сделать просто full outer join.
-- в общем написал два варианта.
--
-- a) ---------------------------------
select f.start as 'first start',
       f.end   as 'first end',
       f.count as 'count',
       l.start as 'last start',
       l.end as 'last end',
       l.count as 'count'
from (select min(date) as 'start',
             max(date) as 'end',
             (select count(distinct cid)
              from events
              where (date >= (select min(ev.date)
                              from events ev
                              where (select cid from (select * from events e order by date limit 1)) = cid))
                and (date <= (select max(ev.date)
                              from events ev
                              where (select cid from (select * from events e order by date limit 1)) = cid)))
                       as 'count'
      from (select *
            from events ev
            where (select cid from (select * from events e order by date limit 1)) = cid)) as f,

     (select min(date) as 'start',
             max(date) as 'end',
             (select count(distinct cid)
              from events
              where (date >= (select min(ev.date)
                              from events ev
                              where (select cid from (select * from events e order by date desc limit 1)) = cid))
                and (date <= (select max(ev.date)
                              from events ev
                              where (select cid from (select * from events e order by date desc limit 1)) = cid)))
                       as 'count'
      from (select *
            from events ev
            where (select cid from (select * from events e order by date desc limit 1)) = cid)) as l;

-- b) -------------------------------------
select min(date) as 'start',
       max(date) as 'end',
       (select count(distinct cid)
        from events
        where (date >= (select min(ev.date)
                        from events ev
                        where (select cid from (select * from events e order by date limit 1)) = cid))
          and (date <= (select max(ev.date)
                        from events ev
                        where (select cid from (select * from events e order by date limit 1)) = cid)))
                 as 'count'
from (select *
      from events ev
      where (select cid from (select * from events e order by date limit 1)) = cid)
union

select min(date) as 'start',
       max(date) as 'end',
       (select count(distinct cid)
        from events
        where (date >= (select min(ev.date)
                        from events ev
                        where (select cid from (select * from events e order by date desc limit 1)) = cid))
          and (date <= (select max(ev.date)
                        from events ev
                        where (select cid from (select * from events e order by date desc limit 1)) = cid)))
                 as 'count'
from (select *
      from events ev
      where (select cid from (select * from events e order by date desc limit 1)) = cid);

