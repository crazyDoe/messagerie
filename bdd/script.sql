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
