# Global_Trade_Analysis

## Overview
This repository contains SQL scripts for analyzing global trade data. The goal of the project is to uncover meaningful insights such as:
- Top trading partners for each country.
- Products with the highest tariff rates.
- Trade imbalances between major economies.
- The most traded products by value.

The queries are optimized for performance and structured for clarity, making them reusable and adaptable for various trade analysis scenarios.

---

## Features
1. **Top Trading Partners**: Identifies the largest trading partners for each country based on total trade value.
2. **Tariff Insights**: Extracts information about products with the highest tariff rates in each country.
3. **Trade Imbalance Analysis**: Explores trade balances between key countries like the USA and China over time.
4. **Product Analysis**: Highlights the top 5 traded products by export and import values.

---

## Getting Started

### Prerequisites
- A SQL database system (e.g., MySQL, PostgreSQL).
- Access to trade datasets (import, export, tariffs, etc.).

### Setup
1. Clone the repository:
   ```bash
   git clone https://github.com/your-username/trade-analysis-sql.git
   cd trade-analysis-sql
   ```
2. Import the trade data into your database.
3. Execute the provided SQL queries in your database client.

---

## Usage
- **Query 1: Top Trading Partners**
  ```sql
  SELECT c1.countryname AS exporting_country, c2.countryname AS importing_country, SUM(e.value) AS total_trade_value
  FROM exports e
  JOIN countries c1 ON e.countryid = c1.countryid
  JOIN imports i ON e.product = i.product
  JOIN countries c2 ON i.countryid = c2.countryid
  GROUP BY exporting_country, importing_country
  ORDER BY total_trade_value DESC;
  ```

- **Query 2: Product with the Highest Tariff**
  ```sql
  SELECT t.CountryID, c.CountryName, t.Product, t.TariffRate
  FROM Tariffs t
  JOIN countries c ON t.countryid = c.countryid
  WHERE t.tariffrate = (
      SELECT MAX(tariffrate)
      FROM tariffs t2
      WHERE t2.countryid = t.countryid
  );
  ```

(Additional queries are included in the SQL script.)

---

## Contributing
Contributions are welcome! If you have ideas for improving the queries or adding new analyses, feel free to open a pull request or issue.

---

## License
This project is licensed under the MIT License. See the LICENSE file for details.

---

## Acknowledgments
Special thanks to open data providers and trade organizations for making global trade datasets accessible.

---

## Contact
If you have any questions or suggestions, feel free to reach out via [LinkedIn](www.linkedin.com/in/pchawla09) or open an issue in the repository.
