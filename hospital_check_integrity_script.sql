SELECT r.id, per.date_naissance, r.date_rdv, r.motif
FROM rdv r
INNER JOIN patient p ON r.patient_id = p.id
INNER JOIN personne per ON p.personne_id = per.id
WHERE per.date_naissance + INTERVAL '18 years' > r.date_rdv AND r.motif = 'Opération';

DELETE FROM rdv WHERE id = 5125;

SELECT id, presc_start, presc_end
FROM prescription
WHERE presc_start + INTERVAL '1 year' < presc_end;