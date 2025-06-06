DROP TABLE temp_patient;
DROP TABLE temp_maj_patient;

CREATE TEMP TABLE temp_patient (
id int,
nom varchar(50),
prenom varchar(50),
date_naissance varchar(50),
adresse varchar(255),
telephone varchar(50)
);

COPY temp_patient
FROM 'C:\Users\paula\Desktop\General\5. HEIG-VD\Semestre 2\InfraDon\hopital_data\csv\hopital_dataset_patients.csv'
(format CSV, HEADER);

CREATE TEMP TABLE temp_maj_patient (
id_patient int,
assurance varchar(50),
sexe varchar(20),
adresse_corrigee varchar(255)
);

COPY temp_maj_patient
FROM 'C:\Users\paula\Desktop\General\5. HEIG-VD\Semestre 2\InfraDon\hopital_data\csv\hopital_dataset_assurances_sexe_adresse.csv'
(format CSV, HEADER);

INSERT INTO personne (id, nom, prenom, telephone, sexe, adresse, date_naissance)
SELECT DISTINCT tp.id, tp.nom, tp.prenom, tp.telephone, tmp.sexe::sexe, tmp.adresse_corrigee, to_date(tp.date_naissance, 'DD/MM/YYYY')
FROM temp_patient tp
INNER JOIN temp_maj_patient tmp ON tp.id = tmp.id_patient;

SELECT id, COUNT(*)
FROM temp_patient
GROUP BY id
ORDER BY COUNT(*) DESC;

SELECT *
FROM temp_patient
WHERE id NOT IN (
    SELECT id 
    FROM temp_maj_patient
);
SELECT *
FROM temp_maj_patient
WHERE id_patient NOT IN (
    SELECT id 
    FROM temp_patient
);