CREATE TEMP TABLE temp_prescription (
id int,
rdv_id int,
medicament_id int,
duree int
);

COPY temp_prescription
FROM 'C:\Users\paula\Desktop\General\5. HEIG-VD\Semestre 2\InfraDon\hopital_data\csv\hopital_dataset_prescriptions.csv'
(format CSV, HEADER);