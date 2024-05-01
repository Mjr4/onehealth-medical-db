-- Generado por Oracle SQL Developer Data Modeler 23.1.0.087.0806
--   en:        2024-04-30 21:07:30 COT
--   sitio:      Oracle Database 11g
--   tipo:      Oracle Database 11g

-- predefined type, no DDL - MDSYS.SDO_GEOMETRY

-- predefined type, no DDL - XMLTYPE

CREATE TABLE affiliation (
    begin           DATE NOT NULL,
    hpl_hospital_id VARCHAR2(10) NOT NULL,
    dtr_doctor_id   VARCHAR2(10) NOT NULL,
    end             DATE
);

ALTER TABLE affiliation
    ADD CONSTRAINT affiliation_pk PRIMARY KEY ( begin,
                                                hpl_hospital_id,
                                                dtr_doctor_id );

CREATE TABLE doctor (
    doctor_id    VARCHAR2(10) NOT NULL,
    f_name       VARCHAR2(15) NOT NULL,
    l_name       VARCHAR2(15) NOT NULL,
    phone        VARCHAR2(9) NOT NULL,
    day_of_birth DATE NOT NULL,
    city         VARCHAR2(15) NOT NULL,
    street       VARCHAR2(30) NOT NULL,
    email        VARCHAR2(30) NOT NULL,
    speciality   VARCHAR2(15) NOT NULL,
    sex          VARCHAR2(1)
);

ALTER TABLE doctor ADD CONSTRAINT doctor_pk PRIMARY KEY ( doctor_id );

ALTER TABLE doctor ADD CONSTRAINT doctor_email_un UNIQUE ( email );

CREATE TABLE hospital (
    hospital_id VARCHAR2(10) NOT NULL,
    city        VARCHAR2(15) NOT NULL,
    street      VARCHAR2(30) NOT NULL,
    phone       VARCHAR2(9) NOT NULL,
    name        VARCHAR2(15) NOT NULL
);

ALTER TABLE hospital ADD CONSTRAINT hospital_pk PRIMARY KEY ( hospital_id );

CREATE TABLE insurance (
    insurance_id   VARCHAR2(10) NOT NULL,
    icy_company_id VARCHAR2(10) NOT NULL,
    ptt_patient_id VARCHAR2(10) NOT NULL,
    init_date      DATE NOT NULL,
    end_date       DATE
);

ALTER TABLE insurance ADD CONSTRAINT insurance_pk PRIMARY KEY ( insurance_id,
                                                                icy_company_id );

CREATE TABLE insurance_company (
    company_id VARCHAR2(10) NOT NULL,
    name       VARCHAR2(30) NOT NULL
);

ALTER TABLE insurance_company ADD CONSTRAINT insurance_company_pk PRIMARY KEY ( company_id );

CREATE TABLE non_refiliable (
    pcn_datetime       TIMESTAMP NOT NULL,
    pcn_ptt_patient_id VARCHAR2(10) NOT NULL
);

CREATE UNIQUE INDEX non_refiliable__idx ON
    non_refiliable (
        pcn_datetime
    ASC,
        pcn_ptt_patient_id
    ASC );

CREATE TABLE patient (
    patient_id       VARCHAR2(10) NOT NULL,
    f_name           VARCHAR2(15) NOT NULL,
    l_name           VARCHAR2(15) NOT NULL,
    blood_t          VARCHAR2(3) NOT NULL,
    city             VARCHAR2(15) NOT NULL,
    street           VARCHAR2(30) NOT NULL,
    phone            VARCHAR2(9) NOT NULL,
    day_of_birth     DATE NOT NULL,
    email            VARCHAR2(30),
    insurance_holder VARCHAR2(10),
    sex              VARCHAR2(1),
    alergics         VARCHAR2(30)
);

ALTER TABLE patient ADD CONSTRAINT patient_pk PRIMARY KEY ( patient_id );

ALTER TABLE patient ADD CONSTRAINT patient_email_un UNIQUE ( email );

CREATE TABLE prescription (
    datetime       TIMESTAMP NOT NULL,
    drug_name      VARCHAR2(15) NOT NULL,
    dosage         VARCHAR2(30) NOT NULL,
    purpose        VARCHAR2(30) NOT NULL,
    side_effects   VARCHAR2(30),
    ptt_patient_id VARCHAR2(10) NOT NULL,
    duration       VARCHAR2(15)
);

ALTER TABLE prescription ADD CONSTRAINT prescription_pk PRIMARY KEY ( datetime,
                                                                      ptt_patient_id );

CREATE TABLE primary_care (
    day_of_assign DATE NOT NULL,
    ptt_id        VARCHAR2(10) NOT NULL,
    dtr_doctor_id VARCHAR2(10) NOT NULL,
    end_of_assing DATE
);

ALTER TABLE primary_care
    ADD CONSTRAINT primary_care_pk PRIMARY KEY ( day_of_assign,
                                                 ptt_id,
                                                 dtr_doctor_id );

CREATE TABLE refiliable (
    num_of_refils      NUMBER NOT NULL,
    sze_of_refils      VARCHAR2(10) NOT NULL,
    pcn_datetime       TIMESTAMP NOT NULL,
    pcn_ptt_patient_id VARCHAR2(10) NOT NULL
);

ALTER TABLE refiliable ADD CONSTRAINT refiliable_pk PRIMARY KEY ( pcn_datetime,
                                                                  pcn_ptt_patient_id );

CREATE TABLE visit (
    vst_date             DATE NOT NULL,
    ptt_patient_id       VARCHAR2(10) NOT NULL,
    vst_time             TIMESTAMP NOT NULL,
    cup_curr_blood_press VARCHAR2(10),
    cup_height           NUMBER(2),
    cup_weight           NUMBER(2),
    fup_patient_stat     VARCHAR2(50),
    nie_init_diagnosis   VARCHAR2(50),
    vst_type             VARCHAR2(3) NOT NULL
);

ALTER TABLE visit
    ADD CONSTRAINT ch_inh_vst CHECK ( vst_type IN ( 'CUP', 'FUP', 'NIE', 'VST' ) );

ALTER TABLE visit
    ADD CONSTRAINT vst_exdep CHECK ( ( vst_type = 'CUP'
                                       AND fup_patient_stat IS NULL
                                       AND nie_init_diagnosis IS NULL )
                                     OR ( vst_type = 'FUP'
                                          AND cup_curr_blood_press IS NULL
                                          AND cup_height IS NULL
                                          AND cup_weight IS NULL
                                          AND nie_init_diagnosis IS NULL )
                                     OR ( vst_type = 'NIE'
                                          AND cup_curr_blood_press IS NULL
                                          AND cup_height IS NULL
                                          AND cup_weight IS NULL
                                          AND fup_patient_stat IS NULL )
                                     OR ( vst_type = 'VST'
                                          AND cup_curr_blood_press IS NULL
                                          AND cup_height IS NULL
                                          AND cup_weight IS NULL
                                          AND fup_patient_stat IS NULL
                                          AND nie_init_diagnosis IS NULL ) );

ALTER TABLE visit
    ADD CONSTRAINT visit_pk PRIMARY KEY ( vst_date,
                                          ptt_patient_id,
                                          vst_time );

ALTER TABLE affiliation
    ADD CONSTRAINT afn_dtr_fk FOREIGN KEY ( dtr_doctor_id )
        REFERENCES doctor ( doctor_id );

ALTER TABLE affiliation
    ADD CONSTRAINT afn_hpl_fk FOREIGN KEY ( hpl_hospital_id )
        REFERENCES hospital ( hospital_id );

ALTER TABLE insurance
    ADD CONSTRAINT ise_icy_fk FOREIGN KEY ( icy_company_id )
        REFERENCES insurance_company ( company_id );

ALTER TABLE insurance
    ADD CONSTRAINT ise_ptt_fk FOREIGN KEY ( ptt_patient_id )
        REFERENCES patient ( patient_id );

ALTER TABLE non_refiliable
    ADD CONSTRAINT non_refiliable_pcn_fk FOREIGN KEY ( pcn_datetime,
                                                       pcn_ptt_patient_id )
        REFERENCES prescription ( datetime,
                                  ptt_patient_id );

ALTER TABLE primary_care
    ADD CONSTRAINT pce_dtr_fk FOREIGN KEY ( dtr_doctor_id )
        REFERENCES doctor ( doctor_id );

ALTER TABLE primary_care
    ADD CONSTRAINT pce_ptt_fk FOREIGN KEY ( ptt_id )
        REFERENCES patient ( patient_id )
            ON DELETE CASCADE;

ALTER TABLE prescription
    ADD CONSTRAINT pcn_ptt_fk FOREIGN KEY ( ptt_patient_id )
        REFERENCES patient ( patient_id );

ALTER TABLE patient
    ADD CONSTRAINT ptt_ptt_fk FOREIGN KEY ( insurance_holder )
        REFERENCES patient ( patient_id );

ALTER TABLE refiliable
    ADD CONSTRAINT rfe_pcn_fk FOREIGN KEY ( pcn_datetime,
                                            pcn_ptt_patient_id )
        REFERENCES prescription ( datetime,
                                  ptt_patient_id );

ALTER TABLE visit
    ADD CONSTRAINT vst_ptt_fk FOREIGN KEY ( ptt_patient_id )
        REFERENCES patient ( patient_id );

CREATE OR REPLACE TRIGGER fkntm_prescription BEFORE
    UPDATE OF ptt_patient_id ON prescription
BEGIN
    raise_application_error(-20225, 'Non Transferable FK constraint  on table PRESCRIPTION is violated');
END;
/

CREATE OR REPLACE TRIGGER fkntm_primary_care BEFORE
    UPDATE OF ptt_id ON primary_care
BEGIN
    raise_application_error(-20225, 'Non Transferable FK constraint  on table PRIMARY_CARE is violated');
END;
/

CREATE OR REPLACE TRIGGER fkntm_visit BEFORE
    UPDATE OF ptt_patient_id ON visit
BEGIN
    raise_application_error(-20225, 'Non Transferable FK constraint  on table VISIT is violated');
END;
/
