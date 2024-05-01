# onehealth-medical-db

Este proyecto fue creado en el curso de **DATABASE DESIGN EN ORACLE ACADEMY**, se limitó al modelado de datos, el código mostrado fue generado por *ORACLE SQL DEVELOPER DATAMODELER* 

HealthOne medical una compañía de seguros en crecimiento que no cuenta con una base de datos que cumpla las necesidades de almacenamiento para la gestión de reclamos de seguros, debido a su crecimiento acelerado. Analizando el caso se ha propuesto el estudio, diseño y construcción de una base de datos que cumpla con los requerimientos necesarios del negocio, la misma debe cumplir con ciertos requerimientos del negocio, como también cumplir con futuras funcionalidades basadas en datos acumulados especificados a continuación.

## Requerimientos
A continuación, se detallan los requerimientos de información necesaria para el negocio.

### Pacientes
Nombre,	Dirección, Teléfono, E-mail, Doctor de cabecera, Identificador de seguro, Compañía de seguro, Holder.
### Cuidados
Doctor asignado, Fecha de asignación, Paciente.
### Doctor
Especialidad, Afiliaciones a hospitales, Teléfono, Dirección.
### Hospital
Dirección, Contacto.
### Prescripciones
Nombre del medicamento, Propósito, Posibles efectos secundarios, Fecha, Dosis, Duración.
#### - Tipo refilable
Cantidad de refils, Tamaño de refils.
#### - Tipo no refilable



### Visitas (atenciones)
#### - Tipo nuevo síntoma/problema
Diagnóstico inicial.
#### - Seguimiento
Estado.
#### - Chequeo
Presión de sangre actual, Altura, Peso.

## Reglas de negocio
-	Cuando una prescripción es escrita para una paciente no puede ser transferida a otro
-	Cada doctor puede estar afiliado a varios hospitales
-	Cada hospital puede tener varios doctores afiliados
-	Cada prescripción debe ser refilable o no refilable (No ambas)

## Asunciones
-	Los pacientes pueden cambiar de compañía de seguros
-	Los pacientes solo tienen una compañía de seguros a la vez
-	Los pacientes solo tienen un doctor primario a la vez
-	Los pacientes solo son atendidos su doctor primario
-	Los registros de visitas no pueden ser transferidas entre pacientes

## Diagrama Entidad Relación
![App Screenshot](/Screenshots/ERD.png)

## Diagrama Relacional
![App Screenshot](/Screenshots/relational.png)

## Tablas

|**Table Name**|**PATIENTS (PTT)**||||||||||||
| :- | :- | :- | :- | :- | :- | :- | :- | :- | :- | :- | :- | :- |
|**Column Name**|**PATIENT\_ID**|**L\_NAME**|**F\_NAME**|**BLOOD\_TYPE**|**CITY**|**STREET**|**PHONE**|**DAY\_OF\_BIRTH**|**EMAIL**|**INSURANCE\_HOLDER**|**SEX**|**ALERGICS**|
|**Key type**|Pk||||||||Uk|Fk|||
|**Nulls/Unique**|\*|\*|\*|\*|\*|\*|\*|\*|o|o|o|o|
|**Sample data**|P000000001|Juan|Luque|O+|Panamá|Calle 50|6812-1213|12-12-2000|juanluque@gmail.com||M|Penicilina|


|**Table Name**|**DOCTORS (DTR)**|||||||||
| :- | :- | :- | :- | :- | :- |:- | :- | :- | :- |
|**Column name**|**DOCTOR\_ID**|**F\_NAME**|**L\_NAME**|**PHONE**|**CITY**|**STREET**|**EMAIL**|**SPECIALITY**|**SEX**|
|**Key type**|PK||||||Uk|||
|**Nulls/Unique**|\*|\*|\*|\*|\*|\*|\*|\*|o|
|**Sample data**|D000000001|Ana|Madrid|6121-1231|Santiago|Verdum|anamadrid@gmail.com|cardióloga|F|


|**Table Name**|**HOSPITALS (HPL)**|||||
| :- | :- | :- | :- | :- | :- |
|**Column name**|HOSPITAL\_ID|NAME|CITY|STREET|PHONE|
|**Key type**|Pk|||||
|**Nulls/Unique**|\*|\*|\*|\*|\*|
|**Sample data**|H000000001|San Juan|Santiago|Calle tercera|912-1411|


|**Table Name**|**PRESCRIPTIONS (PCN)**|||||||
| :- | :- | :- | :- | :- | :- | :- | :- |
|**Column name**|DATETIME|DRUG\_NAME|DOSAGE|PURPOSE|**SIDE\_EFFECTS**|**PTT\_PATIENT\_ID**|**DURATION**|
|**Key type**|Pk|||||Pk, Fk||
|**Nulls/Unique**|\*|\*|\*|\*|O|\*|O|
|**Sample data**|12-05-2023 13:20:25|Ibuprofeno|Una pastilla cada ocho horas|Dolor muscular||P0000000001|diez días|


|**Table Name**|**REFILIABLES (RFE)**||||
| :- | :- | :- | :- | :- |
|**Column name**|PCN\_DATETIME|PCN\_PTT\_PATIENT\_ID|NUM\_OF\_REFILS|SZE\_OF\_REFILS|
|**Key type**|Pk|Pk|||
|**Nulls/Unique**|\*|\*|\*|\*|
|**Sample data**|12-05-2023 13:20:25|P000000001|2|500 mg|


|**Table Name**|**NON\_REFILIABLE (NRE)**||
| :- | :- | :- |
|**Column name**|PCN\_DATETIME|PCN\_PTT\_PATIENT\_ID|
|**Key type**|Pk|Pk|
|**Nulls/Unique**|\*|\*|
|**Sample data**|12-05-2023 13:20:25|P000000001|


|**Table Name**|**VISITS (VST)**|||||||||
| :- | :- | :- | :- | :- | :- |:- | :- | :- | :- |
|**Column name**|VST\_DATE|PCN\_PTT\_PATIENT\_ID|VST\_TIME|VST\_TYPE|CUP\_CURRENT\_BLOOD\_PRES|**CUP\_HEIGHT**|**CUP\_WEIGHT**|**FUP\_PATIENT\_STATUS**|**NIE\_INITIAL\_DIAGNOSIS**|
|**Key type**|Pk|Pk, Fk|Pk|||||||
|**Nulls/Unique**|\*|\*|\*|\*|O|O|O|O|O|
|**Sample data**|12-05-2023 |P000000001|13:20:25|CUP|180/60|172|150|||


|**Table Name** |**INSURANCE\_COMPANIES (ICY)**||
| :- | :- | :- |
|**Column name**|COMPANY\_ID|COMPANY\_NAME|
|**Key type**|Pk||
|**Nulls/Unique**|\*|\*|
|**Sample data**|IC00000010|ASSA|


|**Table Name**|**INSURANCES (ISE)**|||||
| :- | :- | :- | :- | :- | :- |
|**Column name**|INSURANCE\_ID|ICY\_COMPANY\_ID|PTT\_PATIENT\_ID|INIT\_DATE|END\_DATE|
|**Key type**|Pk|Pk, Fk|Pk|||
|**Nulls/Unique**|\*|\*|\*|\*|o|
|**Sample data**|I000000001|IC00000010|P000000001|12-06-2018||


|**Table Name**|**PRIMARY\_CARES (PCE)**||||
| :- | :- | :- | :- | :- |
|**Column name**|DATE\_OF\_ASSIGN|PTT\_PATIENT\_ID|DTR\_DOCTOR\_ID|END\_OF\_ASIGN|
|**Key type**|Pk|Pk, Fk|Pk, Fk||
|**Nulls/Unique**|\*|\*|\*|O|
|**Sample data**|12-05-2022|P000000001|D000000001|10-04-2023|


|**Table Name**|**AFILIATIONS (AFN)**||||
| :- | :- | :- | :- | :- |
|**Column name**|BEGIN|HPL\_HOSPITAL\_ID|DTR\_DOCTOR\_ID|END|
|**Key type**|Pk|Pk, Fk|Pk, Fk||
|**Nulls/Unique**|\*|\*|\*|O|
|**Sample data**|10-02-2015|H000000001|D000000001|11-03-202O|
