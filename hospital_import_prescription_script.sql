DROP TABLE temp_prescription;

CREATE TEMP TABLE temp_prescription (
id int,
rdv_id int,
medicament_id int,
duree int
);

COPY temp_prescription
FROM 'C:\Users\paula\Desktop\General\5. HEIG-VD\Semestre 2\InfraDon\hopital_data\csv\hopital_dataset_prescriptions.csv'
(format CSV, HEADER);

INSERT INTO prescription (id, rdv_id, medicament_id, presc_start, presc_end)
SELECT tp.id, tp.rdv_id, tp.medicament_id, r.date_rdv, (r.date_rdv + duree)
FROM temp_prescription tp
INNER JOIN rdv r ON tp.rdv_id = r.id;