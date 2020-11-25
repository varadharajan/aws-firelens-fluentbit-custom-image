FROM amazon/aws-for-fluent-bit:2.9.0

RUN yum -y update && yum -y install gettext

# Render config
RUN echo $' \n\
[OUTPUT] \n\
    Name cloudwatch \n\
    Match   * \n\
    region $REGION \n\
    log_group_name $LOG_GROUP_NAME \n\
    log_stream_prefix $LOG_PREFIX \n\
    auto_create_group true \n\
    log_key log \n\n\
[OUTPUT] \n\
    Name datadog \n\
    Match  * \n\
    TLS on \n\
    apikey $DD_API_KEY \n\
    dd_service $DD_SERVICE \n\
    dd_source $DD_SOURCE \n\
    dd_tags $DD_TAGS \n\
' > /custom-fluent-bit.conf.template 

# Render entrypoint
RUN echo $' \n\
set -e \n\
envsubst < /custom-fluent-bit.conf.template > /custom-fluent-bit.conf \n\
/bin/sh -c /entrypoint.sh \n\
' > /custom-entrypoint.sh

RUN chmod +x /custom-entrypoint.sh

CMD ["/bin/sh", "-c", "/custom-entrypoint.sh"]