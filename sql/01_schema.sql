
CREATE DATABASE IF NOT EXISTS horiba_cbc;
USE horiba_cbc;

-- Table 1: data_A (general CBC patients)
CREATE TABLE IF NOT EXISTS data_a (
    subject_id INT PRIMARY KEY,
    White_Blood_Cells FLOAT,
    Red_Blood_Cells FLOAT,
    Hemoglobin FLOAT,
    Hematocrit FLOAT,
    MCH FLOAT,
    MCHC FLOAT,
    MCV FLOAT,
    LYMp FLOAT,
    MIDp FLOAT,
    NEUTp FLOAT,
    LYMn FLOAT,
    MIDn FLOAT,
    NEUTn FLOAT,
    RDWSD FLOAT,
    RDWCV FLOAT,
    PLT FLOAT,
    MPV FLOAT,
    PDW FLOAT,
    PCT FLOAT,
    PLCR FLOAT
);

-- Table 2: Patient info (from MIMIC-III)
CREATE TABLE IF NOT EXISTS patient (
    subject_id INT PRIMARY KEY,
    gender VARCHAR(1),
    dob DATETIME,
    dod DATETIME,
    expire_flag INT
);

-- Table 3: CBC results (from MIMIC-III)
CREATE TABLE IF NOT EXISTS cbc_results (
    id INT AUTO_INCREMENT PRIMARY KEY,
    subject_id INT,
    Hemoglobin FLOAT,
    Hematocrit FLOAT,
    Red_Blood_Cells FLOAT,
    White_Blood_Cells FLOAT,
    MCH FLOAT,
    MCHC FLOAT,
    MCV FLOAT,
    Basophils FLOAT,
    Eosinophils FLOAT,
    Lymphocytes FLOAT,
    Monocytes FLOAT,
    Neutrophils FLOAT,
    RDW FLOAT,
    FOREIGN KEY (subject_id) REFERENCES patient(subject_id)
);

-- Table 4: Diagnosis (from MIMIC-III)
CREATE TABLE IF NOT EXISTS diagnosis (
    id INT AUTO_INCREMENT PRIMARY KEY,
    subject_id INT,
    short_title VARCHAR(255),
    long_title VARCHAR(255),
    FOREIGN KEY (subject_id) REFERENCES patient(subject_id)
);
