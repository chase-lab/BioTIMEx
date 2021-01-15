FROM rocker/binder:4.0.3
LABEL maintainer='AlbanSagouis'
USER root
COPY . ${HOME}
RUN chown -R ${NB_USER} ${HOME}
USER ${NB_USER}



RUN R -e "install.packages('https://cran.r-project.org/src/contrib/Archive/data.table/data.table_1.13.1.tar.gz', type = 'source', repos = NULL)"

