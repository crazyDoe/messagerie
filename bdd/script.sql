drop table if exists contact;
drop table if exists contient;
drop table if exists message;
drop table if exists groupe;
drop table if exists personne;

create table personne(
	pseudo text,
	mdp char(256),
	role text not null default 'default',

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
	gno INTEGER PRIMARY KEY AUTOINCREMENT,
	nom text
);

create table message(
	id INTEGER PRIMARY KEY AUTOINCREMENT,
	pno text,
	gno integer,
	message text,
	date text,
	vu integer, /* 1, vu, 0, pas vu */

	constraint fk_message1 foreign key(pno) references personne(pseudo),
	constraint fk_message2 foreign key(gno) references groupe(gno)
);

create table contient(
	id_groupe integer,
	pseudo text,

	constraint pk_contient primary key(id_groupe, pseudo),
	constraint fk_contient1 foreign key(id_groupe) references groupe(gno),
	constraint fk_contient2 foreign key(pseudo) references personne(pseudo)
);


INSERT INTO personne VALUES ('lapin','7b2f2147a674007b92cb0d6856ee0b4660c2b9863e0843df24928187f43eb062','default'); /* lapin - lapin */
INSERT INTO personne VALUES ('leo','a665a45920422f9d417e4867efdc4fb8a04a1f3fff1fa07e998e86f7f7a27ae3','default'); /* leo - 123 */
INSERT INTO personne VALUES ('zighma','0d91c6be27678e391599735c261d67d8ca2da16d2df40a66c279e1aa8b1359d0','default'); /* zighma - chibre */
INSERT INTO personne VALUES ('bryan','8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92','default'); /* bryan - 123456 */
INSERT INTO personne VALUES ('admin','a45031892503571a07f70f86c6cb318f26fdbca9343da6715c7621bf953070a8','default'); /* admin - lolmdr */
INSERT INTO personne VALUES ('bob','f60b5146b1d43e0e1bd8e62ce732b3498c5d7d2cb2491c677560205e4f3c959','default'); /* bob - marteau */
INSERT INTO personne VALUES ('gamingko','505b2e37c5890e12ef5fb861982a19107ad54ed4ee60d3119c37a955bfd48fb5','default'); /* gamingko - starwars59 */
INSERT INTO personne VALUES ('biche','8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92','default'); /* biche - 123456 */
INSERT INTO personne VALUES ('poney','03662a2852282880fe0e247ef90f42e0f8c1ccf0f7b4087ad5cbc4a14b6c206d','default'); /* poney - poney */
INSERT INTO personne VALUES ('philippe','430005175c4c7810996d3481f0dbc3ec01103d6abcc5beec5db4b3f1eae35047','default'); /* philippe - mysql */
INSERT INTO personne VALUES ('sebastien','21ce078705d04ca6324c1d0313fc08ea99f3cef6389a6744d40bd2d9d0cd7816','default'); /* sebastien - recursive */
