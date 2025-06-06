DROP TABLE temp_medecin;
DROP TABLE temp_maj_medecin;

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

CREATE TEMP TABLE temp_maj_medecin (
id_medecin int,
sexe varchar(10),
adresse_hopital varchar(255)
);

COPY temp_maj_medecin
FROM 'C:\Users\paula\Desktop\General\5. HEIG-VD\Semestre 2\InfraDon\hopital_data\csv\hopital_dataset_medecins_adresses_coherentes.csv'
(format CSV, HEADER);

INSERT INTO personne(id, nom, prenom, telephone, sexe, adresse)
SELECT DISTINCT tm.id, tm.nom, tm.prenom, tm.telephone, tmm.sexe::sexe, tmm.adresse_hopital
FROM temp_medecin tm
INNER JOIN temp_maj_medecin tmm ON tm.id = tmm.id_medecin;

SELECT id, COUNT(*)
FROM temp_medecin
GROUP BY id
ORDER BY COUNT(*) DESC;

SELECT *
FROM temp_medecin
WHERE id NOT IN (
    SELECT id 
    FROM temp_maj_medecin
);
SELECT *
FROM temp_maj_medecin
WHERE id_medecin NOT IN (
    SELECT id 
    FROM temp_medecin
);