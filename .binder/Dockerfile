FROM rocker/binder:4.0.2
LABEL maintainer='AlbanSagouis'
USER root
COPY . ${HOME}
RUN chown -R ${NB_USER} ${HOME}
USER ${NB_USER}



RUN wget https://github.com/chase-lab/BioTimeX/raw/master/DESCRIPTION && R -e "renv::restore(repos = c(CRAN='https://packagemanager.rstudio.com/cran/2020-12-21'))"

RUN rm DESCRIPTION.1; exit 0
