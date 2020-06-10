select s.statement_type, sd.line_item_order, sd.line_item, coalesce(user_data.amount,0) as amount
from statements_statement s
    inner join statements_statementdetail sd
        on s.id = sd.statement_id
    left join (
        select tot.line_item_id, sum(tot.amount) as amount
        from (
            select sd.id as line_item_id, sd.line_item, rp.transaction_value * t_st_b.sign as amount, rp.transaction_date
            from (
                select t.id as transaction_property_id, utd.transaction_property, transaction_value, ut.transaction_date
                from statements_usertransaction ut
                    inner join statements_usertransactiondetail utd
                        on ut.id = user_transaction_id
                    inner join statements_transaction t
                        on utd.transaction_property = t.transaction_property
                where ut.user_id = **user_id**
                    and ut.transaction_date > '**begin_date**' and ut.transaction_date <= '**end_date**'
                    **transaction_list**

            ) rp
                inner join statements_transaction_statementdetail_bridge t_st_b
                    on rp.transaction_property_id = t_st_b.transaction_property_id
                inner join statements_statementdetail sd
                    on t_st_b.line_item_id = sd.id
        ) tot       
        group by tot.line_item_id
    ) user_data
        on sd.id = user_data.line_item_id
order by sd.statement_id, sd.line_item_order;