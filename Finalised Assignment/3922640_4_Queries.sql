--D.1
SELECT 
      vbm_egy.date  as 'Observation Date'
    , li_egy.Location as 'Country 1 Name'
    , sum(vbm_egy.total_vaccinations) as 'Administered Vaccine in Country 1'
    , li_chn.Location as 'Country 1 Name'
    , sum(vbm_chn.total_vaccinations) as 'Administered Vaccine in Country 1'
    , sum(vbm_egy.total_vaccinations) - sum(vbm_chn.total_vaccinations) as 'Difference of totals'
FROM
    vaccinations_by_manufacturer vbm_egy
JOIN
    Location_info li_egy
ON
    li_egy.iso_code = vbm_egy.iso_code
  
JOIN
    vaccinations_by_manufacturer vbm_chn
ON
  vbm_egy.date = vbm_chn.date  
JOIN
    Location_info li_chn
ON
    li_chn.iso_code = vbm_chn.iso_code
WHERE
   vbm_egy.iso_code = 'EGY' 
AND   
   vbm_chn.iso_code = 'CHN' 
GROUP BY
    vbm_egy.date    ;
    
	
--D.2
SELECT
      li.location as Country
    , sum(daily_vaccinations) as 'Cumulative Doses'
FROM
    Vaccination_By_Location vbl
JOIN
    Location_info li    
ON
    vbl.iso_code = li.iso_code
GROUP BY
    li.location    ;


-- D.3
 SELECT
     DISTINCT
      li.location as Country
    , vaccine as 'Vaccine Type'
FROM
    vaccinations_by_manufacturer vbm
JOIN
    Location_info li    
ON
    vbm.iso_code = li.iso_code
AND
    vbm.vaccine != 'Unknown';

-- D.4
SELECT
      li.source_name
    , sum(vbm.total_vaccinations)
    , li.source_url
FROM
    vaccinations_by_manufacturer vbm
JOIN
    Location_info li    
ON
    vbm.iso_code = li.iso_code
where source_name is not null
GROUP BY
      li.source_name
ORDER BY
      li.source_name
    , li.source_url;

--D.5
SELECT
      aus.date
    , aus.people_fully_vaccinated as Australia
    , can.people_fully_vaccinated as Canada   
    , grb.people_fully_vaccinated as England   
    , pol.people_fully_vaccinated as Poland   
FROM
      Vaccination_By_Location aus
JOIN      
      Vaccination_By_Location can    
ON
    aus.date = can.date
AND
    can.iso_code = 'CAN'    
JOIN      
      Vaccination_By_Location grb  
ON
    aus.date = grb.date
AND
    grb.iso_code = 'OWID_ENG'  
JOIN      
      Vaccination_By_Location pol    
ON
    aus.date = pol.date
AND
    pol.iso_code = 'POL'    
WHERE
    aus.iso_code = 'AUS'    
