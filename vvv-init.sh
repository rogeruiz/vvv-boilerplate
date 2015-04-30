# Init script for Communities in Schools of Richmond WordPress site

# Project specifics
WP_DB_NAME='wordpress_project_name'
WP_BASE_URL='project-name.dev'
WP_BASE_TITLE='WordPress Base Title'

# Defaults
WP_DB_USER='wp'
WP_DB_PASSWORD='wp'
WP_ADMIN_USER='admin'
WP_ADMIN_PASSWORD='password'
WP_ADMIN_EMAIL='admin@example.com'

# Make a database, if we don't already have one.
echo "Creating database (if it's not already there)";

mysql -u root \
      --password=root \
      -e "CREATE DATABASE IF NOT EXISTS ${WP_DB_NAME}";
mysql -u root \
      --password=root \
      -e "GRANT ALL PRIVILEGES ON ${WP_DB_NAME}.* TO ${WP_DB_USER}@localhost IDENTIFIED BY '${WP_DB_USER}';";

cd htdocs;

wp core config --dbname="${WP_DB_NAME}" \
               --dbuser=$WP_DB_USER \
               --dbpass=$WP_DB_PASSWORD \
               --dbhost="localhost" \
               --allow-root;
wp core install --url=$WP_BASE_URL \
                --title="${WP_BASE_TITLE} WordPress" \
                --admin_user=$WP_ADMIN_USER \
                --admin_password=$WP_ADMIN_PASSWORD \
                --admin_email=$WP_ADMIN_EMAIL \
                --allow-root;

cd ..;
