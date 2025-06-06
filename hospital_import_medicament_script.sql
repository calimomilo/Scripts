DROP TABLE temp_medicament;

CREATE TEMP TABLE temp_medicament (
id int,
nom varchar(50),
dosage varchar(20),
type_medicament varchar(30)
);

COPY temp_medicament
FROM 'C:\Users\paula\Desktop\General\5. HEIG-VD\Semestre 2\InfraDon\hopital_data\csv\hopital_dataset_medicaments.csv'
(format CSV, HEADER);

INSERT INTO medicament (id, nom, dosage, type)
SELECT DISTINCT id, nom, dosage, type_medicament::TYPE
FROM temp_medicament;

SELECT id, COUNT(*)
FROM temp_rdv
GROUP BY id
ORDER BY COUNT(*) DESC;