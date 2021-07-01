FROM tugboatqa/httpd

COPY dist/punchlist.conf /usr/local/apache2/conf/punchlist.conf
COPY dist/punchlist-page-create.sh /usr/local/bin/punchlist-page-create

RUN printf "\nInclude /usr/local/apache2/conf/punchlist.conf\n" \
  >> /usr/local/apache2/conf/httpd.conf; \
  apt-get update && \
  apt-get -y install jq && \
  apt-get clean && \
  rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
