Como regenerar la bbdd
======================

1. Creamos la estructura de la base de datos:

   ```
   sqlite3 databaase.db < db.schema
   ```

2. Cargamos las categorías desde el csv y comprobamos que se han cargado.

   ```
   sqlite3 database.db
   > .mode csv
   > .import categories.csv categories
   > select * from categories;
   ...
   > .exit
   ```

3. Movemos el fichero a `assets/`

   ```
   mv database.db ../assets/
   ```

Podemos usar tableplus, sqlitebrowser o otra GUI también para cargar los datos.
