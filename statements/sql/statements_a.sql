select sd.id as line_item_id, sd.line_item, rp.transaction_value * t_st_b.sign as amount, 
    rp.transaction_date, rp.accounting_date, rp.description, rp.transaction_id, row_number() over (partition by sd.id order by rp.transaction_id) as line_item_seq
from (
    select t.id as transaction_property_id, utd.transaction_property, transaction_value, ut.transaction_date, ut.id as transaction_id, ut.accounting_date, ut.description
    from statements_usertransaction ut
        inner join statements_usertransactiondetail utd
            on ut.id = utd.user_transaction_id
        inner join statements_transaction t
            on utd.transaction_property = t.transaction_property
    where ut.user_id = **user_id**
        and ut.transaction_date <= '**end_date**'
        **transaction_list**
) rp
    inner join statements_transaction_statementdetail_bridge t_st_b
        on rp.transaction_property_id = t_st_b.transaction_property_id
    inner join statements_statementdetail sd
        on t_st_b.line_item_id = sd.id
    inner join statements_statement s
        on sd.statement_id = s.id
where (
    rp.transaction_date >= '**begin_date**' and s.statement_type in ('income_statement', 'cash_flow_statement')) or (s.statement_type in ('balance_sheet')
)