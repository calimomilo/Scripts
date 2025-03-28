DROP TABLE temp_medecin;

CREATE TEMP TABLE temp_medecin (
id int,
nom varchar(50),
prenom varchar(50),
specialite varchar(50),
hopital varchar(50),
telephone varchar(50)
);

COPY temp_medecin
FROM 'C:\Users\paula\Desktop\General\5. HEIG-VD\Semestre 2\InfraDon\hopital_data\csv\hopital_dataset_medecins.csv'
(format CSV, HEADER);

INSERT INTO specialite (nom)
SELECT DISTINCT specialite
FROM temp_medecin;