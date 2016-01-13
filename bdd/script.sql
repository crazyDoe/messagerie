drop table if exists contact;
drop table if exists contient;
drop table if exists message;
drop table if exists groupe;
drop table if exists personne;

create table personne(
	pseudo text,
	mdp text,

	constraint pk_personne primary key(pseudo)
);

create table contact(
	pseudo_ajout text,
	pseudo_reception text,

	constraint pk_contact primary key(pseudo_ajout, pseudo_reception),
	constraint fk_contact1 foreign key(pseudo_ajout) references personne(pseudo),
	constraint fk_contact2 foreign key(pseudo_reception) references personne(pseudo)
);

create table groupe(
	gno serial,
	nom text,

	constraint pk_groupe primary key(gno)
);

create table message(
	id serial,
	pno text,
	gno integer,
	message text,

	constraint pk_message primary key(id, pno, gno),
	constraint fk_message1 foreign key(pno) references personne(pseudo),
	constraint fk_message2 foreign key(gno) references groupe(gno)
);

create table contient(
	id_groupe integer,
	pseudo_personne text,

	constraint pk_contient primary key(id_groupe, pseudo_personne),
	constraint fk_contient1 foreign key(id_groupe) references groupe(gno),
	constraint fk_contient2 foreign key(pseudo_personne) references personne(pseudo)
);

INSERT INTO personne VALUES ('biche','123456');
INSERT INTO personne VALUES ('zepellin','123123');
INSERT INTO personne VALUES ('admin','admin');
INSERT INTO personne VALUES ('thor','jamesbond');
INSERT INTO personne VALUES ('bryan','123456');
INSERT INTO personne VALUES ('bob','marteau');

INSERT INTO groupe (nom) VALUES('test');
INSERT INTO groupe (nom) VALUES('concert');

INSERT INTO contient VALUES(1,'biche');
INSERT INTO contient VALUES(1,'bryan');
INSERT INTO contient VALUES(1,'bob');
INSERT INTO contient VALUES(1,'thor');
INSERT INTO contient VALUES(2,'thor');
INSERT INTO contient VALUES(2,'bob');

INSERT INTO message (pno,gno,message) VALUES('biche',1,'Hello');
INSERT INTO message (pno,gno,message) VALUES('bryan',1,'Ca va ?');
INSERT INTO message (pno,gno,message) VALUES('bob',2,'Slt oui et toi ?');
INSERT INTO message (pno,gno,message) VALUES('biche',2,'slt');
