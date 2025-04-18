% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/data-env.R
\docType{data}
\encoding{UTF-8}
\name{data}
\alias{data}
\alias{mimic}
\alias{mimic_demo}
\alias{eicu}
\alias{eicu_demo}
\alias{hirid}
\alias{aumc}
\alias{miiv}
\alias{sic}
\title{ICU datasets}
\format{
The exported \code{data} environment contains all datasets that have been made
available to \code{ricu}. For datasets that are attached during package loading
(see \code{\link[=attach_src]{attach_src()}}), shortcuts to the datasets are set up in the package
namespace, allowing the object \verb{ricu::data::mimic_demo} to be accessed as
\code{ricu::mimic_demo} (or in case the package namespace has been attached,
simply as \code{mimic_demo}). Datasets that are made available after the package
namespace has been sealed will have their proxy object by default located
in \code{.GlobalEnv}. Datasets are represented by \code{\link[=new_src_env]{src_env}}
objects, while individual tables are \code{\link[=new_src_tbl]{src_tbl}} and do not
represent in-memory data, but rather data stored on disk, subsets of which
can be loaded into memory.
}
\usage{
data
}
\description{
The \href{https://lcp.mit.edu/index.html}{Laboratory for Computational Physiology } (LCP) at MIT hosts several large-scale
databases of hospital intensive care units (ICUs), two of which can be
either downloaded in full (\href{https://physionet.org/content/mimiciii/1.4/}{MIMIC-III } and \href{https://physionet.org/content/eicu-crd/2.0/}{eICU }) or as demo subsets
(\href{https://physionet.org/content/mimiciii-demo/1.4/}{MIMIC-III demo} and
\href{https://physionet.org/content/eicu-crd-demo/2.0/}{eICU demo}), while a
third data set is available only in full (\href{https://physionet.org/content/hirid/1.0/}{HiRID }). While demo data sets are
freely available, full download requires credentialed access which can be
gained by applying for an account with \href{https://physionet.org/register/}{PhysioNet }. Even though registration is required,
the described datasets are all publicly available. With \href{https://amsterdammedicaldatascience.nl/#amsterdamumcdb}{AmsterdamUMCdb }, a non-PhysioNet
hosted data source is available as well. As with the PhysioNet datasets,
access is public but has to be granted by the data collectors.
}
\details{
Setting up a dataset for use with `ricu` requires a configuration object.
For the included datasets, configuration can be loaded from

```
system.file("extdata", "config", "data-sources.json", package = "ricu")
```

by calling [load_src_cfg()] and for dataset that are external to `ricu`,
additional configuration can be made available by setting the environment
variable `RICU_CONFIG_PATH` (for more information, refer to
[load_src_cfg()]). Using the dataset configuration object, data can be
downloaded ([download_src()]), imported ([import_src()]) and attached
([attach_src()]). While downloading and importing are one-time procedures,
attaching of the dataset is repeated every time the package is loaded.
Briefly, downloading loads the raw dataset from the internet (most likely
in `.csv` format), importing consists of some preprocessing to make the
data available more efficiently (by converting it to [`.fst`][fst::fst()]
format) and attaching sets up the data for use by the package. For more
information on the individual steps, refer to the respective documentation
pages.

A dataset that has been successfully made available can interactively be
explored by typing its name into the console and individual tables can be
inspected using the `$` function. For example for the MIMIC-III demo
dataset and the `icustays` table, this gives

```{r, eval = is_data_avail("mimic_demo")}
mimic_demo
mimic_demo$icustays
```

Table subsets can be loaded into memory for example using the
[base::subset()] function, which uses non-standard evaluation (NSE) to
determine a row-subsetting. This design choice stems form the fact that
some tables can have on the order of 10^8 rows, which makes loading full
tables into memory an expensive operation. Table subsets loaded into
memory are represented as [`data.table`][data.table::data.table()] objects.
Extending the above example, if only ICU stays corresponding to the patient
with `subject_id == 10124` are of interest, the respective data can be
loaded as

```{r, eval = is_data_avail("mimic_demo")}
subset(mimic_demo$icustays, subject_id == 10124)
```

Much care has been taken to make `ricu` extensible to new datasets. For
example the publicly available ICU database [AmsterdamUMCdb
](https://amsterdammedicaldatascience.nl/amsterdamumcdb/)
provided by the Amsterdam University Medical Center, currently is not part
of the core datasets of `ricu`, but code for integrating this dataset is
available on [github](https://github.com/eth-mds/aumc).
}
\section{MIMIC-III}{

The Medical Information Mart for Intensive Care
(\href{https://physionet.org/content/mimiciii/}{MIMIC}) database holds
detailed clinical data from roughly 60,000 patient stays in Beth Israel
Deaconess Medical Center (BIDMC) intensive care units between 2001 and 2012.
The database includes information such as demographics, vital sign
measurements made at the bedside (~1 data point per hour), laboratory test
results, procedures, medications, caregiver notes, imaging reports, and
mortality (both in and out of hospital). For further information, please
refer to the \href{https://mimic.mit.edu/docs/iii/}{MIMIC-III documentation}.

The corresponding
\href{https://physionet.org/content/mimiciii-demo/}{demo dataset}
contains the full data of a randomly selected subset of 100 patients from
the patient cohort with conformed in-hospital mortality. The only notable
data omission is the \code{noteevents} table, which contains unstructured text
reports on patients.
}

\section{eICU}{

More recently, Philips Healthcare and LCP began assembling the \href{https://physionet.org/content/eicu-crd/2.0/}{eICU Collaborative Research Database } as a multi-center resource
for ICU data. Combining data of several critical care units throughout the
continental United States from the years 2014 and 2015, this database
contains de-identified health data associated with over 200,000 admissions,
including vital sign measurements, care plan documentation, severity of
illness measures, diagnosis information, and treatment information. For
further information, please refer to the \href{https://eicu-crd.mit.edu/about/eicu/}{eICU documentation }.

For the \href{https://physionet.org/content/eicu-crd-demo/2.0/}{demo subset},
data associated with ICU stays for over 2,500 unit stays selected from 20
of the larger hospitals is included. An important caveat that applied to the
eICU-based datasets is considerable variability among the large number of
hospitals in terms of data availability.
}

\section{HiRID}{

Moving to higher time-resolution, \href{https://physionet.org/content/hirid/1.0/}{HiRID } is a freely accessible critical
care dataset containing data relating to almost 34,000 patient admissions
to the Department of Intensive Care Medicine of the Bern University
Hospital, Switzerland. The dataset contains de-identified demographic
information and a total of 681 routinely collected physiological variables,
diagnostic test results and treatment parameters, collected during the
period from January 2008 to June 2016. Dependent on the type of measurement,
time resolution can be on the order of 2 minutes.
}

\section{AmsterdamUMCdb}{

With similar time-resolution (for vital-sign measurements) as HiRID,
\href{https://amsterdammedicaldatascience.nl/#amsterdamumcdb}{AmsterdamUMCdb}
contains data from 23,000 admissions of adult patients from 2003-2016 to
the department of Intensive Care, of Amsterdam University Medical Center.
In total, nearly 10^9^ individual observations consisting of vitals signs,
clinical scoring systems, device data and lab results data, as well as
nearly 5*10^6^ million medication entries, alongside de-identified
demographic information corresponding to the 20,000 individual patients
is spread over 7 tables.
}

\section{MIMIC-IV}{

The latest v2.2 release of MIMIC-IV is available in added in \code{ricu}.
Building on the success of MIMIC-III, this next iteration
contains data on patients admitted to an ICU or the emergency department
between 2008 - 2019 at BIDMC. Therefore, relative to MIMIC-III, patients
admitted prior to 2008 (whose data is stored in a CareVue-based system) has
been removed, while data onward of 2012 has been added. This simplifies
data queries considerably, as the CareVue/MetaVision data split in MIMIC-III
no longer applies. While addition of ED data is planned, this is not part
of the initial v1.0 release and currently is not supported by \code{ricu}. For
further information, please refer to the \href{https://mimic.mit.edu/docs/iii/}{MIMIC-III documentation }.
}

\section{SICdb}{

The Salzburg ICU database (SICdb) originates from the University Hospital of
Salzburg. In \code{ricu}, version v1.0.6 is currently supported. For
further information, please refer to the \href{https://physionet.org/content/sicdb/1.0.6/}{SICdb documentation }.
}

\references{
Johnson, A., Pollard, T., & Mark, R. (2016). MIMIC-III Clinical Database
(version 1.4). PhysioNet. https://doi.org/10.13026/C2XW26.

MIMIC-III, a freely accessible critical care database. Johnson AEW, Pollard
TJ, Shen L, Lehman L, Feng M, Ghassemi M, Moody B, Szolovits P, Celi LA,
and Mark RG. Scientific Data (2016). DOI: 10.1038/sdata.2016.35.

Johnson, A., Pollard, T., Badawi, O., & Raffa, J. (2019). eICU
Collaborative Research Database Demo (version 2.0). PhysioNet.
https://doi.org/10.13026/gxmm-es70.

The eICU Collaborative Research Database, a freely available multi-center
database for critical care research. Pollard TJ, Johnson AEW, Raffa JD,
Celi LA, Mark RG and Badawi O. Scientific Data (2018). DOI:
http://dx.doi.org/10.1038/sdata.2018.178.

Faltys, M., Zimmermann, M., Lyu, X., Hüser, M., Hyland, S., Rätsch, G., &
Merz, T. (2020). HiRID, a high time-resolution ICU dataset (version 1.0).
PhysioNet. https://doi.org/10.13026/hz5m-md48.

Hyland, S.L., Faltys, M., Hüser, M. et al. Early prediction of circulatory
failure in the intensive care unit using machine learning. Nat Med 26,
364–373 (2020). https://doi.org/10.1038/s41591-020-0789-4

Thoral PJ, Peppink JM, Driessen RH, et al (2020) AmsterdamUMCdb: The First
Freely Accessible European Intensive Care Database from the ESICM Data
Sharing Initiative. https://www.amsterdammedicaldatascience.nl.

Elbers, Dr. P.W.G. (Amsterdam UMC) (2019): AmsterdamUMCdb v1.0.2. DANS.
https://doi.org/10.17026/dans-22u-f8vd

Johnson, A., Bulgarelli, L., Pollard, T., Horng, S., Celi, L. A., & Mark, R.
(2021). MIMIC-IV (version 1.0). PhysioNet.
https://doi.org/10.13026/s6n6-xd98.

Goldberger, A., Amaral, L., Glass, L., Hausdorff, J., Ivanov, P. C., Mark,
R., ... & Stanley, H. E. (2000). PhysioBank, PhysioToolkit, and PhysioNet:
Components of a new research resource for complex physiologic signals.
Circulation (Online). 101 (23), pp. e215–e220.
}
\keyword{datasets}
