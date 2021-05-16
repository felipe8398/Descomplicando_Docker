
########################################
# IMAGEM ORIGEM QUESERÁ BUILDADA
FROM debian
########################################

########################################
# RUN É O COMANDO QUE SERA EXECUTADO AO EXECUTAR O BUILD DO CONTAINER
RUN apt-get update && apt-get install -y apache2 && apt-get clean
RUN chown www-data:www-data /var/lock/ && chown www-data:www-data /var/run/ && chown www-data:www-data /var/log/
########################################

########################################
# ENV SÃO AS VARIAVEIS DE AMBIENTE NECESSARIAS, NECESSARIO ENTENDER DE CADA APLICAÇÃO LENDO SUA DOCUMENTAÇAO 
ENV APACHE_LOCK_DIR="/var/lock"
ENV APACHE_PID_FILE="/var/run/apache2.pid"
ENV APACHE_RUN_USER="www-data"
ENV APACHE_RUN_GROUP="www-data"
ENV APACHE_LOG_DIR="/var/log/apache2"
########################################

########################################
# ADD ADIOCIONA UM ARQUIVO DO HOST NO DIRETORIO DO CONTAINER
ADD index.html /var/www/html/
########################################


########################################
# USER INFORMA COM QUAL USUARIO SERÁ EXECUTADO O CONTAINER 
USER root
########################################

########################################
# EM QUAL DIRETORIO VAI CAIR APÓS O DEPLOY DO CONATINER
WORKDIR /var/www/html
########################################

########################################
# LABEL SÃO DESCRIÇÕES DO CONTAINER
LABEL description="Webserver da massa"
LABEL version="1.0.foda-se"
########################################

########################################
# VOLUME QUE SERÁ CRIADO EM /var/lib/docker/volumes no host que tem relação com o caminho do container
VOLUME /var/www/html/
########################################

########################################
# EXPOSE É A PORTA QUE VAI RODAR O SERVIÇO NO CONTAINER
EXPOSE 80
########################################

########################################
# ENTRYPOINT É O PRONCIPAL PROCESSO, SE ELE MORRER O CONTAINER FALECE JUNTO
ENTRYPOINT ["/usr/sbin/apachectl"]
########################################

########################################
# CMD NESSE CASO IRÁ EXECUTAR OS PARAMETROS DO ENTRYPOINT 
CMD ["-D", "FOREGROUND"]
########################################
