-- ===============================================================================================
-- INSERCIONES PARA MEJORAR LOS RESULTADOS DE LAS CONSULTAS
-- ===============================================================================================

-- ===============================================================================================
-- 1. AGREGAR MÁS DISCOS (especialmente que empiecen con 'T' para la segunda consulta)
-- ===============================================================================================

-- Discos nuevos para diferentes artistas
INSERT INTO industria_musical.disco VALUES (24, 'The Best Of Andrea Bocelli', 'Crossover', '2007-01-01', 'Universal Music Group', 'E.U', 'Andrea Bocelli');
INSERT INTO industria_musical.disco VALUES (25, 'Toda mi vida', 'Pop', '2003-01-01', 'EMI Music México', 'México', 'Yuri');
INSERT INTO industria_musical.disco VALUES (26, 'Testimony', 'Rock', '2009-01-01', 'Warner Music Group', 'E.U', 'Robbie Williams');
INSERT INTO industria_musical.disco VALUES (27, 'The Ultimate Collection', 'Pop', '2004-01-01', 'Sony Music Entertainmen', 'E.U', 'Whitney Houston');
INSERT INTO industria_musical.disco VALUES (28, 'Tributo', 'Rock', '1995-01-01', 'DGC Records', 'E.U', 'Nirvana');
INSERT INTO industria_musical.disco VALUES (29, 'Todo Shakira', 'Pop', '2008-01-01', 'EMI Music Colombia', 'Colombia', 'Shakira');
INSERT INTO industria_musical.disco VALUES (30, 'The Number of the Beast', 'Heavy Metal', '1982-01-01', 'Polydor Records', 'Inglaterra', 'Iron Maiden');
INSERT INTO industria_musical.disco VALUES (31, 'Todas mis canciones', 'Pop', '2005-01-01', 'Warner Music Group', 'E.U', 'Enrique Iglesias');
INSERT INTO industria_musical.disco VALUES (32, 'Templo', 'Folk Rock', '2003-01-01', 'Warner Music Group', 'E.U', 'Mago de Oz');
INSERT INTO industria_musical.disco VALUES (33, 'The Joshua Tree', 'Rock alternativo', '1987-01-01', 'Polydor Records', 'Inglaterra', 'U2');

-- ===============================================================================================
-- 2. AGREGAR CANCIONES A MÚLTIPLES ÁLBUMES 
-- ===============================================================================================

-- Canciones de Andrea Bocelli en su álbum "The Best Of"
INSERT INTO industria_musical.esta VALUES (1, 24, 'The Best Of Andrea Bocelli');
INSERT INTO industria_musical.esta VALUES (2, 24, 'The Best Of Andrea Bocelli');
INSERT INTO industria_musical.esta VALUES (3, 24, 'The Best Of Andrea Bocelli');
INSERT INTO industria_musical.esta VALUES (4, 24, 'The Best Of Andrea Bocelli');
INSERT INTO industria_musical.esta VALUES (5, 24, 'The Best Of Andrea Bocelli');

-- Canciones de Yuri en "Toda mi vida" (álbum recopilatorio)
INSERT INTO industria_musical.esta VALUES (42, 25, 'Toda mi vida');
INSERT INTO industria_musical.esta VALUES (43, 25, 'Toda mi vida');

-- Canciones de Robbie Williams en "Testimony"
INSERT INTO industria_musical.esta VALUES (38, 26, 'Testimony');
INSERT INTO industria_musical.esta VALUES (39, 26, 'Testimony');

-- Canciones de Whitney Houston en "The Ultimate Collection"
INSERT INTO industria_musical.esta VALUES (40, 27, 'The Ultimate Collection');
INSERT INTO industria_musical.esta VALUES (41, 27, 'The Ultimate Collection');

-- Canciones de Nirvana en "Tributo"
INSERT INTO industria_musical.esta VALUES (44, 28, 'Tributo');
INSERT INTO industria_musical.esta VALUES (45, 28, 'Tributo');

-- Canciones de Shakira en "Todo Shakira"
INSERT INTO industria_musical.esta VALUES (46, 29, 'Todo Shakira');
INSERT INTO industria_musical.esta VALUES (47, 29, 'Todo Shakira');
INSERT INTO industria_musical.esta VALUES (48, 29, 'Todo Shakira');
INSERT INTO industria_musical.esta VALUES (49, 29, 'Todo Shakira');
INSERT INTO industria_musical.esta VALUES (50, 29, 'Todo Shakira');

-- Canciones de Iron Maiden en "The Number of the Beast"
INSERT INTO industria_musical.esta VALUES (61, 30, 'The Number of the Beast');
INSERT INTO industria_musical.esta VALUES (62, 30, 'The Number of the Beast');
INSERT INTO industria_musical.esta VALUES (63, 30, 'The Number of the Beast');

-- Canciones de Enrique Iglesias en "Todas mis canciones"
INSERT INTO industria_musical.esta VALUES (69, 31, 'Todas mis canciones');
INSERT INTO industria_musical.esta VALUES (70, 31, 'Todas mis canciones');
INSERT INTO industria_musical.esta VALUES (71, 31, 'Todas mis canciones');
INSERT INTO industria_musical.esta VALUES (72, 31, 'Todas mis canciones');
INSERT INTO industria_musical.esta VALUES (73, 31, 'Todas mis canciones');
INSERT INTO industria_musical.esta VALUES (74, 31, 'Todas mis canciones');

-- Canciones de Mago de Oz en "Templo"
INSERT INTO industria_musical.esta VALUES (16, 32, 'Templo');

-- Canciones de U2 en "The Joshua Tree"
INSERT INTO industria_musical.esta VALUES (25, 33, 'The Joshua Tree');
