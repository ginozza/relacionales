CREATE TABLE Géneros (
  idGénero INT NOT NULL PRIMARY KEY,
  nombre VARCHAR(100) NOT NULL,
  descripción VARCHAR(580)
);

CREATE TABLE Planes(
  idPlan INT NOT NULL PRIMARY KEY,
  nombre VARCHAR(100) NOT NULL,
  costoUsuario MONEY NOT NULL,
  fechaInicioVigencia DATE NOT NULL,
  fechaFinVigencia DATE NOT NULL
);

CREATE TABLE Álbumes (
  idAlbum INT NOT NULL PRIMARY KEY,
  título VARCHAR(100) NOT NULL,
  selloDiscográfico VARCHAR(100) NOT NULL,
  fechaLanzamiento DATE NOT NULL
);

CREATE TABLE Usuarios (
  idUsuario INT NOT NULL PRIMARY KEY,
  email VARCHAR(254) NOT NULL,
  contraseña VARCHAR(128) NOT NULL,
  nombres VARCHAR(100) NOT NULL,
  apellidos VARCHAR(100) NOT NULL,
  sexo VARCHAR(30) NOT NULL,
  fechaNacimiento DATE NOT NULL,
  paísNacimiento VARCHAR(100) NOT NULL,
  paísResidencia VARCHAR(100) NOT NULL,
  idioma VARCHAR(30) NOT NULL,
  fechaRegistro DATE NOT NULL
);

CREATE TABLE Pagos (
   idPago INT NOT NULL PRIMARY KEY,
   idPlan INT NOT NULL,
   idUsuario INT NOT NULL,
   fechaPago DATE NOT NULL,
   montoPagado MONEY NOT NULL,
   FOREIGN KEY (idPlan) REFERENCES Planes(idPlan),
   FOREIGN KEY (idUsuario) REFERENCES Usuarios(idUsuario)
);

CREATE TABLE Músicos(
   idMúsico INT NOT NULL PRIMARY KEY,
   nombres VARCHAR(100) NOT NULL,
   apellidos VARCHAR(100) NOT NULL,
   sexo VARCHAR(30) NOT NULL,
   especialidadMusical VARCHAR(30) NOT NULL,
   fechaNacimiento DATE NOT NULL,
   paísNacimiento VARCHAR(100) NOT NULL,
   fechaFallecimiento DATE NULL,
   paísFallecimiento VARCHAR(100) NULL
);

CREATE TABLE Intérpretes (
  idIntérprete INT NOT NULL PRIMARY KEY,
  nombre VARCHAR(200) NOT NULL,
  añoLanzamiento INT NOT NULL,
  añoRetiro INT NULL,
  tipoIntérprete VARCHAR(10) NOT NULL,
  idGéneroPrincipal INT NOT NULL,
  FOREIGN KEY (idGéneroPrincipal) REFERENCES Géneros(idGénero)
);

CREATE TABLE Canciones (
  idCanción INT NOT NULL PRIMARY KEY,
  título VARCHAR(100) NOT NULL,
  duración TIME(0) NOT NULL,
  tempoBPM INT,
  idioma VARCHAR(30) NOT NULL,
  esInstrumental BIT NOT NULL,
  fechaLanzamiento DATE NOT NULL,
  idÁlbumOriginal INT NULL,
  idGénero INT NOT NULL,
  idIntérpretePrincipal INT NOT NULL,
  FOREIGN KEY (idÁlbumOriginal) REFERENCES Álbumes(idAlbum),
  FOREIGN KEY (idGénero) REFERENCES Géneros(idGénero),
  FOREIGN KEY (idIntérpretePrincipal) REFERENCES Intérpretes(idIntérprete)
);

CREATE TABLE Compositores(
   idCanción INT NOT NULL,
   idMúsicoCompositor INT NOT NULL,
   PRIMARY KEY (idCanción, idMúsicoCompositor),
   FOREIGN KEY (idCanción) REFERENCES Canciones(idCanción),
   FOREIGN KEY (idMúsicoCompositor) REFERENCES Músicos(idMúsico)
);


CREATE TABLE Solistas(
   idIntérpreteSolista INT NOT NULL,
   idMúsico INT NOT NULL,
   PRIMARY KEY (idIntérpreteSolista, idMúsico),
   FOREIGN KEY (idIntérpreteSolista) REFERENCES Intérpretes(idIntérprete),
   FOREIGN KEY (idMúsico) REFERENCES Músicos(idMúsico)
);


CREATE TABLE ParticipacionesEnGrupos(
	idParticipación INT NOT NULL PRIMARY KEY,
	idIntérpreteGrupo INT NOT NULL,
	idMúsico INT NOT NULL,
	rol VARCHAR(100) NOT NULL,
	fechaVinculación DATE NOT NULL,
	fechaRetiro DATE NULL,
    FOREIGN KEY (idIntérpreteGrupo) REFERENCES Intérpretes(idIntérprete),
    FOREIGN KEY (idMúsico) REFERENCES Músicos(idMúsico)
);


CREATE TABLE Calificaciones (
  idUsuario INT NOT NULL,
  idCanción INT NOT NULL,
  calificación INT NOT NULL,
  comentario VARCHAR(280),
  fechaCalificación DATE NOT NULL,
  horaCalificación TIME(0) NOT NULL,
  PRIMARY KEY (idUsuario, idCanción),
  FOREIGN KEY (idUsuario) REFERENCES Usuarios(idUsuario),
  FOREIGN KEY (idCanción) REFERENCES Canciones(idCanción)
);
CREATE TABLE Reproducciones (
  idReproducción INT NOT NULL PRIMARY KEY,
  idUsuario INT NOT NULL,
  idCanción INT NOT NULL,
  fechaReproducción DATE NOT NULL,
  horaReproducción TIME NOT NULL,
  segundosReproducidos INT NOT NULL,
  FOREIGN KEY (idUsuario) REFERENCES Usuarios(idUsuario),
  FOREIGN KEY (idCanción) REFERENCES Canciones(idCanción)
);
CREATE TABLE ListasReproducción (
  idListaReproducción INT NOT NULL PRIMARY KEY,
  idUsuario INT NOT NULL,
  título VARCHAR(100) NOT NULL,
  fechaCreación DATE NOT NULL,
  FOREIGN KEY (idUsuario) REFERENCES Usuarios(idUsuario)
  );
CREATE TABLE CancionesLista (
  idListaReproducción INT NOT NULL,
  idCanción INT NOT NULL,
  lugarEnLista INT NOT NULL,
  fechaInclusión DATE NOT NULL,
  horaInclusión TIME NOT NULL,
  PRIMARY KEY (idListaReproducción, idCanción),
  FOREIGN KEY (idListaReproducción) REFERENCES ListasReproducción(idListaReproducción),
  FOREIGN KEY (idCanción) REFERENCES Canciones(idCanción)
);

---Géneros
INSERT INTO Géneros VALUES(1,'Pop','La expresión música pop (del inglés pop music, contracción de popular music) hace referencia a una combinación de distintos géneros musicales [altamente populares dentro de una sociedad. Este tipo de música es hecha para ser altamente comercializada.');
INSERT INTO Géneros VALUES(2,'Rock','El rock es un género musical que surgió a partir de la combinación de otros tipos musicales preexistentes, principalmente el rhythm and blues y el country. La música rock también abarcó y sirvió de vehículo para los movimientos culturales y sociales, lo que llevó a la creación de subculturas y contracultura.');
INSERT INTO Géneros VALUES(3,'Salsa','La salsa es el nombre comercial dado, en la década de 1960, al género musical resultante de una síntesis de influencias musicales cubanas con otros elementos de música caribeña, latinoamericana y jazz, en especial el jazz afrocubano.');
INSERT INTO Géneros VALUES(4,'Vallenato','El vallenato es un género musical autóctono de la Región Caribe de Colombia. El vallenato tiene cuatro ritmos, cuatro aires, como dicen en Valledupar: paseo, son, puya y merengue (no hay que confundir son y merengue con el son cubano y el merengue dominicano). Y son totalmente distintos uno de otros.');
INSERT INTO Géneros VALUES(5,'Reggaeton','El reggaetón o reguetón es un género de música que nace como fenómeno underground entre las barriadas rurales de Panamá y Puerto Rico, variante del reggae y el Hip-Hop en español, influenciado por ritmos latinos y tomando como base rítmica el danceHall reggae mejor conocido como dembow originario de Jamaica.');
INSERT INTO Géneros VALUES(6,'Andina colombiana','Música andina es un término que se aplica a una gama muy vasta de géneros musicales originados en los Andes de Colombia. La música andina colombiana es muy amplia y variada, ya que cada región le imprime su toque cultural, derivando varios ritmos entre los cuales esta el bambuco, guabina, torbellino , sanjuanero, carranga, guasca, pasillo, rajaleña.');
INSERT INTO Géneros VALUES(7,'Reggae','Reggae es un término inglés que permite nombrar a un estilo musical que se originó en Jamaica durante la década de 1960. Se trata de un género que derivó del rocksteady y del ska y que tiene como principal característica la repetición constante de su ritmo.');
INSERT INTO Géneros VALUES(8,'Merengue',NULL);
INSERT INTO Géneros VALUES(9,'Latina fusión',NULL);
INSERT INTO Géneros VALUES(10,'Soul',NULL);

--Planes
INSERT INTO Planes VALUES(1,'Individual',30000,'01/01/2020','01/01/2024');
INSERT INTO Planes VALUES(2,'Amigo',50350,'08/02/2016','01/01/2024');
INSERT INTO Planes VALUES(3,'Familar',102435,'12/12/2017','01/01/2024');

--Álbumes
INSERT INTO Álbumes VALUES(1,'La tierra del olvido','Polygram','1995-07-25');
INSERT INTO Álbumes VALUES(2,'Vives','Sony Music Latin','2017-11-10');
INSERT INTO Álbumes VALUES(3,'Cielo de tambores','Codiscos','1990-12-20');
INSERT INTO Álbumes VALUES(4,'Huellas del pasado','Codiscos','1995-01-31');
INSERT INTO Álbumes VALUES(5,'Oral Fixation, Vol. 2','Epic','2005-11-28');
INSERT INTO Álbumes VALUES(6,'¿Dónde están los ladrones?','Sony Music Latin','1998-09-29');
INSERT INTO Álbumes VALUES(7,'El Dorado','BMG','1995-10-24');
INSERT INTO Álbumes VALUES(8,'Caribe atómico','BMG','1998-06-23');
INSERT INTO Álbumes VALUES(9,'Título de amor','Sony Music Latin','1993-05-25');
INSERT INTO Álbumes VALUES(10,'Brindo con el alma','CBS','1986-05-27');
INSERT INTO Álbumes VALUES(11,'El mismo','Sony Music Latin','2015-05-06');
INSERT INTO Álbumes VALUES(12,'Oro','Nacional Records','2010-03-02');
INSERT INTO Álbumes VALUES(13,'Vibras ','Universal Music','2018-05-25');
INSERT INTO Álbumes VALUES(14,'Energía','Universal Music','2016-06-24');
INSERT INTO Álbumes VALUES(15,'Pescador, Lucero y Río','El Gallo Productions','1993-12-22');
INSERT INTO Álbumes VALUES(16,'Herencia africana: Salsa de Colombia','PolyGram France','1998-06-30');
INSERT INTO Álbumes VALUES(17,'El Binomio de Oro','Codiscos','1976-09-15');
INSERT INTO Álbumes VALUES(18,'2000','Codiscos','1998-09-30');
INSERT INTO Álbumes VALUES(19,'Pies descalzos','Sony Music Latin','1995-10-06');
INSERT INTO Álbumes VALUES(20,'Déjame entrar','EMI Latin','2001-11-06');

--Usuarios
INSERT INTO Usuarios VALUES(1,'alex@gmail.com','81dc9bdb52d04dc20036dbd8313ed055','Alexander','Buenahora','M','1988-08-27','Colombia','España','Español','2020-01-01');
INSERT INTO Usuarios VALUES(2,'ernesto@hotmail.com','81b073de9370ea873f548e31b8adc081','Ernesto','Gonzalez','M','1980-03-23','Venezuela','Colombia','Español','2019-12-20');
INSERT INTO Usuarios VALUES(3,'rene.metodo@gmail.com','def7924e3199be5e18060bb3e1d547a7','René','Descartes','F','2000-01-01','Francia','Francia','Francés','2021-02-13');
INSERT INTO Usuarios VALUES(4,'fatima@yahoo.com','6562c5c1f33db6e05a082a88cddab5ea','Fatme','Issa','F','1976-07-11','Ecuador','Ecuador','Español','2021-01-30');
INSERT INTO Usuarios VALUES(5,'panteismo@gmail.com','674f3c2c1a8a6f90461e8a66fb5550ba','Baruch ','Spinoza','M','1970-06-06','Holanda','Portugal','Holandés','2020-06-13');
INSERT INTO Usuarios VALUES(6,'marie.curie@gmail.com','46d045ff5190f6ea93739da6c0aa19bc','Marie','Curie ','F','1992-09-06','Francia','Venezuela','Francés','2018-05-12');
INSERT INTO Usuarios VALUES(7,'ana.frank@hotmail.com','cdaeb1282d614772beb1e74c192bebda','Ana','Frank','F','1998-06-22','Alemania','Alemania','Alemán','2017-02-24');
INSERT INTO Usuarios VALUES(8,'piedad.bonnett@gmail.com','f4d87ed3b0dbf9c79746d00cedbb5e78','Piedad','Bonnett','F','1951-06-15','Colombia','Colombia','Español','2020-06-17');
INSERT INTO Usuarios VALUES(9,'elcontratosocial@yahoo.com','c5c53759e4dd1bfe8b3dcfec37d0ea72','Jean-Jacques','Rousseau','M','1987-08-08','Suiza','Francia','Francés','2020-09-12');
INSERT INTO Usuarios VALUES(10,'laciencia.bunge@hotmail.com','eb62f6b9306db575c2d596b1279627a4','Mario','Bunge','M','1919-09-21','Argentina','Canadá','Español','2020-11-08');


--Pagos
INSERT INTO public.pagos VALUES (1, 1, 1, '2020-01-01', 30000.00);
INSERT INTO public.pagos VALUES (2, 1, 1, '2020-02-01', 30000.00);
INSERT INTO public.pagos VALUES (3, 1, 1, '2020-03-03', 30000.00);
INSERT INTO public.pagos VALUES (4, 1, 1, '2020-04-03', 30000.00);
INSERT INTO public.pagos VALUES (5, 1, 1, '2020-05-04', 30000.00);
INSERT INTO public.pagos VALUES (6, 1, 1, '2020-06-04', 30000.00);
INSERT INTO public.pagos VALUES (7, 1, 1, '2020-07-05', 30000.00);
INSERT INTO public.pagos VALUES (8, 1, 1, '2020-08-05', 30000.00);
INSERT INTO public.pagos VALUES (9, 1, 1, '2020-09-05', 30000.00);
INSERT INTO public.pagos VALUES (10, 1, 1, '2020-10-06', 30000.00);
INSERT INTO public.pagos VALUES (11, 1, 1, '2020-11-06', 30000.00);
INSERT INTO public.pagos VALUES (12, 1, 1, '2020-12-07', 30000.00);
INSERT INTO public.pagos VALUES (13, 1, 1, '2021-01-07', 30000.00);
INSERT INTO public.pagos VALUES (14, 1, 1, '2021-02-07', 30000.00);
INSERT INTO public.pagos VALUES (15, 1, 1, '2021-03-10', 30000.00);
INSERT INTO public.pagos VALUES (16, 1, 1, '2021-04-10', 30000.00);
INSERT INTO public.pagos VALUES (18, 1, 2, '2020-01-20', 30000.00);
INSERT INTO public.pagos VALUES (19, 1, 2, '2020-02-20', 30000.00);
INSERT INTO public.pagos VALUES (20, 1, 2, '2020-03-22', 30000.00);
INSERT INTO public.pagos VALUES (21, 1, 2, '2020-04-22', 30000.00);
INSERT INTO public.pagos VALUES (22, 1, 2, '2020-05-23', 30000.00);
INSERT INTO public.pagos VALUES (23, 1, 2, '2020-06-23', 30000.00);
INSERT INTO public.pagos VALUES (24, 1, 2, '2020-07-24', 30000.00);
INSERT INTO public.pagos VALUES (25, 1, 2, '2020-08-24', 30000.00);
INSERT INTO public.pagos VALUES (26, 1, 2, '2020-09-24', 30000.00);
INSERT INTO public.pagos VALUES (27, 1, 2, '2020-10-25', 30000.00);
INSERT INTO public.pagos VALUES (28, 1, 2, '2020-11-25', 30000.00);
INSERT INTO public.pagos VALUES (29, 1, 2, '2020-12-26', 30000.00);
INSERT INTO public.pagos VALUES (30, 1, 2, '2021-01-26', 30000.00);
INSERT INTO public.pagos VALUES (31, 1, 2, '2021-02-26', 30000.00);
INSERT INTO public.pagos VALUES (32, 1, 2, '2021-03-29', 30000.00);
INSERT INTO public.pagos VALUES (33, 2, 3, '2021-02-13', 50350.00);
INSERT INTO public.pagos VALUES (34, 2, 3, '2021-03-14', 50350.00);
INSERT INTO public.pagos VALUES (35, 2, 4, '2021-01-30', 50350.00);
INSERT INTO public.pagos VALUES (36, 2, 4, '2021-02-22', 50350.00);
INSERT INTO public.pagos VALUES (37, 2, 4, '2021-03-17', 50350.00);
INSERT INTO public.pagos VALUES (38, 2, 4, '2021-04-09', 50350.00);
INSERT INTO public.pagos VALUES (39, 2, 5, '2020-06-13', 50350.00);
INSERT INTO public.pagos VALUES (40, 2, 5, '2020-07-14', 50350.00);
INSERT INTO public.pagos VALUES (41, 2, 5, '2020-08-14', 50350.00);
INSERT INTO public.pagos VALUES (42, 2, 5, '2020-09-14', 50350.00);
INSERT INTO public.pagos VALUES (43, 2, 5, '2020-10-15', 50350.00);
INSERT INTO public.pagos VALUES (44, 2, 5, '2020-11-15', 50350.00);
INSERT INTO public.pagos VALUES (45, 2, 5, '2020-12-16', 50350.00);
INSERT INTO public.pagos VALUES (46, 2, 5, '2021-01-16', 50350.00);
INSERT INTO public.pagos VALUES (47, 2, 5, '2021-02-16', 50350.00);
INSERT INTO public.pagos VALUES (48, 2, 5, '2021-03-19', 50350.00);
INSERT INTO public.pagos VALUES (49, 2, 6, '2018-05-12', 50350.00);
INSERT INTO public.pagos VALUES (50, 2, 6, '2018-06-12', 50350.00);
INSERT INTO public.pagos VALUES (51, 2, 6, '2018-07-13', 50350.00);
INSERT INTO public.pagos VALUES (52, 2, 6, '2018-08-13', 50350.00);
INSERT INTO public.pagos VALUES (53, 2, 6, '2018-09-13', 50350.00);
INSERT INTO public.pagos VALUES (54, 2, 6, '2018-10-14', 50350.00);
INSERT INTO public.pagos VALUES (55, 2, 6, '2018-11-14', 50350.00);
INSERT INTO public.pagos VALUES (56, 2, 6, '2018-12-15', 50350.00);
INSERT INTO public.pagos VALUES (57, 2, 6, '2019-01-15', 50350.00);
INSERT INTO public.pagos VALUES (58, 2, 6, '2019-02-15', 50350.00);
INSERT INTO public.pagos VALUES (59, 2, 6, '2019-03-18', 50350.00);
INSERT INTO public.pagos VALUES (60, 2, 6, '2019-04-18', 50350.00);
INSERT INTO public.pagos VALUES (61, 2, 6, '2019-05-19', 50350.00);
INSERT INTO public.pagos VALUES (62, 2, 6, '2019-06-19', 50350.00);
INSERT INTO public.pagos VALUES (63, 2, 6, '2019-07-20', 50350.00);
INSERT INTO public.pagos VALUES (64, 2, 6, '2019-08-20', 50350.00);
INSERT INTO public.pagos VALUES (65, 2, 6, '2019-09-20', 50350.00);
INSERT INTO public.pagos VALUES (66, 2, 6, '2019-10-21', 50350.00);
INSERT INTO public.pagos VALUES (67, 2, 6, '2019-11-21', 50350.00);
INSERT INTO public.pagos VALUES (68, 2, 6, '2019-12-22', 50350.00);
INSERT INTO public.pagos VALUES (69, 2, 6, '2020-01-22', 50350.00);
INSERT INTO public.pagos VALUES (70, 2, 6, '2020-02-22', 50350.00);
INSERT INTO public.pagos VALUES (71, 2, 6, '2020-03-24', 50350.00);
INSERT INTO public.pagos VALUES (72, 2, 6, '2020-04-24', 50350.00);
INSERT INTO public.pagos VALUES (73, 2, 6, '2020-05-25', 50350.00);
INSERT INTO public.pagos VALUES (74, 2, 6, '2020-06-25', 50350.00);
INSERT INTO public.pagos VALUES (75, 2, 6, '2020-07-26', 50350.00);
INSERT INTO public.pagos VALUES (76, 2, 6, '2020-08-26', 50350.00);
INSERT INTO public.pagos VALUES (77, 2, 6, '2020-09-26', 50350.00);
INSERT INTO public.pagos VALUES (78, 2, 6, '2020-10-27', 50350.00);
INSERT INTO public.pagos VALUES (79, 2, 6, '2020-11-27', 50350.00);
INSERT INTO public.pagos VALUES (80, 2, 6, '2020-12-28', 50350.00);
INSERT INTO public.pagos VALUES (81, 2, 6, '2021-01-28', 50350.00);
INSERT INTO public.pagos VALUES (82, 2, 6, '2021-02-28', 50350.00);
INSERT INTO public.pagos VALUES (83, 2, 6, '2021-03-31', 50350.00);
INSERT INTO public.pagos VALUES (105, 2, 7, '2018-12-07', 50350.00);
INSERT INTO public.pagos VALUES (106, 2, 7, '2019-01-07', 50350.00);
INSERT INTO public.pagos VALUES (107, 2, 7, '2019-02-07', 50350.00);
INSERT INTO public.pagos VALUES (108, 2, 7, '2019-03-10', 50350.00);
INSERT INTO public.pagos VALUES (109, 2, 7, '2019-04-10', 50350.00);
INSERT INTO public.pagos VALUES (110, 2, 7, '2019-05-11', 50350.00);
INSERT INTO public.pagos VALUES (111, 2, 7, '2019-06-11', 50350.00);
INSERT INTO public.pagos VALUES (112, 2, 7, '2019-07-12', 50350.00);
INSERT INTO public.pagos VALUES (113, 2, 7, '2019-08-12', 50350.00);
INSERT INTO public.pagos VALUES (114, 2, 7, '2019-09-12', 50350.00);
INSERT INTO public.pagos VALUES (115, 2, 7, '2019-10-13', 50350.00);
INSERT INTO public.pagos VALUES (116, 2, 7, '2019-11-13', 50350.00);
INSERT INTO public.pagos VALUES (117, 2, 7, '2019-12-14', 50350.00);
INSERT INTO public.pagos VALUES (118, 2, 7, '2020-01-14', 50350.00);
INSERT INTO public.pagos VALUES (119, 2, 7, '2020-02-14', 50350.00);
INSERT INTO public.pagos VALUES (120, 2, 7, '2020-03-16', 50350.00);
INSERT INTO public.pagos VALUES (121, 2, 7, '2020-04-16', 50350.00);
INSERT INTO public.pagos VALUES (122, 2, 7, '2020-05-17', 50350.00);
INSERT INTO public.pagos VALUES (123, 2, 7, '2020-06-17', 50350.00);
INSERT INTO public.pagos VALUES (124, 2, 7, '2020-07-18', 50350.00);
INSERT INTO public.pagos VALUES (125, 2, 7, '2020-08-18', 50350.00);
INSERT INTO public.pagos VALUES (126, 1, 7, '2020-09-18', 30000.00);
INSERT INTO public.pagos VALUES (127, 1, 7, '2020-10-19', 30000.00);
INSERT INTO public.pagos VALUES (128, 1, 7, '2020-11-19', 30000.00);
INSERT INTO public.pagos VALUES (129, 1, 7, '2020-12-20', 30000.00);
INSERT INTO public.pagos VALUES (130, 1, 7, '2021-01-20', 30000.00);
INSERT INTO public.pagos VALUES (131, 1, 7, '2021-02-20', 30000.00);
INSERT INTO public.pagos VALUES (132, 1, 7, '2021-03-23', 30000.00);
INSERT INTO public.pagos VALUES (133, 2, 8, '2020-06-17', 50350.00);
INSERT INTO public.pagos VALUES (134, 2, 8, '2020-07-18', 50350.00);
INSERT INTO public.pagos VALUES (135, 2, 8, '2020-08-18', 50350.00);
INSERT INTO public.pagos VALUES (136, 2, 8, '2020-09-18', 50350.00);
INSERT INTO public.pagos VALUES (137, 2, 8, '2020-10-19', 50350.00);
INSERT INTO public.pagos VALUES (138, 2, 8, '2020-11-19', 50350.00);
INSERT INTO public.pagos VALUES (139, 2, 8, '2020-12-20', 50350.00);
INSERT INTO public.pagos VALUES (140, 2, 8, '2021-01-20', 50350.00);
INSERT INTO public.pagos VALUES (141, 2, 8, '2021-02-20', 50350.00);
INSERT INTO public.pagos VALUES (142, 2, 8, '2021-03-23', 50350.00);
INSERT INTO public.pagos VALUES (143, 2, 9, '2020-09-12', 50350.00);
INSERT INTO public.pagos VALUES (144, 2, 9, '2020-10-13', 50350.00);
INSERT INTO public.pagos VALUES (145, 2, 9, '2020-11-13', 50350.00);
INSERT INTO public.pagos VALUES (146, 2, 9, '2020-12-14', 50350.00);
INSERT INTO public.pagos VALUES (147, 2, 9, '2021-01-14', 50350.00);
INSERT INTO public.pagos VALUES (148, 2, 9, '2021-02-14', 50350.00);
INSERT INTO public.pagos VALUES (149, 2, 9, '2021-03-17', 50350.00);
INSERT INTO public.pagos VALUES (150, 1, 10, '2020-11-08', 30000.00);
INSERT INTO public.pagos VALUES (151, 1, 10, '2020-12-09', 30000.00);
INSERT INTO public.pagos VALUES (152, 1, 10, '2021-01-09', 30000.00);
INSERT INTO public.pagos VALUES (153, 1, 10, '2021-02-09', 30000.00);
INSERT INTO public.pagos VALUES (154, 1, 10, '2021-03-12', 30000.00);
INSERT INTO public.pagos VALUES (155, 1, 10, '2021-04-12', 30000.00);
INSERT INTO public.pagos VALUES (17, 1, 2, '2020-01-03', 30000.00);
INSERT INTO public.pagos VALUES (84, 1, 7, '2020-01-10', 30000.00);
INSERT INTO public.pagos VALUES (85, 1, 7, '2020-01-11', 30000.00);
INSERT INTO public.pagos VALUES (86, 1, 7, '2020-01-08', 30000.00);
INSERT INTO public.pagos VALUES (87, 1, 7, '2020-01-10', 30000.00);
INSERT INTO public.pagos VALUES (88, 1, 7, '2020-01-07', 30000.00);
INSERT INTO public.pagos VALUES (89, 1, 7, '2020-01-04', 30000.00);
INSERT INTO public.pagos VALUES (90, 1, 7, '2020-01-10', 30000.00);
INSERT INTO public.pagos VALUES (91, 1, 7, '2020-01-02', 30000.00);
INSERT INTO public.pagos VALUES (92, 1, 7, '2020-01-08', 30000.00);
INSERT INTO public.pagos VALUES (93, 1, 7, '2020-01-03', 30000.00);
INSERT INTO public.pagos VALUES (94, 1, 7, '2020-01-04', 30000.00);
INSERT INTO public.pagos VALUES (95, 1, 7, '2020-01-06', 30000.00);
INSERT INTO public.pagos VALUES (96, 1, 7, '2020-01-10', 30000.00);
INSERT INTO public.pagos VALUES (97, 1, 7, '2020-01-11', 30000.00);
INSERT INTO public.pagos VALUES (98, 1, 7, '2020-01-02', 30000.00);
INSERT INTO public.pagos VALUES (99, 1, 7, '2020-01-08', 30000.00);
INSERT INTO public.pagos VALUES (100, 1, 7, '2020-01-09', 30000.00);
INSERT INTO public.pagos VALUES (101, 1, 7, '2020-01-11', 30000.00);
INSERT INTO public.pagos VALUES (102, 1, 7, '2020-01-07', 30000.00);
INSERT INTO public.pagos VALUES (103, 1, 7, '2020-01-08', 30000.00);
INSERT INTO public.pagos VALUES (104, 1, 7, '2020-01-10', 30000.00);

--Músicos
INSERT INTO Músicos Values(1,'Carlos','vives','M','Vocalista','07/08/1961','Colombia',Null,NULL);
INSERT INTO Músicos Values(2,'Ivan','Benavides','M','Escritor','07/08/1948','Colombia',Null,NULL);
INSERT INTO Músicos Values(3,'Charlie ','Cardona','M','Vocalista','08/07/1970','Colombia',Null,NULL);
INSERT INTO Músicos Values(4,'Saulo','Sánchez','M','Vocalista','07/08/1960','Colombia',Null,NULL);
INSERT INTO Músicos Values(5,'Jairo ','Varela','M','Vocalista','09/12/1949','Colombia','08/08/2012','Colombia');
INSERT INTO Músicos Values(6,'Tito ','Gómez','M','Vocalista','09/04/1948','Puerto Rico','12/06/2007','Colombia');

--Intérpretes
INSERT INTO Intérpretes Values(1,'Carlos Vives',1986,NULL,'Solista',4);
INSERT INTO Intérpretes Values(2,'Grupo Niche',1979,NULL,'Grupo',3);
INSERT INTO Intérpretes Values(3,'Shakira',1990,NULL,'Solista',1);
INSERT INTO Intérpretes Values(4,'Aterciopelados',1990,NULL,'Grupo',2);
INSERT INTO Intérpretes Values(5,'Diomedes Díaz',1975,2013,'Solista',4);
INSERT INTO Intérpretes Values(6,'ChocQuibTown',2000,NULL,'Grupo',1);
INSERT INTO Intérpretes Values(7,'J Balvin',2006,NULL,'Solista',5);
INSERT INTO Intérpretes Values(8,'Silva y Villalba',1966,2018,'Grupo',7);
INSERT INTO Intérpretes Values(9,'Yuri Buenaventura',1996,NULL,'Solista',3);
INSERT INTO Intérpretes Values(10,'El binomio de oro de América',1976,NULL,'Grupo',4);

--Canciones
INSERT INTO Canciones VALUES(1,'La tierra del olvido','00:04:25',101,'español','0','1995-07-25',1,9,1);
INSERT INTO Canciones VALUES(2,'La bicicleta','00:03:47',90,'español','0','2016-05-27',2,9,1);
INSERT INTO Canciones VALUES(3,'Una aventura','00:05:16',186,'español','0','1990-12-20',3,3,2);
INSERT INTO Canciones VALUES(4,'Gotas de lluvia','00:05:54',194,'español','0','1995-01-31',4,3,2);
INSERT INTO Canciones VALUES(5,'Hips dont lie','00:03:38',100,'inglés','0','2005-11-28',5,1,3);
INSERT INTO Canciones VALUES(6,'Ojos así','00:03:55',127,'español','0','1998-09-29',6,1,3);
INSERT INTO Canciones VALUES(7,'Bolero falaz','00:03:45',112,'español','0','1995-10-24',7,2,4);
INSERT INTO Canciones VALUES(8,'Maligno','00:04:09',90,'español','0','1998-06-23',8,2,4);
INSERT INTO Canciones VALUES(9,'Amarte mas no pude','00:04:49',157,'español','0','1993-05-25',9,4,5);
INSERT INTO Canciones VALUES(10,'Sin medir distancias','00:04:58',162,'español','0','1986-05-27',10,4,5);
INSERT INTO Canciones VALUES(11,'Cuando te veo','00:03:51',89,'español','0','2015-05-06',11,9,6);
INSERT INTO Canciones VALUES(12,'De donde vengo yo','00:04:21',93,'español','0','2010-03-02',12,9,6);
INSERT INTO Canciones VALUES(13,'Mi gente','00:03:09',105,'español','0','2017-06-29',13,5,7);
INSERT INTO Canciones VALUES(14,'Ginza','00:02:51',102,'español','0','2015-07-17',14,5,7);
INSERT INTO Canciones VALUES(15,'Las acacias','00:04:04',95,'español','0','1993-12-22',15,6,8);
INSERT INTO Canciones VALUES(16,'Oropel','00:02:28',143,'español','0','1993-12-22',15,6,8);
INSERT INTO Canciones VALUES(17,'Ne me quitte pas','00:05:37',172,'francés','0','1998-06-30',16,3,9);
INSERT INTO Canciones VALUES(18,'Cali es sabrosura','00:03:14',184,'español','0','2018-08-24',NULL,3,9);
INSERT INTO Canciones VALUES(19,'La creciente','00:03:02',147,'español','0','1976-09-15',17,4,10);
INSERT INTO Canciones VALUES(20,'Olvídala','00:05:04',132,'español','0','1998-09-30',18,4,10);


--Compositor
INSERT INTO Compositores Values(1,1);
INSERT INTO Compositores Values(1,2);

--Solistas
INSERT INTO Solistas Values(1,1);

--ParticipacionesEnGrupos
INSERT INTO ParticipacionesEnGrupos VALUES (1,2,3,'Voz principal','08/08/1900',Null);
INSERT INTO ParticipacionesEnGrupos VALUES (2,2,4,'Piano','08/08/1900','08/08/2020');
INSERT INTO ParticipacionesEnGrupos VALUES (3,2,5,'Maracas','08/08/1900',Null);
INSERT INTO ParticipacionesEnGrupos VALUES (4,2,6,'Bajo','08/08/1900','08/08/2021');

--Calificaciones
INSERT INTO Calificaciones VALUES(1,14,5,NULL,'03-18-2021','05:33:13');
INSERT INTO Calificaciones VALUES(1,1,4,NULL,'03-11-2021','22:45:15');
INSERT INTO Calificaciones VALUES(1,2,5,NULL,'07-24-2021','08:33:09');
INSERT INTO Calificaciones VALUES(1,7,5,NULL,'03-23-2020','11:18:42');
INSERT INTO Calificaciones VALUES(1,12,4,NULL,'07-10-2021','00:17:21');
INSERT INTO Calificaciones VALUES(1,4,2,NULL,'05-25-2020','21:03:41');
INSERT INTO Calificaciones VALUES(1,3,2,NULL,'03-07-2020','05:13:51');
INSERT INTO Calificaciones VALUES(1,19,5,NULL,'07-18-2021','15:04:10');
INSERT INTO Calificaciones VALUES(1,5,4,NULL,'03-15-2021','00:26:09');
INSERT INTO Calificaciones VALUES(2,9,3,NULL,'12-25-2019','06:30:26');
INSERT INTO Calificaciones VALUES(2,14,5,NULL,'12-20-2019','08:54:11');
INSERT INTO Calificaciones VALUES(2,11,1,NULL,'12-28-2020','10:40:56');
INSERT INTO Calificaciones VALUES(2,7,1,NULL,'12-24-2019','08:10:10');
INSERT INTO Calificaciones VALUES(2,10,1,NULL,'12-27-2020','13:21:59');
INSERT INTO Calificaciones VALUES(2,8,5,NULL,'12-26-2019','09:29:20');
INSERT INTO Calificaciones VALUES(2,5,2,NULL,'12-20-2019','12:48:55');
INSERT INTO Calificaciones VALUES(2,13,4,NULL,'12-26-2021','17:36:37');
INSERT INTO Calificaciones VALUES(2,1,5,NULL,'12-26-2019','03:01:49');
INSERT INTO Calificaciones VALUES(3,5,2,NULL,'12-28-2021','10:54:59');
INSERT INTO Calificaciones VALUES(3,10,2,NULL,'09-17-2021','09:17:31');
INSERT INTO Calificaciones VALUES(3,6,4,NULL,'09-18-2021','11:54:47');
INSERT INTO Calificaciones VALUES(3,12,1,NULL,'12-14-2021','17:13:01');
INSERT INTO Calificaciones VALUES(3,7,4,NULL,'11-27-2021','03:32:58');
INSERT INTO Calificaciones VALUES(4,1,4,NULL,'03-29-2021','06:42:06');
INSERT INTO Calificaciones VALUES(4,2,2,NULL,'03-11-2021','09:00:28');
INSERT INTO Calificaciones VALUES(4,8,4,NULL,'03-22-2021','11:13:56');
INSERT INTO Calificaciones VALUES(4,4,3,NULL,'03-20-2021','22:23:03');
INSERT INTO Calificaciones VALUES(4,12,1,NULL,'03-21-2021','17:12:02');
INSERT INTO Calificaciones VALUES(4,5,2,NULL,'02-28-2021','01:54:52');
INSERT INTO Calificaciones VALUES(4,6,3,NULL,'02-17-2021','17:23:57');
INSERT INTO Calificaciones VALUES(4,7,1,NULL,'03-13-2021','14:04:23');
INSERT INTO Calificaciones VALUES(4,11,1,NULL,'02-10-2021','12:39:35');
INSERT INTO Calificaciones VALUES(4,10,1,NULL,'02-14-2021','02:19:51');
INSERT INTO Calificaciones VALUES(4,9,3,NULL,'02-10-2021','14:50:21');
INSERT INTO Calificaciones VALUES(4,3,3,NULL,'03-26-2021','23:31:46');
INSERT INTO Calificaciones VALUES(5,4,3,NULL,'07-30-2020','09:33:49');
INSERT INTO Calificaciones VALUES(5,8,4,NULL,'07-09-2020','00:18:29');
INSERT INTO Calificaciones VALUES(5,6,3,NULL,'07-24-2020','08:48:50');
INSERT INTO Calificaciones VALUES(5,2,1,NULL,'07-13-2020','10:18:08');
INSERT INTO Calificaciones VALUES(5,12,3,NULL,'08-08-2020','19:30:02');
INSERT INTO Calificaciones VALUES(5,9,4,NULL,'07-05-2020','22:06:29');
INSERT INTO Calificaciones VALUES(5,10,5,NULL,'07-17-2020','15:52:43');
INSERT INTO Calificaciones VALUES(5,7,1,NULL,'07-23-2020','04:25:13');
INSERT INTO Calificaciones VALUES(5,5,2,NULL,'07-09-2020','14:32:13');
INSERT INTO Calificaciones VALUES(5,3,2,NULL,'08-07-2020','05:55:39');
INSERT INTO Calificaciones VALUES(5,1,2,NULL,'08-04-2020','22:14:13');
INSERT INTO Calificaciones VALUES(6,9,4,NULL,'05-30-2018','13:16:28');
INSERT INTO Calificaciones VALUES(6,12,3,NULL,'06-14-2018','04:36:25');
INSERT INTO Calificaciones VALUES(6,17,3,NULL,'06-18-2018','06:31:21');
INSERT INTO Calificaciones VALUES(6,2,1,NULL,'07-03-2018','14:17:51');
INSERT INTO Calificaciones VALUES(6,4,3,NULL,'05-27-2018','16:56:18');
INSERT INTO Calificaciones VALUES(6,11,3,NULL,'07-11-2018','15:09:09');
INSERT INTO Calificaciones VALUES(6,8,3,NULL,'07-05-2018','08:23:50');
INSERT INTO Calificaciones VALUES(6,15,1,'la letra es buena','06-09-2018','11:12:04');
INSERT INTO Calificaciones VALUES(6,20,4,'q','06-04-2018','23:02:30');
INSERT INTO Calificaciones VALUES(6,1,1,NULL,'06-29-2018','14:55:17');
INSERT INTO Calificaciones VALUES(7,4,3,NULL,'03-14-2017','16:18:22');
INSERT INTO Calificaciones VALUES(7,5,1,NULL,'03-14-2017','19:57:35');
INSERT INTO Calificaciones VALUES(7,16,3,NULL,'04-05-2017','14:05:53');
INSERT INTO Calificaciones VALUES(7,2,2,NULL,'03-16-2017','04:31:35');
INSERT INTO Calificaciones VALUES(7,8,3,NULL,'03-26-2017','09:42:01');
INSERT INTO Calificaciones VALUES(7,13,1,NULL,'03-10-2017','03:25:11');
INSERT INTO Calificaciones VALUES(7,3,2,NULL,'04-01-2017','15:34:06');
INSERT INTO Calificaciones VALUES(7,7,2,NULL,'03-05-2017','09:06:23');
INSERT INTO Calificaciones VALUES(7,15,1,NULL,'03-07-2017','08:57:39');
INSERT INTO Calificaciones VALUES(7,20,1,NULL,'04-09-2017','04:51:48');
INSERT INTO Calificaciones VALUES(7,9,1,NULL,'02-26-2017','03:48:54');
INSERT INTO Calificaciones VALUES(7,1,1,NULL,'04-12-2017','11:44:07');
INSERT INTO Calificaciones VALUES(7,19,2,NULL,'03-05-2017','18:12:20');
INSERT INTO Calificaciones VALUES(7,18,4,NULL,'04-25-2017','03:02:11');
INSERT INTO Calificaciones VALUES(7,10,1,NULL,'03-12-2017','14:03:51');
INSERT INTO Calificaciones VALUES(7,11,4,NULL,'04-16-2017','01:46:44');
INSERT INTO Calificaciones VALUES(7,6,2,NULL,'04-18-2017','04:48:50');
INSERT INTO Calificaciones VALUES(8,20,3,NULL,'07-14-2020','01:45:11');
INSERT INTO Calificaciones VALUES(8,15,5,NULL,'08-14-2020','22:48:35');
INSERT INTO Calificaciones VALUES(8,5,1,NULL,'07-16-2020','16:22:19');
INSERT INTO Calificaciones VALUES(8,12,5,NULL,'07-10-2020','00:28:37');
INSERT INTO Calificaciones VALUES(8,2,5,NULL,'07-02-2020','09:20:43');
INSERT INTO Calificaciones VALUES(8,7,2,NULL,'07-18-2020','14:36:15');
INSERT INTO Calificaciones VALUES(8,18,1,NULL,'07-01-2020','00:59:16');
INSERT INTO Calificaciones VALUES(8,1,5,NULL,'06-17-2020','12:32:42');
INSERT INTO Calificaciones VALUES(8,6,1,NULL,'07-18-2020','07:53:53');
INSERT INTO Calificaciones VALUES(8,14,5,NULL,'07-10-2020','18:45:48');
INSERT INTO Calificaciones VALUES(8,3,1,NULL,'08-04-2020','20:00:48');
INSERT INTO Calificaciones VALUES(8,8,4,NULL,'06-20-2020','19:24:04');
INSERT INTO Calificaciones VALUES(8,4,3,NULL,'08-13-2020','19:21:48');
INSERT INTO Calificaciones VALUES(8,10,3,NULL,'06-24-2020','08:50:15');
INSERT INTO Calificaciones VALUES(8,17,1,NULL,'08-11-2020','02:38:56');
INSERT INTO Calificaciones VALUES(8,9,2,NULL,'07-28-2020','11:02:51');
INSERT INTO Calificaciones VALUES(8,13,2,NULL,'07-22-2020','20:07:50');
INSERT INTO Calificaciones VALUES(8,19,1,NULL,'06-18-2020','07:32:15');
INSERT INTO Calificaciones VALUES(9,5,3,NULL,'10-07-2020','04:15:15');
INSERT INTO Calificaciones VALUES(9,12,4,NULL,'09-21-2020','17:40:52');
INSERT INTO Calificaciones VALUES(9,13,3,NULL,'10-10-2020','22:50:59');
INSERT INTO Calificaciones VALUES(9,2,5,NULL,'09-30-2020','19:50:57');
INSERT INTO Calificaciones VALUES(9,11,5,NULL,'10-07-2020','14:01:37');
INSERT INTO Calificaciones VALUES(9,14,3,NULL,'09-23-2020','15:00:54');
INSERT INTO Calificaciones VALUES(9,15,2,NULL,'10-20-2020','02:29:45');
INSERT INTO Calificaciones VALUES(9,10,3,NULL,'10-26-2020','16:07:44');
INSERT INTO Calificaciones VALUES(9,4,2,'Excelente canción','09-24-2020','22:59:28');
INSERT INTO Calificaciones VALUES(9,1,2,NULL,'10-13-2020','01:30:43');
INSERT INTO Calificaciones VALUES(10,17,3,NULL,'01-01-2021','09:00:32');
INSERT INTO Calificaciones VALUES(10,15,2,NULL,'11-25-2020','13:51:52');
INSERT INTO Calificaciones VALUES(10,20,2,NULL,'01-05-2021','02:10:30');
INSERT INTO Calificaciones VALUES(10,18,3,NULL,'11-21-2020','20:09:10');
INSERT INTO Calificaciones VALUES(10,19,4,NULL,'11-20-2020','10:20:23');
INSERT INTO Calificaciones VALUES(10,13,4,NULL,'11-19-2020','13:06:47');
INSERT INTO Calificaciones VALUES(10,2,5,NULL,'11-13-2020','01:18:41');

--Reproducciones
INSERT INTO Reproducciones VALUES(1,3,12,'08-20-2021','22:08:05',257);
INSERT INTO Reproducciones VALUES(2,6,4,'11-15-2019','09:38:27',324);
INSERT INTO Reproducciones VALUES(3,1,3,'03-23-2020','20:05:19',291);
INSERT INTO Reproducciones VALUES(4,4,3,'03-02-2021','20:46:31',276);
INSERT INTO Reproducciones VALUES(5,5,2,'06-20-2021','06:26:14',197);
INSERT INTO Reproducciones VALUES(6,9,4,'11-20-2021','01:57:11',350);
INSERT INTO Reproducciones VALUES(7,7,4,'11-25-2020','17:51:41',329);
INSERT INTO Reproducciones VALUES(8,1,14,'11-04-2021','21:11:12',111);
INSERT INTO Reproducciones VALUES(9,4,1,'03-02-2021','15:37:02',265);
INSERT INTO Reproducciones VALUES(10,2,13,'12-26-2019','05:31:19',189);
INSERT INTO Reproducciones VALUES(11,8,20,'09-28-2020','16:04:02',264);
INSERT INTO Reproducciones VALUES(12,4,2,'07-30-2021','12:45:19',223);
INSERT INTO Reproducciones VALUES(13,2,9,'12-21-2019','12:27:52',289);
INSERT INTO Reproducciones VALUES(14,2,14,'12-26-2021','11:38:20',146);
INSERT INTO Reproducciones VALUES(15,3,5,'12-25-2021','07:33:43',218);
INSERT INTO Reproducciones VALUES(16,4,8,'06-30-2021','20:09:40',219);
INSERT INTO Reproducciones VALUES(17,8,15,'10-20-2021','01:16:59',244);
INSERT INTO Reproducciones VALUES(18,9,5,'09-25-2021','05:45:15',218);
INSERT INTO Reproducciones VALUES(19,5,4,'10-20-2021','08:16:57',329);
INSERT INTO Reproducciones VALUES(20,9,5,'10-26-2021','06:57:31',218);
INSERT INTO Reproducciones VALUES(21,9,12,'12-20-2020','00:37:35',221);
INSERT INTO Reproducciones VALUES(22,8,20,'09-28-2020','01:09:31',204);
INSERT INTO Reproducciones VALUES(23,5,8,'07-17-2020','19:25:35',245);
INSERT INTO Reproducciones VALUES(24,1,1,'07-15-2021','20:49:55',225);
INSERT INTO Reproducciones VALUES(25,6,9,'12-25-2021','02:15:27',289);
INSERT INTO Reproducciones VALUES(26,4,4,'05-30-2021','06:19:26',350);
INSERT INTO Reproducciones VALUES(27,1,2,'03-11-2021','09:47:39',187);
INSERT INTO Reproducciones VALUES(28,6,12,'06-17-2020','11:44:36',201);
INSERT INTO Reproducciones VALUES(29,3,10,'12-22-2021','02:25:38',298);
INSERT INTO Reproducciones VALUES(30,7,4,'03-28-2018','17:12:37',314);
INSERT INTO Reproducciones VALUES(31,4,12,'01-30-2021','06:03:20',261);
INSERT INTO Reproducciones VALUES(32,2,11,'12-24-2020','22:29:58',171);
INSERT INTO Reproducciones VALUES(33,7,5,'03-30-2021','23:30:57',214);
INSERT INTO Reproducciones VALUES(34,1,7,'02-06-2020','16:17:14',221);
INSERT INTO Reproducciones VALUES(35,3,6,'09-27-2021','14:55:56',175);
INSERT INTO Reproducciones VALUES(36,4,4,'03-02-2021','18:06:15',350);
INSERT INTO Reproducciones VALUES(37,5,8,'10-18-2020','16:28:03',219);
INSERT INTO Reproducciones VALUES(38,8,5,'06-18-2020','04:58:38',214);
INSERT INTO Reproducciones VALUES(39,10,19,'11-13-2020','23:17:23',178);
INSERT INTO Reproducciones VALUES(40,10,17,'11-11-2020','06:34:45',337);
INSERT INTO Reproducciones VALUES(41,9,13,'12-13-2020','22:33:51',149);
INSERT INTO Reproducciones VALUES(42,10,15,'11-12-2020','23:01:07',144);
INSERT INTO Reproducciones VALUES(43,10,20,'12-09-2021','17:08:52',300);
INSERT INTO Reproducciones VALUES(44,9,2,'09-15-2020','19:25:43',197);
INSERT INTO Reproducciones VALUES(45,6,17,'11-25-2018','00:18:52',277);
INSERT INTO Reproducciones VALUES(46,7,5,'07-26-2021','09:28:39',214);
INSERT INTO Reproducciones VALUES(47,4,2,'03-30-2021','21:43:08',127);
INSERT INTO Reproducciones VALUES(48,7,16,'05-29-2018','16:06:47',48);
INSERT INTO Reproducciones VALUES(49,4,4,'03-30-2021','08:38:02',294);
INSERT INTO Reproducciones VALUES(50,8,12,'08-22-2020','07:08:56',261);
INSERT INTO Reproducciones VALUES(51,6,17,'06-18-2019','13:34:25',312);
INSERT INTO Reproducciones VALUES(52,7,2,'12-29-2019','19:43:39',223);
INSERT INTO Reproducciones VALUES(53,10,18,'12-18-2021','21:53:56',194);
INSERT INTO Reproducciones VALUES(54,3,5,'12-29-2021','01:50:45',158);
INSERT INTO Reproducciones VALUES(55,10,17,'11-26-2020','15:39:29',277);
INSERT INTO Reproducciones VALUES(56,2,11,'12-23-2019','22:38:15',206);
INSERT INTO Reproducciones VALUES(57,1,12,'09-11-2020','13:09:06',261);
INSERT INTO Reproducciones VALUES(58,2,7,'12-20-2019','15:48:09',225);
INSERT INTO Reproducciones VALUES(59,8,2,'07-28-2021','23:23:05',187);
INSERT INTO Reproducciones VALUES(60,8,7,'09-29-2021','13:27:19',225);
INSERT INTO Reproducciones VALUES(61,2,10,'12-23-2021','02:48:29',198);
INSERT INTO Reproducciones VALUES(62,4,1,'07-30-2021','20:51:54',205);
INSERT INTO Reproducciones VALUES(63,4,5,'08-30-2021','11:14:42',178);
INSERT INTO Reproducciones VALUES(64,1,4,'03-08-2021','08:10:23',254);
INSERT INTO Reproducciones VALUES(65,7,2,'12-27-2019','23:30:40',223);
INSERT INTO Reproducciones VALUES(66,4,6,'11-30-2021','02:20:11',195);
INSERT INTO Reproducciones VALUES(67,5,6,'11-21-2021','09:10:20',205);
INSERT INTO Reproducciones VALUES(68,6,12,'12-23-2021','23:47:54',161);
INSERT INTO Reproducciones VALUES(69,6,12,'06-23-2021','16:02:48',221);
INSERT INTO Reproducciones VALUES(70,2,8,'12-21-2021','21:21:06',249);
INSERT INTO Reproducciones VALUES(71,9,11,'12-14-2021','19:10:07',131);
INSERT INTO Reproducciones VALUES(72,6,2,'10-27-2020','20:32:43',167);
INSERT INTO Reproducciones VALUES(73,1,14,'12-02-2020','19:22:42',141);
INSERT INTO Reproducciones VALUES(74,7,16,'10-27-2017','15:05:11',108);
INSERT INTO Reproducciones VALUES(75,5,2,'11-26-2020','01:41:09',127);
INSERT INTO Reproducciones VALUES(76,10,17,'11-27-2020','01:59:17',312);
INSERT INTO Reproducciones VALUES(77,7,2,'08-27-2021','23:55:13',223);
INSERT INTO Reproducciones VALUES(78,1,4,'10-15-2021','22:20:40',324);
INSERT INTO Reproducciones VALUES(79,1,7,'11-18-2020','11:27:28',195);
INSERT INTO Reproducciones VALUES(80,8,2,'12-19-2020','20:51:56',202);
INSERT INTO Reproducciones VALUES(81,8,2,'12-22-2021','18:26:52',227);
INSERT INTO Reproducciones VALUES(82,2,5,'12-20-2019','13:44:03',218);
INSERT INTO Reproducciones VALUES(83,5,8,'12-15-2021','02:43:49',249);
INSERT INTO Reproducciones VALUES(84,6,4,'09-16-2018','07:37:38',354);
INSERT INTO Reproducciones VALUES(85,5,12,'10-25-2020','13:27:43',257);
INSERT INTO Reproducciones VALUES(86,3,6,'10-27-2021','23:03:32',205);
INSERT INTO Reproducciones VALUES(87,4,7,'06-30-2021','20:27:48',165);
INSERT INTO Reproducciones VALUES(88,9,13,'12-19-2021','18:34:16',149);
INSERT INTO Reproducciones VALUES(89,4,8,'09-30-2021','04:05:05',209);
INSERT INTO Reproducciones VALUES(90,6,11,'09-13-2018','11:49:51',231);
INSERT INTO Reproducciones VALUES(91,7,8,'03-02-2018','02:55:07',249);
INSERT INTO Reproducciones VALUES(92,8,18,'07-23-2021','14:01:43',154);
INSERT INTO Reproducciones VALUES(93,5,9,'08-16-2020','19:40:04',249);
INSERT INTO Reproducciones VALUES(94,1,12,'12-01-2021','00:55:33',161);
INSERT INTO Reproducciones VALUES(95,1,14,'01-23-2020','18:06:40',131);
INSERT INTO Reproducciones VALUES(96,6,12,'11-28-2020','12:38:26',261);
INSERT INTO Reproducciones VALUES(97,9,14,'12-14-2020','13:28:51',146);
INSERT INTO Reproducciones VALUES(98,10,20,'11-24-2020','07:32:04',264);
INSERT INTO Reproducciones VALUES(99,8,1,'09-17-2020','17:25:08',261);
INSERT INTO Reproducciones VALUES(100,9,15,'12-20-2021','12:55:20',184);
INSERT INTO Reproducciones VALUES(101,1,12,'07-07-2021','17:17:21',231);
INSERT INTO Reproducciones VALUES(102,8,7,'11-26-2020','22:56:37',200);
INSERT INTO Reproducciones VALUES(103,2,8,'12-21-2020','06:53:01',219);
INSERT INTO Reproducciones VALUES(104,9,10,'10-22-2020','01:09:39',294);
INSERT INTO Reproducciones VALUES(105,5,10,'06-22-2020','08:27:53',294);
INSERT INTO Reproducciones VALUES(106,2,11,'12-30-2019','06:29:33',171);
INSERT INTO Reproducciones VALUES(107,4,1,'10-30-2021','23:56:06',265);
INSERT INTO Reproducciones VALUES(108,2,5,'12-24-2019','13:47:43',178);
INSERT INTO Reproducciones VALUES(109,2,7,'12-24-2020','20:51:59',225);
INSERT INTO Reproducciones VALUES(110,10,15,'12-08-2020','19:25:30',240);
INSERT INTO Reproducciones VALUES(111,3,5,'07-19-2021','11:14:28',188);
INSERT INTO Reproducciones VALUES(112,8,6,'07-19-2020','08:01:18',235);
INSERT INTO Reproducciones VALUES(113,10,19,'12-27-2021','02:01:35',178);
INSERT INTO Reproducciones VALUES(114,3,12,'07-18-2021','06:52:14',161);
INSERT INTO Reproducciones VALUES(115,5,8,'10-28-2020','15:40:53',209);
INSERT INTO Reproducciones VALUES(116,9,12,'09-19-2020','01:21:34',201);
INSERT INTO Reproducciones VALUES(117,10,18,'11-24-2021','03:53:22',94);
INSERT INTO Reproducciones VALUES(118,8,14,'08-30-2021','11:33:42',131);
INSERT INTO Reproducciones VALUES(119,9,15,'09-18-2021','05:53:09',184);
INSERT INTO Reproducciones VALUES(120,4,11,'10-30-2021','15:11:45',231);
INSERT INTO Reproducciones VALUES(121,3,10,'12-26-2021','20:13:12',273);
INSERT INTO Reproducciones VALUES(122,4,7,'03-30-2021','00:00:31',225);
INSERT INTO Reproducciones VALUES(123,8,12,'10-22-2020','09:17:44',261);
INSERT INTO Reproducciones VALUES(124,10,17,'11-14-2021','18:50:37',277);
INSERT INTO Reproducciones VALUES(125,3,10,'10-30-2021','22:19:35',273);
INSERT INTO Reproducciones VALUES(126,9,5,'09-29-2020','03:49:40',218);
INSERT INTO Reproducciones VALUES(127,1,3,'03-15-2021','06:42:52',316);
INSERT INTO Reproducciones VALUES(128,2,7,'12-24-2019','11:24:12',225);
INSERT INTO Reproducciones VALUES(129,9,10,'11-27-2021','23:23:38',268);
INSERT INTO Reproducciones VALUES(130,5,4,'06-28-2021','04:03:58',254);
INSERT INTO Reproducciones VALUES(131,2,14,'12-21-2020','07:35:09',146);
INSERT INTO Reproducciones VALUES(132,3,5,'07-20-2021','09:52:11',218);
INSERT INTO Reproducciones VALUES(133,5,4,'11-19-2020','08:57:38',254);
INSERT INTO Reproducciones VALUES(134,4,1,'07-30-2021','14:38:02',235);
INSERT INTO Reproducciones VALUES(135,4,11,'06-30-2021','14:22:09',227);
INSERT INTO Reproducciones VALUES(136,10,20,'11-09-2021','20:59:39',300);
INSERT INTO Reproducciones VALUES(137,8,2,'06-26-2021','05:52:11',187);
INSERT INTO Reproducciones VALUES(138,8,3,'07-22-2021','19:23:56',312);
INSERT INTO Reproducciones VALUES(139,5,6,'10-23-2020','03:12:48',205);
INSERT INTO Reproducciones VALUES(140,9,15,'10-28-2021','00:13:32',184);
INSERT INTO Reproducciones VALUES(141,3,6,'10-26-2021','08:05:21',235);
INSERT INTO Reproducciones VALUES(142,5,7,'06-29-2021','18:37:13',225);
INSERT INTO Reproducciones VALUES(143,2,8,'12-22-2019','20:05:05',149);
INSERT INTO Reproducciones VALUES(144,5,12,'12-26-2021','01:40:21',221);
INSERT INTO Reproducciones VALUES(145,10,17,'12-17-2021','17:20:08',237);
INSERT INTO Reproducciones VALUES(146,1,12,'11-02-2021','07:02:27',221);
INSERT INTO Reproducciones VALUES(147,6,2,'06-29-2018','12:25:09',197);
INSERT INTO Reproducciones VALUES(148,7,13,'04-26-2018','08:38:54',129);
INSERT INTO Reproducciones VALUES(149,10,19,'11-22-2021','17:45:51',182);
INSERT INTO Reproducciones VALUES(150,7,3,'04-27-2020','04:41:48',316);
INSERT INTO Reproducciones VALUES(151,3,10,'07-13-2021','12:37:40',238);
INSERT INTO Reproducciones VALUES(152,9,4,'09-14-2020','19:17:13',314);
INSERT INTO Reproducciones VALUES(153,7,5,'07-27-2021','05:46:57',218);
INSERT INTO Reproducciones VALUES(154,2,14,'12-20-2020','17:57:39',71);
INSERT INTO Reproducciones VALUES(155,9,13,'10-20-2020','11:51:00',159);
INSERT INTO Reproducciones VALUES(156,6,8,'05-20-2018','23:05:12',249);
INSERT INTO Reproducciones VALUES(157,6,15,'11-20-2021','15:17:02',219);
INSERT INTO Reproducciones VALUES(158,4,5,'12-30-2021','18:43:30',218);
INSERT INTO Reproducciones VALUES(159,4,7,'06-30-2021','01:43:12',185);
INSERT INTO Reproducciones VALUES(160,8,6,'10-23-2020','11:58:11',231);
INSERT INTO Reproducciones VALUES(161,4,5,'09-30-2021','13:04:26',158);
INSERT INTO Reproducciones VALUES(162,6,15,'12-25-2019','10:29:03',219);
INSERT INTO Reproducciones VALUES(163,6,20,'09-26-2019','19:36:59',304);
INSERT INTO Reproducciones VALUES(164,10,13,'11-15-2021','00:04:25',149);
INSERT INTO Reproducciones VALUES(165,3,10,'10-27-2021','11:04:23',238);
INSERT INTO Reproducciones VALUES(166,9,2,'10-28-2020','10:32:29',167);
INSERT INTO Reproducciones VALUES(167,8,8,'06-30-2020','02:18:51',224);
INSERT INTO Reproducciones VALUES(168,10,15,'11-27-2020','07:27:26',204);
INSERT INTO Reproducciones VALUES(169,1,7,'07-24-2021','07:05:01',165);
INSERT INTO Reproducciones VALUES(170,9,12,'09-30-2021','07:59:47',231);
INSERT INTO Reproducciones VALUES(171,7,7,'04-30-2017','01:00:03',185);
INSERT INTO Reproducciones VALUES(172,1,3,'11-14-2021','06:39:08',286);
INSERT INTO Reproducciones VALUES(173,1,7,'03-29-2021','20:28:05',221);
INSERT INTO Reproducciones VALUES(174,5,5,'11-23-2020','21:21:33',188);
INSERT INTO Reproducciones VALUES(175,10,13,'12-09-2021','10:01:00',189);
INSERT INTO Reproducciones VALUES(176,7,2,'03-28-2018','21:04:05',187);
INSERT INTO Reproducciones VALUES(177,3,6,'11-27-2021','20:40:45',235);
INSERT INTO Reproducciones VALUES(178,4,6,'09-30-2021','08:05:51',231);
INSERT INTO Reproducciones VALUES(179,1,3,'03-07-2020','00:30:02',316);
INSERT INTO Reproducciones VALUES(180,9,13,'12-20-2020','14:50:36',189);
INSERT INTO Reproducciones VALUES(181,4,2,'05-30-2021','05:48:12',227);
INSERT INTO Reproducciones VALUES(182,6,2,'12-27-2021','21:18:20',227);
INSERT INTO Reproducciones VALUES(183,3,5,'09-17-2021','03:25:57',158);
INSERT INTO Reproducciones VALUES(184,7,15,'07-26-2017','02:46:58',219);
INSERT INTO Reproducciones VALUES(185,10,19,'12-17-2021','07:42:55',178);
INSERT INTO Reproducciones VALUES(186,7,5,'03-24-2021','23:50:44',188);
INSERT INTO Reproducciones VALUES(187,9,12,'11-12-2020','21:10:23',161);
INSERT INTO Reproducciones VALUES(188,6,1,'12-27-2019','01:25:03',165);
INSERT INTO Reproducciones VALUES(189,9,1,'10-23-2021','14:00:35',261);
INSERT INTO Reproducciones VALUES(190,5,4,'08-18-2021','10:16:32',354);
INSERT INTO Reproducciones VALUES(191,9,4,'11-23-2021','11:50:47',354);
INSERT INTO Reproducciones VALUES(192,7,4,'11-29-2020','16:23:31',354);
INSERT INTO Reproducciones VALUES(193,4,5,'10-30-2021','07:16:16',158);
INSERT INTO Reproducciones VALUES(194,7,15,'04-28-2018','06:35:21',184);
INSERT INTO Reproducciones VALUES(195,4,2,'11-30-2021','19:38:54',187);
INSERT INTO Reproducciones VALUES(196,2,8,'12-22-2021','23:43:12',249);
INSERT INTO Reproducciones VALUES(197,7,20,'02-28-2018','05:08:09',204);
INSERT INTO Reproducciones VALUES(198,9,10,'10-21-2021','23:46:01',198);
INSERT INTO Reproducciones VALUES(199,5,5,'08-16-2021','07:31:58',188);
INSERT INTO Reproducciones VALUES(200,8,4,'11-19-2020','15:44:21',294);
INSERT INTO Reproducciones VALUES(201,4,6,'11-30-2021','12:47:50',195);
INSERT INTO Reproducciones VALUES(202,8,10,'06-17-2020','03:17:00',268);
INSERT INTO Reproducciones VALUES(203,10,15,'11-22-2021','01:41:09',219);
INSERT INTO Reproducciones VALUES(204,7,20,'08-24-2017','22:58:52',279);
INSERT INTO Reproducciones VALUES(205,8,17,'06-28-2020','00:57:53',333);
INSERT INTO Reproducciones VALUES(206,9,15,'12-18-2020','15:40:18',144);
INSERT INTO Reproducciones VALUES(207,10,20,'12-22-2021','20:15:52',300);
INSERT INTO Reproducciones VALUES(208,8,15,'06-27-2020','21:37:19',204);
INSERT INTO Reproducciones VALUES(209,3,6,'08-23-2021','01:20:19',235);
INSERT INTO Reproducciones VALUES(210,7,9,'04-27-2020','05:47:30',229);
INSERT INTO Reproducciones VALUES(211,10,17,'11-24-2021','00:36:57',333);
INSERT INTO Reproducciones VALUES(212,6,11,'11-28-2018','10:52:49',171);
INSERT INTO Reproducciones VALUES(213,4,11,'06-30-2021','19:07:12',206);
INSERT INTO Reproducciones VALUES(214,6,12,'07-19-2018','11:15:19',231);
INSERT INTO Reproducciones VALUES(215,3,5,'07-16-2021','03:49:03',118);
INSERT INTO Reproducciones VALUES(216,4,10,'09-30-2021','14:10:53',258);
INSERT INTO Reproducciones VALUES(217,10,13,'11-15-2021','22:07:15',129);
INSERT INTO Reproducciones VALUES(218,9,14,'09-13-2020','02:10:22',141);
INSERT INTO Reproducciones VALUES(219,5,3,'12-27-2021','15:39:07',256);
INSERT INTO Reproducciones VALUES(220,8,9,'06-18-2021','19:14:23',189);
INSERT INTO Reproducciones VALUES(221,9,15,'09-12-2021','22:19:27',240);
INSERT INTO Reproducciones VALUES(222,3,7,'12-17-2021','01:37:58',165);
INSERT INTO Reproducciones VALUES(223,7,1,'07-30-2021','23:32:56',265);
INSERT INTO Reproducciones VALUES(224,8,8,'10-17-2021','22:17:27',209);
INSERT INTO Reproducciones VALUES(225,5,5,'11-26-2020','15:41:01',218);
INSERT INTO Reproducciones VALUES(226,1,1,'07-17-2020','03:14:05',265);
INSERT INTO Reproducciones VALUES(227,8,6,'09-30-2021','13:56:36',205);
INSERT INTO Reproducciones VALUES(228,3,5,'09-28-2021','23:46:01',158);
INSERT INTO Reproducciones VALUES(229,1,3,'02-27-2020','12:27:37',216);
INSERT INTO Reproducciones VALUES(230,5,2,'11-20-2021','10:06:34',223);
INSERT INTO Reproducciones VALUES(231,3,7,'11-27-2021','13:29:43',195);
INSERT INTO Reproducciones VALUES(232,7,7,'07-24-2018','14:34:33',200);
INSERT INTO Reproducciones VALUES(233,7,15,'12-29-2018','07:39:12',240);
INSERT INTO Reproducciones VALUES(234,3,6,'11-30-2021','02:09:22',205);
INSERT INTO Reproducciones VALUES(235,10,17,'11-10-2021','05:02:49',307);
INSERT INTO Reproducciones VALUES(236,1,2,'01-11-2020','06:36:37',223);
INSERT INTO Reproducciones VALUES(237,7,3,'04-30-2019','16:49:26',256);
INSERT INTO Reproducciones VALUES(238,9,11,'11-21-2021','15:45:36',191);
INSERT INTO Reproducciones VALUES(239,3,5,'09-15-2021','15:17:07',214);
INSERT INTO Reproducciones VALUES(240,4,9,'09-30-2021','05:25:08',259);
INSERT INTO Reproducciones VALUES(241,5,4,'06-26-2020','01:08:27',294);
INSERT INTO Reproducciones VALUES(242,4,3,'04-30-2021','09:47:52',316);
INSERT INTO Reproducciones VALUES(243,3,6,'09-23-2021','16:28:29',235);
INSERT INTO Reproducciones VALUES(244,8,14,'09-29-2021','14:29:05',111);
INSERT INTO Reproducciones VALUES(245,6,8,'06-19-2021','10:02:46',224);
INSERT INTO Reproducciones VALUES(246,5,4,'09-17-2020','09:40:47',354);
INSERT INTO Reproducciones VALUES(247,4,6,'03-02-2021','01:20:33',231);
INSERT INTO Reproducciones VALUES(248,10,20,'12-25-2020','19:18:15',274);
INSERT INTO Reproducciones VALUES(249,5,2,'12-19-2020','20:46:32',223);
INSERT INTO Reproducciones VALUES(250,1,2,'09-19-2020','12:12:56',202);
INSERT INTO Reproducciones VALUES(251,5,4,'06-21-2021','00:25:32',324);
INSERT INTO Reproducciones VALUES(252,3,10,'12-16-2021','15:13:55',238);
INSERT INTO Reproducciones VALUES(253,4,4,'04-30-2021','15:37:23',294);
INSERT INTO Reproducciones VALUES(254,4,12,'03-02-2021','17:25:57',161);
INSERT INTO Reproducciones VALUES(255,7,20,'06-25-2019','12:54:27',244);
INSERT INTO Reproducciones VALUES(256,8,13,'07-25-2021','16:25:44',189);
INSERT INTO Reproducciones VALUES(257,3,7,'08-23-2021','14:10:33',185);
INSERT INTO Reproducciones VALUES(258,8,10,'08-25-2020','10:18:16',298);
INSERT INTO Reproducciones VALUES(259,6,4,'10-22-2018','10:01:26',254);
INSERT INTO Reproducciones VALUES(260,7,19,'03-27-2021','10:55:18',82);
INSERT INTO Reproducciones VALUES(261,9,11,'10-30-2021','00:10:30',191);
INSERT INTO Reproducciones VALUES(262,2,13,'12-23-2020','03:09:19',159);
INSERT INTO Reproducciones VALUES(263,10,15,'12-22-2021','02:06:23',244);
INSERT INTO Reproducciones VALUES(264,6,15,'10-13-2020','04:51:38',184);
INSERT INTO Reproducciones VALUES(265,7,2,'06-28-2020','11:42:10',197);
INSERT INTO Reproducciones VALUES(266,7,2,'02-25-2018','04:10:58',187);
INSERT INTO Reproducciones VALUES(267,3,10,'09-22-2021','11:00:01',198);
INSERT INTO Reproducciones VALUES(268,10,19,'12-18-2020','11:38:04',152);
INSERT INTO Reproducciones VALUES(269,9,15,'12-18-2020','03:16:49',244);
INSERT INTO Reproducciones VALUES(270,3,6,'09-17-2021','20:07:50',231);
INSERT INTO Reproducciones VALUES(271,3,7,'11-27-2021','12:24:38',195);
INSERT INTO Reproducciones VALUES(272,2,8,'12-24-2019','13:30:12',249);
INSERT INTO Reproducciones VALUES(273,5,9,'07-26-2020','03:28:53',289);
INSERT INTO Reproducciones VALUES(274,7,18,'09-24-2019','19:46:27',194);
INSERT INTO Reproducciones VALUES(275,1,12,'10-12-2021','10:09:27',236);
INSERT INTO Reproducciones VALUES(276,8,2,'08-20-2020','18:57:04',127);
INSERT INTO Reproducciones VALUES(277,6,4,'06-28-2018','19:37:38',354);
INSERT INTO Reproducciones VALUES(278,1,2,'09-05-2021','10:50:48',127);
INSERT INTO Reproducciones VALUES(279,2,9,'12-27-2020','08:11:59',249);
INSERT INTO Reproducciones VALUES(280,7,13,'07-30-2021','22:07:41',185);
INSERT INTO Reproducciones VALUES(281,3,7,'12-17-2021','04:58:19',125);
INSERT INTO Reproducciones VALUES(282,10,2,'12-08-2021','00:58:53',127);
INSERT INTO Reproducciones VALUES(283,7,16,'12-25-2018','06:49:18',148);
INSERT INTO Reproducciones VALUES(284,7,2,'04-28-2019','02:56:02',227);
INSERT INTO Reproducciones VALUES(285,6,17,'11-25-2021','02:39:13',337);
INSERT INTO Reproducciones VALUES(286,9,5,'12-12-2021','01:27:39',178);
INSERT INTO Reproducciones VALUES(287,4,9,'05-30-2021','00:01:10',249);
INSERT INTO Reproducciones VALUES(288,3,12,'09-25-2021','16:38:12',261);
INSERT INTO Reproducciones VALUES(289,3,6,'09-21-2021','07:45:45',235);
INSERT INTO Reproducciones VALUES(290,8,2,'10-24-2020','18:52:52',167);
INSERT INTO Reproducciones VALUES(291,4,3,'08-30-2021','06:11:19',312);
INSERT INTO Reproducciones VALUES(292,4,4,'06-30-2021','10:05:10',324);
INSERT INTO Reproducciones VALUES(293,5,6,'09-13-2020','23:08:08',231);
INSERT INTO Reproducciones VALUES(294,1,4,'10-09-2021','14:40:44',254);
INSERT INTO Reproducciones VALUES(295,3,12,'12-27-2021','02:41:45',261);
INSERT INTO Reproducciones VALUES(296,9,14,'12-21-2021','03:53:14',171);
INSERT INTO Reproducciones VALUES(297,9,14,'12-27-2021','06:37:26',171);
INSERT INTO Reproducciones VALUES(298,4,6,'12-30-2021','02:08:26',135);
INSERT INTO Reproducciones VALUES(299,10,15,'11-23-2021','23:18:26',204);
INSERT INTO Reproducciones VALUES(300,8,19,'06-27-2020','01:57:40',142);
INSERT INTO Reproducciones VALUES(301,2,9,'12-25-2020','01:27:09',289);
INSERT INTO Reproducciones VALUES(302,7,16,'03-30-2019','21:12:19',148);
INSERT INTO Reproducciones VALUES(303,3,5,'10-15-2021','18:05:21',218);
INSERT INTO Reproducciones VALUES(304,5,2,'07-15-2021','13:47:19',223);
INSERT INTO Reproducciones VALUES(305,9,10,'12-25-2021','15:38:23',198);
INSERT INTO Reproducciones VALUES(306,6,4,'06-12-2021','07:52:31',354);
INSERT INTO Reproducciones VALUES(307,5,5,'12-21-2020','05:51:58',188);
INSERT INTO Reproducciones VALUES(308,6,9,'07-15-2019','09:25:26',189);
INSERT INTO Reproducciones VALUES(309,7,2,'03-02-2017','15:46:34',127);
INSERT INTO Reproducciones VALUES(310,1,19,'05-05-2021','00:35:41',182);
INSERT INTO Reproducciones VALUES(311,5,6,'12-21-2020','03:45:25',205);
INSERT INTO Reproducciones VALUES(312,5,6,'08-29-2020','11:41:21',175);
INSERT INTO Reproducciones VALUES(313,1,14,'03-13-2021','07:37:31',141);
INSERT INTO Reproducciones VALUES(314,10,18,'12-15-2020','23:01:02',190);
INSERT INTO Reproducciones VALUES(315,6,17,'07-28-2018','17:56:30',307);
INSERT INTO Reproducciones VALUES(316,7,1,'02-28-2019','23:37:59',240);
INSERT INTO Reproducciones VALUES(317,7,4,'11-24-2018','09:28:39',254);
INSERT INTO Reproducciones VALUES(318,6,4,'12-28-2020','02:28:00',314);
INSERT INTO Reproducciones VALUES(319,5,3,'12-26-2021','23:48:53',286);
INSERT INTO Reproducciones VALUES(320,7,16,'06-24-2017','02:02:47',144);
INSERT INTO Reproducciones VALUES(321,2,8,'12-26-2019','14:38:48',249);
INSERT INTO Reproducciones VALUES(322,9,1,'11-20-2021','00:25:32',205);
INSERT INTO Reproducciones VALUES(323,4,7,'03-02-2021','13:40:16',125);
INSERT INTO Reproducciones VALUES(324,7,3,'12-30-2021','09:57:25',312);
INSERT INTO Reproducciones VALUES(325,9,10,'12-30-2021','16:49:32',298);
INSERT INTO Reproducciones VALUES(326,10,2,'11-29-2020','05:23:56',202);
INSERT INTO Reproducciones VALUES(327,4,3,'09-30-2021','03:10:50',316);
INSERT INTO Reproducciones VALUES(328,3,6,'09-28-2021','08:19:05',210);
INSERT INTO Reproducciones VALUES(329,2,13,'12-21-2019','01:57:09',189);
INSERT INTO Reproducciones VALUES(330,10,2,'12-12-2021','00:08:29',127);
INSERT INTO Reproducciones VALUES(331,1,12,'12-25-2021','06:09:46',231);
INSERT INTO Reproducciones VALUES(332,8,9,'11-29-2021','22:20:55',285);
INSERT INTO Reproducciones VALUES(333,7,20,'11-25-2021','08:12:48',279);
INSERT INTO Reproducciones VALUES(334,1,3,'08-27-2020','10:36:59',316);
INSERT INTO Reproducciones VALUES(335,7,10,'04-27-2018','13:21:48',294);
INSERT INTO Reproducciones VALUES(336,1,1,'03-18-2021','15:02:16',165);
INSERT INTO Reproducciones VALUES(337,5,2,'12-14-2020','21:35:16',187);
INSERT INTO Reproducciones VALUES(338,5,9,'09-14-2020','15:55:04',249);
INSERT INTO Reproducciones VALUES(339,7,16,'08-28-2020','13:04:04',108);
INSERT INTO Reproducciones VALUES(340,7,20,'06-26-2018','20:33:02',264);
INSERT INTO Reproducciones VALUES(341,4,1,'07-30-2021','10:42:09',265);
INSERT INTO Reproducciones VALUES(342,4,7,'01-30-2021','05:49:28',221);
INSERT INTO Reproducciones VALUES(343,9,2,'10-12-2020','13:32:10',127);
INSERT INTO Reproducciones VALUES(344,4,9,'03-30-2021','18:27:19',249);
INSERT INTO Reproducciones VALUES(345,8,3,'11-29-2021','09:46:03',276);
INSERT INTO Reproducciones VALUES(346,3,10,'12-23-2021','18:56:05',298);
INSERT INTO Reproducciones VALUES(347,1,4,'07-10-2021','12:02:56',354);
INSERT INTO Reproducciones VALUES(348,5,3,'12-24-2021','22:50:39',316);
INSERT INTO Reproducciones VALUES(349,10,13,'12-26-2021','12:29:44',189);
INSERT INTO Reproducciones VALUES(350,6,20,'08-14-2021','00:08:10',304);
INSERT INTO Reproducciones VALUES(351,3,7,'11-30-2021','21:30:01',225);
INSERT INTO Reproducciones VALUES(352,3,12,'07-21-2021','18:02:13',201);
INSERT INTO Reproducciones VALUES(353,3,7,'12-28-2021','01:17:00',225);
INSERT INTO Reproducciones VALUES(354,3,12,'10-26-2021','02:50:15',257);
INSERT INTO Reproducciones VALUES(355,3,6,'07-29-2021','19:03:47',195);
INSERT INTO Reproducciones VALUES(356,5,8,'12-24-2020','10:57:12',219);
INSERT INTO Reproducciones VALUES(357,10,2,'11-23-2020','03:46:21',227);
INSERT INTO Reproducciones VALUES(358,2,7,'12-21-2019','21:41:25',195);
INSERT INTO Reproducciones VALUES(359,3,7,'07-16-2021','22:57:22',200);
INSERT INTO Reproducciones VALUES(360,10,19,'11-22-2021','00:32:47',178);
INSERT INTO Reproducciones VALUES(361,5,1,'12-29-2020','21:29:34',265);
INSERT INTO Reproducciones VALUES(362,7,15,'12-25-2018','22:28:15',214);
INSERT INTO Reproducciones VALUES(363,9,10,'10-27-2021','18:34:09',298);
INSERT INTO Reproducciones VALUES(364,9,4,'12-16-2021','01:56:33',254);
INSERT INTO Reproducciones VALUES(365,4,3,'07-30-2021','01:08:07',316);
INSERT INTO Reproducciones VALUES(366,1,3,'04-21-2020','02:24:21',256);
INSERT INTO Reproducciones VALUES(367,2,11,'12-29-2019','11:04:23',231);
INSERT INTO Reproducciones VALUES(368,5,8,'08-19-2020','11:59:00',249);
INSERT INTO Reproducciones VALUES(369,3,5,'09-20-2021','09:24:49',218);
INSERT INTO Reproducciones VALUES(370,7,1,'12-27-2018','16:23:00',240);
INSERT INTO Reproducciones VALUES(371,10,2,'11-08-2020','03:03:32',227);
INSERT INTO Reproducciones VALUES(372,6,11,'05-20-2018','16:03:35',206);
INSERT INTO Reproducciones VALUES(373,4,1,'03-02-2021','20:53:57',265);
INSERT INTO Reproducciones VALUES(374,9,15,'10-29-2021','15:38:28',204);
INSERT INTO Reproducciones VALUES(375,7,9,'07-26-2019','21:55:26',289);
INSERT INTO Reproducciones VALUES(376,9,11,'09-15-2020','22:38:31',191);
INSERT INTO Reproducciones VALUES(377,3,7,'10-13-2021','06:46:03',165);
INSERT INTO Reproducciones VALUES(378,4,12,'01-30-2021','05:54:22',257);
INSERT INTO Reproducciones VALUES(379,10,20,'11-22-2021','17:12:22',204);
INSERT INTO Reproducciones VALUES(380,1,2,'07-18-2021','12:31:41',127);
INSERT INTO Reproducciones VALUES(381,7,1,'04-24-2020','09:34:47',225);
INSERT INTO Reproducciones VALUES(382,1,4,'10-09-2020','00:45:24',329);
INSERT INTO Reproducciones VALUES(383,1,7,'05-22-2021','19:36:58',185);
INSERT INTO Reproducciones VALUES(384,4,2,'12-30-2021','07:53:28',202);
INSERT INTO Reproducciones VALUES(385,9,4,'09-28-2021','01:51:09',350);
INSERT INTO Reproducciones VALUES(386,4,9,'07-30-2021','04:00:04',264);
INSERT INTO Reproducciones VALUES(387,8,19,'07-22-2020','10:02:01',182);
INSERT INTO Reproducciones VALUES(388,3,6,'07-23-2021','22:05:12',205);
INSERT INTO Reproducciones VALUES(389,3,6,'12-14-2021','07:31:59',210);
INSERT INTO Reproducciones VALUES(390,9,11,'09-21-2020','13:13:46',206);
INSERT INTO Reproducciones VALUES(391,3,6,'07-29-2021','06:14:04',205);
INSERT INTO Reproducciones VALUES(392,8,4,'07-25-2021','22:32:12',294);
INSERT INTO Reproducciones VALUES(393,1,5,'01-25-2021','00:02:37',118);
INSERT INTO Reproducciones VALUES(394,10,19,'11-11-2021','10:17:56',157);
INSERT INTO Reproducciones VALUES(395,7,19,'05-26-2020','04:07:01',82);
INSERT INTO Reproducciones VALUES(396,1,1,'03-21-2021','12:14:58',240);
INSERT INTO Reproducciones VALUES(397,7,11,'06-24-2019','22:53:39',201);
INSERT INTO Reproducciones VALUES(398,1,5,'11-17-2021','13:56:22',158);
INSERT INTO Reproducciones VALUES(399,1,7,'01-03-2020','03:01:22',221);
INSERT INTO Reproducciones VALUES(400,10,13,'11-25-2020','11:04:43',159);
INSERT INTO Reproducciones VALUES(401,2,11,'12-21-2021','18:19:31',131);
INSERT INTO Reproducciones VALUES(402,10,2,'11-23-2021','19:59:52',223);
INSERT INTO Reproducciones VALUES(403,1,5,'08-30-2020','09:26:55',188);
INSERT INTO Reproducciones VALUES(404,2,1,'12-28-2020','11:46:36',235);
INSERT INTO Reproducciones VALUES(405,10,18,'11-09-2020','17:09:03',164);
INSERT INTO Reproducciones VALUES(406,5,4,'08-14-2020','03:40:27',329);
INSERT INTO Reproducciones VALUES(407,7,7,'03-26-2021','17:33:51',200);
INSERT INTO Reproducciones VALUES(408,2,14,'12-25-2019','04:51:09',171);
INSERT INTO Reproducciones VALUES(409,7,15,'07-24-2021','13:02:04',214);
INSERT INTO Reproducciones VALUES(410,4,5,'03-30-2021','08:27:58',188);
INSERT INTO Reproducciones VALUES(411,7,5,'02-26-2018','06:41:22',118);
INSERT INTO Reproducciones VALUES(412,8,20,'06-23-2021','04:21:33',304);
INSERT INTO Reproducciones VALUES(413,8,2,'08-20-2021','10:42:28',202);
INSERT INTO Reproducciones VALUES(414,5,4,'11-22-2020','11:14:05',354);
INSERT INTO Reproducciones VALUES(415,8,10,'08-26-2021','12:19:36',294);
INSERT INTO Reproducciones VALUES(416,4,6,'10-30-2021','11:24:43',235);
INSERT INTO Reproducciones VALUES(417,8,7,'11-23-2020','00:24:42',225);
INSERT INTO Reproducciones VALUES(418,4,12,'10-30-2021','14:55:43',261);
INSERT INTO Reproducciones VALUES(419,3,6,'09-18-2021','15:02:10',210);
INSERT INTO Reproducciones VALUES(420,7,13,'08-28-2017','18:50:10',164);
INSERT INTO Reproducciones VALUES(421,7,13,'04-27-2020','12:30:25',185);
INSERT INTO Reproducciones VALUES(422,2,14,'12-26-2021','05:15:34',171);
INSERT INTO Reproducciones VALUES(423,8,5,'07-30-2020','08:16:34',188);
INSERT INTO Reproducciones VALUES(424,4,6,'03-02-2021','07:22:12',175);
INSERT INTO Reproducciones VALUES(425,10,15,'12-10-2021','10:20:32',214);
INSERT INTO Reproducciones VALUES(426,1,14,'02-18-2021','11:00:28',171);
INSERT INTO Reproducciones VALUES(427,9,2,'12-17-2021','16:43:35',127);
INSERT INTO Reproducciones VALUES(428,10,17,'12-16-2021','00:33:18',277);
INSERT INTO Reproducciones VALUES(429,4,3,'05-30-2021','04:48:08',276);
INSERT INTO Reproducciones VALUES(430,8,7,'08-25-2020','19:41:54',221);
INSERT INTO Reproducciones VALUES(431,4,2,'03-30-2021','06:08:48',187);
INSERT INTO Reproducciones VALUES(432,4,2,'07-30-2021','01:54:31',223);
INSERT INTO Reproducciones VALUES(433,2,5,'12-26-2021','02:51:07',158);
INSERT INTO Reproducciones VALUES(434,4,7,'08-30-2021','15:31:43',200);
INSERT INTO Reproducciones VALUES(435,4,3,'12-30-2021','06:48:47',276);
INSERT INTO Reproducciones VALUES(436,2,5,'12-25-2019','04:20:33',178);
INSERT INTO Reproducciones VALUES(437,5,7,'10-20-2021','13:41:35',225);
INSERT INTO Reproducciones VALUES(438,7,16,'03-24-2017','18:04:47',123);
INSERT INTO Reproducciones VALUES(439,9,2,'12-13-2020','05:48:44',227);
INSERT INTO Reproducciones VALUES(440,10,15,'12-08-2020','09:53:57',244);
INSERT INTO Reproducciones VALUES(441,3,7,'11-20-2021','20:49:26',200);
INSERT INTO Reproducciones VALUES(442,8,2,'08-24-2021','20:45:01',223);
INSERT INTO Reproducciones VALUES(443,8,6,'12-20-2021','17:26:45',231);
INSERT INTO Reproducciones VALUES(444,6,9,'11-26-2019','00:21:01',289);
INSERT INTO Reproducciones VALUES(445,10,2,'11-10-2020','04:20:46',187);
INSERT INTO Reproducciones VALUES(446,10,20,'12-18-2021','03:21:38',204);
INSERT INTO Reproducciones VALUES(447,4,5,'04-30-2021','06:38:45',188);
INSERT INTO Reproducciones VALUES(448,1,14,'09-27-2020','13:12:30',146);
INSERT INTO Reproducciones VALUES(449,3,6,'11-30-2021','18:01:01',235);
INSERT INTO Reproducciones VALUES(450,1,1,'05-14-2021','22:45:13',165);
INSERT INTO Reproducciones VALUES(451,9,10,'10-13-2020','04:57:56',238);
INSERT INTO Reproducciones VALUES(452,8,6,'07-25-2021','02:38:42',235);
INSERT INTO Reproducciones VALUES(453,10,2,'12-17-2021','08:00:35',223);
INSERT INTO Reproducciones VALUES(454,6,9,'05-20-2019','17:24:08',285);
INSERT INTO Reproducciones VALUES(455,4,12,'03-02-2021','23:51:00',257);
INSERT INTO Reproducciones VALUES(456,3,5,'12-28-2021','02:55:43',118);
INSERT INTO Reproducciones VALUES(457,9,14,'12-17-2020','23:22:21',111);
INSERT INTO Reproducciones VALUES(458,6,17,'08-24-2020','17:19:19',237);
INSERT INTO Reproducciones VALUES(459,1,14,'02-23-2021','21:30:59',71);
INSERT INTO Reproducciones VALUES(460,1,14,'12-11-2020','17:03:40',167);
INSERT INTO Reproducciones VALUES(461,1,12,'04-04-2021','13:42:53',261);
INSERT INTO Reproducciones VALUES(462,5,1,'06-20-2021','09:22:52',205);
INSERT INTO Reproducciones VALUES(463,4,8,'07-30-2021','03:45:00',245);
INSERT INTO Reproducciones VALUES(464,3,5,'11-26-2021','17:34:45',118);
INSERT INTO Reproducciones VALUES(465,2,13,'12-29-2019','05:29:44',185);
INSERT INTO Reproducciones VALUES(466,2,9,'12-24-2020','18:55:10',264);
INSERT INTO Reproducciones VALUES(467,1,7,'11-30-2020','19:41:06',221);
INSERT INTO Reproducciones VALUES(468,2,5,'12-28-2021','10:47:28',118);
INSERT INTO Reproducciones VALUES(469,3,6,'10-19-2021','01:23:58',205);
INSERT INTO Reproducciones VALUES(470,4,8,'05-30-2021','20:44:41',224);
INSERT INTO Reproducciones VALUES(471,10,20,'11-09-2020','23:40:22',204);
INSERT INTO Reproducciones VALUES(472,7,5,'08-29-2018','19:30:45',218);
INSERT INTO Reproducciones VALUES(473,1,4,'05-25-2020','23:03:35',350);
INSERT INTO Reproducciones VALUES(474,9,11,'09-14-2021','10:35:44',131);
INSERT INTO Reproducciones VALUES(475,10,13,'11-18-2021','14:21:53',159);
INSERT INTO Reproducciones VALUES(476,7,15,'02-26-2017','09:51:54',244);
INSERT INTO Reproducciones VALUES(477,5,9,'08-25-2020','02:13:59',264);
INSERT INTO Reproducciones VALUES(478,9,10,'10-20-2020','01:57:24',198);
INSERT INTO Reproducciones VALUES(479,6,9,'06-12-2018','21:00:56',289);
INSERT INTO Reproducciones VALUES(480,1,19,'01-08-2021','09:25:30',182);
INSERT INTO Reproducciones VALUES(481,5,2,'12-19-2021','12:24:08',197);
INSERT INTO Reproducciones VALUES(482,1,1,'10-09-2021','23:11:04',265);
INSERT INTO Reproducciones VALUES(483,7,7,'07-30-2020','21:28:30',185);
INSERT INTO Reproducciones VALUES(484,3,6,'11-15-2021','05:32:50',205);
INSERT INTO Reproducciones VALUES(485,9,4,'10-19-2021','14:32:05',254);
INSERT INTO Reproducciones VALUES(486,5,7,'06-26-2020','08:00:47',125);
INSERT INTO Reproducciones VALUES(487,6,12,'09-24-2020','10:27:42',231);
INSERT INTO Reproducciones VALUES(488,9,13,'10-23-2020','07:42:30',159);
INSERT INTO Reproducciones VALUES(489,7,6,'12-29-2018','08:36:01',235);
INSERT INTO Reproducciones VALUES(490,3,6,'07-26-2021','00:57:44',210);
INSERT INTO Reproducciones VALUES(491,9,1,'12-15-2021','09:09:18',265);
INSERT INTO Reproducciones VALUES(492,6,8,'10-16-2021','13:02:59',245);
INSERT INTO Reproducciones VALUES(493,2,1,'12-25-2019','00:53:57',225);
INSERT INTO Reproducciones VALUES(494,7,7,'10-24-2019','15:46:01',225);
INSERT INTO Reproducciones VALUES(495,8,13,'09-18-2020','08:15:47',185);
INSERT INTO Reproducciones VALUES(496,2,8,'12-26-2020','07:33:09',224);
INSERT INTO Reproducciones VALUES(497,4,6,'11-30-2021','11:38:05',205);
INSERT INTO Reproducciones VALUES(498,6,4,'09-17-2020','15:06:44',294);

-- listas
INSERT INTO ListasReproducción values(1,5,'Música para planchar','07-07-2020');
INSERT INTO ListasReproducción values(2,1,'Mis favoritas','02-13-2020');
INSERT INTO ListasReproducción values(3,7,'Canciones para dedicar a mi novia cuando tenga novia','03-01-2017');
INSERT INTO ListasReproducción values(4,6,'Mi cuerpo pide salsa','07-10-2018');
INSERT INTO ListasReproducción values(5,4,'Música para estudiar','03-06-2021');
INSERT INTO ListasReproducción values(6,9,'Entrenar con energia ','09-26-2020');
INSERT INTO ListasReproducción values(7,7,'Tarde de relajación','03-02-2017');
INSERT INTO ListasReproducción values(8,8,'Manejar con gusto, sabor y ritmo','07-02-2020');
INSERT INTO ListasReproducción values(9,4,'Para gustos los colores','03-18-2021');
INSERT INTO ListasReproducción values(10,4,'Reggaeton viejo','02-23-2021');
INSERT INTO ListasReproducción values(11,5,'Música para trabajar','08-09-2020');
INSERT INTO ListasReproducción values(12,5,'Colección de imperdibles','07-01-2020');
INSERT INTO ListasReproducción values(13,2,'Crossover de ayer y hoy','01-31-2020');
INSERT INTO ListasReproducción values(14,8,'Paseo en familia','08-06-2020');
INSERT INTO ListasReproducción values(15,3,'De todo un poco','02-15-2021');
INSERT INTO ListasReproducción values(16,8,'Las melodias que inspiran','08-11-2020');
INSERT INTO ListasReproducción values(17,8,'Música para viajar','06-25-2020');
INSERT INTO ListasReproducción values(18,10,'Buena vibra','12-24-2020');
INSERT INTO ListasReproducción values(19,2,'Viernes en la tarde en la oficina','01-29-2020');
INSERT INTO ListasReproducción values(20,7,'Bailoteo','03-02-2017');

--CancionesLista
INSERT INTO CancionesLista Values(17,8,1,'08-11-2020','15:13:27');
INSERT INTO CancionesLista Values(6,1,1,'12-15-2020','03:46:26');
INSERT INTO CancionesLista Values(4,2,1,'09-16-2018','21:11:33');
INSERT INTO CancionesLista Values(8,13,1,'09-06-2020','18:28:35');
INSERT INTO CancionesLista Values(15,7,1,'03-06-2021','17:42:28');
INSERT INTO CancionesLista Values(14,15,1,'10-04-2020','11:16:17');
INSERT INTO CancionesLista Values(11,10,1,'09-20-2020','02:55:50');
INSERT INTO CancionesLista Values(7,20,1,'04-26-2017','06:45:40');
INSERT INTO CancionesLista Values(2,19,1,'03-09-2020','01:46:35');
INSERT INTO CancionesLista Values(10,3,1,'03-09-2021','18:29:29');
INSERT INTO CancionesLista Values(18,2,1,'03-02-2021','10:17:45');
INSERT INTO CancionesLista Values(20,2,1,'03-30-2017','12:57:17');
INSERT INTO CancionesLista Values(7,3,2,'05-09-2017','08:51:45');
INSERT INTO CancionesLista Values(18,17,2,'02-05-2021','06:11:19');
INSERT INTO CancionesLista Values(2,7,2,'04-25-2020','12:23:24');
INSERT INTO CancionesLista Values(2,2,3,'03-09-2020','20:49:57');
INSERT INTO CancionesLista Values(6,14,2,'11-02-2020','21:58:15');
INSERT INTO CancionesLista Values(7,18,3,'03-18-2017','08:58:35');
INSERT INTO CancionesLista Values(3,2,1,'05-08-2017','02:43:20');
INSERT INTO CancionesLista Values(7,7,4,'04-12-2017','23:31:48');
INSERT INTO CancionesLista Values(14,3,2,'09-15-2020','13:09:45');
INSERT INTO CancionesLista Values(7,16,5,'03-31-2017','05:00:53');
INSERT INTO CancionesLista Values(16,10,1,'09-13-2020','12:59:13');
INSERT INTO CancionesLista Values(10,11,2,'02-26-2021','18:25:34');
INSERT INTO CancionesLista Values(15,12,2,'03-02-2021','12:39:45');
INSERT INTO CancionesLista Values(7,8,6,'04-30-2017','08:19:36');
INSERT INTO CancionesLista Values(17,15,2,'08-07-2020','14:25:07');
INSERT INTO CancionesLista Values(17,2,3,'07-14-2020','17:16:52');
INSERT INTO CancionesLista Values(17,17,4,'07-04-2020','10:45:14');
INSERT INTO CancionesLista Values(19,10,1,'02-22-2020','22:44:08');
INSERT INTO CancionesLista Values(17,12,5,'08-13-2020','05:17:20');
INSERT INTO CancionesLista Values(13,5,1,'03-29-2020','02:28:25');
INSERT INTO CancionesLista Values(9,9,1,'03-12-2021','13:05:55');
INSERT INTO CancionesLista Values(4,9,3,'09-27-2018','19:04:31');
INSERT INTO CancionesLista Values(6,11,3,'10-15-2020','07:41:39');
INSERT INTO CancionesLista Values(17,9,6,'09-10-2020','08:19:16');
INSERT INTO CancionesLista Values(8,20,2,'07-04-2020','19:14:32');
INSERT INTO CancionesLista Values(16,8,2,'09-18-2020','02:26:19');
INSERT INTO CancionesLista Values(7,11,7,'03-18-2017','02:49:33');
INSERT INTO CancionesLista Values(20,3,2,'03-13-2017','18:17:47');
INSERT INTO CancionesLista Values(16,4,3,'10-12-2020','09:47:34');
INSERT INTO CancionesLista Values(5,8,1,'03-13-2021','20:17:11');
INSERT INTO CancionesLista Values(15,6,3,'03-08-2021','04:25:50');
INSERT INTO CancionesLista Values(11,3,2,'09-04-2020','19:58:26');
INSERT INTO CancionesLista Values(5,11,2,'03-06-2021','03:11:22');
INSERT INTO CancionesLista Values(8,2,3,'08-29-2020','06:55:52');
INSERT INTO CancionesLista Values(14,20,3,'08-31-2020','19:01:21');
INSERT INTO CancionesLista Values(3,20,2,'04-24-2017','06:46:38');
INSERT INTO CancionesLista Values(5,18,3,'03-10-2021','11:02:31');
INSERT INTO CancionesLista Values(19,3,2,'02-13-2020','14:48:40');
INSERT INTO CancionesLista Values(4,12,4,'07-31-2018','10:47:31');
INSERT INTO CancionesLista Values(11,15,3,'08-26-2020','13:26:07');
INSERT INTO CancionesLista Values(10,17,3,'03-03-2021','11:17:33');
INSERT INTO CancionesLista Values(4,4,5,'07-31-2018','07:50:40');
INSERT INTO CancionesLista Values(20,16,3,'03-18-2017','08:36:21');
INSERT INTO CancionesLista Values(14,6,4,'08-10-2020','09:12:06');
INSERT INTO CancionesLista Values(4,1,6,'08-25-2018','11:16:35');
INSERT INTO CancionesLista Values(2,15,4,'03-18-2020','14:34:58');
INSERT INTO CancionesLista Values(4,17,7,'09-24-2018','22:08:27');
INSERT INTO CancionesLista Values(12,8,1,'09-10-2020','00:44:39');
INSERT INTO CancionesLista Values(18,18,3,'01-10-2021','09:02:58');
INSERT INTO CancionesLista Values(6,5,4,'10-24-2020','07:14:23');
INSERT INTO CancionesLista Values(12,1,2,'07-08-2020','18:49:08');
INSERT INTO CancionesLista Values(10,2,4,'03-09-2021','21:41:06');
INSERT INTO CancionesLista Values(3,16,3,'04-23-2017','05:01:10');
INSERT INTO CancionesLista Values(12,10,3,'08-08-2020','09:07:02');
INSERT INTO CancionesLista Values(4,15,8,'09-01-2018','18:57:01');
INSERT INTO CancionesLista Values(10,1,5,'03-17-2021','07:49:06');
INSERT INTO CancionesLista Values(1,12,1,'07-28-2020','03:08:46');
INSERT INTO CancionesLista Values(6,12,5,'12-02-2020','17:45:29');
INSERT INTO CancionesLista Values(11,8,4,'10-14-2020','10:37:37');
INSERT INTO CancionesLista Values(4,20,9,'08-16-2018','20:07:28');
INSERT INTO CancionesLista Values(17,6,8,'07-18-2020','06:34:38');
INSERT INTO CancionesLista Values(20,7,4,'05-17-2017','02:25:56');
INSERT INTO CancionesLista Values(14,1,5,'09-27-2020','14:56:48');
INSERT INTO CancionesLista Values(18,19,4,'03-14-2021','04:38:54');
INSERT INTO CancionesLista Values(13,1,2,'03-15-2020','02:50:12');
INSERT INTO CancionesLista Values(6,4,6,'10-05-2020','02:49:38');
INSERT INTO CancionesLista Values(2,3,5,'04-29-2020','15:36:54');
INSERT INTO CancionesLista Values(1,2,2,'08-07-2020','11:15:48');
INSERT INTO CancionesLista Values(12,19,4,'08-17-2020','12:27:39');
INSERT INTO CancionesLista Values(17,14,9,'07-24-2020','12:05:11');
INSERT INTO CancionesLista Values(19,8,3,'03-25-2020','07:26:38');
INSERT INTO CancionesLista Values(8,10,4,'07-24-2020','20:33:05');
INSERT INTO CancionesLista Values(8,15,5,'08-21-2020','23:42:34');
INSERT INTO CancionesLista Values(1,14,3,'07-31-2020','00:53:24');
INSERT INTO CancionesLista Values(16,2,4,'09-26-2020','21:55:34');
INSERT INTO CancionesLista Values(3,4,4,'04-17-2017','21:48:25');
INSERT INTO CancionesLista Values(1,1,4,'08-10-2020','00:40:48');
INSERT INTO CancionesLista Values(7,1,8,'03-29-2017','14:18:20');
INSERT INTO CancionesLista Values(6,10,7,'11-04-2020','03:55:30');
INSERT INTO CancionesLista Values(14,7,6,'10-11-2020','19:19:30');
INSERT INTO CancionesLista Values(18,13,5,'03-07-2021','13:19:40');
INSERT INTO CancionesLista Values(20,6,5,'04-01-2017','06:09:43');
INSERT INTO CancionesLista Values(18,20,6,'03-02-2021','00:48:40');
INSERT INTO CancionesLista Values(13,13,3,'04-09-2020','12:49:13');
INSERT INTO CancionesLista Values(6,2,8,'11-06-2020','07:09:19');
INSERT INTO CancionesLista Values(5,7,4,'03-12-2021','22:59:20');
INSERT INTO CancionesLista Values(4,19,10,'08-02-2018','05:20:40');
INSERT INTO CancionesLista Values(16,11,5,'10-09-2020','10:02:37');
INSERT INTO CancionesLista Values(15,10,4,'03-14-2021','08:27:27');
INSERT INTO CancionesLista Values(1,4,5,'07-08-2020','05:31:42');
INSERT INTO CancionesLista Values(10,16,6,'03-02-2021','01:39:52');
INSERT INTO CancionesLista Values(17,5,10,'08-16-2020','09:37:39');
INSERT INTO CancionesLista Values(19,9,4,'01-31-2020','07:53:03');
INSERT INTO CancionesLista Values(16,1,6,'08-20-2020','12:04:58');
INSERT INTO CancionesLista Values(7,5,9,'05-20-2017','20:34:04');
INSERT INTO CancionesLista Values(7,15,10,'04-22-2017','22:45:08');
INSERT INTO CancionesLista Values(8,8,6,'08-06-2020','17:14:43');
INSERT INTO CancionesLista Values(16,9,7,'09-27-2020','07:54:06');
INSERT INTO CancionesLista Values(1,5,6,'07-17-2020','06:31:54');
INSERT INTO CancionesLista Values(10,7,7,'03-06-2021','01:22:37');
INSERT INTO CancionesLista Values(13,7,4,'02-06-2020','20:15:46');
INSERT INTO CancionesLista Values(2,17,6,'04-01-2020','20:03:13');
INSERT INTO CancionesLista Values(12,5,6,'08-28-2020','19:25:16');
INSERT INTO CancionesLista Values(16,19,8,'08-17-2020','06:22:54');
INSERT INTO CancionesLista Values(16,5,9,'09-30-2020','23:41:23');
INSERT INTO CancionesLista Values(10,5,8,'03-07-2021','14:38:18');
INSERT INTO CancionesLista Values(6,15,9,'11-30-2020','05:07:41');
INSERT INTO CancionesLista Values(20,15,6,'04-21-2017','18:45:04');
INSERT INTO CancionesLista Values(20,20,7,'04-02-2017','00:41:23');
INSERT INTO CancionesLista Values(1,7,7,'08-12-2020','11:33:55');
INSERT INTO CancionesLista Values(20,10,8,'04-15-2017','16:38:09');
INSERT INTO CancionesLista Values(4,11,12,'08-15-2018','18:57:10');
INSERT INTO CancionesLista Values(2,12,7,'04-29-2020','02:13:15');
INSERT INTO CancionesLista Values(14,11,7,'10-13-2020','21:07:05');
INSERT INTO CancionesLista Values(17,7,11,'08-19-2020','20:53:55');
INSERT INTO CancionesLista Values(5,1,5,'03-05-2021','10:01:34');
INSERT INTO CancionesLista Values(18,15,7,'01-01-2021','18:27:46');
INSERT INTO CancionesLista Values(11,1,5,'08-31-2020','04:11:40');
INSERT INTO CancionesLista Values(16,14,10,'08-25-2020','13:31:23');
INSERT INTO CancionesLista Values(1,3,8,'07-22-2020','23:55:52');
INSERT INTO CancionesLista Values(19,16,5,'02-10-2020','23:32:45');
INSERT INTO CancionesLista Values(11,14,6,'10-04-2020','10:31:14');
INSERT INTO CancionesLista Values(13,11,5,'04-03-2020','03:59:56');
INSERT INTO CancionesLista Values(13,9,6,'04-14-2020','16:08:04');
INSERT INTO CancionesLista Values(8,19,7,'07-02-2020','20:30:48');
INSERT INTO CancionesLista Values(9,1,2,'03-12-2021','20:12:16');
INSERT INTO CancionesLista Values(7,13,11,'03-26-2017','15:06:18');
INSERT INTO CancionesLista Values(12,13,7,'09-09-2020','19:10:41');
INSERT INTO CancionesLista Values(7,19,12,'04-13-2017','03:31:22');
INSERT INTO CancionesLista Values(10,4,9,'03-08-2021','21:43:17');
INSERT INTO CancionesLista Values(10,6,10,'03-01-2021','05:35:52');
INSERT INTO CancionesLista Values(16,18,11,'10-22-2020','09:27:01');
INSERT INTO CancionesLista Values(5,2,6,'03-11-2021','12:43:31');
INSERT INTO CancionesLista Values(1,19,9,'09-03-2020','09:25:14');
INSERT INTO CancionesLista Values(19,14,7,'01-29-2020','19:04:32');
INSERT INTO CancionesLista Values(15,5,6,'03-16-2021','14:41:17');
INSERT INTO CancionesLista Values(20,4,9,'04-26-2017','16:49:05');
INSERT INTO CancionesLista Values(5,3,7,'03-11-2021','04:09:03');
INSERT INTO CancionesLista Values(4,8,13,'09-06-2018','19:52:20');
INSERT INTO CancionesLista Values(20,5,10,'04-19-2017','08:55:38');
INSERT INTO CancionesLista Values(2,9,8,'03-22-2020','08:29:52');
INSERT INTO CancionesLista Values(11,20,7,'09-13-2020','08:43:27');
INSERT INTO CancionesLista Values(5,14,8,'03-14-2021','18:56:33');
INSERT INTO CancionesLista Values(10,19,11,'03-11-2021','15:50:57');
INSERT INTO CancionesLista Values(6,13,10,'12-08-2020','17:36:59');
INSERT INTO CancionesLista Values(7,2,13,'04-09-2017','14:13:49');
INSERT INTO CancionesLista Values(10,8,12,'03-10-2021','08:22:32');
INSERT INTO CancionesLista Values(17,1,12,'07-29-2020','23:05:34');
INSERT INTO CancionesLista Values(8,16,8,'09-16-2020','22:32:44');
INSERT INTO CancionesLista Values(7,9,14,'05-10-2017','23:58:21');
INSERT INTO CancionesLista Values(14,13,8,'10-11-2020','18:08:26');


