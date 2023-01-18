# Primary Care Shortage Area (PCSA) Shapefile Analysis

One project I am currently working on is finding out how many of our Graduate Medical Education (GME) residency applicants are located in a PCSA area. The PCSA data was
pulled from the California Department of Health Care Access and Information (HCAI) https://data.chhs.ca.gov/dataset/primary-care-shortage-areas-in-california. One way to 
find out if an applicant is within a PCSA is to search by address, however, there are 140 applicants and it would take time to search one by one. 

The file named **"PCSA_shapefile.R"** shows how I used our applicant data ("testing.csv") to turn it into a shapefile but using the "tidygeocoder" library to extract the latitude and longitude of each address and converting the file into a shapefile. Once I converted into a shapefile, I then merged that file, to the PCSA shapefile. Once merged I was able to see which applicants are located in a PCSA file. The file names "FY223_PCSA.csv" shows the final draft of the merged spreadsheet. 

**"pcsa.png"** shows the California Map and the areas labed as PCSA. **"pcsa_points"** show the same map and includes red dots to show where the applicants are located.
