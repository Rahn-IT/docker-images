#!/bin/bash

cat << EOF > /parsedmarc/config.ini
[general]
save_aggregate = True
save_forensic = True
silent = False

[mailbox]
reports_folder = ${REPORTS_FOLDER}
archive_folder = ${ARCHIVE_FOLDER}
watch = True

[imap]
host = ${IMAP_HOST}
user = ${IMAP_USER} 
password = ${IMAP_PASSWORD}

[elasticsearch]
hosts = ${ES_URL}
ssl = ${ES_USE_SSL}


EOF


exec parsedmarc -c /parsedmarc/config.ini