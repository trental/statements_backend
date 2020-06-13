select statement_type, line_item_order, line_item, line_format, amount
from output
union
select 'income_statement', 250, 'gross_margin', 'sub-total' as line_format, sum(amount) as amount
from (
    select case when line_item = 'net_sales' then amount
                when line_item = 'cost_of_goods_sold' then amount * -1
                else 0
        end as amount
    from output
    where statement_type = 'income_statement'
) a
union
select 'income_statement', 550, 'operating_expense', 'sub-total' as line_format, sum(amount) as amount
from output
where statement_type = 'income_statement'
    and line_item in ('sales_and_marketing', 'research_and_development', 'general_and_administrative')    
union    
select 'income_statement', 575, 'income_from_operations', 'sub-total' as line_format, sum(amount) as amount
from (
    select case when line_item = 'net_sales' then amount
                when line_item = 'cost_of_goods_sold' then amount * -1
                when line_item = 'sales_and_marketing' then amount * -1
                when line_item = 'research_and_development' then amount * -1
                when line_item = 'general_and_administrative' then amount * -1
                else 0
        end as amount
    from output
    where statement_type = 'income_statement'
) a
union    
select 'income_statement', 750, 'net_income', 'grand-total' as line_format, sum(amount) as amount
from (
    select case when line_item = 'net_sales' then amount
                when line_item = 'cost_of_goods_sold' then amount * -1
                when line_item = 'sales_and_marketing' then amount * -1
                when line_item = 'research_and_development' then amount * -1
                when line_item = 'general_and_administrative' then amount * -1
                when line_item = 'net_interest_income' then amount * 1
                when line_item = 'income_taxes' then amount * -1                
                else 0
        end as amount
    from output
    where statement_type = 'income_statement'
) a
union
select 'cash_flow_statement', 12, 'cash_flow_from_operations', 'sub-total' as line_format, sum(amount) as amount
from (
    select case when line_item = 'cash_receipts' then amount
                when line_item = 'cash_disbursements' then amount * -1
                else 0
        end as amount
    from output
    where statement_type = 'cash_flow_statement'
) a
union
select 'cash_flow_statement', 32, 'ending_cash_balances', 'grand-total' as line_format, sum(amount) as amount
from (
    select case when line_item = 'cash_receipts' then amount
                when line_item = 'cash_disbursements' then amount * -1
                when line_item = 'ppe_purchase' then amount * -1
                when line_item = 'net_borrowings' then amount
                when line_item = 'income_taxes_paid' then amount * -1
                when line_item = 'sale_of_capital_stock' then amount
                else 0
        end as amount
    from output
    where statement_type = 'cash_flow_statement'
) a
union
select 'balance_sheet', 22, 'current_assets', 'sub-total' as line_format, sum(amount) as amount
from (
    select case when line_item = 'cash' then amount
                when line_item = 'accounts_receivable' then amount
                when line_item = 'inventories' then amount
                when line_item = 'prepaid_expenses' then amount
                else 0
        end as amount
    from output
    where statement_type = 'balance_sheet'
) a
union
select 'balance_sheet', 37, 'net_fixed_assets', 'sub-total' as line_format, sum(amount) as amount
from (
    select case when line_item = 'fixed_assets_at_cost' then amount
                when line_item = 'accumulated_depreciation' then amount * -1
                else 0
        end as amount
    from output
    where statement_type = 'balance_sheet'
) a
union
select 'balance_sheet', 38, 'total_assets', 'grand-total' as line_format, sum(amount) as amount
from (
    select case when line_item = 'cash' then amount
                when line_item = 'accounts_receivable' then amount
                when line_item = 'inventories' then amount
                when line_item = 'prepaid_expenses' then amount
                when line_item = 'fixed_assets_at_cost' then amount
                when line_item = 'accumulated_depreciation' then amount * -1
                else 0
        end as amount
    from output
    where statement_type = 'balance_sheet'
) a
union
select 'balance_sheet', 57, 'current_liabilties', 'sub-total' as line_format, sum(amount) as amount
from (
    select case when line_item = 'accounts_payable' then amount
                when line_item = 'accrued_expenses' then amount
                when line_item = 'current_portion_of_debt' then amount
                when line_item = 'income_taxes_payable' then amount
                else 0
        end as amount
    from output
    where statement_type = 'balance_sheet'
) a
union
select 'balance_sheet', 62, 'total_liabilties', 'grand-total' as line_format, sum(amount) as amount
from (
    select case when line_item = 'accounts_payable' then amount
                when line_item = 'accrued_expenses' then amount
                when line_item = 'current_portion_of_debt' then amount
                when line_item = 'income_taxes_payable' then amount
                when line_item = 'longterm_debt' then amount
                else 0
        end as amount
    from output
    where statement_type = 'balance_sheet'
) a
union
select 'balance_sheet', 72, 'shareholders_equity', 'sub-total' as line_format, sum(amount) as amount
from (
    select case when line_item = 'capital_stock' then amount
                when line_item = 'retained_earnings' then amount
                else 0
        end as amount
    from output
    where statement_type = 'balance_sheet'
) a
union
select 'balance_sheet', 73, 'total_liabilties_and_equity', 'grand-total' as line_format, sum(amount) as amount
from (
    select case when line_item = 'accounts_payable' then amount
                when line_item = 'accrued_expenses' then amount
                when line_item = 'current_portion_of_debt' then amount
                when line_item = 'income_taxes_payable' then amount
                when line_item = 'longterm_debt' then amount
                when line_item = 'capital_stock' then amount
                when line_item = 'retained_earnings' then amount
                else 0
        end as amount
    from output
    where statement_type = 'balance_sheet'
) a