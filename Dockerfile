from zzl0/athenacli

USER root
run apt install -y most 
ENV PAGER=most
ENV AWS_ATHENA_S3_STAGING_DIR=<THE DIR>
ENV AWS_DEFAULT_REGION=<THE REGION>
COPY .athenacli /home/.athenacli
USER athena
