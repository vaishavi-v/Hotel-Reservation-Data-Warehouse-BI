# Hotel Reservation Data Warehouse & Business Intelligence System

**IT3101 – Data Warehousing and Business Intelligence | Group Project | 2026**

## Project Overview

This project develops a Data Warehouse and Business Intelligence solution using hotel reservation data. The system transforms raw reservation records into structured analytical data to identify booking trends, cancellation patterns and operational insights.

## Dataset

- **Source:** Kaggle – Hotel Reservations Dataset
- **Records:** 36,275 hotel reservations
- **Original attributes:** 19
- **Business focus:** Reservation trends, cancellation behaviour and hotel booking analysis.

## Technologies Used

- R – Data preprocessing and data preparation
- Microsoft SQL Server – Database development and data warehousing
- SQL – ETL, dimensional modelling and analytical queries
- Microsoft Power BI – Interactive dashboards and visualisation

## Project Implementation

1. **Data Preparation:** Cleaned and prepared 36,275 reservation records and created additional analytical attributes.
2. **Data Warehouse Development:** Designed a dimensional model with a reservation fact table and six core dimensions.
3. **ETL Process:** Loaded and transformed reservation data into the data warehouse.
4. **Data Mart Development:** Created a Reservation Analytics Data Mart containing 4,864 analytical groups.
5. **Business Intelligence:** Developed interactive Power BI reports with KPI visualisations, filters and date hierarchy drill-down and roll-up analysis.

## Key Results

- 36,275 reservation records processed.
- 11,885 cancelled reservations identified.
- Overall cancellation rate of **32.76%**.
- 4,864 analytical groups generated in the data mart.
- All 36,275 reservations preserved in the analytical data mart.

## Power BI Dashboard

The dashboard contains four reporting pages:

- Executive Summary
- Trend Analysis
- Interactive Analysis
- Calendar Planning

## Repository Contents

- `R/` – Data preprocessing scripts.
- `SQL/` – Database, ETL, dimensional modelling and analytical SQL scripts.
- `PowerBI/` – Power BI report and dashboard screenshots.
- `docs/` – Project documentation and report.
- `data/` – Dataset information and instructions.

## Project Type

Academic group project completed for the BSc (Hons) Information Technology degree, specialising in Data Science.

**Note:** This repository documents the project implementation. Dataset files are not included; refer to the original Kaggle source for the data.
