FROM amazon/aws-for-fluent-bit:2.9.0

RUN yum -y update && yum -y install gettext

COPY custom-fluent-bit.conf.template /
COPY custom-fluent-bit-datadog.conf.template /
COPY custom-entrypoint.sh /

RUN chmod +x /custom-entrypoint.sh

CMD ["/bin/bash", "/custom-entrypoint.sh"]
