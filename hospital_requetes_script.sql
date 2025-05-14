SELECT pers.nom, pers.prenom, COUNT(*) AS prescriptions
FROM prescription presc
INNER JOIN rdv r ON presc.rdv_id = r.id
INNER JOIN patient p ON r.patient_id = p.id
INNER JOIN personne pers ON p.personne_id = pers.id
GROUP BY (pers.nom, pers.prenom)
ORDER BY pers.nom, pers.prenom;

SELECT mpers.nom || ' ' || mpers.prenom AS medecin, ppers.nom || ' ' || ppers.prenom AS patient, r.date_rdv, r.motif, r.premier_rdv
FROM rdv r
INNER JOIN patient p ON r.patient_id = p.id
INNER JOIN personne ppers ON p.personne_id = ppers.id
INNER JOIN medecin m ON r.medecin_id = m.id
INNER JOIN personne mpers ON m.personne_id = mpers.id
WHERE r.motif = 'Consultation'
ORDER BY mpers.nom, mpers.prenom, r.date_rdv;

SELECT sp.nom, COUNT(*) AS rdv
FROM rdv r
INNER JOIN medecin m ON r.medecin_id = m.id
INNER JOIN specialite sp ON m.specialite_id = sp.id
GROUP BY sp.nom
ORDER BY rdv DESC
LIMIT 1;



SELECT nom, MAX(counter)
FROM (
    SELECT sp.nom, COUNT(*) AS counter
    FROM rdv r
    INNER JOIN medecin m ON r.medecin_id = m.id
    INNER JOIN specialite sp ON m.specialite_id = sp.id
    GROUP BY sp.nom
);