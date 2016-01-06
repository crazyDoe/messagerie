drop table if exists contient;
drop table if exists message;
drop table if exists groupe;
drop table if exists contact;
drop table if exists personne;

create table personne(
	pno serial,
	pseudo text,
	mdp text,
	avatar text,

	constraint pk_personne primary key(pno)
);

create table contact(
	id_ajout integer,
	id_reception integer,

	constraint pk_contact primary key(id_ajout, id_reception),
	constraint fk_contact1 foreign key(id_ajout) references personne(pno), 
	constraint fk_contact2 foreign key(id_reception) references personne(pno)
);

create table groupe(
	gno serial,
	nom text,

	constraint pk_groupe primary key(gno)
);

create table message(
	pno integer,
	gno integer,
	message text,

	constraint pk_message primary key(pno, gno),
	constraint fk_message1 foreign key(pno) references personne(pno), 
	constraint fk_message2 foreign key(gno) references groupe(gno)
);

create table contient(
	id_groupe integer,
	id_personne integer,

	constraint pk_contient primary key(id_groupe, id_personne),
	constraint fk_contient1 foreign key(id_groupe) references groupe(gno), 
	constraint fk_contient2 foreign key(id_personne) references personne(pno)
);