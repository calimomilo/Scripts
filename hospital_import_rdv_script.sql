DROP TABLE temp_rdv;

CREATE TEMP TABLE temp_rdv (
	id int,
	patient_id int,
	medecin_id int,
	date_rdv varchar(20),
	motif varchar(20)
);

COPY temp_rdv
FROM 'C:\Users\paula\Desktop\General\5. HEIG-VD\Semestre 2\InfraDon\hopital_data\csv\hopital_dataset_rdvs.csv'
(format CSV, HEADER);

INSERT INTO rdv (id, patient_id, medecin_id, date_rdv, motif, premier_rdv)
SELECT tr.id, p.id, m.id, to_date(tr.date_rdv, 'DD/MM/YYYY'), tr.motif::motif, (tr.patient_id, to_date(tr.date_rdv, 'DD/MM/YYYY')) IN (
	SELECT patient_id, MIN(to_date(date_rdv, 'DD/MM/YYYY'))
	FROM temp_rdv
	GROUP BY patient_id)
FROM temp_rdv tr
INNER JOIN patient p ON tr.patient_id = p.personne_id
INNER JOIN medecin m ON tr.medecin_id = m.personne_id
ON CONFLICT (medecin_id, date_rdv)
DO NOTHING;

DELETE FROM rdv;