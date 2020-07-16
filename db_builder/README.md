Como regenerar la bbdd
======================

1. Creamos la estructura de la base de datos:

   ```
   sqlite3 database.db < db.schema
   ```

2. Cargamos las categorías y los recursos desde el csv y comprobamos que se han cargado.

   ```
   sqlite3 database.db
   > .mode csv
   > .import categories.csv categories
   > .import resources.csv resources
   > select * from categories;
   ...
   > select * from resources;
   ...
   > .exit
   ```

3. Movemos el fichero a `assets/`

   ```
   mv database.db ../assets/
   ```

Podemos usar tableplus, sqlitebrowser o otra GUI también para cargar los datos.
