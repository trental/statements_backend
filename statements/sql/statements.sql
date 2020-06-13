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
order by sd.statement_id, sd.line_item_order;