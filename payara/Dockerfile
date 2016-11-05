FROM java:8-jdk

ARG PASSWORD
ENV PASSWORD $PASSWORD
ENV PAYARA_PKG https://s3-eu-west-1.amazonaws.com/payara.co/Payara+Downloads/Payara+4.1.1.163/payara-4.1.1.163.zip
ENV PAYARA_VERSION 163
ENV PKG_FILE_NAME payara-full-$PAYARA_VERSION.zip
ENV PAYARA_PATH /opt/payara41

RUN \
 apt-get update && \ 
 apt-get install -y apt-utils && \
 apt-get install -y unzip supervisor && \
 apt-get clean && \
 rm -rf /var/lib/apt/lists/*

RUN wget --quiet -O /opt/$PKG_FILE_NAME $PAYARA_PKG
RUN unzip -qq /opt/$PKG_FILE_NAME -d /opt

RUN mkdir -p $PAYARA_PATH/deployments/ROOT/WEB-INF
RUN useradd -b /opt -m -s /bin/bash payara && echo payara:payara | chpasswd
RUN chown -R payara:payara /opt

# Default payara ports to expose
EXPOSE 4848 8009 8080 8181

USER payara
WORKDIR $PAYARA_PATH


# set credentials to admin/admin 

RUN echo 'AS_ADMIN_PASSWORD=\n\
AS_ADMIN_NEWPASSWORD='$PASSWORD'\n\
EOF\n'\
>> /opt/tmpfile

RUN echo 'AS_ADMIN_PASSWORD='$PASSWORD'\n\
EOF\n'\
>> /opt/pwdfile

RUN $PAYARA_PATH/bin/asadmin start-domain && \
 $PAYARA_PATH/bin/asadmin --user admin --passwordfile=/opt/tmpfile change-admin-password && \
 $PAYARA_PATH/bin/asadmin --user admin --passwordfile=/opt/pwdfile enable-secure-admin && \
 $PAYARA_PATH/bin/asadmin restart-domain && \
 $PAYARA_PATH/bin/asadmin --user admin --passwordfile=/opt/pwdfile create-jvm-options '-Dspring.profiles.active=dev' && \
 $PAYARA_PATH/bin/asadmin --user admin --passwordfile=/opt/pwdfile delete-jvm-options '-XX\:MaxPermSize=192m' && \
 $PAYARA_PATH/bin/asadmin --user admin --passwordfile=/opt/pwdfile delete-jvm-options '-Xmx512m' && \
 $PAYARA_PATH/bin/asadmin --user admin --passwordfile=/opt/pwdfile create-jvm-options '-Xmx3072m' && \
 $PAYARA_PATH/bin/asadmin --user admin --passwordfile=/opt/pwdfile create-jvm-options '-Xms3072m' && \
 $PAYARA_PATH/bin/asadmin --user admin --passwordfile=/opt/pwdfile --interactive=false --help=false deploy --name youhire --force=false --verify=false --enabled=true --generatermistubs=false --availabilityenabled=false --contextroot / $PAYARA_PATH/deployments/ROOT/ && \
 $PAYARA_PATH/bin/asadmin stop-domain

RUN rm /opt/tmpfile

USER root
ADD payara.conf /etc/supervisor/conf.d
CMD ["/usr/bin/supervisord", "-n"]
