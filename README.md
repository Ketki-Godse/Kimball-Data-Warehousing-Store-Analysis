# Kimball-Data-Warehousing-Store-Analysis

<img width="1010" alt="image" src="https://github.com/Ketki-Godse/Kimball-Data-Warehousing-Store-Analysis/assets/134458658/550e468b-ed58-40c2-a5da-0b908820e8f1">



Kimball data warehousing is a methodology developed by Ralph Kimball that focuses on the dimensional modeling approach for designing data warehouses. This approach aims to make data easily accessible and understandable for end users, particularly for business intelligence and reporting purposes.

## Business Problem
Company A manufactures and sells products through its retail stores. As a data analyst, my task is to analyze the sales history of Stores 5 and 8 and provide recommendations to enhance the company’s sales profitability. The following are the key questions I aim to address:
​
1. An overall assessment of Stores number 5 and 8’s sales.
    1.How are they performing compared to target? Will they meet their 2014 target?
    2.Should either store be closed? Why or why not?
    3.What should be done in the next year to maximize store profits?

2. Recommend separate 2013 and 2014 bonus amounts for each store if the total bonus pool for 2013 is $500,000 and the total bonus pool for 2014 is $400,000. Base your recommendation on how well the stores are selling Product Types of Men’s Casual and Women’s Casual.

3. Assess product sales by day of the week at Stores 5 and 8. What can we learn about sales trends?

4. Compare the performance of all stores located in states that have more than one store to all stores that are the only store in the state. What can we learn about having more than one store in a state?

## My Approach
Steps followed:
1. Determined Business Requirements
2. Identified the Grain
3. Identified the Dimensions
4. Identified the Facts
5. Created a snowflake schema
6. Created Staging Tables
7. Designed and loaded the Dimension Tables
8. Designed and loaded the Fact Tables
9. Created Views based on business problem
10. Used live connections to connect the views to Tableau
11. Created visualizations to answer the business questions

## Visualizations [Link](https://public.tableau.com/app/profile/ketki.godse/viz/KimballDataWarehousingStoreAnalysis/IMT577KetkiGodseDashboard)

### Question 1
<img width="780" alt="image" src="https://github.com/Ketki-Godse/Kimball-Data-Warehousing-Store-Analysis/assets/134458658/c504ddf2-69e3-4f6b-9fc3-7bc4de67e820">

### Question 2
<img width="773" alt="image" src="https://github.com/Ketki-Godse/Kimball-Data-Warehousing-Store-Analysis/assets/134458658/298451ec-8e15-47e6-a603-31809b9a3086">

### Question 3
<img width="773" alt="image" src="https://github.com/Ketki-Godse/Kimball-Data-Warehousing-Store-Analysis/assets/134458658/ea29cf5a-2cdf-4dad-8e85-7a6bb641c439">

### Question 4
<img width="773" alt="image" src="https://github.com/Ketki-Godse/Kimball-Data-Warehousing-Store-Analysis/assets/134458658/bb03cf8d-ffd4-4211-bb4a-862723c153d0">

