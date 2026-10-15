# Wordpress integration for Univention Corporate Server (UCS)

## Security disclaimer
Don't use it on public servers - the wordpress version is outdated and most likely has severe security problems!

Upgrade the wordpress version immediately after the installation - and hope that the PHP versions, etc are still compatible.

## Install

Copy this repo to the UCS hostsystem. Then:

```bash
make build
make run
make install
```

## misc

The internal WordPress Administrator account is `wp-admin`. The password for this account can be found in the file `/etc/wordpress-admin.secret`.

By default the Plugin authLDAP is activated to use the UCS IDM as authentication backend.

- The default role for authenticated users is "Subscriber"
- All members of "Domain Admins" are "Administrators" in WordPress
- All members of "wordpress-subscribers" are "Subscribers" in WordPress
- All members of "wordpress-contributors" are "Contributors" in WordPress
- All members of "wordpress-editors" are "Editors" in WordPress
- All members of "wordpress-authors" are "Authors" in WordPress

Please note that the WordPress App has to be updated via wordpress itself (login as Administrator → Dashboard → Updates).
Updating the App via the App Center only updates the container (apache, php, ...) not WordPress.
