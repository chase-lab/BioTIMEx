BioTIMEx
--------

### Description

This research compendium regroups scripts used to download, re-structure
and aggregate data sets to constitute a large meta-analysis of
communities in experimental setups sampled several times. The code found
here was originally versionned using git and stored on github &lt;&gt;,
and was eventually submitted to Zenodo &lt;&gt;. This code accompanies
the article: XXXXX.

### Reproducibility and R environment

To ensure that the working environment (R version and package version)
are documented and isolated, the package renv
(<a href="https://rstudio.github.io/renv/index.html" class="uri">https://rstudio.github.io/renv/index.html</a>)
was used. By running `renv::restore()`, renv will install all missing
packages at once. This function will use the `renv.lock` file to
download the same versions of packages that we used.

### Methods

Data sets were originally searched for among LTER data sets and suitable
open access data stored on EPI were selected
(<a href="https://portal.edirepository.org/nis/home.jsp" class="uri">https://portal.edirepository.org/nis/home.jsp</a>).

Suitable data sets were individually downloaded from R. Scripts managing
these downloads are grouped inside `R/data download/`. These scripts
follow EDI process of data checking and formatting. You can run all
these scripts at once by running this command here or from
`R/1.0_downloading_raw_data.r`:

    if(!dir.exists('data/raw data/'))   dir.create('data/raw data/')
    listF <- list.files('./R/data download', pattern = ".R|.r", full.names = TRUE)
    lapply(listF, function(fullPath) source(fullPath, encoding = 'UTF-8', echo = FALSE, local = TRUE))

All downloaded data sets are saved in separate folders named following
the convention `author_year`.

In a second step, each data set is re-structured or wrangled to fit a
common format before analysis. The scripts turning the original
heterogeneously structured data sets into comparable tables are in the
`./R/data wrangling/` folder. You can run all these scripts at once by
running this command here or from `R/2.0-wrangling_raw_data.r`:

    if(!dir.exists('data/wrangled data/'))   dir.create('data/wrangled data/')
    listF <- list.files('R/data wrangling', pattern = ".R|.r", full.names = TRUE)
    lapply(listF, function(fullPath) source(fullPath, encoding = 'UTF-8', echo = FALSE, local = TRUE))

Finally, all restructured tables are aggregated together in a final
table by the `.R/3.0_merging_long-format_tables.r` script. The structure
of the end-product table is a long format with each row recording the
composition of a community in one place at a given time. Format is
described in `./data/template long format.txt` and variables are
defined.

### Analyses

Further analyses were carried at on R too by Shane Blowes and
collaborators.
