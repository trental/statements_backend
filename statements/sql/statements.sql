select s.statement_type, sd.line_item_order, sd.line_item, 
    coalesce(user_data.amount,0) as amount,
    coalesce(concat('[',user_data.tr_list,']'), '[]') as tr_list
from statements_statement s
    inner join statements_statementdetail sd
        on s.id = sd.statement_id
    left join (
        select appended_data.line_item_id, appended_data.amount, appended_data.tr_list
        from (
            with recursive rdata as (
                select rb.line_item_id, rb.line_item, rb.amount, rb.transaction_id, rb.line_item_seq, 1 as last, 
                    concat('{"id":',rb.transaction_id::text,', "accounting_date":"', rb.accounting_date, '", "description":"', rb.description, '"}') as tr_list
                from recursive_base rb
                where rb.line_item_seq = 1
                union
                select rd.line_item_id, rd.line_item, rd.amount + rb.amount as amount, rd.transaction_id, rd.line_item_seq, rd.last + 1 as last, 
                    concat(rd.tr_list, ', ', '{"id":',rb.transaction_id::text,', "accounting_date":"', rb.accounting_date, '", "description":"', rb.description, '"}') as tr_list
                from rdata rd
                    inner join recursive_base rb
                        on rd.last + 1 = rb.line_item_seq
                        and rd.line_item_id = rb.line_item_id
            )
            select d.*,
                row_number() over (partition by d.line_item_id order by d.last desc) as rev_seq
            from rdata d
        ) appended_data
        where appended_data.rev_seq = 1
    ) user_data
        on sd.id = user_data.line_item_id
union
select 'cash_flow_statement' as statement_type, 0 as line_item_order, 'beginning_cash_balance' as line_item,
    coalesce(sum(
        case when line_item = 'cash_receipts' then amount
                when line_item = 'cash_disbursements' then amount * -1
                when line_item = 'ppe_purchase' then amount * -1
                when line_item = 'net_borrowings' then amount
                when line_item = 'income_taxes_paid' then amount * -1
                when line_item = 'sale_of_capital_stock' then amount
                when line_item = 'beginning_cash_balance' then amount
                else 0
        end
    ),0) as amount,
    '[]' as tr_list
from (
    select sd.id as line_item_id, sd.line_item, rp.transaction_value * t_st_b.sign as amount, 
        rp.transaction_date, rp.accounting_date, rp.description, rp.transaction_id
    from (
        select t.id as transaction_property_id, utd.transaction_property, transaction_value, ut.transaction_date, ut.id as transaction_id, ut.accounting_date, ut.description
        from statements_usertransaction ut
            inner join statements_usertransactiondetail utd
                on ut.id = utd.user_transaction_id
            inner join statements_transaction t
                on utd.transaction_property = t.transaction_property
        where ut.user_id = **user_id**
            and ut.transaction_date < '**begin_date**'
            **transaction_list**
        ) rp
        inner join statements_transaction_statementdetail_bridge t_st_b
            on rp.transaction_property_id = t_st_b.transaction_property_id
        inner join statements_statementdetail sd
            on t_st_b.line_item_id = sd.id
        inner join statements_statement s
            on sd.statement_id = s.id
    where s.statement_type = 'cash_flow_statement'
) d;