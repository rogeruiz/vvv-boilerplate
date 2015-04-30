VVV Boilerplate
===

Using [VVV](https://github.com/Varying-Vagrant-Vagrants/VVV) is pretty great. Having a starting point for any new projects you bring under the VVV tool-set is a great way to enhance your productivity.

### Getting started

Once this command runs, it will create an `./htdocs` directory in the current working directory if this directory doesn't exist. This `./htdocs` directory is used by VVV to serve WordPress. If you are tracking the whole project, you should create a git repo within the `./htdocs` directory. If you are only tracking the theme, you can clone your custom theme, within the `./htdocs/wp-content/themes` directory.

##### If you are tracking the whole WordPress installation

```sh
$ cd ./htdocs
$ git init
```

##### If you are only tracking the WordPress theme

```sh
$ cd ./htdocs/wp-content/themes/
$ git clone git@github.com/user/theme-repo ./theme-wp
```

### Using VVV for local development

Documentation on VVV can be [found here](https://github.com/Varying-Vagrant-Vagrants/VVV#varying-vagrant-vagrants). More information about the files described below can be [found here](https://github.com/varying-vagrant-vagrants/vvv/wiki/Auto-site-Setup).

The following files each accomplish something specific to the VVV site.
```
./single-site
├── vvv-hosts
├── vvv-init.sh
└── vvv-nginx.conf
```

* `vvv-hosts` contains the /etc/hosts entries which will allow VVV to add them to your /etc/hosts file.

```
project-name.dev
```

* `vvv-init.sh` is the provisioning script for this specific WP installation.

```
#/bin/bash

# Init script for WordPress on VVV

# README: You are going to want to edit these.
WP_DB_NAME='wordpress_project'
WP_BASE_URL='project-name.dev'
WP_BASE_TITLE='WordPress Base Title'

# README: Defaults as you see fit, but these are good enough to leave for development.
WP_DB_USER='wp'
WP_DB_PASSWORD='wp'
WP_ADMIN_USER='admin'
WP_ADMIN_PASSWORD='password'
WP_ADMIN_EMAIL='admin@example.com'

# Make a database, if we don't already have one.
echo "Creating database for ${WP_BASE_TITLE} (if it's not already there)";

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
echo "${WP_BASE_TITLE} WordPress Successfully Installed ✔︎";

```

* `vvv-nginx.conf` is the server-configuration block for the ngnix server running in the VM.

```
server {
  listen 80;
  listen 443 ssl;
  server_name project-name.dev;

  root {vvv_path_to_folder}/htdocs;

  include /etc/nginx/nginx-wp-common.conf;
}
```
