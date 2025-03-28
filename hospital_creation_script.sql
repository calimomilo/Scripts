-- CREATION ENUM

CREATE TYPE "sexe" AS ENUM (
  'Homme',
  'Femme',
  'Non-binaire'
);

CREATE TYPE "motif" AS ENUM (
  'Consultation',
  'Examen',
  'Opération',
  'Suivi',
  'Urgence'
);

CREATE TYPE "type" AS ENUM (
  'Comprimé',
  'Capsule',
  'Gélule',
  'Aérosol',
  'Injection'
);

-- CREATION TABLES

CREATE TABLE "personne" (
  "id" serial PRIMARY KEY,
  "nom" varchar(255) NOT NULL,
  "prenom" varchar(25) NOT NULL,
  "telephone" varchar(25) NOT NULL,
  "sexe" sexe,
  "adresse" varchar(255) NOT NULL,
  "date_naissance" date,
  "created_at" timestamp
);

CREATE TABLE "patient" (
  "id" serial PRIMARY KEY,
  "personne_id" integer NOT NULL,
  "assurance" integer NOT NULL,
  "complementaire" boolean NOT NULL,
  "created_at" timestamp
);

CREATE TABLE "medecin" (
  "id" serial PRIMARY KEY,
  "personne_id" integer NOT NULL,
  "specialite_id" integer NOT NULL,
  "hopital" varchar(255) NOT NULL,
  "created_at" timestamp
);

CREATE TABLE "rdv" (
  "id" serial PRIMARY KEY,
  "patient_id" integer NOT NULL,
  "medecin_id" integer NOT NULL,
  "date_rdv" date NOT NULL,
  "motif" motif NOT NULL,
  "premier_rdv" boolean NOT NULL,
  "created_at" timestamp
);

CREATE TABLE "medicament" (
  "id" serial PRIMARY KEY,
  "nom" varchar(255) NOT NULL,
  "dosage" varchar(20) NOT NULL,
  "type" type NOT NULL,
  "created_at" timestamp
);

CREATE TABLE "prescription" (
  "id" serial PRIMARY KEY,
  "rdv_id" integer NOT NULL,
  "medicament_id" integer NOT NULL,
  "presc_start" date NOT NULL,
  "presc_end" date NOT NULL,
  "created_at" timestamp
);

CREATE TABLE "specialite" (
  "id" serial PRIMARY KEY,
  "nom" varchar(50) NOT NULL,
  "created_at" timestamp
);

CREATE TABLE "assurance" (
  "id" serial PRIMARY KEY,
  "nom" varchar(255) NOT NULL,
  "created_at" timestamp
);

-- AJOUT FOREIGN KEYS

ALTER TABLE "patient" ADD FOREIGN KEY ("personne_id") REFERENCES "personne" ("id");

ALTER TABLE "patient" ADD FOREIGN KEY ("assurance") REFERENCES "assurance" ("id");

ALTER TABLE "medecin" ADD FOREIGN KEY ("personne_id") REFERENCES "personne" ("id");

ALTER TABLE "medecin" ADD FOREIGN KEY ("specialite_id") REFERENCES "specialite" ("id");

ALTER TABLE "rdv" ADD FOREIGN KEY ("patient_id") REFERENCES "patient" ("id");

ALTER TABLE "rdv" ADD FOREIGN KEY ("medecin_id") REFERENCES "medecin" ("id");

ALTER TABLE "prescription" ADD FOREIGN KEY ("rdv_id") REFERENCES "rdv" ("id");

ALTER TABLE "prescription" ADD FOREIGN KEY ("medicament_id") REFERENCES "medicament" ("id");

-- AJOUT CONTRAINTES

ALTER TABLE personne ADD UNIQUE (nom, prenom, date_naissance);

ALTER TABLE patient ADD UNIQUE (personne_id);

ALTER TABLE medecin ADD UNIQUE (personne_id);

ALTER TABLE assurance ADD UNIQUE (nom);

ALTER TABLE specialite ADD UNIQUE (nom);

ALTER TABLE rdv ADD UNIQUE (medecin_id, date_rdv);

--ALTER TABLE rdv ADD CONSTRAINT check_premier_rdv CHECK (premier_rdv AND date_rdv = ???);

--ALTER TABLE rdv ADD CONSTRAINT check_operation_mineur CHECK (motif = 'Opération' AND ???);

--ALTER TABLE prescription ADD CONSTRAINT check_start CHECK (presc_start = ???);

ALTER TABLE prescription ADD CONSTRAINT check_duree CHECK (presc_end < presc_start + interval '1 year');

ALTER TABLE medicament ADD UNIQUE (nom, dosage, type);
