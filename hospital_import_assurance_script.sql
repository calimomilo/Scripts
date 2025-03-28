DROP TABLE temp_maj_patient;

CREATE TEMP TABLE temp_maj_patient (
id_patient int,
assurance varchar(50),
sexe varchar(20),
adresse_corrigee varchar(255)
);

COPY temp_maj_patient
FROM 'C:\Users\paula\Desktop\General\5. HEIG-VD\Semestre 2\InfraDon\hopital_data\csv\hopital_dataset_assurances_sexe_adresse.csv'
(format CSV, HEADER);

INSERT INTO assurance(nom)
SELECT DISTINCT split_part(assurance, ' +', 1)
FROM temp_maj_patient;