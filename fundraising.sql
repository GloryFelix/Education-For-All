-- view donation_data table
SELECT *
FROM donation_data;

-- view donor_data table 
SELECT *
FROM donor_data;

-- check if we have unique donors
SELECT COUNT(DISTINCT(donation_data.id)) AS number_of_total_donors
FROM donation_data;
-- we have 1000 unique donors since
-- Total donations
SELECT SUM(donation_data.donation) AS total_donations
FROM donation_data;

-- Total donations made by frequency of donation
SELECT donor_data.donation_frequency, SUM(donation_data.donation) AS total_donations
FROM donation_data
JOIN donor_data
ON donor_data.id = donation_data.id
GROUP BY donor_data.donation_frequency;

-- since there are people that promised to donate but NEVER donated, we will filter total donations and number of donations by removing the ones that never donated

-- Total donations and number of donors that donated by gender
SELECT donation_data.gender, SUM(donation_data.donation) AS total_donations, COUNT(donation_data.id) AS number_of_donors
FROM donation_data
JOIN donor_data
ON donor_data.id = donation_data.id
WHERE donor_data.donation_frequency != 'Never'
GROUP BY donation_data.gender;

-- Total actual donations and number of donors by Job field in descending order
SELECT donation_data.job_field, SUM(donation_data.donation) AS total_donations, COUNT(donation_data.id) AS number_of_donations
FROM donation_data
JOIN donor_data
ON donor_data.id = donation_data.id
WHERE donor_data.donation_frequency != 'Never'
GROUP BY donation_data.job_field
ORDER BY total_donations DESC;

-- Total donation and number of donations above $200
SELECT SUM(donation_data.donation) AS total_donations, COUNT(donation_data.donation) AS number_of_donations
FROM donation_data
JOIN donor_data
ON donor_data.id = donation_data.id
WHERE donation_data.donation > 200
AND donor_data.donation_frequency != 'Never';

-- Total donation and number of donations below $200
SELECT SUM(donation_data.donation) AS total_donations, COUNT(donation_data.donation) AS number_of_donations
FROM donation_data
JOIN donor_data
ON donor_data.id = donation_data.id
WHERE donation_data.donation < 200
AND donor_data.donation_frequency != 'Never';

-- Top 10 states contributes the highest donations
SELECT donation_data.state, SUM(donation_data.donation) AS total_donations
FROM donation_data
JOIN donor_data
ON donor_data.id = donation_data.id
WHERE donor_data.donation_frequency != 'Never'
GROUP BY donation_data.state
ORDER BY total_donations DESC
LIMIT 10;

-- Top 10 states contributes the least donation
SELECT donation_data.state, SUM(donation_data.donation) AS total_donations
FROM donation_data
JOIN donor_data
ON donor_data.id = donation_data.id
WHERE donor_data.donation_frequency != 'Never'
GROUP BY donation_data.state
ORDER BY total_donations ASC
LIMIT 10;

-- Top 10 highest donors and cars driven
SELECT CONCAT(donation_data.first_name, ' ', donation_data.last_name) AS full_name, donor_data.car, SUM(donation_data.donation) AS total_donations
FROM donation_data
JOIN donor_data
ON donation_data.id = donor_data.id
WHERE donor_data.donation_frequency != 'Never'
GROUP BY full_name, donor_data.car
ORDER BY total_donations DESC
LIMIT 10;

-- Top 10 cars driven by the highest donors
SELECT donor_data.car, SUM(donation_data.donation) AS total_donations
FROM donation_data
JOIN donor_data
ON donation_data.id = donor_data.id
WHERE donation_frequency != 'Never'
GROUP BY donor_data.car
ORDER BY total_donations DESC
LIMIT 10;

-- view donors that went to university and never donated the amount they pledged
SELECT donation_data.gender, COUNT(donor_data.university) AS donors, SUM(donation_data.donation) AS total_donations
FROM donation_data
JOIN donor_data
ON donation_data.id = donor_data.id
WHERE donor_data.donation_frequency = 'Never'
AND donor_data.university IS NOT NULL
GROUP BY donation_data.gender;
