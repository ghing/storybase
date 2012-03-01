#!/bin/bash

CREATE_LANG=1

# For Ubuntu 8.x and 9.x releases.
if [ -d "/usr/share/postgresql-8.3-postgis" ]
then
    POSTGIS_SQL_PATH=/usr/share/postgresql-8.3-postgis
    POSTGIS_SQL=lwpostgis.sql
fi

# For Ubuntu 10.04
if [ -d "/usr/share/postgresql/8.4/contrib" ]
then
    POSTGIS_SQL_PATH=/usr/share/postgresql/8.4/contrib
    POSTGIS_SQL=postgis.sql
fi

# For Ubuntu 10.10 (with PostGIS 1.5)
if [ -d "/usr/share/postgresql/8.4/contrib/postgis-1.5" ]
then
    POSTGIS_SQL_PATH=/usr/share/postgresql/8.4/contrib/postgis-1.5
    POSTGIS_SQL=postgis.sql
    GEOGRAPHY=1
else
    GEOGRAPHY=0
fi

# For Ubuntu 11.10 (with PostGIS 1.5)
if [ -d "/usr/share/postgresql/9.1/contrib/postgis-1.5" ]
then
    POSTGIS_SQL_PATH=/usr/share/postgresql/9.1/contrib/postgis-1.5
    POSTGIS_SQL=postgis.sql
    GEOGRAPHY=1
    CREATE_LANG=0
else
    GEOGRAPHY=0
fi

createdb -E UTF8 -U postgres template_postgis

if ((CREATE_LANG))
then
    createlang -U postgres -d template_postgis plpgsql
fi

# BEGIN DEBUG
echo "$postgis_sql_path/$postgis_sql"
ls $postgis_sql_path/$postgis_sql
# END DEBUG
psql -d postgres -U postgres -c "UPDATE pg_database SET datistemplate='true' WHERE datname='template_postgis';" && \
psql -d template_postgis -U postgres -f $POSTGIS_SQL_PATH/$POSTGIS_SQL && \
psql -d template_postgis -U postgres -f $POSTGIS_SQL_PATH/spatial_ref_sys.sql && \
psql -d template_postgis -U postgres -c "GRANT ALL ON geometry_columns TO PUBLIC;" && \
psql -d template_postgis -U postgres -c "GRANT ALL ON spatial_ref_sys TO PUBLIC;"

if ((GEOGRAPHY))
then
    psql -d template_postgis -U postgres -c "GRANT ALL ON geography_columns TO PUBLIC;"
fi
