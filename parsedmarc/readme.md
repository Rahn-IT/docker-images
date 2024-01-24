# Parsedmarc

A docker container based on https://github.com/domainaware/parsedmarc.

| Environment Variable | Function                                                                                 |
|----------------------|------------------------------------------------------------------------------------------|
| IMAP_HOST            | The Imap host to connect to                                                              |
| IMAP_USER            | The user for IMAP login                                                                  |
| IMAP_PASSWORD        | The password for IMAP login                                                              |
| REPORTS_FOLDER       | The folder to search in - default is `INBOX`                                             |
| REPORTS_FOLDER       | The folder to put handled reports in - default is `Archive`                              |
| ES_URL               | The URL to use for connecting to Elasticsearch - e.g.: `https://user:secret@example.com` |
| ES_USE_SSL           | Configures if the connection should use SSL                                              |