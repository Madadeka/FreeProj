--person
CREATE TABLE person (
	id serial4 NOT NULL,
	first_name varchar(150) NOT NULL,
	last_name varchar(150) NOT NULL,
	pat varchar(150) NOT NULL,--отчество
	birth_date timestamp NOT NULL,
	write_date timestamp NOT NULL,
	CONSTRAINT person_pkey PRIMARY KEY (id)
);

--extras
CREATE TABLE extras (
	id serial4 NOT NULL,
	id_person serial4 NOT NULL,
	ext varchar(400) NOT NULL,--справка
	CONSTRAINT extras_pkey PRIMARY KEY (id)
);