CREATE TABLE _Age_Group (
    age_group TEXT PRIMARY KEY
);

CREATE TABLE _Vaccine (
    Vaccine TEXT PRIMARY KEY
);

CREATE TABLE Location_info (
    iso_code      TEXT (100) PRIMARY KEY,
    Location      TEXT,
    source_url    TEXT,
    Location_Type TEXT,
    source_name   TEXT
);

CREATE TABLE Vaccination_By_Location (
    iso_code                            TEXT    REFERENCES Location_info (iso_code),
    date                                DATE,
    people_vaccinated                   INTEGER,
    people_fully_vaccinated             INTEGER,
    total_boosters                      INTEGER,
    total_vaccinations_per_hundred      INTEGER,
    daily_vaccinations_raw              INTEGER,
    daily_vaccinations                  INTEGER,
    daily_vaccinations_per_million      INTEGER,
    daily_people_vaccinated             INTEGER,
    daily_people_vaccinated_per_hundred DECIMAL,
    total_distributed                   INTEGER,
    distributed_per_hundred             DECIMAL,
    share_doses_used                    DECIMAL,
    PRIMARY KEY (
        iso_code,
        date
    )
);


CREATE TABLE vaccinations_by_age_group (
    iso_code                            TEXT    REFERENCES Location_info (iso_code),
    date                                DATE,
    age_group                           TEXT    REFERENCES _Age_Group (age_group),
    people_vaccinated_per_hundred       DECIMAL,
    people_fully_vaccinated_per_hundred DECIMAL,
    people_with_booster_per_hundred     DECIMAL,
    PRIMARY KEY (
        iso_code,
        date,
        age_group
    )
);

CREATE TABLE vaccinations_by_manufacturer (
    iso_code           [ISO_CODE TEXT] REFERENCES Location_info (iso_code),
    date               DATE,
    vaccine            TEXT            REFERENCES _Vaccine (Vaccine),
    total_vaccinations INTEGER,
    is_shared          BOOLEAN         DEFAULT (FALSE),
    PRIMARY KEY (
        iso_code,
        date,
        vaccine
    )
);
