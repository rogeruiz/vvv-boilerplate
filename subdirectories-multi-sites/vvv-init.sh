# Project specifics
WP_DB_NAME='wordpress_multiproject'
WP_BASE_URL='multiproject.dev'
WP_BASE_TITLE='WordPress Multisite Base Title'

# Defaults
WP_DB_USER='wp'
WP_DB_PASSWORD='wp'
WP_DB_PREFIX='wp_'
WP_ADMIN_USER='admin'
WP_ADMIN_PASSWORD='password'
WP_ADMIN_EMAIL='admin@local.dev'
WP_GENERATED_SALTS=`curl --silent https://api.wordpress.org/secret-key/1.1/salt/`

function so_long_and_thanks_for_all_the_blogs {
  echo " "
  echo "Happy Blogging!"
  exit 0
}

echo " "
echo "Initializing Project for ${WP_BASE_TITLE} with DB <${WP_DB_NAME}> @ ${WP_BASE_URL}"

# Make a database, if we don't already have one.
echo " "
echo "Creating database for ${WP_BASE_TITLE} called ${WP_DB_NAME}"

mysql -u root \
      --password=root \
      -e "CREATE DATABASE IF NOT EXISTS ${WP_DB_NAME}"
mysql -u root \
      --password=root \
      -e "GRANT ALL PRIVILEGES ON ${WP_DB_NAME}.* TO ${WP_DB_USER}@localhost IDENTIFIED BY '${WP_DB_USER}'"

# Check if we need to bother downloading, configuring, & installing WordPress
if [ -d ./htdocs ]; then
  echo " "
  echo "There seems to already be a WordPress install in this directory."
  so_long_and_thanks_for_all_the_blogs
fi

mkdir htdocs && cd htdocs

# Download Latest WordPress
echo " "
echo "Downloading Latest WordPress using wp-cli"
wp core download

# Configure WordPress
echo " "
echo "Configuring WordPress using wp-cli"
wp core config --dbname="${WP_DB_NAME}" \
               --dbuser=$WP_DB_USER \
               --dbpass=$WP_DB_PASSWORD \
               --dbhost="localhost" \
               --dbprefix=$WP_DB_PREFIX \
               --allow-root \
               --skip-salts \
               --extra-php <<-PHP
define('WP_DEBUG', true);
define('WP_DEBUG_LOG', true);
$WP_GENERATED_SALTS
PHP

# Install / Activate WordPress
echo " "
echo "Install WordPress"
wp core multisite-install --url=$WP_BASE_URL \
                --title="${WP_BASE_TITLE} WordPress" \
                --admin_user=$WP_ADMIN_USER \
                --admin_password=$WP_ADMIN_PASSWORD \
                --admin_email=$WP_ADMIN_EMAIL \
                --allow-root

# Read in the URLs from the vvv-hosts file for the current multisite
echo " "
echo "Creating sites in WordPress Network"
while read -r URL
do
  SLUG='^([A-Za-z0-9\-]+)\.[A-Za-z0-9\-]+\..+$';
  if [[ $URL =~ $SLUG ]]; then
    SLUG="${BASH_REMATCH[1]}"
    echo "Creating ${WP_BASE_TITLE} site for ${SLUG}"
    wp site create --slug=$SLUG \
                   --title="${WP_BASE_TITLE} Subdomain (${SLUG}) WordPress" \
                   --email=$WP_ADMIN_EMAIL \
                   --allow-root;
  fi
done < "../vvv-hosts"

# Bow out
so_long_and_thanks_for_all_the_blogs
