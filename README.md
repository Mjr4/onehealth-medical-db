# onehealth-medical-db

Este proyecto fue creado en el curso de **DATABASE DESIGN EN ORACLE ACADEMY**, se limitó al modelado de datos, el código mostrado fue generado por *ORACLE SQL DEVELOPER DATAMODELER* 

HealthOne medical una compañía de seguros en crecimiento que no cuenta con una base de datos que cumpla las necesidades de almacenamiento para la gestión de reclamos de seguros, debido a su crecimiento acelerado. Analizando el caso se ha propuesto el estudio, diseño y construcción de una base de datos que cumpla con los requerimientos necesarios del negocio, la misma debe cumplir con ciertos requerimientos del negocio, como también cumplir con futuras funcionalidades basadas en datos acumulados especificados a continuación.

## Requerimientos
A continuación, se detallan los requerimientos de información necesaria para el negocio.

### Pacientes
•	Nombre
•	Dirección
•	Teléfono
•	E-mail
•	Doctor de cabecera
•	Identificador de seguro
•	Compañía de seguro
•	Holder
### Cuidados
•	Doctor asignado
•	Fecha de asignación
•	Paciente
### Doctor
•	Especialidad
•	Afiliaciones a hospitales
•	Teléfono
•	Dirección
### Hospital
•	Dirección
•	Contacto
### Prescripciones
•	Nombre del medicamento
•	Propósito
•	Posibles efectos secundarios
•	Fecha
•	Dosis
•	Duración
#### Tipo refilable
•	Cantidad de refils
•	Tamaño de refils
#### Tipo no refilable
•	


### Visitas (atenciones)
#### Tipo nuevo síntoma/problema
•	Diagnóstico inicial
#### Seguimiento
•	Estado
#### Chequeo
•	Presión de sangre actual
•	Altura
•	Peso

## Reglas de negocio
•	Cuando una prescripción es escrita para una paciente no puede ser transferida a otro
•	Cada doctor puede estar afiliado a muchos hospitales
•	Cada hospital puede tener muchos doctores afiliados
•	Cada prescripción debe ser refilable o no refilable. No ambas

## Asunciones
•	Los pacientes pueden cambiar de compañía de seguros
•	Los pacientes solo tienen una compañía de seguros a la vez
•	Los pacientes solo tienen un doctor primario a la vez
•	Los pacientes solo son atendidos su doctor primario
•	Los registros de visitas no pueden ser transferidas entre pacientes
