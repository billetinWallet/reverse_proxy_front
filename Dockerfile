FROM nginx
RUN apt-get update -qq && apt-get -y install apache2-utils
ENV NODE_ROOT /var/www/api-gateway
WORKDIR $NODE_ROOT
RUN mkdir log
COPY app.conf /tmp/app.nginx
COPY certificate.crt /etc/nginx/certificate.crt
COPY privatekey.key /etc/nginx/privatekey.key
RUN envsubst '$NODE_ROOT' < /tmp/app.nginx > /etc/nginx/conf.d/default.conf
EXPOSE 443
CMD [ "nginx", "-g", "daemon off;" ]