delete from statements_transaction;

insert into statements_transaction (transaction_type, transaction_property, transaction_property_datatype) VALUES ('issue_common_stock', 'capital', 'number');
insert into statements_transaction (transaction_type, transaction_property, transaction_property_datatype) VALUES ('salary_and_employment_expenses_general_and_administrative', 'salary_paid_general_and_administrative', 'number');
insert into statements_transaction (transaction_type, transaction_property, transaction_property_datatype) VALUES ('salary_and_employment_expenses_sales_and_marketing', 'salary_paid_sales_and_marketing', 'number');
insert into statements_transaction (transaction_type, transaction_property, transaction_property_datatype) VALUES ('salary_and_employment_expenses_general_and_administrative', 'employment_expenses_accrued_general_and_administrative', 'number');
insert into statements_transaction (transaction_type, transaction_property, transaction_property_datatype) VALUES ('salary_and_employment_expenses_sales_and_marketing', 'employment_expenses_accrued_sales_and_marketing', 'number');
insert into statements_transaction (transaction_type, transaction_property, transaction_property_datatype) VALUES ('borrow', 'loan_amount', 'number');
insert into statements_transaction (transaction_type, transaction_property, transaction_property_datatype) VALUES ('borrow', 'current_debt', 'number');
insert into statements_transaction (transaction_type, transaction_property, transaction_property_datatype) VALUES ('borrow', 'long_term_debt', 'number');
insert into statements_transaction (transaction_type, transaction_property, transaction_property_datatype) VALUES ('purchase_ppe_cash', 'cost_of_cash_ppe', 'number');
insert into statements_transaction (transaction_type, transaction_property, transaction_property_datatype) VALUES ('purchase_ppe_accounts_payable', 'cost_of_accounts_payable_ppe', 'number');
insert into statements_transaction (transaction_type, transaction_property, transaction_property_datatype) VALUES ('pay_accrued_expenses', 'accrued_expenses_paid', 'number');
insert into statements_transaction (transaction_type, transaction_property, transaction_property_datatype) VALUES ('pay_employment_expenses', 'employment_expenses_paid', 'number');
insert into statements_transaction (transaction_type, transaction_property, transaction_property_datatype) VALUES ('purchase_inventory_cash', 'cost_of_cash_inventory', 'number');
insert into statements_transaction (transaction_type, transaction_property, transaction_property_datatype) VALUES ('purchase_inventory_accounts_payable', 'cost_of_accounts_payable_inventory', 'number');
insert into statements_transaction (transaction_type, transaction_property, transaction_property_datatype) VALUES ('salary_and_employment_expenses_inventories', 'salary_paid_inventories', 'number');
insert into statements_transaction (transaction_type, transaction_property, transaction_property_datatype) VALUES ('salary_and_employment_expenses_inventories', 'employment_expenses_accrued_inventories', 'number');
insert into statements_transaction (transaction_type, transaction_property, transaction_property_datatype) VALUES ('depreciation_to_inventory', 'depreciation_amount', 'number');
insert into statements_transaction (transaction_type, transaction_property, transaction_property_datatype) VALUES ('pay_accounts_payable_cash', 'cost_of_accounts_payable_cash', 'number');
insert into statements_transaction (transaction_type, transaction_property, transaction_property_datatype) VALUES ('scrap_inventory', 'inventory_amount_to_scrap', 'number');
insert into statements_transaction (transaction_type, transaction_property, transaction_property_datatype) VALUES ('sales_and_marketing_expenses_accounts_payable', 'cost_of_sales_and_marketing_accounts_payable', 'number');
insert into statements_transaction (transaction_type, transaction_property, transaction_property_datatype) VALUES ('sales_and_marketing_expenses_cash', 'cost_of_sales_and_marketing_cash', 'number');
insert into statements_transaction (transaction_type, transaction_property, transaction_property_datatype) VALUES ('receive_order', 'inventory_to_cost_of_goods_sold', 'number');
insert into statements_transaction (transaction_type, transaction_property, transaction_property_datatype) VALUES ('receive_order', 'net_sales_from_accounts_receivable', 'number');
insert into statements_transaction (transaction_type, transaction_property, transaction_property_datatype) VALUES ('receive_order', 'commissions_on_sale', 'number');
insert into statements_transaction (transaction_type, transaction_property, transaction_property_datatype) VALUES ('receive_order', 'net_sales_to_retained_earnings', 'number');
insert into statements_transaction (transaction_type, transaction_property, transaction_property_datatype) VALUES ('process_accounts_receivable_to_cash', 'accounts_receivable_to_cash', 'number');
insert into statements_transaction (transaction_type, transaction_property, transaction_property_datatype) VALUES ('write_off_bad_debt', 'write_off_to_accounts_receivable', 'number');
insert into statements_transaction (transaction_type, transaction_property, transaction_property_datatype) VALUES ('write_off_bad_debt', 'write_off_to_commissions', 'number');
insert into statements_transaction (transaction_type, transaction_property, transaction_property_datatype) VALUES ('purchase_prepaid_expenses_cash', 'cash_to_prepaid_expenses', 'number');
insert into statements_transaction (transaction_type, transaction_property, transaction_property_datatype) VALUES ('recognize_prepaid_expenses_general_and_administrative', 'prepaid_expenses_to_general_and_administrative', 'number');
insert into statements_transaction (transaction_type, transaction_property, transaction_property_datatype) VALUES ('principal_and_interest_payment_on_debt_cash', 'cash_to_interest_paid', 'number');
insert into statements_transaction (transaction_type, transaction_property, transaction_property_datatype) VALUES ('principal_and_interest_payment_on_debt_cash', 'cash_to_principal_paid', 'number');
insert into statements_transaction (transaction_type, transaction_property, transaction_property_datatype) VALUES ('book_income_taxes_payable', 'income_taxes_payable', 'number');
insert into statements_transaction (transaction_type, transaction_property, transaction_property_datatype) VALUES ('pay_income_taxes_payable', 'income_taxes_paid', 'number');

insert into statements_transaction (transaction_type, transaction_property, transaction_property_datatype) VALUES ('issue_common_stock', 'transaction_date', 'date');
insert into statements_transaction (transaction_type, transaction_property, transaction_property_datatype) VALUES ('salary_and_employment_expenses_general_and_administrative', 'transaction_date', 'date');
insert into statements_transaction (transaction_type, transaction_property, transaction_property_datatype) VALUES ('salary_and_employment_expenses_sales_and_marketing', 'transaction_date', 'date');


insert into statements_transaction (transaction_type, transaction_property, transaction_property_datatype) VALUES ('borrow', 'transaction_date', 'date');


insert into statements_transaction (transaction_type, transaction_property, transaction_property_datatype) VALUES ('purchase_ppe_cash', 'transaction_date', 'date');
insert into statements_transaction (transaction_type, transaction_property, transaction_property_datatype) VALUES ('purchase_ppe_accounts_payable', 'transaction_date', 'date');
insert into statements_transaction (transaction_type, transaction_property, transaction_property_datatype) VALUES ('pay_accrued_expenses', 'transaction_date', 'date');
insert into statements_transaction (transaction_type, transaction_property, transaction_property_datatype) VALUES ('pay_employment_expenses', 'transaction_date', 'date');
insert into statements_transaction (transaction_type, transaction_property, transaction_property_datatype) VALUES ('purchase_inventory_cash', 'transaction_date', 'date');
insert into statements_transaction (transaction_type, transaction_property, transaction_property_datatype) VALUES ('purchase_inventory_accounts_payable', 'transaction_date', 'date');
insert into statements_transaction (transaction_type, transaction_property, transaction_property_datatype) VALUES ('salary_and_employment_expenses_inventories', 'transaction_date', 'date');

insert into statements_transaction (transaction_type, transaction_property, transaction_property_datatype) VALUES ('depreciation_to_inventory', 'transaction_date', 'date');
insert into statements_transaction (transaction_type, transaction_property, transaction_property_datatype) VALUES ('pay_accounts_payable_cash', 'transaction_date', 'date');
insert into statements_transaction (transaction_type, transaction_property, transaction_property_datatype) VALUES ('scrap_inventory', 'transaction_date', 'date');
insert into statements_transaction (transaction_type, transaction_property, transaction_property_datatype) VALUES ('sales_and_marketing_expenses_accounts_payable', 'transaction_date', 'date');
insert into statements_transaction (transaction_type, transaction_property, transaction_property_datatype) VALUES ('sales_and_marketing_expenses_cash', 'transaction_date', 'date');
insert into statements_transaction (transaction_type, transaction_property, transaction_property_datatype) VALUES ('receive_order', 'transaction_date', 'date');



insert into statements_transaction (transaction_type, transaction_property, transaction_property_datatype) VALUES ('process_accounts_receivable_to_cash', 'transaction_date', 'date');
insert into statements_transaction (transaction_type, transaction_property, transaction_property_datatype) VALUES ('write_off_bad_debt', 'transaction_date', 'date');

insert into statements_transaction (transaction_type, transaction_property, transaction_property_datatype) VALUES ('purchase_prepaid_expenses_cash', 'transaction_date', 'date');
insert into statements_transaction (transaction_type, transaction_property, transaction_property_datatype) VALUES ('recognize_prepaid_expenses_general_and_administrative', 'transaction_date', 'date');
insert into statements_transaction (transaction_type, transaction_property, transaction_property_datatype) VALUES ('principal_and_interest_payment_on_debt_cash', 'transaction_date', 'date');

insert into statements_transaction (transaction_type, transaction_property, transaction_property_datatype) VALUES ('book_income_taxes_payable', 'transaction_date', 'date');
insert into statements_transaction (transaction_type, transaction_property, transaction_property_datatype) VALUES ('pay_income_taxes_payable', 'transaction_date', 'date');

insert into statements_transaction (transaction_type, transaction_property, transaction_property_datatype) VALUES ('issue_common_stock', 'transaction_date', 'date');
insert into statements_transaction (transaction_type, transaction_property, transaction_property_datatype) VALUES ('salary_and_employment_expenses_general_and_administrative', 'transaction_date', 'date');
insert into statements_transaction (transaction_type, transaction_property, transaction_property_datatype) VALUES ('salary_and_employment_expenses_sales_and_marketing', 'transaction_date', 'date');


insert into statements_transaction (transaction_type, transaction_property, transaction_property_datatype) VALUES ('borrow', 'transaction_date', 'date');


insert into statements_transaction (transaction_type, transaction_property, transaction_property_datatype) VALUES ('purchase_ppe_cash', 'transaction_date', 'date');
insert into statements_transaction (transaction_type, transaction_property, transaction_property_datatype) VALUES ('purchase_ppe_accounts_payable', 'transaction_date', 'date');
insert into statements_transaction (transaction_type, transaction_property, transaction_property_datatype) VALUES ('pay_accrued_expenses', 'transaction_date', 'date');
insert into statements_transaction (transaction_type, transaction_property, transaction_property_datatype) VALUES ('pay_employment_expenses', 'transaction_date', 'date');
insert into statements_transaction (transaction_type, transaction_property, transaction_property_datatype) VALUES ('purchase_inventory_cash', 'transaction_date', 'date');
insert into statements_transaction (transaction_type, transaction_property, transaction_property_datatype) VALUES ('purchase_inventory_accounts_payable', 'transaction_date', 'date');
insert into statements_transaction (transaction_type, transaction_property, transaction_property_datatype) VALUES ('salary_and_employment_expenses_inventories', 'transaction_date', 'date');

insert into statements_transaction (transaction_type, transaction_property, transaction_property_datatype) VALUES ('depreciation_to_inventory', 'transaction_date', 'date');
insert into statements_transaction (transaction_type, transaction_property, transaction_property_datatype) VALUES ('pay_accounts_payable_cash', 'transaction_date', 'date');
insert into statements_transaction (transaction_type, transaction_property, transaction_property_datatype) VALUES ('scrap_inventory', 'transaction_date', 'date');
insert into statements_transaction (transaction_type, transaction_property, transaction_property_datatype) VALUES ('sales_and_marketing_expenses_accounts_payable', 'transaction_date', 'date');
insert into statements_transaction (transaction_type, transaction_property, transaction_property_datatype) VALUES ('sales_and_marketing_expenses_cash', 'transaction_date', 'date');
insert into statements_transaction (transaction_type, transaction_property, transaction_property_datatype) VALUES ('receive_order', 'transaction_date', 'date');



insert into statements_transaction (transaction_type, transaction_property, transaction_property_datatype) VALUES ('process_accounts_receivable_to_cash', 'transaction_date', 'date');
insert into statements_transaction (transaction_type, transaction_property, transaction_property_datatype) VALUES ('write_off_bad_debt', 'transaction_date', 'date');

insert into statements_transaction (transaction_type, transaction_property, transaction_property_datatype) VALUES ('purchase_prepaid_expenses_cash', 'transaction_date', 'date');
insert into statements_transaction (transaction_type, transaction_property, transaction_property_datatype) VALUES ('recognize_prepaid_expenses_general_and_administrative', 'transaction_date', 'date');
insert into statements_transaction (transaction_type, transaction_property, transaction_property_datatype) VALUES ('principal_and_interest_payment_on_debt_cash', 'transaction_date', 'date');

insert into statements_transaction (transaction_type, transaction_property, transaction_property_datatype) VALUES ('book_income_taxes_payable', 'transaction_date', 'date');
insert into statements_transaction (transaction_type, transaction_property, transaction_property_datatype) VALUES ('pay_income_taxes_payable', 'transaction_date', 'date');

insert into statements_transaction (transaction_type, transaction_property, transaction_property_datatype) VALUES ('issue_common_stock', 'transaction_date', 'date');
insert into statements_transaction (transaction_type, transaction_property, transaction_property_datatype) VALUES ('salary_and_employment_expenses_general_and_administrative', 'transaction_date', 'date');
insert into statements_transaction (transaction_type, transaction_property, transaction_property_datatype) VALUES ('salary_and_employment_expenses_sales_and_marketing', 'transaction_date', 'date');


insert into statements_transaction (transaction_type, transaction_property, transaction_property_datatype) VALUES ('borrow', 'transaction_date', 'date');


insert into statements_transaction (transaction_type, transaction_property, transaction_property_datatype) VALUES ('purchase_ppe_cash', 'transaction_date', 'date');
insert into statements_transaction (transaction_type, transaction_property, transaction_property_datatype) VALUES ('purchase_ppe_accounts_payable', 'transaction_date', 'date');
insert into statements_transaction (transaction_type, transaction_property, transaction_property_datatype) VALUES ('pay_accrued_expenses', 'transaction_date', 'date');
insert into statements_transaction (transaction_type, transaction_property, transaction_property_datatype) VALUES ('pay_employment_expenses', 'transaction_date', 'date');
insert into statements_transaction (transaction_type, transaction_property, transaction_property_datatype) VALUES ('purchase_inventory_cash', 'transaction_date', 'date');
insert into statements_transaction (transaction_type, transaction_property, transaction_property_datatype) VALUES ('purchase_inventory_accounts_payable', 'transaction_date', 'date');
insert into statements_transaction (transaction_type, transaction_property, transaction_property_datatype) VALUES ('salary_and_employment_expenses_inventories', 'transaction_date', 'date');

insert into statements_transaction (transaction_type, transaction_property, transaction_property_datatype) VALUES ('depreciation_to_inventory', 'transaction_date', 'date');
insert into statements_transaction (transaction_type, transaction_property, transaction_property_datatype) VALUES ('pay_accounts_payable_cash', 'transaction_date', 'date');
insert into statements_transaction (transaction_type, transaction_property, transaction_property_datatype) VALUES ('scrap_inventory', 'transaction_date', 'date');
insert into statements_transaction (transaction_type, transaction_property, transaction_property_datatype) VALUES ('sales_and_marketing_expenses_accounts_payable', 'transaction_date', 'date');
insert into statements_transaction (transaction_type, transaction_property, transaction_property_datatype) VALUES ('sales_and_marketing_expenses_cash', 'transaction_date', 'date');
insert into statements_transaction (transaction_type, transaction_property, transaction_property_datatype) VALUES ('receive_order', 'transaction_date', 'date');



insert into statements_transaction (transaction_type, transaction_property, transaction_property_datatype) VALUES ('process_accounts_receivable_to_cash', 'transaction_date', 'date');
insert into statements_transaction (transaction_type, transaction_property, transaction_property_datatype) VALUES ('write_off_bad_debt', 'transaction_date', 'date');

insert into statements_transaction (transaction_type, transaction_property, transaction_property_datatype) VALUES ('purchase_prepaid_expenses_cash', 'transaction_date', 'date');
insert into statements_transaction (transaction_type, transaction_property, transaction_property_datatype) VALUES ('recognize_prepaid_expenses_general_and_administrative', 'transaction_date', 'date');
insert into statements_transaction (transaction_type, transaction_property, transaction_property_datatype) VALUES ('principal_and_interest_payment_on_debt_cash', 'transaction_date', 'date');

insert into statements_transaction (transaction_type, transaction_property, transaction_property_datatype) VALUES ('book_income_taxes_payable', 'transaction_date', 'date');
insert into statements_transaction (transaction_type, transaction_property, transaction_property_datatype) VALUES ('pay_income_taxes_payable', 'transaction_date', 'date');