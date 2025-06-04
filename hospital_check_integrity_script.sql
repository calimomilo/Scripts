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
VALUES (1, 4, 'Jimenez Ltd');

SELECT p.nom, p.prenom, s.nom
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

-- patients avec des rdv qui se chevauchent
INSERT INTO rdv(patient_id, medecin_id, date_rdv, motif, premier_rdv)
VALUES (2, 8, '2025-02-19', 'Consultation', false);

SELECT p.nom, p.prenom, r.date_rdv, r.motif
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
