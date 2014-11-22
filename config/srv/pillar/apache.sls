# ``apache`` formula configuration:
apache:
  server: apache2
  service: apache2

  vhostdir: /etc/apache2/sites-available
  confdir: /etc/apache2/conf.d
  confext: .conf
  logdir: /var/log/apache2
  wwwdir: /srv/apache2

  # ``apache.mod_wsgi`` formula additional configuration:
  mod_wsgi: mod_wsgi

  # ``apache.vhosts`` formula additional configuration:
  sites:
    example.net:
      template_file: salt://apache/vhosts/minimal.tmpl

    example.com: # must be unique; used as an ID declaration in Salt.
      template_file: salt://apache/vhosts/standard.tmpl

      ####################### DEFAULT VALUES BELOW ############################
      # NOTE: the values below are simply default settings that *can* be
      # overridden and are not required in order to use this formula to create
      # vhost entries.
      #
      # Do not copy the values below into your Pillar unless you intend to
      # modify these vaules.
      ####################### DEFAULT VALUES BELOW ############################
      template_engine: jinja

      interface: '*'
      port: '80'

      ServerName: example.com # uses the unique ID above unless specified
      ServerAlias: www.example.com

      ServerAdmin: webmaster@example.com

      LogLevel: warn
      ErrorLog: /path/to/logs/example.com-error.log # E.g.: /var/log/apache2/example.com-error.log
      CustomLog: /path/to/logs/example.com-access.log # E.g.: /var/log/apache2/example.com-access.log

      DocumentRoot: /path/to/www/dir/example.com # E.g., /var/www/example.com

      Directory:
        # "default" is a special case; Adds ``/path/to/www/dir/example.com``
        # E.g.: /var/www/example.com
        default:
          Options: -Indexes FollowSymLinks
          Order: allow,deny    # For Apache < 2.4
          Allow: from all      # For apache < 2.4
          Require: all granted # For apache > 2.4.
          AllowOverride: None
          Formula_Append: |
            Additional config as a
            multi-line string here

      Formula_Append: |
        Additional config as a
        multi-line string here

  # ``apache.debian_full`` formula additional configuration:
  register-site:
    # any name as an array index, and you can duplicate this section
    UNIQUE_VALUE_HERE:
      name: 'my name'
      path: 'salt://path/to/sites-available/conf/file'
      state: 'enabled'

  modules:
    enabled:  # List modules to enable
      - ldap
      - ssl
    disabled:  # List modules to disable
      - rewrite
