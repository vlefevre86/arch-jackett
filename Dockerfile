FROM binhex/arch-base:2015062300
MAINTAINER sdesbure

# additional files
##################

# add supervisor conf file for app
ADD *.conf /etc/supervisor/conf.d/

# add install bash script
ADD *.sh /root/

# install app
#############

# make executable and run bash scripts to install app
RUN chmod +x /root/*.sh && \
    /bin/bash /root/install.sh

# docker settings
#################

# map /config to host defined config path (used to store configuration from app)
VOLUME /config

# expose port for http
EXPOSE 9117

# mount /config on the right place
##################################

CMD mount -o bind /config /opt/Jackett/.config/Jackett

# run supervisor
################

# run supervisor
CMD ["supervisord", "-c", "/etc/supervisor.conf", "-n"]
