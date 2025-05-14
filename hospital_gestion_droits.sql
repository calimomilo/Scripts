CREATE ROLE secretaire;
CREATE ROLE medecin;
CREATE ROLE administrateur;

GRANT SELECT ON assurance TO secretaire;
GRANT SELECT ON medecin TO secretaire;
GRANT SELECT ON medicament TO secretaire;
GRANT SELECT ON patient TO secretaire;
GRANT SELECT ON personne TO secretaire;
GRANT SELECT ON prescription TO secretaire;
GRANT SELECT, INSERT, UPDATE ON rdv TO secretaire;
GRANT SELECT ON specialite TO secretaire;

GRANT SELECT, INSERT, UPDATE, DELETE ON assurance TO administrateur;
GRANT SELECT, INSERT, UPDATE, DELETE ON medecin TO administrateur;
GRANT SELECT, INSERT, UPDATE, DELETE ON medicament TO administrateur;
GRANT SELECT, INSERT, UPDATE, DELETE ON patient TO administrateur;
GRANT SELECT, INSERT, UPDATE, DELETE ON personne TO administrateur;
GRANT SELECT, INSERT, UPDATE, DELETE ON prescription TO administrateur;
GRANT SELECT, INSERT, UPDATE, DELETE ON rdv TO administrateur;
GRANT SELECT, INSERT, UPDATE, DELETE ON specialite TO administrateur;

GRANT INSERT, UPDATE ON prescription TO medecin;