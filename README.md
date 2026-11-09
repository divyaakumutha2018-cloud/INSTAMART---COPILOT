##### ##Use Case

Swiggy Instamart delivers groceries and everyday items in six metro cities, and the leadership review keeps surfacing three problems: raw order exports that nobody trusts, retention teams that cannot see which customers are about to stop ordering, and a support desk overwhelmed by free-text tickets. This project builds one internal Customer Intelligence & Support Copilot that fixes all three by cleaning and validating the data, segmenting customers with RFM and K-Means, predicting customers likely to lapse, and triaging support tickets. Together, these give the Head of Customer Experience a single trusted tool for retention and support decisions.

##### \#\# Project Structure

Instamart Customer Intelligence and Support Copilot/
├── data/
│ ├── customers.csv, orders.csv, tickets.csv # raw generated data
│ ├── raw/products.csv # product catalogue
│ ├── clean/ # cleaned CSVs (Part A)
│ ├── instamart.db # SQLite database
│ └── lapse\_dataset.csv # Part B lapse features and label
├── outputs/
│ ├── customer\_segments.csv # Part B segments
│ ├── lapse\_model.joblib # saved logistic regression
│ └── retention\_list.csv # illustrative Premium list
├── sql/queries.sql # seven SQL analysis queries
├── Customer\_Intelligence\_Support\_Copilot.ipynb # main notebook
├── generate\_data.py
├── Requirements.txt
└── README.md

Until then, keep these in place so the final notebook can be assembled quickly:

* **Notebook sections in order:** Part A (cleaning, store and validate, SQL, pandas cross-check), Part B (RFM, K-Means, segments, lapse model, class balance, interpretation), then Part C and Part D. Each section should run from top to bottom.
* **Files already saved:** `data/clean/`, `data/instamart.db`, `sql/queries.sql`, `data/lapse_dataset.csv`, `outputs/customer_segments.csv`, `outputs/lapse_model.joblib`, `outputs/retention_list.csv`.
* **Pinned versions:** add `scikit-learn==1.5.2` to `Requirements.txt`, since that's the version that runs on your machine.
* **Notes to keep for the README:** the leakage argument (cutoff 2025-09-01), the Q6 tie explanation, the cluster-label reminder, and the Premium-list caveat.