select s.*
    from (
    select concat(p.year, ' ', p.period) as reporting_period,
        concat(p.year, '-',
        case when p.period = 'Q1' then '01-01'
            when p.period = 'Q2' then '04-01'
            when p.period = 'Q3' then '07-01'
            when p.period = 'Q4' then '10-01'
            else '01-01'
        end) as begin_date,
        concat(p.year, '-',
        case when p.period = 'Q1' then '03-31'
            when p.period = 'Q2' then '06-30'
            when p.period = 'Q3' then '09-30'
            when p.period = 'Q4' then '12-31'
            else '12-31'
        end) as end_date
    from (
        select 
            extract(year from accounting_date) as year, concat('Q', round((extract(month from accounting_date) + 0.5)::decimal / 3,0)) as period
        from statements_usertransaction
        union
        select 
            extract(year from accounting_date) as year, 'Annual' as period
        from statements_usertransaction
    ) p
) s
order by s.end_date, s.reporting_period desc;