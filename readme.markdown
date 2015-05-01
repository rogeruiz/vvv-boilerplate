VVV Boilerplates
===

Using [VVV](https://github.com/Varying-Vagrant-Vagrants/VVV) is pretty great. Having a starting point for any new projects you bring under the VVV tool-set is a great way to enhance your productivity.

### Getting started

Once this command runs, it will create an `./htdocs` directory in the current working directory if this directory doesn't exist. This `./htdocs` directory is used by VVV to serve WordPress. If you are tracking the whole project, you should create a Git repo within the `./htdocs` directory. If you are only tracking the theme, you can clone your custom theme, within the `./htdocs/wp-content/themes` directory.

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

##### Using the different boilerplates

Copy the boilerplate directory you want to use to `$VVV_ROOT/www` and update it's name appropriately. Once that directory has been copied to the `www` directory, you will have to update all of the files to reference your new site. The files that need to be updated are referenced below for each WordPress site.

One these files are updated, simply run `vagrant reload --provision` to provision your VM with the latest contents of `www`. If you simply provision the box, you will need to update your `/etc/hosts` file manually as the vagrant hooks only run on up/reload.

##### Single Site Boilerplate

```
./single-site
├── vvv-hosts
├── vvv-init.sh
└── vvv-nginx.conf
```

* `vvv-hosts` contains the /etc/hosts entries which will allow VVV to add them to your /etc/hosts file.
  * Update the line that references `project.dev` to point to the URL you would like for your site to use in the browser. __Remember this URL as you will be referencing it in the other files as well__.
* `vvv-init.sh` is the provisioning script for this specific WP installation.
  * Update the three variables:
    * `WP_DB_NAME`
    * `WP_BASE_URL` (_Same as the first line of your `vvv-hosts` file_)
    * `WP_BASE_TITLE`
  * Make sure to update any other variables that you may need to tweak if you are migrating a project from production to local. Otherwise, you should be safe with the defaults in the boilerplate.
* `vvv-nginx.conf` is the server-configuration block for the ngnix server running in the VM.
  * Update `server_name` to the same contents of the first line of your `vvv-hosts` file.

##### Multisite Subdirectories Boilerplate

```
./subdirectories-multi-site
├── vvv-hosts
├── vvv-init.sh
└── vvv-nginx.conf
```

* `vvv-hosts` contains the /etc/hosts entries which will allow VVV to add them to your /etc/hosts file.
  * Update the line that references `multiproject.dev` to point to the URL you would like for your site to use in the browser. __Remember this URL as you will be referencing it in the other files as well__.
  * Also update the rest of the lines to use a subdomain remembering to include the domain and TLD for your site. __Caveat: Even though this is a subdirectory WordPress Multisite the `vvv-init.sh` script expects the subdomains to exist in order to create your sites in the WordPress Multisite Network.__
* `vvv-init.sh` is the provisioning script for this specific WP installation.
  * Update the three variables:
    * `WP_DB_NAME`
    * `WP_BASE_URL` (_Same as the first line of your `vvv-hosts` file_)
    * `WP_BASE_TITLE`
  * Make sure to update any other variables that you may need to tweak if you are migrating a project from production to local. Otherwise, you should be safe with the defaults in the boilerplate.
* `vvv-nginx.conf` is the server-configuration block for the ngnix server running in the VM.
  * Update `server_name` to the same contents of the first line of your `vvv-hosts` file.

##### Multisite Subdomains Boilerplate

```
./subdomains-multi-site
├── vvv-hosts
├── vvv-init.sh
└── vvv-nginx.conf
```

* `vvv-hosts` contains the /etc/hosts entries which will allow VVV to add them to your /etc/hosts file.
  * Update the line that references `multiproject.dev` to point to the URL you would like for your site to use in the browser. __Remember this URL as you will be referencing it in the other files as well__.
  * Also update the rest of the lines to use a subdomain remembering to include the domain and TLD for your site.
* `vvv-init.sh` is the provisioning script for this specific WP installation.
  * Update the three variables:
    * `WP_DB_NAME`
    * `WP_BASE_URL` (_Same as the first line of your `vvv-hosts` file_)
    * `WP_BASE_TITLE`
  * Make sure to update any other variables that you may need to tweak if you are migrating a project from production to local. Otherwise, you should be safe with the defaults in the boilerplate.
* `vvv-nginx.conf` is the server-configuration block for the ngnix server running in the VM.
  * Update `server_name` to the same contents of the first line of your `vvv-hosts` file. __Remember to include the leading `.` character in the `server_name` to capture subdomains__

###### Happy Blogging!

