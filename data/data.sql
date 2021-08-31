BEGIN;
DROP VIEW "seedlist";
DROP TABLE IF EXISTS "userdata",
"category",
"variety",
"seed";

DROP DOMAIN IF EXISTS "email";

DROP TYPE IF EXISTS "stat",
"availability";

CREATE DOMAIN "email" AS text CHECK (
    VALUE ~ '^(?:[a-z0-9!#$%&''*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&''*+/=?^_`{|}~-]+)*|"(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21\x23-\x5b\x5d-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])*")@(?:(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\[(?:(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?|[a-z0-9-]*[a-z0-9]:(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21-\x5a\x53-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])+)\])$'
);

CREATE TYPE "stat" AS ENUM('notconfirm', 'confirm');

CREATE TYPE "availability" AS ENUM('notstock', 'stock');
DROP TABLE IF EXISTS "userdata", "seed";
CREATE TABLE "userdata"(
    "id" INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    "pseudo" TEXT NOT NULL UNIQUE,
    "email" EMAIL NOT NULL UNIQUE,
    "city" TEXT NOT NULL,
    "mdp" TEXT NOT NULL,
    "keyconfirm" TEXT NOT NULL,
    "statut" STAT NOT NULL DEFAULT 'notconfirm',
    "created_at" TIMESTAMPTZ NOT NULL DEFAULT now(),
    "updated_at" TIMESTAMPTZ
);

CREATE TABLE "category"(
    "id" INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    "name" TEXT NOT NULL,
    "img" TEXT NOT NULL,
    "img_author" TEXT NOT NULL
);

CREATE TABLE "variety"(
    "id" INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    "name" TEXT NOT NULL,
    "category_id" INT NOT NULL REFERENCEs "category"("id")
);

CREATE TABLE "seed"(
    "id" INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    "user_id" INT NOT NULL REFERENCES "userdata"("id") ON DELETE CASCADE,
    "variety_id" INT NOT NULL REFERENCES "variety"("id"),
    "description" TEXT NOT NULL,
    "conseil" TEXT NOT NULL,
    "availability" AVAILABILITY NOT NULL DEFAULT 'stock',
    "created_at" TIMESTAMPTZ NOT NULL DEFAULT now(),
    "updated_at" TIMESTAMPTZ
);

INSERT INTO
    "userdata" ("pseudo", "email", "city", "mdp", "keyconfirm")
VALUES
    (
        'Cedric',
        'cedric@engrainon.nous',
        'Peyrolles en provence',
        '$2b$05$nNLJdFwrLKsoKkWkn8G9t.qgVlJ8zJwwv7COS6fpoivKGArvzFzPK',
        '6wz36JJ54lZnlZpCbq1kEyrIBgvNOi'
    ),
    (
        'Yann',
        'yann@engrainon.nous',
        'Aucune idée',
        '$2b$05$nNLJdFwrLKsoKkWkn8G9t.qgVlJ8zJwwv7COS6fpoivKGArvzFzPK',
        '6wz367854zZnlZpCbq1kEyrIBgvNOi'
    ),
    (
        'Julie',
        'julie@engrainon.nous',
        'Mayenne',
        '$2b$05$nNLJdFwrLKsoKkWkn8G9t.qgVlJ8zJwwv7COS6fpoivKGArvzFzPK',
        '6wz36JJ54lZnlZpCbq1kEyrIBer58e'
    ),
    (
        'Mikael',
        'mikael@engrainon.nous',
        'Chnor',
        '$2b$05$nNLJdFwrLKsoKkWkn8G9t.qgVlJ8zJwwv7COS6fpoivKGArvzFzPK',
        '6wz36JJ54lZnlze9851kEyrIBgvNOi'
    ),
    (
        'Kevin',
        'kevin@engrainon.nous',
        'les iles',
        '$2b$05$nNLJdFwrLKsoKkWkn8G9t.qgVlJ8zJwwv7COS6fpoivKGArvzFzPK',
        '6wz36JJ54l659zdCbq1kEyrIBgvNOi'
    );

INSERT INTO
    "category"("name", "img", "img_author")
VALUES
    (
        'Courgette',
        'https://images.unsplash.com/photo-1596056094719-10ba4f7ea650?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1',
        'Edson Rosas'
    ),
    (
        'Tomate',
        'https://images.unsplash.com/photo-1562695530-ca03c4b98623?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1',
        'Hamed Omidian'
    ),
    (
        'Aubergine',
        'https://images.unsplash.com/photo-1613881553903-4543f5f2cac9?ixlib=rb-1.2.1',
        'Nina Luong'
    ),
    (
        'Carotte',
        'https://images.unsplash.com/photo-1445282768818-728615cc910a?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=1050&q=80',
        'Jonathan Pielmayer'
    ),
    (
        'Salade',
        'https://images.unsplash.com/photo-1543056295-d585ba290712?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=967&q=80',
        'Lulucmy'
    ),
    (
        'Radis',
        'https://images.unsplash.com/photo-1592346520936-9444037b2e28?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=675&q=80',
        'Laura Lefurgey-Smith'
    ),
    (
        'Framboise',
        'https://images.unsplash.com/photo-1618422689173-3dbcdeb82fa7?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=807&q=80',
        'Jocelyn Morales'
    ),
    (
        'Poire',
        'https://images.unsplash.com/photo-1570115114436-63d3405246e7?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=634&q=80',
        'Moritz Kindler'
    ),
    (
        'Pastèque',
        'https://images.unsplash.com/photo-1587049352846-4a222e784d38?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=800&q=80',
        'Art Rachen'
    ),
    (
        'Melon',
        'https://images.unsplash.com/photo-1602597190461-43774583d3c0?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1189&q=80',
        'Otherness TV'
    ),
    (
        'Courge',
        'https://images.unsplash.com/photo-1506785212-4b1c7d23a1cc?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=675&q=80',
        'Brigitte Tohm'
    ),
    (
        'Menthe',
        'https://images.unsplash.com/photo-1582556135623-653b87486f21?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=995&q=80',
        'Abby Boggier'
    ),
    (
        'Piment',
        'https://images.unsplash.com/photo-1526346698789-22fd84314424?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1050&q=80',
        'Elle Hughes'
    ),
    (
        'Poireau',
        'https://images.unsplash.com/photo-1549913468-0ddc24a4a1bf?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=634&q=80',
        'Heather Gill'
    );

INSERT INTO
    "variety"("name", "category_id")
VALUES
    ('De nice', 1),
    ('Rome', 2),
    ('Blanche', 3),
    ('de Chantenay à Coeur Rouge', 4),
    ('de Colmar à Coeur Rouge', 4),
    ('Jaune obtuse du doubs', 4),
    ('Batavia', 5),
    ('Pommée', 5),
    ('Iceberg', 5),
    ('Chicorée frisée', 5),
    ('Angelus', 6),
    ('bacchus', 6),
    ('Zlata', 6),
    ('Noir', 6),
    ('Malling promise', 7),
    ('Willamette', 7),
    ('Tulameen', 7),
    ('Surprise dautomne', 7),
    ('Beurré Giffard', 8),
    ('Dr Jules Guyot', 8),
    ('Williams', 8),
    ('Beurré Hardy', 8),
    ('Ali Baba', 9),
    ('Astrakhanski', 9),
    ('Crimson Sweet', 9),
    ('Jubilee', 9),
    ('Charantais', 10),
    ('Canari', 10),
    ('Banana', 10),
    ('Delicious 51', 10),
    ('Mooregold', 11),
    ('Lady Godiva', 11),
    ('Dickinson', 11),
    ('Tuffy', 11),
    ('Pommée', 12),
    ('Menthe Poivré', 12),
    ('Chocolat', 12),
    ('De Corée', 12),
    ('Violet Sparkle', 13),
    ('Balloon', 13),
    ('Aji Yellow', 13),
    ('Bonnet d’Évêque', 13),
    ('King Richard', 14),
    ('Bleu de Solaize', 14),
    ('Buttoir à manche', 14),
    ('Bleu d’Hiver', 14);

INSERT INTO
    "variety"("name", "category_id")
VALUES
    ('de Chantenay à Coeur Rouge', 4),
    ('de Colmar à Coeur Rouge', 4),
    ('Jaune obtuse du doubs', 4),
    ('Batavia', 5),
    ('Pommée', 5),
    ('Iceberg', 5),
    ('Chicorée frisée', 5),
    ('Angelus', 6),
    ('bacchus', 6),
    ('Zlata', 6),
    ('Noir', 6),
    ('Malling promise', 7),
    ('Willamette', 7),
    ('Tulameen', 7),
    ('Surprise dautomne', 7),
    ('Beurré Giffard', 8),
    ('Dr Jules Guyot', 8),
    ('Williams', 8),
    ('Beurré Hardy', 8),
    ('Ali Baba', 9),
    ('Astrakhanski', 9),
    ('Crimson Sweet', 9),
    ('Jubilee', 9),
    ('Charantais', 10),
    ('Canari', 10),
    ('Banana', 10),
    ('Delicious 51', 10),
    ('Mooregold', 11),
    ('Lady Godiva', 11),
    ('Dickinson', 11),
    ('Tuffy', 11),
    ('Pommée', 12),
    ('Menthe Poivré', 12),
    ('Chocolat', 12),
    ('De Corée', 12),
    ('Violet Sparkle', 13),
    ('Balloon', 13),
    ('Aji Yellow', 13),
    ('Bonnet d’Évêque', 13),
    ('King Richard', 14),
    ('Bleu de Solaize', 14),
    ('Buttoir à manche', 14),
    ('Bleu d’Hiver', 14);

INSERT INTO
    "seed"(
        "user_id",
        "variety_id",
        "description",
        "conseil"
    )
VALUES
    (
        1,
        1,
        'Petite courgette longue',
        'Semis a faire 8 semaine avant la mise en terre'
    ),
    (
        2,
        2,
        'Tomate allongé parfaite pour sauce',
        'A planter en plein soleil'
    ),
    (
        3,
        3,
        'Aubergine a la chaire tendre de couleur blanche, parfait pour une poèlé',
        'Long a germé'
    ),
    (
        4,
        1,
        'Petite courgette longue',
        'Semis a faire 8 semaine avant la mise en terre'
    ),
    (
        4,
        2,
        'Tomate allongé parfaite pour sauce',
        'A planter en plein soleil'
    ),
    (
        3,
        3,
        'Aubergine a la chaire tendre de couleur blanche, parfait pour une poèlé',
        'Long a germé'
    ),
    (
        5,
        1,
        'Petite courgette longue',
        'Semis a faire 8 semaine avant la mise en terre'
    ),
    (
        5,
        2,
        'Tomate allongé parfaite pour sauce',
        'A planter en plein soleil'
    ),
    (
        5,
        3,
        'Aubergine a la chaire tendre de couleur blanche, parfait pour une poèlé',
        'Long a germé'
    ),
    (
        2,
        1,
        'Petite courgette longue',
        'Semis a faire 8 semaine avant la mise en terre'
    ),
    (
        1,
        2,
        'Tomate allongé parfaite pour sauce',
        'A planter en plein soleil'
    ),
    (
        2,
        3,
        'Aubergine a la chaire tendre de couleur blanche, parfait pour une poèlé',
        'Long a germé');


CREATE VIEW seedlist AS
SELECT
    seed.id,
    seed.user_id,
    seed.description,
    seed.conseil,
    seed.availability,
	seed.created_at AS created_at,
	seed.variety_id AS variety_id,
    category.id AS category_id,
    category.name AS category_name,
    category.img AS category_img,
    category.img_author AS cathegory_img_author,
    variety.name AS variety_name,
    userdata.pseudo AS pseudo_user,
    userdata.email AS email_user
FROM
    seed
    JOIN userdata ON userdata.id = seed.user_id
    JOIN variety ON seed.variety_id = variety.id
    JOIN category ON variety.category_id = category.id;

COMMIT;