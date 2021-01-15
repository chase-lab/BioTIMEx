FROM rocker/binder:4.0.1
LABEL maintainer='AlbanSagouis'
USER root
COPY . ${HOME}
RUN chown -R ${NB_USER} ${HOME}
USER ${NB_USER}



RUN R -e "install.packages(c('vegan','data.table'))"

