FROM rocker/binder:4.0.2
LABEL maintainer='AlbanSagouis'
USER root
COPY . ${HOME}
RUN chown -R ${NB_USER} ${HOME}
USER ${NB_USER}



RUN R -e "install.packages(c('data.table'), repos = c(CRAN='https://packagemanager.rstudio.com/cran/2020-12-21'))"

