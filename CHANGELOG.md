# Change log

## master (unreleased)

### New Features

* [fix] restore_backup.sh restores the default public scheme
* SSL configuration is enabled by default
* Add backup and restore scripts
* Add `markdownlint` check in CI
* Add `shellcheck` check in CI

### Changes

* Fix create backup script to really use `gzip`
* Fix create backup script to created backup for non-clean db
