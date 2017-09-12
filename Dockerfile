FROM nginx
RUN mkdir -v -p /palladium/view && mkdir -v -p palladium/api && rm /etc/nginx/conf.d/default.conf
RUN echo "daemon off;" >> /etc/nginx/nginx.conf
ADD ./palladium.conf /etc/nginx/conf.d/palladium.conf
CMD service nginx start
