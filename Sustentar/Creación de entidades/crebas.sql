/*==============================================================*/
/* DBMS name:      PostgreSQL 8                                 */
/* Created on:     21/11/2021 16:33:24                          */
/*==============================================================*/


drop table CLIENTE;

drop table CONTRATO;

drop table CONVENIO;

drop table INCIDENCIAS;

drop table INSUMOS;

drop table MANTENIMIENTO;

drop table MANTENIMIENTO_TECNICO;

drop table PAGO;

drop table PLANILLA;

drop table TARIFA;

drop table TECNICO;

drop table TIPO;

/*==============================================================*/
/* Table: CLIENTE                                               */
/*==============================================================*/
create table CLIENTE (
   ID_CLIENTE           VARCHAR(10)          not null,
   CEDULA               VARCHAR(10)          not null,
   NOMBRE               CHAR(80)             not null,
   APELLIDO             CHAR(80)             not null,
   FECHA_NACIMIENTO     DATE                 not null,
   DIRECCION            CHAR(80)             not null,
   TELEFONO             VARCHAR(10)          not null,
   CORREO_ELECTRONICO   CHAR(80)             not null,
   PROVINCIA            CHAR(80)             not null,
   CANTON               CHAR(80)             not null,
   SECTOR               CHAR(80)             not null,
   constraint PK_CLIENTE primary key (ID_CLIENTE)
);

/*==============================================================*/
/* Table: CONTRATO                                              */
/*==============================================================*/
create table CONTRATO (
   ID_MEDIDOR           VARCHAR(10)          not null,
   ID_TIPO              CHAR(80)             null,
   LUGAR_CONTRATO       CHAR(80)             not null,
   FECHA_CONTRATO       DATE                 not null,
   CONSTA_CONVENIO      CHAR(80)             not null,
   constraint PK_CONTRATO primary key (ID_MEDIDOR)
);

/*==============================================================*/
/* Table: CONVENIO                                              */
/*==============================================================*/
create table CONVENIO (
   ID_CONVENIO          VARCHAR(10)          not null,
   ID_CLIENTE           VARCHAR(10)          null,
   ID_MEDIDOR           VARCHAR(10)          null,
   DEUDA_TOTAL          MONEY                not null,
   PAGO_CONVENIO        MONEY                not null,
   FECHA_CONVENIO       DATE                 not null,
   constraint PK_CONVENIO primary key (ID_CONVENIO)
);

/*==============================================================*/
/* Table: INCIDENCIAS                                           */
/*==============================================================*/
create table INCIDENCIAS (
   ID_INCIDENCIA        VARCHAR(10)          not null,
   ID_MEDIDOR           VARCHAR(10)          null,
   INFORMANTE           CHAR(80)             not null,
   CIUDAD               CHAR(80)             not null,
   PROBLEMA             CHAR(80)             not null,
   FECHA_INCIDENCIA     DATE                 not null,
   constraint PK_INCIDENCIAS primary key (ID_INCIDENCIA)
);

/*==============================================================*/
/* Table: INSUMOS                                               */
/*==============================================================*/
create table INSUMOS (
   ID_INSUMO            CHAR(80)             not null,
   ID_TIPO              CHAR(80)             null,
   ID_MANTENIMIENTO     CHAR(80)             null,
   LUGAR_INSTALACION    CHAR(80)             not null,
   FECHA_INSTALACION    DATE                 not null,
   constraint PK_INSUMOS primary key (ID_INSUMO)
);

/*==============================================================*/
/* Table: MANTENIMIENTO                                         */
/*==============================================================*/
create table MANTENIMIENTO (
   ID_MANTENIMIENTO     CHAR(80)             not null,
   ID_INCIDENCIA        VARCHAR(10)          null,
   FECHA_MANTENIMIENTO  DATE                 not null,
   LUGAR_MANTENIMIENTO  CHAR(80)             not null,
   constraint PK_MANTENIMIENTO primary key (ID_MANTENIMIENTO)
);

/*==============================================================*/
/* Table: MANTENIMIENTO_TECNICO                                 */
/*==============================================================*/
create table MANTENIMIENTO_TECNICO (
   ID_TECNICO           VARCHAR(10)          not null,
   ID_MANTENIMIENTO     CHAR(80)             not null,
   constraint PK_MANTENIMIENTO_TECNICO primary key (ID_TECNICO, ID_MANTENIMIENTO)
);

/*==============================================================*/
/* Table: PAGO                                                  */
/*==============================================================*/
create table PAGO (
   ID_PAGO              VARCHAR(10)          not null,
   ID_TARIFA            VARCHAR(10)          null,
   ID_PLANILLA          CHAR(80)             null,
   CONSUMO_KILOVATIO    INT4                 not null,
   COSTO_KILOVATIO      MONEY                not null,
   constraint PK_PAGO primary key (ID_PAGO)
);

/*==============================================================*/
/* Table: PLANILLA                                              */
/*==============================================================*/
create table PLANILLA (
   ID_PLANILLA          CHAR(80)             not null,
   ID_MEDIDOR           VARCHAR(10)          null,
   CONSUMO              INT4                 not null,
   LUGAR_PLANILLA       CHAR(80)             not null,
   FECHA_PLANILLA       DATE                 not null,
   constraint PK_PLANILLA primary key (ID_PLANILLA)
);

/*==============================================================*/
/* Table: TARIFA                                                */
/*==============================================================*/
create table TARIFA (
   ID_TARIFA            VARCHAR(10)          not null,
   ID_CLIENTE           VARCHAR(10)          null,
   CONSUMO_MAXIMO       INT4                 not null,
   CONSUMO_MINIMO       INT4                 not null,
   TIPO_TARIFA          CHAR(80)             not null,
   VALOR                MONEY                not null,
   VALOR_PENALIZADO     MONEY                not null,
   FECHA_TARIFA         DATE                 not null,
   LUGAR_TARIFA         CHAR(80)             not null,
   constraint PK_TARIFA primary key (ID_TARIFA)
);

/*==============================================================*/
/* Table: TECNICO                                               */
/*==============================================================*/
create table TECNICO (
   ID_TECNICO           VARCHAR(10)          not null,
   NOMBRE_TECNICO       CHAR(80)             not null,
   APELLIDO_TECNICO     CHAR(80)             not null,
   TELEFONO_TECNICO     VARCHAR(10)          not null,
   CORREO_TECNICO       CHAR(80)             not null,
   DIRECCION_TECNICO    CHAR(80)             not null,
   constraint PK_TECNICO primary key (ID_TECNICO)
);

/*==============================================================*/
/* Table: TIPO                                                  */
/*==============================================================*/
create table TIPO (
   ID_TIPO              CHAR(80)             not null,
   NOMBRE_TIPO          CHAR(80)             not null,
   constraint PK_TIPO primary key (ID_TIPO)
);

/*==============================================================*/
/* CREACIÓN DE FOREIGN KEY                                      */
/*==============================================================*/

alter table CONTRATO
   add constraint FK_CONTRATO_RELATIONS_TIPO foreign key (ID_TIPO)
      references TIPO (ID_TIPO)
      on delete restrict on update restrict;

alter table CONVENIO
   add constraint FK_CONVENIO_RELATIONS_CLIENTE foreign key (ID_CLIENTE)
      references CLIENTE (ID_CLIENTE)
      on delete restrict on update restrict;

alter table CONVENIO
   add constraint FK_CONVENIO_RELATIONS_CONTRATO foreign key (ID_MEDIDOR)
      references CONTRATO (ID_MEDIDOR)
      on delete restrict on update restrict;

alter table INCIDENCIAS
   add constraint FK_INCIDENC_RELATIONS_CONTRATO foreign key (ID_MEDIDOR)
      references CONTRATO (ID_MEDIDOR)
      on delete restrict on update restrict;

alter table INSUMOS
   add constraint FK_INSUMOS_RELATIONS_MANTENIM foreign key (ID_MANTENIMIENTO)
      references MANTENIMIENTO (ID_MANTENIMIENTO)
      on delete restrict on update restrict;

alter table INSUMOS
   add constraint FK_INSUMOS_RELATIONS_TIPO foreign key (ID_TIPO)
      references TIPO (ID_TIPO)
      on delete restrict on update restrict;

alter table MANTENIMIENTO
   add constraint FK_MANTENIM_RELATIONS_INCIDENC foreign key (ID_INCIDENCIA)
      references INCIDENCIAS (ID_INCIDENCIA)
      on delete restrict on update restrict;

alter table MANTENIMIENTO_TECNICO
   add constraint FK_MANTENIM_RELATIONS_TECNICO foreign key (ID_TECNICO)
      references TECNICO (ID_TECNICO)
      on delete restrict on update restrict;

alter table MANTENIMIENTO_TECNICO
   add constraint FK_MANTENIM_RELATIONS_MANTENIM foreign key (ID_MANTENIMIENTO)
      references MANTENIMIENTO (ID_MANTENIMIENTO)
      on delete restrict on update restrict;

alter table PAGO
   add constraint FK_PAGO_RELATIONS_TARIFA foreign key (ID_TARIFA)
      references TARIFA (ID_TARIFA)
      on delete restrict on update restrict;

alter table PAGO
   add constraint FK_PAGO_RELATIONS_PLANILLA foreign key (ID_PLANILLA)
      references PLANILLA (ID_PLANILLA)
      on delete restrict on update restrict;

alter table PLANILLA
   add constraint FK_PLANILLA_RELATIONS_CONTRATO foreign key (ID_MEDIDOR)
      references CONTRATO (ID_MEDIDOR)
      on delete restrict on update restrict;

alter table TARIFA
   add constraint FK_TARIFA_RELATIONS_CLIENTE foreign key (ID_CLIENTE)
      references CLIENTE (ID_CLIENTE)
      on delete restrict on update restrict;

