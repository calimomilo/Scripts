-- Pas de rdv avant celui marqué premier rdv
INSERT INTO rdv(patient_id, medecin_id, date_rdv, motif, premier_rdv)
VALUES (2, 5, '2025-01-01', 'Suivi', FALSE);
SELECT r.id, patient_id, p.prenom, p.nom, date_rdv, premier_rdv
FROM rdv r
INNER JOIN patient pat ON r.patient_id = pat.id
INNER JOIN personne p ON pat.personne_id = p.id
WHERE premier_rdv <> (
    (pat.id, date_rdv) IN (
    SELECT patient_id, MIN(date_rdv)
    FROM rdv
    GROUP BY patient_id
    )
);

DELETE FROM rdv
WHERE id = 2;

-- Pas d'opérations pour les mineurs
SELECT r.id, per.date_naissance, r.date_rdv, r.motif
FROM rdv r
INNER JOIN patient p ON r.patient_id = p.id
INNER JOIN personne per ON p.personne_id = per.id
WHERE per.date_naissance + INTERVAL '18 years' > r.date_rdv AND r.motif = 'Opération';

DELETE FROM rdv WHERE id IN (
    SELECT r.id
    FROM rdv r
    INNER JOIN patient p ON r.patient_id = p.id
    INNER JOIN personne per ON p.personne_id = per.id
    WHERE per.date_naissance + INTERVAL '18 years' > r.date_rdv AND r.motif = 'Opération'
);

-- début de prescription à la date du rdv
INSERT INTO prescription (rdv_id, medicament_id, presc_start, presc_end)
VALUES (5935, 6059, '2025-02-25', '2025-02-28');

SELECT p.id, r.date_rdv, p.presc_start
FROM prescription p
INNER JOIN rdv r ON p.rdv_id = r.id
WHERE r.date_rdv <> p.presc_start;

DELETE FROM prescription WHERE id IN (
    SELECT p.id
    FROM prescription p
    INNER JOIN rdv r ON p.rdv_id = r.id
    WHERE r.date_rdv <> p.presc_start
);

-- étapes pour la suivante
SELECT p.nom, p.prenom, COUNT(*) AS nombre
FROM medecin m
INNER JOIN personne p ON m.personne_id = p.id
INNER JOIN specialite s ON m.specialite_id = s.id
GROUP BY (p.nom, p.prenom);

SELECT *
FROM (
    SELECT p.nom, p.prenom, COUNT(*) AS nombre
    FROM medecin m
    INNER JOIN personne p ON m.personne_id = p.id
    INNER JOIN specialite s ON m.specialite_id = s.id
    GROUP BY (p.nom, p.prenom)
)
WHERE nombre > 1;

-- médecins avec le même nom mais des spécialités différentes
INSERT INTO personne(nom, prenom, telephone, adresse)
VALUES ('Roach', 'Jesse', 'téléphone', 'adresse');
INSERT INTO medecin(personne_id, specialite_id, hopital)
VALUES (2, 4, 'Jimenez Ltd');

SELECT m.id, p.id, p.nom, p.prenom, s.nom
FROM medecin m
INNER JOIN personne p ON m.personne_id = p.id
INNER JOIN specialite s ON m.specialite_id = s.id
WHERE (p.nom, p.prenom) IN (
    SELECT nom, prenom
    FROM (
        SELECT p.nom, p.prenom, COUNT(*) AS nombre
        FROM medecin m
        INNER JOIN personne p ON m.personne_id = p.id
        INNER JOIN specialite s ON m.specialite_id = s.id
        GROUP BY (p.nom, p.prenom)
    )
    WHERE nombre > 1
);

DELETE FROM medecin WHERE id = 18;
DELETE FROM personne WHERE id = 2;

-- patients avec des rdv qui se chevauchent -> rendu obsolète par la contrainte d'unicité
INSERT INTO rdv(patient_id, medecin_id, date_rdv, motif, premier_rdv)
VALUES (2, 8, '2025-02-19', 'Consultation', false);

SELECT r.id, p.nom, p.prenom, r.date_rdv, r.motif
FROM rdv r
INNER JOIN patient pat ON r.patient_id = pat.id
INNER JOIN personne p ON pat.personne_id = p.id
WHERE (pat.id, date_rdv) IN (
    SELECT patient_id, date_rdv
    FROM (
        SELECT patient_id, date_rdv, COUNT(*) AS nombre
        FROM rdv
        GROUP BY (patient_id, date_rdv)
    )
    WHERE nombre > 1
);

DELETE FROM rdv WHERE id = 3;