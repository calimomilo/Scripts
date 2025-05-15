CREATE ROLE secretaire;
CREATE ROLE medecin;
CREATE ROLE administrateur;

CREATE USER lucie LOGIN PASSWORD 'lucie';
CREATE USER marie LOGIN PASSWORD 'marie';
CREATE USER julie LOGIN PASSWORD 'julie';
GRANT secretaire TO lucie;
GRANT medecin TO marie;
GRANT administrateur  TO julie;

GRANT SELECT ON assurance, medecin, medicament, patient, personne, prescription, rdv, specialite TO secretaire;
GRANT INSERT, UPDATE ON rdv TO secretaire;

GRANT INSERT, UPDATE ON prescription TO medecin;

GRANT SELECT, INSERT, UPDATE, DELETE ON assurance, medecin, medicament, patient, personne, prescription, rdv, specialite TO administrateur;
