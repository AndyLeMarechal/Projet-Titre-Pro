BEGIN;

DROP TABLE IF EXISTS "menu","plat","boisson","dessert","ingredient","user","restaurant","tag","menu_has_plat","menu_has_boisson","menu_has_dessert","plat_has_ingredient","plat_has_tag";

CREATE TABLE "menu" (
  "id" INTEGER PRIMARY KEY GENERATED BY DEFAULT AS IDENTITY,
  "title" TEXT NOT NULL,
  "description" TEXT NOT NULL,
  "created_at" TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "updated_at" TIMESTAMPTZ
);

CREATE TABLE "plat" (
  "id" INTEGER PRIMARY KEY GENERATED BY DEFAULT AS IDENTITY,
  "title" TEXT NOT NULL,
  "description" TEXT NOT NULL,
  "created_at" TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "updated_at" TIMESTAMPTZ
);
CREATE TABLE "boisson" (
  "id" INTEGER PRIMARY KEY GENERATED BY DEFAULT AS IDENTITY,
  "title" TEXT NOT NULL,
  "soft" BOOLEAN NOT NULL,
  "created_at" TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "updated_at" TIMESTAMPTZ
);
CREATE TABLE "dessert" (
  "id" INTEGER PRIMARY KEY GENERATED BY DEFAULT AS IDENTITY,
  "title" TEXT NOT NULL ,
  "created_at" TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "updated_at" TIMESTAMPTZ
);
CREATE TABLE "user" (
  "id" INTEGER PRIMARY KEY GENERATED BY DEFAULT AS IDENTITY,
  "username" TEXT NOT NULL UNIQUE,
  "email" TEXT NOT NULL UNIQUE,
  "password" TEXT NOT NULL UNIQUE,
  "firstname" TEXT NOT NULL,
  "lastname" TEXT NOT NULL,
  "adress" TEXT NOT NULL,
  "role" TEXT NOT NULL,
  "created_at" TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "updated_at" TIMESTAMPTZ
);
CREATE TABLE "restaurant" (
  "id" INTEGER PRIMARY KEY GENERATED BY DEFAULT AS IDENTITY,
  "name" TEXT NOT NULL,
  "adress" TEXT NOT NULL,
  "created_at" TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "updated_at" TIMESTAMPTZ
);
CREATE TABLE "tag" (
  "id" INTEGER PRIMARY KEY GENERATED BY DEFAULT AS IDENTITY,
  "name" TEXT NOT NULL UNIQUE,
  "color" VARCHAR(7),
  "created_at" TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "updated_at" TIMESTAMPTZ
);


CREATE TABLE "menu_has_plat" (
  "id" INTEGER GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,

  "menu_id" INTEGER NOT NULL REFERENCES "menu"("id") ON DELETE CASCADE,
  "plat_id" INTEGER NOT NULL REFERENCES "plat"("id") ON DELETE CASCADE,

  UNIQUE ("menu_id", "plat_id"),

  "created_at" TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "updated_at" TIMESTAMPTZ
);

CREATE TABLE "menu_has_boisson" (
  "id" INTEGER GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,

  "menu_id" INTEGER NOT NULL REFERENCES "menu"("id") ON DELETE CASCADE,
  "boisson_id" INTEGER NOT NULL REFERENCES "boisson"("id") ON DELETE CASCADE,

  UNIQUE ("menu_id", "boisson_id"),

  "created_at" TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "updated_at" TIMESTAMPTZ
);

CREATE TABLE "menu_has_dessert" (
  "id" INTEGER GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,

  "menu_id" INTEGER NOT NULL REFERENCES "menu"("id") ON DELETE CASCADE,
  "dessert_id" INTEGER NOT NULL REFERENCES "dessert"("id") ON DELETE CASCADE,

  UNIQUE ("menu_id", "dessert_id"),

  "created_at" TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "updated_at" TIMESTAMPTZ
);

CREATE TABLE "plat_has_tag" (
  "id" INTEGER GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,

  "plat_id" INTEGER NOT NULL REFERENCES "plat"("id") ON DELETE CASCADE,
  "tag_id" INTEGER NOT NULL REFERENCES "tag"("id") ON DELETE CASCADE,

  UNIQUE ("plat_id", "tag_id"),

  "created_at" TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "updated_at" TIMESTAMPTZ
);

COMMIT;