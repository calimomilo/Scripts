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

INSERT INTO patient (personne_id, assurance, complementaire)
SELECT tmp.id_patient, a.id, (tmp.assurance LIKE '%+ complémentaire')
FROM temp_maj_patient tmp
INNER JOIN assurance a ON a.nom = split_part(tmp.assurance, ' +', 1)
ON CONFLICT (personne_id)
DO NOTHING;