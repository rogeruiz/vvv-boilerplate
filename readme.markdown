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
* `vvv-init.sh` is the provisioning script for this specific WP installation.
* `vvv-nginx.conf` is the server-configuration block for the ngnix server running in the VM.

The `.dev` URL needs to be updated in these three files to what you want to install. Also, the single-site directory should be copied into your `VVV/www` directory and named appropriately. The WP_DB_NAME, WP_BASE_URL, WP_BASE_TITLE variables in the `vvv-init.sh` script should be updated appropriately as well.
