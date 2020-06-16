# Statements - A Stepping Stone to Financial Freedom (Backend)

Statements is a financial history manager modeled after the book [Financial Statements](https://www.amazon.com/Financial-Statements-Third-Step-Step/dp/1632651750/) by Thomas Ittelson. The application creates financial statements from a user's transaction history. The three created financial statements are:

- Balance Sheet
- Income Statement
- Cash Flow Statement

The user enters an accounting date and selects a transaction type (issue common stock, pay accrued expenses, etc.) from a list of available options. From there the app intuitively prompts the user for the required transaction details. The app will organize and place the transactional values into the correct reporting periods and positions on each statement.

A reference deployment for this back-end is located at [http://fierce-escarpment-04103.herokuapp.com](http://fierce-escarpment-04103.herokuapp.com). You can also interact with the system through the front-end located at [http://statements-frontend.herokuapp.com/](http://statements-frontend.herokuapp.com/). Login with username "f" and password "s" for a complete replication of transactions and financial statements of Appleseed Enterprises, Inc., the fictional company showcased in the inspiration book "Financial Statements."

## Back-end Technologies

The Statements backend is a RESTful API built with expandability in mind. This is done by using SQL as the organizational and calculation engine. Use of tables to store transactional details vertically creates a dynamic data structure enabling flexible aggregation and adaptive front-end rendering.

What does that mean? The application contains over 25 different transaction types that are defined in just two header and detail tables.

### The Stack:

- Python
- Django
- PostgreSQL
- JWT Authentication

## Data Model

Three main models exist in Statements:

1. User
2. Transaction (header, detail, and template tables)
3. Statement (header and detail tables)

> ![Data Design](planning/data_desing.png)

A new user transaction is created from a transaction template. The bridging table between transaction details and statement details allows a N:N relationship between the two tables along with appropriate signing (+1, -1) for summing in each statement. Finally, SQL drives the organization and calculation of reporting including a recursive SQL query that lists each transaction underlying the totals on each financial statement.

## Ideas for the Future

Many opportunities for expansion exist in this data model. A quick list includes:

1. Custom user transactions
2. Custom financial statements
3. Financial ratio reporting and analysis
4. Pro-forma financial statements based on historical performance and projected trends
