# Documentation for the `gigs` package.
  
----------------------------------------------------------------
 
 *Assess Fetal, Newborn, and Child Growth with International Standards* 
  
----------------------------------------------------------------
 
### Version information:
  
- Package: gigs
- Version: 0.1.8
- Generated: 2024-11-21T17:32:25
- Author(s): Bartosz Jablonski (yabwon@gmail.com), Simon Parker (simon.parker.24@ucl.ac.uk), Linda Vesel, Eric Ohuma (eric.ohuma@lshtm.ac.uk)
- Maintainer(s): Bartosz Jablonski (yabwon@gmail.com)
- License: GNU General Public License v3.0
- File SHA256: `F*153695E7C4F007D2BFF34ACF7F666D95150F52E27ADA710EFEC8CD8FE2F804D0` for this version
- Content SHA256: `C*C6B2B9B3B715F6D4CF01316EFF20F327394FC8F8D3B1CE47DFCB99BA3F6F778E` for this version
  
---
 
# The `gigs` package, version: `0.1.8`;
  
---
 

# `gigs` SAS Package

## Overview

Produced as part of the Guidance for International Growth Standards
project at the London School of Hygiene & Tropical Medicine, **gigs**
provides a single, simple interface for working with the WHO Child
Growth standards and outputs from the INTERGROWTH-21<sup>st</sup>
project. You will find functions for converting from anthropometric
measures (e.g. weight or length) to z-scores and centiles, and the
inverse. Also included are functions for classifying newborn and infant
growth according to literature-based cut-offs.

**gigs** is of use to anyone interested in fetal and child growth,
including child health researchers, policymakers, and clinicians. This
package is best suited to growth data where the gestational age (GA) of
each child is known, as the use of the growth standards included in
**gigs** is GA-dependent. We recommend you check out the [available
standards](#available-international-growth-standards) section to see if
your anthropometric measurements can be converted to z-scores/centiles
by **gigs**. We recommend using **gigs** to generate continuous or
categorical measures of fetal/newborn/child growth, which can then be
used in downstream analyses.

## Installation

### Installing the SAS packages framework

`gigs` works with the SAS Packages Framework (SPF), so installing `gigs` requires
that the SPF is installed. First, create a directory where the SPF and 
packages will be stored. This can be at any directory you choose, for example:
- `D:\SAS_Packages`
- `/home/myuser/myPackages`

SPF is designed in such a way that this directory you've made **must** be refered
to by fileref `packages`. In your SAS session (preferably at the beginning), you
should run the following code:

```sas
filename packages "/path/to/packages/directory";
```

Installing an SPF package, "in a nutshell", means copying `SPFinit.sas` (from
`packagename.zip`) file into the packages directory. This can be done
automatically or manually.

### Installing `gigs` - automatic

To install `gigs` automatically, your SAS session must have access to the
internet.

The following code will install the SAS Packages Framework, `gigs`,
and `macroArray` (required for `gigs` to work). You only need to execute
this code *once*:

```sas
filename packages "/path/to/packages/directory";
filename SPFinit url
 "https://raw.githubusercontent.com/yabwon/SAS_PACKAGES/main/SPF/SPFinit.sas";
%include SPFinit;

%installPackage(SPFinit gigs macroArray)

filename SPFinit clear;
```

After running this code, check the log to see if the process was successful.

### Installing `gigs` - manual

If your SAS session *does not* have access to the internet but you can copy
files manually to your packages directory, you can install `gigs` like so:

- Download `SPFinit.sas` from [here](https://github.com/yabwon/SAS_PACKAGES/tree/main/SPF)
- Download `gigs.zip` from [here](https://github.com/SASPAC/gigs)
- Download `macroarray.zip` from [here](https://github.com/SASPAC/macroarray)

Once downloaded, copy these files manually to your SAS packages directory.

### Using `gigs` in a SAS session
To use `gigs` in a new SAS session, you must enable the SAS Packages Framework, then
load `gigs` with `%loadPackage`:

```sas
filename packages "/path/to/packages/directory";
%include packages(SPFinit.sas);
%loadPackage(gigs)
```

The `macroArray` package will be loaded automatically when `gigs` is loaded.

If using `gigs` often in your work, the most convenient/practical way to load `gigs` is
to put those three lines of code in your `autoexec.sas` file.

### Links to SAS Package Framework materials

The [**SAS Packages Framework (SPF)**](https://github.com/yabwon/SAS_PACKAGES)

Location of the [**SAS Packages Repository**](https://github.com/SASPAC)

[**Workshop materials**](https://github.com/yabwon/HoW-SASPackages)

---

## Rationale + terminology

When working with growth measurements from individual children, it is
helpful to compare those measurements to a growth standard, which
represents average growth for an population of children. This allows
assessment of individual growth - for example, that a baby was born
small, but later caught up to its peers in size. It also allows you to
compare measurements from different children.

These standards of growth can be made in different ways, but the best
studies utilise international samples made of up thousands of healthy
fetuses, newborns, or children. In **gigs**, you’ll find different
international growth standards, allowing you to compare growth measures
from children with different ages, weights, heights, and more.

In general, you’ll use **gigs** to transform raw growth measures to
*z-scores* or *centiles*. Z-scores and centiles represent the location
of a measurement within a normal distribution of values, such that:

- A *z-score* is the number of standard deviations from the mean for a
  given anthropometric measurement (e.g. height or weight).
- A *centile* represents the proportion of measurements in some
  distribution which we would expect to be lower than a measurement
  we’ve taken. In *gigs*, these are represented as a value between `0`
  and `1`. For example, `0.5` corresponds to the 50<sup>th</sup> centile
  (i.e. the mean), whereas `0.75` corresponds to the 75<sup>th</sup>
  centile.

In growth data, z-scores and centiles represent the size a fetus,
newborn, or child relative to its peers. Size here is considered
relative to a standardising variable, which is usually age but could
also be another variable such as their length. By tracking a child’s
relative size as they grow, you can see if they are achieving their
growth potential or not. If not, this may indicate underlying issues
such as ill health or undernutrition.

## Classification functions

**gigs** includes a number of functions which permit fast identification
of at-risk infants through classification of suboptimal growth. The
cut-offs used are sourced from research literature; you can check the
function documentation to see these sources.

### Available international growth standards

`gigs` facilitates the proper use of international growth standards, which
are growth charts developed using international samples of healthy singleton
children born to mothers that had their health needs met during pregnancy.
They represent an international standard of 'optimal' growth. `gigs` implements
international growth standards from the WHO and INTERGROWTH-21<sup>st</sup>
project:

* `ig_nbs` - INTERGROWTH-21<sup>st</sup> Newborn Size standards (including very preterm)
  <details><summary>Component standards</summary>

  | Acronym  | Description                   | Unit  | `gest_days` range |
  |----------|-------------------------------|-------|-------------------|
  | `wfga`   | weight-for-GA                 | kg    | 168 to 300 days   |
  | `lfga`   | length-for-GA                 | cm    | 168 to 300 days   |
  | `hcfga`  | head circumference-for-GA     | cm    | 168 to 300 days   |
  | `wlrfga` | weight-to-length ratio-for-GA | kg/cm | 168 to 300 days   |
  | `ffmfga` | fat-free mass-for-GA          | kg    | 266 to 294 days   |
  | `bfpfga` | body fat percentage-for-GA    | %     | 266 to 294 days   |
  | `fmfga`  | fat mass-for-GA               | kg    | 266 to 294 days   |

  </details>
* `ig_png` - INTERGROWTH-21<sup>st</sup> Postnatal Growth of Preterm Infants standards
  <details><summary>Component standards</summary>

  | Acronym | Description                | Unit | `x` range             |
  |---------|----------------------------|------|-----------------------|
  | `wfa`   | weight-for-age             | kg   | 27 to ≤64 exact weeks |
  | `lfa`   | length-for-age             | cm   | 27 to ≤64 exact weeks |
  | `hcfa`  | head circumference-for-age | cm   | 27 to ≤64 exact weeks |
  | `wfl`   | weight-for-length          | kg   | 35 to 65 cm           |

  </details>
* `ig_fet` - INTERGROWTH-21<sup>st</sup> Fetal standards
  <details><summary>Component standards</summary>

  | Acronym   | Description                                                  | Unit | `x` range       |
  |-----------|--------------------------------------------------------------|------|-----------------|
  | `hcfga`   | head circumference-for-GA                                    | mm   | 98 to 280 days  |
  | `bpdfga`  | biparietal diameter-for-GA                                   | mm   | 98 to 280 days  |
  | `acfga`   | abdominal circumference-for-GA                               | mm   | 98 to 280 days  |
  | `flfga`   | femur length-for-GA                                          | mm   | 98 to 280 days  |
  | `ofdfga`  | occipito-frontal diameter for-GA                             | mm   | 98 to 280 days  |
  | `efwfga`  | estimated fetal weight-for-GA                                | g    | 154 to 280 days |
  | `sfhfga`  | symphisis-fundal height-for-GA                               | mm   | 112 to 294 days |
  | `crlfga`  | crown-rump length-for-GA                                     | mm   | 58 to 105 days  |
  | `gafcrl`  | GA-for-crown-rump length                                     | days | 15 to 95 mm     |
  | `gwgfga`  | gestational weight gain-for-GA                               | kg   | 98 to 280 days  |
  | `pifga`   | pulsatility index-for-GA                                     |      | 168 to 280 days |
  | `rifga`   | resistance index-for-GA                                      |      | 168 to 280 days |
  | `sdrfga`  | systolic/diastolic ratio-for-GA                              |      | 168 to 280 days |
  | `tcdfga`  | transcerebellar diameter-for-GA                              | mm   | 98 to 280 days  |
  | `tcdfga`  | GA-for-transcerebellar diameter                              | mm   | 98 to 280 days  |
  | `poffga`  | parietal-occipital fissure-for-GA                            | mm   | 105 to 252 days |
  | `sffga`   | Sylvian fissue-for-GA                                        | mm   | 105 to 252 days |
  | `avfga`   | anterior horn of the lateral ventricle-for-GA                | mm   | 105 to 252 days |
  | `pvfga`   | atrium of the posterior horn of the lateral ventricle-for-GA | mm   | 105 to 252 days |
  | `cmfga`   | cisterna magna-for-GA                                        | mm   | 105 to 252 days |
  | `hefwfga` | Hadlock estimated fetal weight-for-GA                        | g    | 126 to 287 days |


  </details>
* `who_gs` - WHO Child Growth Standards for term infants
  <details><summary>Component standards</summary>

  | Acronym | Description                  | Unit             | `x` range       |
  |---------|------------------------------|------------------|-----------------|
  | `wfa`   | weight-for-age               | kg               | 0 to 1856 days  |
  | `bfa`   | BMI-for-age                  | kg/m<sup>2</sup> | 0 to 1856 days  |
  | `lhfa`  | length/height-for-age        | cm               | 0 to 1856 days  |
  | `hcfa`  | head circumference-for-age   | cm               | 0 to 1856 days  |
  | `wfl`   | weight-for-height            | kg               | 45 to 110 cm    |
  | `wfh`   | weight-for-length            | kg               | 65 to 120 cm    |
  | `acfa`  | arm circumference-for-age    | cm               | 91 to 1856 days |
  | `ssfa`  | subscapular skinfold-for-age | mm               | 91 to 1856 days |
  | `tsfa`  | triceps skinfold-for-age     | mm               | 91 to 1856 days |

  </details>

## Funding

Bill & Melinda Gates Foundation

---

  
---
 
  
---
 
Required SAS Components: 
  - Base SAS Software
  
---
 
Required SAS Packages: 
  - macroArray (1.2.6)
  
---
 
 
--------------------------------------------------------------------
 
*SAS package generated by SAS Package Framework, version `20241102`*
 
--------------------------------------------------------------------
 
# The `gigs` package content
The `gigs` package consists of the following content:
 
1. [`_tmpgigs` libname ](#tmpgigs-libname-1 )
2. [`_tmpgigs.ig_nbs_bc_li` data ](#tmpgigsignbsbcli-data-2 )
3. [`_tmpgigs.ig_nbs_coeffs` data ](#tmpgigsignbscoeffs-data-3 )
4. [`_tmpgigs.life6mo` data ](#tmpgigslife6mo-data-4 )
5. [`_tmpgigs.who_lms_parameters_data` data ](#tmpgigswholmsparametersdata-data-5 )
6. [`_tmpgigs.ig_fet_centiles_data` lazydata ](#tmpgigsigfetcentilesdata-lazydata-6 )
7. [`_tmpgigs.ig_fet_zscores_data` lazydata ](#tmpgigsigfetzscoresdata-lazydata-7 )
8. [`_tmpgigs.ig_nbs_centiles_data` lazydata ](#tmpgigsignbscentilesdata-lazydata-8 )
9. [`_tmpgigs.ig_nbs_zscores_data` lazydata ](#tmpgigsignbszscoresdata-lazydata-9 )
10. [`_tmpgigs.ig_png_centiles_data` lazydata ](#tmpgigsigpngcentilesdata-lazydata-10 )
11. [`_tmpgigs.ig_png_zscores_data` lazydata ](#tmpgigsigpngzscoresdata-lazydata-11 )
12. [`_tmpgigs.life6mo_expected` lazydata ](#tmpgigslife6moexpected-lazydata-12 )
13. [`_tmpgigs.who_gs_centiles_data` lazydata ](#tmpgigswhogscentilesdata-lazydata-13 )
14. [`_tmpgigs.who_gs_zscores_data` lazydata ](#tmpgigswhogszscoresdata-lazydata-14 )
15. [`gigs_ig_fet_estimate_ga_crl()` function ](#gigsigfetestimategacrl-functions-37 )
16. [`gigs_ig_png_equations()` function ](#gigsigpngequations-functions-47 )
17. [`gigs_ig_fet_estimate_ga()` function ](#gigsigfetestimatega-functions-52 )
18. [`gigs_ig_fet_value2zscore()` function ](#gigsigfetvalue2zscore-functions-53 )
19. [`gigs_ig_fet_zscore2value()` function ](#gigsigfetzscore2value-functions-54 )
20. [`gigs_ig_png_centile2value()` function ](#gigsigpngcentile2value-functions-58 )
21. [`gigs_ig_png_value2centile()` function ](#gigsigpngvalue2centile-functions-59 )
22. [`gigs_ig_png_value2zscore()` function ](#gigsigpngvalue2zscore-functions-60 )
23. [`gigs_ig_png_zscore2value()` function ](#gigsigpngzscore2value-functions-61 )
24. [`gigs_who_gs_value2zscore()` function ](#gigswhogsvalue2zscore-functions-64 )
25. [`gigs_who_gs_zscore2value()` function ](#gigswhogszscore2value-functions-65 )
26. [`gigs_ig_fet_centile2value()` function ](#gigsigfetcentile2value-functions-66 )
27. [`gigs_ig_fet_value2centile()` function ](#gigsigfetvalue2centile-functions-67 )
28. [`gigs_ig_nbs_centile2value()` function ](#gigsignbscentile2value-functions-68 )
29. [`gigs_ig_nbs_value2centile()` function ](#gigsignbsvalue2centile-functions-69 )
30. [`gigs_who_gs_centile2value()` function ](#gigswhogscentile2value-functions-70 )
31. [`gigs_who_gs_value2centile()` function ](#gigswhogsvalue2centile-functions-71 )
32. [`gigs_ig_nbs_value2zscore()` function ](#gigsignbsvalue2zscore-functions-72 )
33. [`gigs_ig_nbs_zscore2value()` function ](#gigsignbszscore2value-functions-73 )
34. [`%gigs_ig_fet_acronym()` macro ](#gigsigfetacronym-macro-74 )
35. [`%gigs_ig_nbs_acronym()` macro ](#gigsignbsacronym-macro-75 )
36. [`%gigs_ig_png_acronym()` macro ](#gigsigpngacronym-macro-76 )
37. [`%gigs_who_gs_acronym()` macro ](#gigswhogsacronym-macro-77 )
38. [`gigs_acronym_functions` exec ](#gigsacronymfunctions-exec-78 )
39. [`gigs_acronym_functions` clean ](#gigsacronymfunctions-clean-79 )
40. [`gigs_categorise_sfga()` function ](#gigscategorisesfga-functions-84 )
41. [`gigs_compute_sfga()` function ](#gigscomputesfga-functions-85 )
42. [`gigs_categorise_headsize()` function ](#gigscategoriseheadsize-functions-86 )
43. [`gigs_categorise_stunting()` function ](#gigscategorisestunting-functions-87 )
44. [`gigs_categorise_svn()` function ](#gigscategorisesvn-functions-88 )
45. [`gigs_categorise_wasting()` function ](#gigscategorisewasting-functions-89 )
46. [`gigs_categorise_wfa()` function ](#gigscategorisewfa-functions-90 )
47. [`gigs_compute_headsize()` function ](#gigscomputeheadsize-functions-91 )
48. [`gigs_compute_stunting()` function ](#gigscomputestunting-functions-92 )
49. [`gigs_compute_svn()` function ](#gigscomputesvn-functions-93 )
50. [`gigs_compute_wasting()` function ](#gigscomputewasting-functions-94 )
51. [`gigs_compute_wfa()` function ](#gigscomputewfa-functions-95 )
52. [`gigs_classify_headsize()` function ](#gigsclassifyheadsize-functions-96 )
53. [`gigs_classify_sfga()` function ](#gigsclassifysfga-functions-97 )
54. [`gigs_classify_stunting()` function ](#gigsclassifystunting-functions-98 )
55. [`gigs_classify_svn()` function ](#gigsclassifysvn-functions-99 )
56. [`gigs_classify_wasting()` function ](#gigsclassifywasting-functions-100 )
57. [`gigs_classify_wfa()` function ](#gigsclassifywfa-functions-101 )
58. [`%gigs_classify_growth()` macro ](#gigsclassifygrowth-macro-102 )
  
 
59. [License note](#license)
  
---
 
## `_tmpgigs` libname <a name="tmpgigs-libname-1"></a> ######
 
The `_tmpGIGS` library stores temporary data sets
generated during the `gigs` package load.

If possible a subdirectory of the `WORK` location is created, like: 
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~sas
LIBNAME _tmpGIGS BASE "%sysfunc(pathname(WORK))/gigs_package_temporary_data";
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

If not possible, then redirects to the `WORK` location, like:
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~sas
LIBNAME _tmpGIGS (WORK); 
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
---

  
---
 
## `_tmpgigs.ig_nbs_bc_li` data <a name="tmpgigsignbsbcli-data-2"></a> ######

Internal `gigs` package data. Contains coefficients for
INTERGROWTH-21<sup>st</sup> Newborn Size standard
for body composition (fat mass-for-GA; fat-free mass-for-GA; body fat %-for-GA).

  
---
 
## `_tmpgigs.ig_nbs_coeffs` data <a name="tmpgigsignbscoeffs-data-3"></a> ######

`gigs` package data.

INTERGROWTH-21<sup>st</sup> Newborn Size Standards GAMLSS coefficients

### Description
This table has mu, sigma, nu and tau coefficient values for the
INTERGROWTH-21<sup>st</sup> Newborn Size standards which are based on the skew
T type 3 distribution:

* Weight-for-gestational age from 231 to 300 days
* Length-for-gestational age from 231 to 300 days
* Head circumference-for-gestational age from 231 to 300 days

These coefficients are grouped by `acronym`, then `sex`. Within each group,
`gest_days` establishes the order of mu/sigma/nu/tau values.

### References

Villar J, Cheikh Ismail L, Victora CG, Ohuma EO, Bertino E, Altman DG, et al.
**International standards for newborn weight, length, and head circumference
by gestational age and sex: the Newborn Cross-Sectional Study of the
INTERGROWTH-21st Project.** *Lancet* 2014, **384(9946):857-68.**
doi: [10.1016/S0140-6736(14)60932-6](https://dx.doi.org/10.1016/S0140-6736(14)60932-6)

### Source

Raw mu/sigma/nu/tau values were provided by Dr Eric Ohuma.

---

  
---
 
## `_tmpgigs.life6mo` data <a name="tmpgigslife6mo-data-4"></a> ######

`gigs` package data.

Data extract from the Low birthweight Infant Feeding Exploration (LIFE) study

### Description 

A subset of anthropometric data for 300 singleton infants
enrolled in the Low birthweight Infant Feeding Exploration (LIFE) study. 

### Variables are as follows:

- `id` - Unique ID for each infant in the dataset (1--300).
- `sex` - Sex of the infant (`M` = Male; `F` = Female).
- `visitweek` - Chronological age in weeks (+1/-1) when study visit occurred (0--26).
- `gest_days` - Best obstetric estimate of gestational age in days (181--291).
- `age_days` - Chronological age in days at each visit; equal to `pma - gestage` (0--242).
- `pma` - Post-menstrual age in days (182--528).
- `wt_kg` - Mean weight in kg (1.240--9.40667).
- `len_cm` - Mean length in cm (37.37--72.93).
- `headcirc_cm` - Mean head circumference in cm (23.20--44.87).
- `muac_cm` - Mean mid-upper arm circumference in cm (6.30--16.83).

### Note 

We subsetted the full LIFE 6 month dataset for `gigs`. As such, this
extract only includes data from 300 singleton pregnancies where the best
estimate of gestational age was >168 days. We also removed rows in the full LIFE
dataset corresponding to visit weeks where no measurement data was taken due to
non-attendance of the visit.

### References

Vesel L, Bellad RM, Manji K, Saidi F, Velasquez E, Sudfeld C, et al.
**Feeding practices and growth patterns of moderately low birthweight infants
in resource-limited settings: results from a multisite, longitudinal
observational study.** *BMJ Open* 2023, **13(2):e067316.**
doi: [10.1136/BMJOPEN-2022-067316](https://dx.doi.org/10.1136/BMJOPEN-2022-067316)

---

  
---
 
## `_tmpgigs.who_lms_parameters_data` data <a name="tmpgigswholmsparametersdata-data-5"></a> ######

`gigs` package data.

WHO Child Growth Standards LMS coefficients

### Description

A table with lambda/mu/sigma values for the WHO Child Growth Standards. LMS
values are organised by each `acronym`, then `sex`, then the `x` variable which
is relevant to each `acronym` (either age, length/height, or  BMI).

### References

de Onis M, Garza C, Victora CG, Onyango AW, Frongillo EA, Martines J. **The
WHO Multicentre Growth Reference Study: planning, study design, and
methodology** *Food Nutr Bull.* 2004, **25(1 Suppl):S15-26.**
doi: [10.1177/15648265040251s104](https://dx.doi.org/10.1177/15648265040251s104)

World Health Organisation. **WHO child growth standards:
length/height-for-age, weight-for-age, weight-for-length, weight-for-height
and body mass index-for-age: methods and development.** *Technical report,
WHO, Geneva*, 2006.

World Health Organisation. **WHO child growth standards: head
circumference-for-age, arm circumference-for-age, triceps skinfold-for-age
and subscapular skinfold-for-age: methods and development.** *Technical
report, WHO, Geneva*, 2007.

Cole TJ. **The LMS method for constructing normalized growth standards.**
*Eur J Clin Nutr.* 1990, **44(1):45-60.** PMID:
[2354692](https://pubmed.ncbi.nlm.nih.gov/2354692/)

### Source

[WHO Child Growth Standards](https://www.who.int/tools/child-growth-standards/standards)

---

  
---
 
## `_tmpgigs.ig_fet_centiles_data` lazydata <a name="tmpgigsigfetcentilesdata-lazydata-6"></a> ######

`gigs` package lazy data with centile growth curves for the INTERGROWTH-21<sup>st</sup> Fetal standards.

### Description

A data set with reference values for different centiles at valid gestational
ages in days.

### Source

[INTERGROWTH-21<sup>st</sup> Pregnancy Dating (CRL)](https://intergrowth21.tghn.org/pregnancy-dating/)

[INTERGROWTH-21<sup>st</sup> Symphysis-Fundal Height standard](https://intergrowth21.tghn.org/symphysis-fundal-height/)

[INTERGROWTH-21<sup>st</sup> Fetal Growth standards](https://intergrowth21.tghn.org/fetal-growth/)

[INTERGROWTH-21<sup>st</sup> Fetal Doppler standards](https://intergrowth21.tghn.org/fetal-doppler/)

[INTERGROWTH-21<sup>st</sup> Gestational Weight Gain standard](https://intergrowth21.tghn.org/gestational-weight-gain/)

### Note

Some cells are missing data values, because the different Fetal
standards were published using different centiles - so some have data for e.g.
the 25th centile, whilst others do not.

### References

Papageorghiou AT, Ohuma EO, Altman DG, Todros T, Cheikh Ismail L, Lambert A
et al. **International standards for fetal growth based on serial ultrasound
measurements: the Fetal Growth Longitudinal Study of the INTERGROWTH-21st
Project.** *Lancet* 2014, **384(9946):869-79.**
doi: [10.1016/S0140-6736(14)61490-2](https://dx.doi.org/10.1016/S0140-6736(14)61490-2)

Stirnemann J, Villar J, Salomon LJ, Ohuma EO, Lamber A, Victoria CG et al.
**International Estimated Fetal Weight Standards of the INTERGROWTH-21st
Project.** *Ultrasound Obstet Gynecol* 2016, **49:478-486**
doi: [10.1002/uog.17347](https://dx.doi.org/10.1002/uog.17347)

Papageorghiou AT, Ohuma EO, Gravett MG, Lamber A, Noble JA, Pang R et al.
**International standards for symphysis-fundal height based on serial
measurements from the Fetal Growth Longitudinal Study of the INTERGROWTH-21st
Project: prospective cohort study in eight countries.** *BMJ* 2016, **355:i5662** 
doi: [10.1136/bmj.i5662](https://dx.doi.org/10.1136/bmj.i5662)

Papageorghiou AT, Kennedy SH, Salomon LJ, Ohuma EO, Cheikh Ismail L, Barros
FC et al. **International standards for early fetal size and pregnancy dating
based on ultrasound measurement of crown-rump length in the first trimester
of pregnancy.** *Ultrasound Obstet Gynecol* 2014, **44(6):641-48**
doi: [10.1002/uog.13448](https://dx.doi.org/10.1002/uog.13448)

Cheikh Ismail L, Bishop DC, Pang R, Ohuma EO, Kac G, Abrams B et al.
**Gestational weight gain standards based on women enrolled in the Fetal
Growth Longitudinal Study of the INTERGROWTH-21st Project: a prospective
longitudinal cohort study.** *BMJ* 2016, **352:i555** 
doi: [10.1136/bmj.i555](https://dx.doi.org/10.1136/bmj.i555)

Drukker L, Staines-Urias E, Villar J, Barros FC, Carvalho M, Munim S et al.
**International gestational age-specific centiles for umbilical artery
Doppler indices: a longitudinal prospective cohort study of the
INTERGROWTH-21st Project.** *Am J Obstet Gynecol* 2021,
**222(6):602.e1-602.e15** \doi{10.1016/j.ajog.2020.01.012}
doi: [10.1016/j.ajog.2020.01.012](https://dx.doi.org/10.1016/j.ajog.2020.01.012)

Rodriguez-Sibaja MJ, Villar J, Ohuma EO, Napolitano R, Heyl S, Carvalho M et
al. **Fetal cerebellar growth and Sylvian fissure maturation: international
standards from Fetal Growth Longitudinal Study of INTERGROWTH-21st Project**
*Ultrasound Obstet Gynecol* 2021, **57(4):614-623** 
doi: [10.1002/uog.22017](https://dx.doi.org/10.1002/uog.22017)

Napolitano R, Molloholli M, Donadono V, Ohuma EO, Wanyonyi SZ, Kemp B et al.
**International standards for fetal brain structures based on serial
ultrasound measurements from Fetal Growth Longitudinal Study of
INTERGROWTH-21st Project** *Ultrasound Obstet Gynecol* 2020, **56(3):359-370** 
doi: [10.1002/uog.21990](https://dx.doi.org/10.1002/uog.21990)

Stirnemann J, Salomon LJ, Papageorghiou AT. **INTERGROWTH-21st
standards for Hadlock's estimation of fetal weight** *Ultrasound Obstet
Gynecol* 2020, **56(6):946-948**
doi: [10.1002/uog.22000](https://dx.doi.org/10.1002/uog.22000)

### Loading data to SAS

Run the following snippet to load the data set to SAS session:

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ sas
  %loadPackage(gigs, lazyData=_tmpgigs.ig_fet_centiles_data)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

---

  
---
 
## `_tmpgigs.ig_fet_zscores_data` lazydata <a name="tmpgigsigfetzscoresdata-lazydata-7"></a> ######

`gigs` package lazy data with z-score growth curves for the INTERGROWTH-21<sup>st</sup> Fetal standards.

### Description

A data set with reference values for different z-scores at valid gestational
ages in days.

### Source

[INTERGROWTH-21<sup>st</sup> Pregnancy Dating (CRL)](https://intergrowth21.tghn.org/pregnancy-dating/)

[INTERGROWTH-21<sup>st</sup> Symphysis-Fundal Height standard](https://intergrowth21.tghn.org/symphysis-fundal-height/)

[INTERGROWTH-21<sup>st</sup> Fetal Growth standards](https://intergrowth21.tghn.org/fetal-growth/)

[INTERGROWTH-21<sup>st</sup> Fetal Doppler standards](https://intergrowth21.tghn.org/fetal-doppler/)

[INTERGROWTH-21<sup>st</sup> Gestational Weight Gain standard](https://intergrowth21.tghn.org/gestational-weight-gain/)

### Note

Some INTERGROWTH-21<sup>st</sup> Fetal standards were only published with
centile tables, so not all of the INTERGROWTH-21<sup>st</sup> Fetal standards
are present in this table of z-score data.

### References

Papageorghiou AT, Ohuma EO, Altman DG, Todros T, Cheikh Ismail L, Lambert A
et al. **International standards for fetal growth based on serial ultrasound
measurements: the Fetal Growth Longitudinal Study of the INTERGROWTH-21st
Project.** *Lancet* 2014, **384(9946):869-79.**
doi: [10.1016/S0140-6736(14)61490-2](https://dx.doi.org/10.1016/S0140-6736(14)61490-2)

Stirnemann J, Villar J, Salomon LJ, Ohuma EO, Lamber A, Victoria CG et al.
**International Estimated Fetal Weight Standards of the INTERGROWTH-21st
Project.** *Ultrasound Obstet Gynecol* 2016, **49:478-486**
doi: [10.1002/uog.17347](https://dx.doi.org/10.1002/uog.17347)

Papageorghiou AT, Ohuma EO, Gravett MG, Lamber A, Noble JA, Pang R et al.
**International standards for symphysis-fundal height based on serial
measurements from the Fetal Growth Longitudinal Study of the INTERGROWTH-21st
Project: prospective cohort study in eight countries.** *BMJ* 2016, **355:i5662** 
doi: [10.1136/bmj.i5662](https://dx.doi.org/10.1136/bmj.i5662)

Papageorghiou AT, Kennedy SH, Salomon LJ, Ohuma EO, Cheikh Ismail L, Barros
FC et al. **International standards for early fetal size and pregnancy dating
based on ultrasound measurement of crown-rump length in the first trimester
of pregnancy.** *Ultrasound Obstet Gynecol* 2014, **44(6):641-48**
doi: [10.1002/uog.13448](https://dx.doi.org/10.1002/uog.13448)

Cheikh Ismail L, Bishop DC, Pang R, Ohuma EO, Kac G, Abrams B et al.
**Gestational weight gain standards based on women enrolled in the Fetal
Growth Longitudinal Study of the INTERGROWTH-21st Project: a prospective
longitudinal cohort study.** *BMJ* 2016, **352:i555** 
doi: [10.1136/bmj.i555](https://dx.doi.org/10.1136/bmj.i555)

Drukker L, Staines-Urias E, Villar J, Barros FC, Carvalho M, Munim S et al.
**International gestational age-specific centiles for umbilical artery
Doppler indices: a longitudinal prospective cohort study of the
INTERGROWTH-21st Project.** *Am J Obstet Gynecol* 2021,
**222(6):602.e1-602.e15** \doi{10.1016/j.ajog.2020.01.012}
doi: [10.1016/j.ajog.2020.01.012](https://dx.doi.org/10.1016/j.ajog.2020.01.012)

Rodriguez-Sibaja MJ, Villar J, Ohuma EO, Napolitano R, Heyl S, Carvalho M et
al. **Fetal cerebellar growth and Sylvian fissure maturation: international
standards from Fetal Growth Longitudinal Study of INTERGROWTH-21st Project**
*Ultrasound Obstet Gynecol* 2021, **57(4):614-623** 
doi: [10.1002/uog.22017](https://dx.doi.org/10.1002/uog.22017)

Napolitano R, Molloholli M, Donadono V, Ohuma EO, Wanyonyi SZ, Kemp B et al.
**International standards for fetal brain structures based on serial
ultrasound measurements from Fetal Growth Longitudinal Study of
INTERGROWTH-21st Project** *Ultrasound Obstet Gynecol* 2020, **56(3):359-370** 
doi: [10.1002/uog.21990](https://dx.doi.org/10.1002/uog.21990)

Stirnemann J, Salomon LJ, Papageorghiou AT. **INTERGROWTH-21st
standards for Hadlock's estimation of fetal weight** *Ultrasound Obstet
Gynecol* 2020, **56(6):946-948**
doi: [10.1002/uog.22000](https://dx.doi.org/10.1002/uog.22000)

### Loading data to SAS

Run the following snippet to load the data set to SAS session:

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ sas
  %loadPackage(gigs, lazyData=_tmpgigs.ig_fet_zscores_data)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

---

  
---
 
## `_tmpgigs.ig_nbs_centiles_data` lazydata <a name="tmpgigsignbscentilesdata-lazydata-8"></a> ######

`gigs` package lazy data with centile growth curves for the
INTERGROWTH-21<sup>st</sup> Newborn Size standards (including very preterm).

### Description

A data set with reference values for different centiles at valid gestational
ages in days.

### Source

[INTERGROWTH-21<sup>st</sup> Newborn Size in Very Preterm Infants](https://intergrowth21.tghn.org/very-preterm-size-birth/#vp1)

[INTERGROWTH-21<sup>st</sup> Newborn Size Standards](https://intergrowth21.tghn.org/newborn-size-birth/#ns1)

[INTERGROWTH-21<sup>st</sup> Newborn Size Standards - Body Composition](https://www.nature.com/articles/pr201752)

### Note

The tables in this package are combined versions of the tables published by
Villar *et al.* (2014) and Villar *et al.* (2016), so they cover `168` to
`300` days' gestational age. The body composition tables (`ffmfga`, `bfpfga`,
and `fmfga`) cover a smaller gestational age span, ranging from only `266` to
`294` days' (38 to 42 weeks') gestational age.

### References

Villar J, Giuliani F, Fenton TR, Ohuma EO, Ismail LC, Kennedy SH et al.
**INTERGROWTH-21st very preterm size at birth reference charts.** *Lancet*
2016, **387(10021):844-45.** 
doi: [10.1016/S0140-6736(16)00384-6](https://dx.doi.org/10.1016/S0140-6736(16)00384-6)

Villar J, Cheikh Ismail L, Victora CG, Ohuma EO, Bertino E, Altman DG, et al.
**International standards for newborn weight, length, and head circumference
by gestational age and sex: the Newborn Cross-Sectional Study of the
INTERGROWTH-21st Project.** *Lancet* 2014, **384(9946):857-68.**
doi: [10.1016/S0140-6736(14)60932-6](https://dx.doi.org/10.1016/S0140-6736(14)60932-6)

Villar J, Puglia FA, Fenton TR, Ismal LC, Staines-Urias E, Giuliani F, et al.
**Body composition at birth and its relationship with neonatal anthropometric
ratios: the newborn body composition study of the INTERGROWTH-21st
project.** *Pediatric Research* 2017, **82:305-316.**
doi: [10.1038/pr.2017.52](https://dx.doi.org/10.1038/pr.2017.52)

### Loading data to SAS

Run the following snippet to load the data set to SAS session:

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ sas
  %loadPackage(gigs, lazyData=_tmpgigs.ig_nbs_centiles_data)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

---

  
---
 
## `_tmpgigs.ig_nbs_zscores_data` lazydata <a name="tmpgigsignbszscoresdata-lazydata-9"></a> ######

`gigs` package lazy data with z-score growth curves for the
INTERGROWTH-21<sup>st</sup> Newborn Size standards (including very preterm).

### Description

A data set with reference values for different z-scores at valid gestational
ages in days.

### Source

[INTERGROWTH-21<sup>st</sup> Newborn Size in Very Preterm Infants](https://intergrowth21.tghn.org/very-preterm-size-birth/#vp1)

[INTERGROWTH-21<sup>st</sup> Newborn Size Standards](https://intergrowth21.tghn.org/newborn-size-birth/#ns1)

[INTERGROWTH-21<sup>st</sup> Newborn Size Standards - Body Composition](https://www.nature.com/articles/pr201752)

### Note

The tables in this package are combined versions of the tables published by
Villar *et al.* (2014) and Villar *et al.* (2016), so they cover `168` to
`300` days' gestational age. The body composition tables (`ffmfga`, `bfpfga`,
and `fmfga`) cover a smaller gestational age span, ranging from only `266` to
`294` days' (38 to 42 weeks') gestational age.

### References

Villar J, Giuliani F, Fenton TR, Ohuma EO, Ismail LC, Kennedy SH et al.
**INTERGROWTH-21st very preterm size at birth reference charts.** *Lancet*
2016, **387(10021):844-45.** 
doi: [10.1016/S0140-6736(16)00384-6](https://dx.doi.org/10.1016/S0140-6736(16)00384-6)

Villar J, Cheikh Ismail L, Victora CG, Ohuma EO, Bertino E, Altman DG, et al.
**International standards for newborn weight, length, and head circumference
by gestational age and sex: the Newborn Cross-Sectional Study of the
INTERGROWTH-21st Project.** *Lancet* 2014, **384(9946):857-68.**
doi: [10.1016/S0140-6736(14)60932-6](https://dx.doi.org/10.1016/S0140-6736(14)60932-6)

Villar J, Puglia FA, Fenton TR, Ismal LC, Staines-Urias E, Giuliani F, et al.
**Body composition at birth and its relationship with neonatal anthropometric
ratios: the newborn body composition study of the INTERGROWTH-21st
project.** *Pediatric Research* 2017, **82:305-316.**
doi: [10.1038/pr.2017.52](https://dx.doi.org/10.1038/pr.2017.52)

### Loading data to SAS

Run the following snippet to load the data set to SAS session:

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ sas
  %loadPackage(gigs, lazyData=_tmpgigs.ig_nbs_zscores_data)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

---

  
---
 
## `_tmpgigs.ig_png_centiles_data` lazydata <a name="tmpgigsigpngcentilesdata-lazydata-10"></a> ######

`gigs` package lazy data with z-score growth curves for the
INTERGROWTH-21<sup>st</sup> Postnatal Growth Standards.

### Description

A data set with reference values for different centiles at `x` variables, either
post-menstrual age in weeks or length in cm.

### References

Villar J, Giuliani F, Bhutta ZA, Bertino E, Ohuma EO, Ismail LC et al.
**Postnatal growth standards for preterm infants: the Preterm Postnatal
Follow-up Study of the INTERGROWTH-21st Project.** *Lancet Glob Health* 2015,
*3(11):e681-e691.* 
doi: [10.1016/S2214-109X(15)00163-1](https://dx.doi.org/10.1016/S2214-109X(15)00163-1)

### Source

[INTERGROWTH-21<sup>st</sup> Postnatal Growth of Preterm Infants](https://intergrowth21.tghn.org/postnatal-growth-preterm-infants/)

### Loading data to SAS

Run the following snippet to load the data set to SAS session:

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ sas
  %loadPackage(gigs, lazyData=_tmpgigs.ig_png_centiles_data)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

---

  
---
 
## `_tmpgigs.ig_png_zscores_data` lazydata <a name="tmpgigsigpngzscoresdata-lazydata-11"></a> ######

`gigs` package lazy data with z-score growth curves for the
INTERGROWTH-21<sup>st</sup> Postnatal Growth Standards.

### Description

A data set with reference values for different z-scores at `x` variables, either
post-menstrual age in weeks or length in cm.

### References

Villar J, Giuliani F, Bhutta ZA, Bertino E, Ohuma EO, Ismail LC et al.
**Postnatal growth standards for preterm infants: the Preterm Postnatal
Follow-up Study of the INTERGROWTH-21st Project.** *Lancet Glob Health* 2015,
*3(11):e681-e691.* 
doi: [10.1016/S2214-109X(15)00163-1](https://dx.doi.org/10.1016/S2214-109X(15)00163-1)

### Source

[INTERGROWTH-21<sup>st</sup> Postnatal Growth of Preterm Infants](https://intergrowth21.tghn.org/postnatal-growth-preterm-infants/)

### Loading data to SAS

Run the following snippet to load the data set to SAS session:

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ sas
  %loadPackage(gigs, lazyData=_tmpgigs.ig_png_zscores_data)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

---

  
---
 
## `_tmpgigs.life6mo_expected` lazydata <a name="tmpgigslife6moexpected-lazydata-12"></a> ######

Internal `gigs` package lazy data. Required to perform tests.

### Loading data to SAS

Run the following snippet to load the data set to SAS session:

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ sas
  %loadPackage(gigs, lazyData=_tmpgigs.life6mo_expected)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

---

  
---
 
## `_tmpgigs.who_gs_centiles_data` lazydata <a name="tmpgigswhogscentilesdata-lazydata-13"></a> ######

`gigs` package lazy data with centile growth curves for the WHO Child Growth
standards.

### Description

A data set with reference values at different centiles for valid `x` values
(usually age in days, also length or height in cm for weight-for-length (`wfl`)
and weight-for-height (`wfh`) standards, respectively).

### References

de Onis M, Garza C, Victora CG, Onyango AW, Frongillo EA, Martines J. **The
WHO Multicentre Growth Reference Study: planning, study design, and
methodology** *Food Nutr Bull.* 2004, **25(1 Suppl):S15-26.**
doi: [10.1177/15648265040251s104](https://dx.doi.org/10.1177/15648265040251s104)

World Health Organisation. **WHO child growth standards:
length/height-for-age, weight-for-age, weight-for-length, weight-for-height
and body mass index-for-age: methods and development.** *Technical report,
WHO, Geneva*, 2006.

World Health Organisation. **WHO child growth standards: head
circumference-for-age, arm circumference-for-age, triceps skinfold-for-age
and subscapular skinfold-for-age: methods and development.** *Technical
report, WHO, Geneva*, 2007.

### Source

[WHO Child Growth Standards](https://www.who.int/tools/child-growth-standards/standards)

### Loading data to SAS

Run the following snippet to load the data set to SAS session:

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ sas
  %loadPackage(gigs, lazyData=_tmpgigs.who_gs_centiles_data)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

---

  
---
 
## `_tmpgigs.who_gs_zscores_data` lazydata <a name="tmpgigswhogszscoresdata-lazydata-14"></a> ######

`gigs` package lazy data with z-score growth curves for the WHO Child Growth
standards.

### Description

A data set with reference values at different z-scores for valid `x` values
(usually age in days, also length or height in cm for weight-for-length (`wfl`)
and weight-for-height (`wfh`) standards, respectively).

### References

de Onis M, Garza C, Victora CG, Onyango AW, Frongillo EA, Martines J. **The
WHO Multicentre Growth Reference Study: planning, study design, and
methodology** *Food Nutr Bull.* 2004, **25(1 Suppl):S15-26.**
doi: [10.1177/15648265040251s104](https://dx.doi.org/10.1177/15648265040251s104)

World Health Organisation. **WHO child growth standards:
length/height-for-age, weight-for-age, weight-for-length, weight-for-height
and body mass index-for-age: methods and development.** *Technical report,
WHO, Geneva*, 2006.

World Health Organisation. **WHO child growth standards: head
circumference-for-age, arm circumference-for-age, triceps skinfold-for-age
and subscapular skinfold-for-age: methods and development.** *Technical
report, WHO, Geneva*, 2007.

### Source

[WHO Child Growth Standards](https://www.who.int/tools/child-growth-standards/standards)

### Loading data to SAS

Run the following snippet to load the data set to SAS session:

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ sas
  %loadPackage(gigs, lazyData=_tmpgigs.who_gs_zscores_data)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

---

  
---
 
## `gigs_ig_fet_estimate_ga_crl()` function <a name="gigsigfetestimategacrl-functions-37"></a> ######

Estimate gestational age using crown-rump length in mm

### Syntax

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~sas
function gigs_ig_fet_estimate_ga_crl(
  crl_mm
);
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

---


### Arguments

1. `crl_mm` - Crown-rump length value(s) in mm taken from
    an ultrasound scan obtained 56 to 97 days since the
    last menstrual period.

### Returns

Numeric variable with gestational age estimate(s) in days.

### See also

This function uses `gigs_ig_fet_mu_sigma` subroutine internally.

### References

Papageorghiou AT, Kennedy SH, Salomon LJ, Ohuma EO, Cheikh Ismail L, Barros
FC et al. **International standards for early fetal size and pregnancy dating
based on ultrasound measurement of crown-rump length in the first trimester
of pregnancy.** *Ultrasound Obstet Gynecol* 2014, **44(6):641-48**
doi: [10.1002/uog.13448](https://dx.doi.org/10.1002/uog.13448)

---

  
---
 
## `gigs_ig_png_equations()` function <a name="gigsigpngequations-functions-47"></a> ######

INTERGROWTH-21<sup>st</sup> Postnatal Growth of Preterm Infants standards:
mu/sigma equations

Estimates median and standard deviation for different measures of postnatal
growth in preterm infants.

### Syntax

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~sas
subroutine gigs_ig_png_equations(
  xIN
, sex $
, acronym $
, mu
, sigma
, logarithmic
);
  OUTARGS mu, sigma, logarithmic;
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

---


### Arguments

1. `sex` - Character variable with sex(es), either `"M"` (male) or `"F"` (female).

2. `pma_weeks` - Numeric variable with post-menstrual age(s) in exact weeks. 
    Elements not between `27` and `64` will return invalid results.

3. `acronym` - Character variable with acronym(s) denoting 
    an INTERGROWTH-21<sup>st</sup> Postnatal Growth standard. Should
    be one of `"wfa"` (weight-for-age), `"lfa"` (length-for-age), `"hcfa"`
    (head circumference-for-age), or `"wfl"` (weight-for-length).

4. `mu` - Numeric variable, of category `OUTARGS`, with mu parameter 
    value returned for particular combination of `gest_days`, `sex`, and `acronym`.

5. `sigma` - Numeric variable, of category `OUTARGS`, with sigma parameter 
    value returned for particular combination of `gest_days`, `sex`, and `acronym`.

6. `logarithmic` - Numeric variable, of category `OUTARGS`, which returns `1`
    for acronyms `"wfa"` and `"lfa"` and `0` otherwise.

### Note 

The weight-for-age and length-for-age standards are logarithmic, so
require slightly different treatment to use in z-score conversions. In
contrast, head circumference for gestational age returns the median and
standard deviation with no logarithm applied. The weight-for-length
standard is not within the provided reference, but was instead supplied
directly by Dr Eric Ohuma.

### References

Villar J, Giuliani F, Bhutta ZA, Bertino E, Ohuma EO, Ismail LC et al.
**Postnatal growth standards for preterm infants: the Preterm Postnatal
Follow-up Study of the INTERGROWTH-21st Project.** *Lancet Glob Health* 2015,
*3(11):e681-e691.* 
doi: [10.1016/S2214-109X(15)00163-1](https://dx.doi.org/10.1016/S2214-109X(15)00163-1)

---

  
---
 
## `gigs_ig_fet_estimate_ga()` function <a name="gigsigfetestimatega-functions-52"></a> ######

Estimate gestational age using INTERGROWTH-21<sup>st</sup> predictive equations

### Syntax

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~sas
function gigs_ig_fet_estimate_ga(
  crl_mm /*=. NULL*/
, headcirc_mm /*=. NULL*/
, femurlen_mm /*=. NULL*/
);
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

---


### Arguments

1. `crl_mm` - Crown-rump length value(s) in mm taken from
    an ultrasound scan obtained 56 to 97 days since the
    last menstrual period.

2. `headcirc_mm` - Head circumference value(s) in cm taken
    from an ultrasound scan obtained 98 to 181 days since
    the last menstrual period.

3. `femurlen_mm` - Head length value(s) in cm, measured at
    the same time as the value(s) in `headcirc_mm`.

### Returns

Estimated gestational age(s) in days.

### Note

The function will attempt to estimate the gestational age (GA) in three steps,
from highest to lowest accuracy. First, using crown-rump length measurements
obtained in early pregnancy, then with both head circumference and femur length
measurements, and finally with head circumference alone.

### References

Papageorghiou AT, Kennedy SH, Salomon LJ, Ohuma EO, Cheikh Ismail L, Barros
FC et al. **International standards for early fetal size and pregnancy dating
based on ultrasound measurement of crown-rump length in the first trimester
of pregnancy.** *Ultrasound Obstet Gynecol* 2014, **44(6):641-48**
doi: [10.1002/uog.13448](https://dx.doi.org/10.1002/uog.13448)

Papageorghiou AT, Kemp B, Stones W, Ohuma EO, Kennedy SH, Purwar M et al.
**Ultrasound-based gestational age estimation in late pregnancy.**
*Ultrasound Obstet Gynecol* 2016. **48(6):719-26** doi:
[10.1002/uog.15894](https://dx.doi.org/10.1002/uog.15894)

### Examples

1. Estimate gestational age in 3 different ways
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~sas
data have;
  input crl_mm headcirc_mm femurlen_mm;
CARDS4;
40 250 55
41 251 56
42 252 57
43 253 58
44 254 59
45 255 60
;;;;
run;

data get;
  set have;
  
  estimate1 = gigs_ig_fet_estimate_ga(
    crl_mm,
    .,
    .
  );

  estimate2 = gigs_ig_fet_estimate_ga(
    .,
    headcirc_mm,
    femurlen_mm
  );

  estimate3 = gigs_ig_fet_estimate_ga(
    crl_mm,
    headcirc_mm,
    femurlen_mm
  );
run;
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

---

  
---
 
## `gigs_ig_fet_value2zscore()` function <a name="gigsigfetvalue2zscore-functions-53"></a> ######

Convert values to z-scores in the INTERGROWTH-21<sup>st</sup> Fetal Growth standards

### Syntax

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~sas
function gigs_ig_fet_value2zscore(
  y
, x
, acronym $
);
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

---


### Arguments

1. `y` - Numeric variable with values to convert to z-scores/centiles.

2. `x` - Numeric variable with x values. 
    Elements should have specific units and be between certain values 
    depending on the standard in use (defined by `acronym`). 
    These are:
    - Between 98 and 280 days for `"hcfga"`, `"bpdfga"`, 
     `"acfga"`, `"flfga"`, `"ofdfga"`, and `"tcdfga"`.
    - Between 154 and 280 days for `"efwfga"`.
    - Between 112 and 294 days for `"sfhfga"`.
    - Between 58 and 105 days for `"crlfga"`.
    - Between 19 and 95 mm for `"gafcrl"`.
    - Between 105 and 280 days for `"gwgfga"`.
    - Between 168 and 280 days for `"pifga"`, `"rifga"`, and `"sdrfga"` 
      (the INTERGROWTH-21<sup>st</sup> Fetal Doppler standards).
    - Between 105 and 252 days for `"poffga"`, `"sffga"`, `"avfga"`, and `"pvfga"` 
      (the INTERGROWTH-21<sup>st</sup> Fetal Brain Development standards).
    - Between 126 and 287 days for `"hefwfga"` (the INTERGROWTH-21<sup>st</sup> 
      standard for Hadlock-based estimated fetal weight).

    By default, gigs will return missing value (`.`) 
    for out-of-bounds elements in `x`.
    
    Numeric variable `gest_days`, `crl_mm`, or `tcd_mm` 
    are standard-specific `x` variables. 
 
3. `acronym` - Character variable denoting the
    INTERGROWTH-21<sup>st</sup> Fetal Growth standard(s) in use. 
    Each value should be one of:
    - `"hcfga"` (head circumference-for-GA)
    - `"bpdfga"` (biparietal diameter-for-GA)
    - `"acfga"` (abdominal circumference-for-GA)
    - `"flfga"` (femur length-for-GA)
    - `"ofdfga"` (occipito-frontal diameter-for-GA)
    - `"efwfga"` (estimated fetal weight-for-GA)
    - `"sfhfga"` (symphisis-fundal height-for-GA)
    - `"crlfga"` (crown-rump length-for-GA)
    - `"gafcrl"` (GA-for-crown-rump length)
    - `"gwgfga"` (gestational weight gain-for-GA)
    - `"pifga"` (pulsatility index-for-GA)
    - `"rifga"` (resistance index-for-GA)
    - `"sdrfga"` (systolic/diastolic ratio-for-GA)
    - `"tcdfga"` (transcerebellar diameter-for-GA)
    - `"poffga"` (parieto-occipital fissure-for-GA)
    - `"sffga"` (Sylvian fissure-for-GA)
    - `"avfga"` (anterior horn of lateral ventricle-for-GA)
    - `"pvfga"` (atrium of posterior horn of lateral ventricle-for-GA)
    - `"cmfga"` (cisterna magna-for-GA)
    - `"hefwfga"` (Hadlock esimated fetal weight-for-GA)

   If elements in `acronym` are not one of the above values, 
   gigs will return missing value (`.`).
   
### Returns

Numeric variable of expected z-scores for each measurement.

### Note

For each acronym from the list: 
`"hcfga"`, `"bpdfga"`, `"acfga"`, `"flfga"`, `"ofdfga"`, 
`"efwfga"`, `"sfhfga"`, `"crlfga"`, `"gafcrl"`, `"gwgfga"`, 
`"pifga"`, `"rifga"`, `"sdrfga"`, `"tcdfga"`, `"poffga"`, 
`"hefwfga"`, `"sffga"`, `"avfga"`, `"pvfga"`, and `"cmfga"` 
a counterpart "acronym function", which is a wrapper for 
the `gigs_ig_fet_value2zscore`, is generated. 
The "acronym function" has the following form:

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~sas
gigs_ig_fet_<acronym>_value2zscore(y, x)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Complete list is:

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~sas
gigs_ig_fet_hcfga_value2zscore(headcirc_mm, gest_days)

gigs_ig_fet_bpdfga_value2zscore(bpd_mm, gest_days)

gigs_ig_fet_acfga_value2zscore(abdocirc_mm, gest_days)

gigs_ig_fet_flfga_value2zscore(femurlen_mm, gest_days)

gigs_ig_fet_ofdfga_value2zscore(ofd_mm, gest_days)

gigs_ig_fet_efwfga_value2zscore(efw_g, gest_days)

gigs_ig_fet_hefwfga_value2zscore(hadlock_efw_g, gest_days)

gigs_ig_fet_sfhfga_value2zscore(sfh_cm, gest_days)

gigs_ig_fet_crlfga_value2zscore(crl_mm, gest_days)

gigs_ig_fet_gafcrl_value2zscore(gest_days, crl_mm)

gigs_ig_fet_gwgfga_value2zscore(gest_wt_gain_kg, gest_days)

gigs_ig_fet_pifga_value2zscore(puls_idx, gest_days)

gigs_ig_fet_rifga_value2zscore(resist_idx, gest_days)

gigs_ig_fet_sdrfga_value2zscore(sys_dia_ratio, gest_days)

gigs_ig_fet_tcdfga_value2zscore(tcd_mm, gest_days)

gigs_ig_fet_gaftcd_value2zscore(gest_days, tcd_mm)

gigs_ig_fet_poffga_value2zscore(par_occ_fiss_mm, gest_days)

gigs_ig_fet_sffga_value2zscore(sylv_fiss_mm, gest_days)

gigs_ig_fet_avfga_value2zscore(ant_hlv_mm, gest_days)

gigs_ig_fet_pvfga_value2zscore(atr_phlv_mm, gest_days)

gigs_ig_fet_cmfga_value2zscore(cist_mag_mm, gest_days)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Parameters meaning:

- `gest_days` - Numeric variable that is usually used as the `x` 
                variable, but can also be a `y` variable for the 
                `"gafcrl"` and `"gaftcd"` standards. 
                
- `headcirc_mm` - Numeric variable with head
                  circumference measurements in mm.
                  
- `bpd_mm` - Numeric variable with biparietal diameter
             measurement(s) in mm.
             
- `abdocirc_mm` - Numeric variable with abdominal
                  circumference measurement(s) in mm.
                  
- `femurlen_mm` - Numeric variable with femur length(s) in mm.

- `ofd_mm` - Numeric variable with in occipito-frontal
             diameter(s) in mm.
             
- `efw_g` - Numeric variable with estimated fetal weight(s) in g.
            
- `hadlock_efw_g` - Numeric variable with estimated fetal weight(s) in g.
            
- `sfh_cm` - Numeric variable with symphisis-fundal height(s) in mm.
             
- `crl_mm` - Numeric variable with crown-rump length(s) in mm.

- `gest_wt_gain_kg` - Numeric variable with gestational
                      weight gain(s)/loss(es) in kg.
                      
- `puls_idx` - Numeric variable with pulsatility index value(s).

- `resist_idx` - Numeric variable with resistance index value(s).

- `sys_dia_ratio` - Numeric variable with systolic/diastolic 
                    ratio value(s).
                    
- `tcd_mm` - Numeric variable with transcerebellar diameter(s) in mm.
             
- `par_occ_fiss_mm` - Numeric variable with parietal-occipital 
                      fissure measurement(s) in mm.
                      
- `sylv_fiss_mm` - Numeric variable with Sylvian fissure
                   measurement(s) in mm.
                   
- `ant_hlv_mm` - Numeric variable with anterior horn of
                 lateral ventricle measurements(s) in mm.
                 
- `atr_phlv_mm` - Numeric variable with atrium of
                  posterior horn of lateral ventricle measurement(s) in mm.
                  
- `cist_mag_mm` - Numeric variable with cisterna magna
                  measurement(s) in mm.

Those functions are generated by the `%gigs_ig_fet_acronym()` macro.

### See also 

See the following function used internally by this function:
`gigs_validate_ig_fet`,
`gigs_ig_fet_doppler_y2z`,
`gigs_ig_fet_efw_y2z`,
`gigs_ig_fet_gwg_y2z`, and
`gigs_ig_fet_mu_sigma_y2z`.

### References

Papageorghiou AT, Ohuma EO, Altman DG, Todros T, Cheikh Ismail L, Lambert A
et al. **International standards for fetal growth based on serial ultrasound
measurements: the Fetal Growth Longitudinal Study of the INTERGROWTH-21st
Project.** *Lancet* 2014, **384(9946):869-79.**
doi: [10.1016/S0140-6736(14)61490-2](https://dx.doi.org/10.1016/S0140-6736(14)61490-2)

Stirnemann J, Villar J, Salomon LJ, Ohuma EO, Lamber A, Victoria CG et al.
**International Estimated Fetal Weight Standards of the INTERGROWTH-21st
Project.** *Ultrasound Obstet Gynecol* 2016, **49:478-486**
doi: [10.1002/uog.17347](https://dx.doi.org/10.1002/uog.17347)

Papageorghiou AT, Ohuma EO, Gravett MG, Lamber A, Noble JA, Pang R et al.
**International standards for symphysis-fundal height based on serial
measurements from the Fetal Growth Longitudinal Study of the INTERGROWTH-21st
Project: prospective cohort study in eight countries.** *BMJ* 2016,
**355:i5662** 
doi: [10.1136/bmj.i5662](https://dx.doi.org/10.1136/bmj.i5662)

Papageorghiou AT, Kennedy SH, Salomon LJ, Ohuma EO, Cheikh Ismail L, Barros
FC et al. **International standards for early fetal size and pregnancy dating
based on ultrasound measurement of crown-rump length in the first trimester
of pregnancy.** *Ultrasound Obstet Gynecol* 2014, **44(6):641-48**
doi: [10.1002/uog.13448](https://dx.doi.org/10.1002/uog.13448)

Cheikh Ismail L, Bishop DC, Pang R, Ohuma EO, Kac G, Abrams B et al.
**Gestational weight gain standards based on women enrolled in the Fetal
Growth Longitudinal Study of the INTERGROWTH-21st Project: a prospective
longitudinal cohort study.** *BMJ* 2016, **352:i555** 
doi: [10.1136/bmj.i555](https://dx.doi.org/10.1136/bmj.i555)

Drukker L, Staines-Urias E, Villar J, Barros FC, Carvalho M, Munim S et al.
**International gestational age-specific centiles for umbilical artery
Doppler indices: a longitudinal prospective cohort study of the
INTERGROWTH-21st Project.** *Am J Obstet Gynecol* 2021,
**222(6):602.e1-602.e15** 
doi: [10.1016/j.ajog.2020.01.012](https://dx.doi.org/10.1016/j.ajog.2020.01.012)

Rodriguez-Sibaja MJ, Villar J, Ohuma EO, Napolitano R, Heyl S, Carvalho M et
al. **Fetal cerebellar growth and Sylvian fissure maturation: international
standards from Fetal Growth Longitudinal Study of INTERGROWTH-21st Project**
*Ultrasound Obstet Gynecol* 2021, **57(4):614-623** 
doi: [10.1002/uog.22017](https://dx.doi.org/10.1002/uog.22017)

Napolitano R, Molloholli M, Donadono V, Ohuma EO, Wanyonyi SZ, Kemp B et al.
**International standards for fetal brain structures based on serial
ultrasound measurements from Fetal Growth Longitudinal Study of
INTERGROWTH-21st Project** *Ultrasound Obstet Gynecol* 2020,
**56(3):359-370** 
doi: [10.1002/uog.21990](https://dx.doi.org/10.1002/uog.21990)

Stirnemann J, Salomon LJ, Papageorghiou AT. **INTERGROWTH-21st
standards for Hadlock's estimation of fetal weight** *Ultrasound Obstet
Gynecol* 2020, **56(6):946-948**
doi: [10.1002/uog.22000](https://dx.doi.org/10.1002/uog.22000)

### Examples

1. Convert values to z-scores 
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~sas
data _null_;
  acronym = "acfga";

  do abdocirc_mm = 335 to 340;
    do gest_days = 265 to 270;
      value = gigs_ig_fet_value2zscore(abdocirc_mm,gest_days,acronym);
      put (_ALL_) (=);
    end;
    put;
  end;
run;
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

---

  
---
 
## `gigs_ig_fet_zscore2value()` function <a name="gigsigfetzscore2value-functions-54"></a> ######

Convert z-scores to values in the INTERGROWTH-21<sup>st</sup> Fetal standards

### Syntax

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~sas
function gigs_ig_fet_zscore2value(
  z
, x
, acronym $
);
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

---



### Arguments

1. `z` - Numeric variable with z-scores to convert to values.

2. `x` - Numeric variable with x values. 
    Elements should have specific units and be between certain values 
    depending on the standard in use (defined by `acronym`). 
    These are:
    - Between 98 and 280 days for `"hcfga"`, `"bpdfga"`, 
     `"acfga"`, `"flfga"`, `"ofdfga"`, and `"tcdfga"`.
    - Between 154 and 280 days for `"efwfga"`.
    - Between 112 and 294 days for `"sfhfga"`.
    - Between 58 and 105 days for `"crlfga"`.
    - Between 19 and 95 mm for `"gafcrl"`.
    - Between 105 and 280 days for `"gwgfga"`.
    - Between 168 and 280 days for `"pifga"`, `"rifga"`, and `"sdrfga"` 
      (the INTERGROWTH-21<sup>st</sup> Fetal Doppler standards).
    - Between 105 and 252 days for `"poffga"`, `"sffga"`, `"avfga"`, and `"pvfga"` 
      (the INTERGROWTH-21<sup>st</sup> Fetal Brain Development standards).
    - Between 126 and 287 days for `"hefwfga"` (the INTERGROWTH-21<sup>st</sup> 
      standard for Hadlock-based estimated fetal weight).

    By default, gigs will return missing value (`.`) 
    for out-of-bounds elements in `x`.
    
    Numeric variable `gest_days`, `crl_mm`, or `tcd_mm` 
    are standard-specific `x` variables. 
 
3. `acronym` - Character variable denoting the
    INTERGROWTH-21<sup>st</sup> Fetal Growth standard(s) in use. 
    Each value should be one of:
    - `"hcfga"` (head circumference-for-GA)
    - `"bpdfga"` (biparietal diameter-for-GA)
    - `"acfga"` (abdominal circumference-for-GA)
    - `"flfga"` (femur length-for-GA)
    - `"ofdfga"` (occipito-frontal diameter-for-GA)
    - `"efwfga"` (estimated fetal weight-for-GA)
    - `"sfhfga"` (symphisis-fundal height-for-GA)
    - `"crlfga"` (crown-rump length-for-GA)
    - `"gafcrl"` (GA-for-crown-rump length)
    - `"gwgfga"` (gestational weight gain-for-GA)
    - `"pifga"` (pulsatility index-for-GA)
    - `"rifga"` (resistance index-for-GA)
    - `"sdrfga"` (systolic/diastolic ratio-for-GA)
    - `"tcdfga"` (transcerebellar diameter-for-GA)
    - `"poffga"` (parieto-occipital fissure-for-GA)
    - `"sffga"` (Sylvian fissure-for-GA)
    - `"avfga"` (anterior horn of lateral ventricle-for-GA)
    - `"pvfga"` (atrium of posterior horn of lateral ventricle-for-GA)
    - `"cmfga"` (cisterna magna-for-GA)
    - `"hefwfga"` (Hadlock esimated fetal weight-for-GA)

   If elements in `acronym` are not one of the above values, 
   gigs will return missing value (`.`).

### Returns

Numeric variable of expected measurements for each z-score.

### Note

For each acronym from the list: 
`"hcfga"`, `"bpdfga"`, `"acfga"`, `"flfga"`, `"ofdfga"`, 
`"efwfga"`, `"sfhfga"`, `"crlfga"`, `"gafcrl"`, `"gwgfga"`, 
`"pifga"`, `"rifga"`, `"sdrfga"`, `"tcdfga"`, `"poffga"`, 
`"hefwfga"`, `"sffga"`, `"avfga"`, `"pvfga"`, and `"cmfga"` 
a counterpart "acronym function", which is a wrapper for 
the `gigs_ig_fet_zscore2value`, is generated. 
The "acronym function" has the following form:

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~sas
gigs_ig_fet_<acronym>_zscore2value(z, x)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Complete list is:

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~sas
gigs_ig_fet_hcfga_zscore2value(z, gest_days)

gigs_ig_fet_bpdfga_zscore2value(z, gest_days)

gigs_ig_fet_acfga_zscore2value(z, gest_days)

gigs_ig_fet_flfga_zscore2value(z, gest_days)

gigs_ig_fet_ofdfga_zscore2value(z, gest_days)

gigs_ig_fet_efwfga_zscore2value(z, gest_days)

gigs_ig_fet_hefwfga_zscore2value(z, gest_days)

gigs_ig_fet_sfhfga_zscore2value(z, gest_days)

gigs_ig_fet_crlfga_zscore2value(z, gest_days)

gigs_ig_fet_gafcrl_zscore2value(z, crl_mm)

gigs_ig_fet_gwgfga_zscore2value(z, gest_days)

gigs_ig_fet_pifga_zscore2value(z, gest_days)

gigs_ig_fet_rifga_zscore2value(z, gest_days)

gigs_ig_fet_sdrfga_zscore2value(z, gest_days)

gigs_ig_fet_tcdfga_zscore2value(z, gest_days)

gigs_ig_fet_gaftcd_zscore2value(z, tcd_mm)

gigs_ig_fet_poffga_zscore2value(z, gest_days)

gigs_ig_fet_sffga_zscore2value(z, gest_days)

gigs_ig_fet_avfga_zscore2value(z, gest_days)

gigs_ig_fet_pvfga_zscore2value(z, gest_days)

gigs_ig_fet_cmfga_zscore2value(z, gest_days)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Those functions are generated by the `%gigs_ig_fet_acronym()` macro.

### See also

See the following function used internally by this function:
`gigs_validate_ig_fet`, 
`gigs_ig_fet_doppler_z2y`,
`gigs_ig_fet_efw_z2y`,
`gigs_ig_fet_gwg_z2y`, and
`gigs_ig_fet_mu_sigma_z2y`.

### References

Papageorghiou AT, Ohuma EO, Altman DG, Todros T, Cheikh Ismail L, Lambert A
et al. **International standards for fetal growth based on serial ultrasound
measurements: the Fetal Growth Longitudinal Study of the INTERGROWTH-21st
Project.** *Lancet* 2014, **384(9946):869-79.**
doi: [10.1016/S0140-6736(14)61490-2](https://dx.doi.org/10.1016/S0140-6736(14)61490-2)

Stirnemann J, Villar J, Salomon LJ, Ohuma EO, Lamber A, Victoria CG et al.
**International Estimated Fetal Weight Standards of the INTERGROWTH-21st
Project.** *Ultrasound Obstet Gynecol* 2016, **49:478-486**
doi: [10.1002/uog.17347](https://dx.doi.org/10.1002/uog.17347)

Papageorghiou AT, Ohuma EO, Gravett MG, Lamber A, Noble JA, Pang R et al.
**International standards for symphysis-fundal height based on serial
measurements from the Fetal Growth Longitudinal Study of the INTERGROWTH-21st
Project: prospective cohort study in eight countries.** *BMJ* 2016,
**355:i5662** 
doi: [10.1136/bmj.i5662](https://dx.doi.org/10.1136/bmj.i5662)

Papageorghiou AT, Kennedy SH, Salomon LJ, Ohuma EO, Cheikh Ismail L, Barros
FC et al. **International standards for early fetal size and pregnancy dating
based on ultrasound measurement of crown-rump length in the first trimester
of pregnancy.** *Ultrasound Obstet Gynecol* 2014, **44(6):641-48**
doi: [10.1002/uog.13448](https://dx.doi.org/10.1002/uog.13448)

Cheikh Ismail L, Bishop DC, Pang R, Ohuma EO, Kac G, Abrams B et al.
**Gestational weight gain standards based on women enrolled in the Fetal
Growth Longitudinal Study of the INTERGROWTH-21st Project: a prospective
longitudinal cohort study.** *BMJ* 2016, **352:i555** 
doi: [10.1136/bmj.i555](https://dx.doi.org/10.1136/bmj.i555)

Drukker L, Staines-Urias E, Villar J, Barros FC, Carvalho M, Munim S et al.
**International gestational age-specific centiles for umbilical artery
Doppler indices: a longitudinal prospective cohort study of the
INTERGROWTH-21st Project.** *Am J Obstet Gynecol* 2021,
**222(6):602.e1-602.e15** 
doi: [10.1016/j.ajog.2020.01.012](https://dx.doi.org/10.1016/j.ajog.2020.01.012)

Rodriguez-Sibaja MJ, Villar J, Ohuma EO, Napolitano R, Heyl S, Carvalho M et
al. **Fetal cerebellar growth and Sylvian fissure maturation: international
standards from Fetal Growth Longitudinal Study of INTERGROWTH-21st Project**
*Ultrasound Obstet Gynecol* 2021, **57(4):614-623** 
doi: [10.1002/uog.22017](https://dx.doi.org/10.1002/uog.22017)

Napolitano R, Molloholli M, Donadono V, Ohuma EO, Wanyonyi SZ, Kemp B et al.
**International standards for fetal brain structures based on serial
ultrasound measurements from Fetal Growth Longitudinal Study of
INTERGROWTH-21st Project** *Ultrasound Obstet Gynecol* 2020,
**56(3):359-370** 
doi: [10.1002/uog.21990](https://dx.doi.org/10.1002/uog.21990)

Stirnemann J, Salomon LJ, Papageorghiou AT. **INTERGROWTH-21st
standards for Hadlock's estimation of fetal weight** *Ultrasound Obstet
Gynecol* 2020, **56(6):946-948**
doi: [10.1002/uog.22000](https://dx.doi.org/10.1002/uog.22000)

### Examples

1. Calculate value from z-scores 
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~sas
data _null_;
  acronym = "acfga";

  do z = -1 to 1;
    do x = 279 to 281;
      value = gigs_ig_fet_zscore2value(z,x,acronym);
      put (_ALL_) (=);
    end;
    put;
  end;
run;
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

---

  
---
 
## `gigs_ig_png_centile2value()` function <a name="gigsigpngcentile2value-functions-58"></a> ######

Convert centiles to values in the INTERGROWTH-21<sup>st</sup>
Postnatal Growth Standards for preterm infants

### Syntax

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~sas
function gigs_ig_png_centile2value(
  p
, x
, sex $
, acronym $
); 
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

---


### Arguments

1. `p` - Numeric variable with centiles to convert to values. 

2. `x` - Numeric variable with x values. 
    Elements of `x` or its standard-specific equivalents (`pma_weeks`, `length_cm`) 
    should have specific units and be between certain values depending 
    on the standard in use (defined by `acronym`). 
    These are:
    - Between 27 and 64 weeks for `"wfa"`, `"lfa"`, and `"hcfa"`.
    - Between 35 and 65 cm for `"wfl"`.

    By default, gigs will return missing value (`.`) for 
    out-of-bounds elements in `x`.

3. `sex` - Character variable with sex(es), either "M" (male) or "F" (female).

4. `acronym` - Character variable denoting the
    INTERGROWTH-21<sup>st</sup> Postnatal Growth standard(s) in use. 
    Each element should be one of:
    - `"wfa"` (weight-for-age)
    - `"lfa"` (length-for-age)
    - `"hcfa"` (head circumference-for-age)
    - `"wfl"` (weight-for-length)

### Returns

Numeric variable of expected measurements for each centile.
  
### Note

For each acronym from the list: 
`"wfa"`, `"lfa"`, `"hcfa"`, and `"wfl"`
a counterpart "acronym function", which is a wrapper for 
the `gigs_ig_png_centile2value`, is generated. 
The "acronym function" has the following form:

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~sas
gigs_ig_png_<acronym>_centile2value(p, x, sex)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Complete list is:

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~sas
gigs_ig_png_wfa_centile2value(p, pma_weeks, sex)

gigs_ig_png_lfa_centile2value(p, pma_weeks, sex)

gigs_ig_png_hcfa_centile2value(p, pma_weeks, sex)

gigs_ig_png_wfl_centile2value(p, length_cm, sex)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Those functions are generated by the `%gigs_ig_png_acronym()` macro.

### See also

The function internally use
`gigs_validate_ig_png`, 
`gigs_ig_png_equations`, and
SAS `QUANTILE` functions.

### References

Villar J, Giuliani F, Bhutta ZA, Bertino E, Ohuma EO, Ismail LC et al.
**Postnatal growth standards for preterm infants: the Preterm Postnatal
Follow-up Study of the INTERGROWTH-21st Project.** *Lancet Glob Health* 2015,
*3(11):e681-e691.* 
doi: [10.1016/S2214-109X(15)00163-1](https://dx.doi.org/10.1016/S2214-109X(15)00163-1)

### Example

1. Convert centiles to values
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~sas
data have;
  input p pma_weeks sex :$1.;
CARDS4;
0.25 54 M
0.50 55 F
0.75 56 M
;;;;
run;

data get;
  set have;
  acronym = "wfa";
  
  value = gigs_ig_png_centile2value(p, pma_weeks, sex, acronym);
run;
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

---

  
---
 
## `gigs_ig_png_value2centile()` function <a name="gigsigpngvalue2centile-functions-59"></a> ######

Convert values to centiles in the INTERGROWTH-21<sup>st</sup>
Postnatal Growth Standards for preterm infants

### Syntax

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~sas
function gigs_ig_png_value2centile(
  y
, x
, sex $
, acronym $
);
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

---


### Arguments

1. `y` - Numeric variable with anthropometric measurement(s) 
    to convert to centiles. Units depend on which acronym(s) are in use. 

2. `x` - Numeric variable with x values. 
    Elements of `x` or its standard-specific equivalents (`pma_weeks`, `length_cm`) 
    should have specific units and be between certain values depending 
    on the standard in use (defined by `acronym`). 
    These are:
    - Between 27 and 64 weeks for `"wfa"`, `"lfa"`, and `"hcfa"`.
    - Between 35 and 65 cm for `"wfl"`.

    By default, gigs will return missing value (`.`) for 
    out-of-bounds elements in `x`.

3. `sex` - Character variable with sex(es), either "M" (male) or "F" (female).

4. `acronym` - Character variable denoting the
    INTERGROWTH-21<sup>st</sup> Postnatal Growth standard(s) in use. 
    Each element should be one of:
    - `"wfa"` (weight-for-age)
    - `"lfa"` (length-for-age)
    - `"hcfa"` (head circumference-for-age)
    - `"wfl"` (weight-for-length)

### Returns

Numeric variable of centiles.

### Note

For each acronym from the list: 
`"wfa"`, `"lfa"`, `"hcfa"`, and `"wfl"`
a counterpart "acronym function", which is a wrapper for 
the `gigs_ig_png_value2zscore`, is generated. 
The "acronym function" has the following form:

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~sas
gigs_ig_png_<acronym>_value2zscore(y, x, sex)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Complete list is:

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~sas
gigs_ig_png_wfa_value2zscore(weight_kg, pma_weeks, sex)

gigs_ig_png_lfa_value2zscore(length_cm, pma_weeks, sex)

gigs_ig_png_hcfa_value2zscore(headcirc_cm, pma_weeks, sex)

gigs_ig_png_wfl_value2zscore(weight_kg, length_cm, sex)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Parameters meaning:

- `weight_kg` - Numeric variable with weight measurement(s) in kg.
- `pma_weeks` - Numeric variable with post-menstrual age(s) in weeks. 
    Values should be within the bounds defined in the documentation for `x`.
- `length_cm` - Numeric variable with recumbent length measurement(s) in cm. 
    This argument can be either an `x` variable when using the length-for-age 
    standard (`"lfa"`), or a `y` variable when using the weight-for-length 
    (`"wfl"`) standard.
- `headcirc_cm` - Numeric variable with head circumference measurement(s) in cm.

Those functions are generated by the `%gigs_ig_png_acronym()` macro.

### See also

The function internally use
`gigs_validate_ig_png`, and
`gigs_ig_png_equations` functions.

### References

Villar J, Giuliani F, Bhutta ZA, Bertino E, Ohuma EO, Ismail LC et al.
**Postnatal growth standards for preterm infants: the Preterm Postnatal
Follow-up Study of the INTERGROWTH-21st Project.** *Lancet Glob Health* 2015,
*3(11):e681-e691.* 
doi: [10.1016/S2214-109X(15)00163-1](https://dx.doi.org/10.1016/S2214-109X(15)00163-1)

### Examples

1. Get centiles for values
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~sas
data have;
  inpout weight_kg pma_weeks sex :$1.;
CARDS4;
5.79 54 M
5.92 55 F
7.25 56 M
;;;;
run;

data get;
  set have;
  acronym = "wfa";
  
  centiles = gigs_ig_png_value2centile(weight_kg, pma_weeks, sex, acronym);
run;
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

---

  
---
 
## `gigs_ig_png_value2zscore()` function <a name="gigsigpngvalue2zscore-functions-60"></a> ######

Convert values to z-scores in the INTERGROWTH-21<sup>st</sup>
Postnatal Growth Standards for preterm infants

### Syntax

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~sas
function gigs_ig_png_value2zscore(
  y
, x
, sex $
, acronym $
);
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

---


### Arguments

1. `y` - Numeric variable with anthropometric measurement(s) 
    to convert to z-scores. Units depend on which acronym(s) are in use. 

2. `x` - Numeric variable with x values. 
    Elements of `x` or its standard-specific equivalents (`pma_weeks`, `length_cm`) 
    should have specific units and be between certain values depending 
    on the standard in use (defined by `acronym`). 
    These are:
    - Between 27 and 64 weeks for `"wfa"`, `"lfa"`, and `"hcfa"`.
    - Between 35 and 65 cm for `"wfl"`.

    By default, gigs will return missing value (`.`) for 
    out-of-bounds elements in `x`.

3. `sex` - Character variable with sex(es), either "M" (male) or "F" (female).

4. `acronym` - Character variable denoting the
    INTERGROWTH-21<sup>st</sup> Postnatal Growth standard(s) in use. 
    Each element should be one of:
    - `"wfa"` (weight-for-age)
    - `"lfa"` (length-for-age)
    - `"hcfa"` (head circumference-for-age)
    - `"wfl"` (weight-for-length)

### Returns

Numeric variable of z-scores for each measurement.

### Note

For each acronym from the list: 
`"wfa"`, `"lfa"`, `"hcfa"`, and `"wfl"`
a counterpart "acronym function", which is a wrapper for 
the `gigs_ig_png_value2zscore`, is generated. 
The "acronym function" has the following form:

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~sas
gigs_ig_png_<acronym>_value2zscore(y, x, sex)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Complete list is:

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~sas
gigs_ig_png_wfa_value2zscore(weight_kg, pma_weeks, sex)

gigs_ig_png_lfa_value2zscore(length_cm, pma_weeks, sex)

gigs_ig_png_hcfa_value2zscore(headcirc_cm, pma_weeks, sex)

gigs_ig_png_wfl_value2zscore(weight_kg, length_cm, sex)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Parameters meaning:

- `weight_kg` - Numeric variable with weight measurement(s) in kg.
- `pma_weeks` - Numeric variable with post-menstrual age(s) in weeks. 
    Values should be within the bounds defined in the documentation for `x`.
- `length_cm` - Numeric variable with recumbent length measurement(s) in cm. 
    This argument can be either an `x` variable when using the length-for-age 
    standard (`"lfa"`), or a `y` variable when using the weight-for-length 
    (`"wfl"`) standard.
- `headcirc_cm` - Numeric variable with head circumference measurement(s) in cm.

Those functions are generated by the `%gigs_ig_png_acronym()` macro.

### See also

The function internally use
`gigs_validate_ig_png`, and
`gigs_ig_png_equations` functions.

### References

Villar J, Giuliani F, Bhutta ZA, Bertino E, Ohuma EO, Ismail LC et al.
**Postnatal growth standards for preterm infants: the Preterm Postnatal
Follow-up Study of the INTERGROWTH-21st Project.** *Lancet Glob Health* 2015,
*3(11):e681-e691.* 
doi: [10.1016/S2214-109X(15)00163-1](https://dx.doi.org/10.1016/S2214-109X(15)00163-1)

### Examples

1. Get z-score for values
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~sas
data have;
  inpout weight_kg pma_weeks sex :$1.;
CARDS4;
5.79 54 M
5.92 55 F
7.25 56 M
;;;;
run;

data get;
  set have;
  acronym = "wfa";
  
  zscore = gigs_ig_png_value2zscore(weight_kg, pma_weeks, sex, acronym);
run;
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

---

  
---
 
## `gigs_ig_png_zscore2value()` function <a name="gigsigpngzscore2value-functions-61"></a> ######

Convert z-scores to values in the INTERGROWTH-21<sup>st</sup>
Postnatal Growth Standards for preterm infants

### Syntax

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~sas
function gigs_ig_png_zscore2value(
  z
, x
, sex $
, acronym $
);
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

---


### Arguments

1. `z` - Numeric variable with z-scores to convert to values. 

2. `x` - Numeric variable with x values. 
    Elements of `x` or its standard-specific equivalents (`pma_weeks`, `length_cm`) 
    should have specific units and be between certain values depending 
    on the standard in use (defined by `acronym`). 
    These are:
    - Between 27 and 64 weeks for `"wfa"`, `"lfa"`, and `"hcfa"`.
    - Between 35 and 65 cm for `"wfl"`.

    By default, gigs will return missing value (`.`) for 
    out-of-bounds elements in `x`.

3. `sex` - Character variable with sex(es), either "M" (male) or "F" (female).

4. `acronym` - Character variable denoting the
    INTERGROWTH-21<sup>st</sup> Postnatal Growth standard(s) in use. 
    Each element should be one of:
    - `"wfa"` (weight-for-age)
    - `"lfa"` (length-for-age)
    - `"hcfa"` (head circumference-for-age)
    - `"wfl"` (weight-for-length)

### Returns

Numeric variable of expected measurements for each z-score.
  
### Note

For each acronym from the list: 
`"wfa"`, `"lfa"`, `"hcfa"`, and `"wfl"`
a counterpart "acronym function", which is a wrapper for 
the `gigs_ig_png_zscore2value`, is generated. 
The "acronym function" has the following form:

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~sas
gigs_ig_png_<acronym>_zscore2value(z, x, sex)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Complete list is:

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~sas
gigs_ig_png_wfa_zscore2value(z, pma_weeks, sex)

gigs_ig_png_lfa_zscore2value(z, pma_weeks, sex)

gigs_ig_png_hcfa_zscore2value(z, pma_weeks, sex)

gigs_ig_png_wfl_zscore2value(z, length_cm, sex)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Those functions are generated by the `%gigs_ig_png_acronym()` macro.

### See also

The function internally use
`gigs_validate_ig_png`, and
`gigs_ig_png_equations` functions.

### References

Villar J, Giuliani F, Bhutta ZA, Bertino E, Ohuma EO, Ismail LC et al.
**Postnatal growth standards for preterm infants: the Preterm Postnatal
Follow-up Study of the INTERGROWTH-21st Project.** *Lancet Glob Health* 2015,
*3(11):e681-e691.* 
doi: [10.1016/S2214-109X(15)00163-1](https://dx.doi.org/10.1016/S2214-109X(15)00163-1)

### Example

1. Convert z-scores to values
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~sas
data have;
  input z pma_weeks sex :$1.;
CARDS4;
-0.6745 54 M
+0.0000 55 F
+0.6745 56 M
;;;;
run;

data get;
  set have;
  acronym = "wfa";
  
  value = gigs_ig_png_zscore2value(z, pma_weeks, sex, acronym);
run;
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

---

  
---
 
## `gigs_who_gs_value2zscore()` function <a name="gigswhogsvalue2zscore-functions-64"></a> ######

Convert values to z-scores in the WHO Child Growth Standards

### Syntax

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~sas
function gigs_who_gs_value2zscore(
  y
, x
, sex $
, acronym $
);  
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

---


### Arguments

1. `y` - Numeric variable with anthropometric measurement(s) 
    to convert to z-scores. 
    Units depend on which acronym(s) are in use.

2. `x` - Numeric variable with x values. Elements in `x` or its 
    standard-specific equivalents (`age_days`, `length_cm`, and `height_cm`) 
    should have specific units and be between certain values depending 
    on the standard in use (defined by `acronym`). 
    These are:
    - Between 0 and 1856 days for `"wfa"`, `"bfa"`, `"lhfa"`, and `"hcfa"`.
    - Between 45 and 110 cm for `"wfl"`.
    - Between 65 and 120 cm for `"wfh"`.
    - Between 91 and 1856 days for `"acfa"`, `"ssfa"`, `"tsfa"`.

    By default, gigs will return missing value (`.`) for 
    out-of-bounds elements in `x`.

3. `sex` - Character variable with sex(es), either "M" (male) or "F" (female).

4. `acronym` - Character variable denoting the WHO Child
    Growth standard(s) in use. Each element should be one of:
    - `"wfa"` (weight-for-age)
    - `"bfa"` (BMI-for-age)
    - `"lhfa"` (length/height-for-age)
    - `"wfl"` (weight-for-length)
    - `"wfh"` (weight-for-height)
    - `"hcfa"` (head circumference-for-age)
    - `"acfa"` (arm circumference-for-age)
    - `"ssfa"` (subscapular skinfold-for-age)
    - `"tsfa"` (triceps skinfold-for-age)

### Returns

Numeric variable of z-scores for each measurement.

### Note

For each acronym from the list: 
`"wfa"`, `"bfa"`, `"lhfa"`, `"wfl"`, `"wfh"`,
`"hcfa"`, `"acfa"`, `"ssfa"`, and `"tsfa"` 
a counterpart "acronym function", which is a wrapper for 
the `gigs_who_gs_value2zscore`, is generated. 
The "acronym function" has the following form:

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~sas
gigs_who_gs_<acronym>_value2zscore(y, x, sex)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Complete list is:

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~sas
gigs_who_gs_wfa_value2zscore(weight_kg, age_days, sex)

gigs_who_gs_bfa_value2zscore(bmi, age_days, sex)

gigs_who_gs_lhfa_value2zscore(lenht_cm, age_days, sex)

gigs_who_gs_wfl_value2zscore(weight_kg, length_cm, sex)

gigs_who_gs_wfh_value2zscore(weight_kg, height_cm, sex)

gigs_who_gs_hcfa_value2zscore(headcirc_cm, age_days, sex)

gigs_who_gs_acfa_value2zscore(armcirc_cm, age_days, sex)

gigs_who_gs_ssfa_value2zscore(subscap_sf_mm, age_days, sex)

gigs_who_gs_tsfa_value2zscore(triceps_sf_mm, age_days, sex)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Parameters meaning:

- `weight_kg` - Numeric variable with weight measurement(s) in kg.
- `bmi` - Numeric variable with body mass index measurement(s) in kg/m<sup>2</sup>.
- `lenht_cm` - Numeric variable with length/height measurement(s) in cm.
- `headcirc_cm` - Numeric variable with head circumference measurement(s) in cm.
- `armcirc_cm` - Numeric variable with arm circumference measurement(s) in cm.
- `subscap_sf_mm` - Numeric variable with subscapular skinfold measurement(s) in mm.
- `triceps_sf_mm` - Numeric variable with triceps skinfold measurement(s) in mm.

Those functions are generated by the `%gigs_who_gs_acronym()` macro.

### See also

The function internally use
`gigs_validate_who_gs`,
`gigs_who_gs_lms`, and
`gigs_v_from_lms` functions.

### References

de Onis M, Garza C, Victora CG, Onyango AW, Frongillo EA, Martines J. **The
WHO Multicentre Growth Reference Study: planning, study design, and
methodology** *Food Nutr Bull.* 2004, **25(1 Suppl):S15-26.**
doi: [10.1177/15648265040251s104](https://dx.doi.org/10.1177/15648265040251s104)

World Health Organisation. **WHO child growth standards:
length/height-for-age, weight-for-age, weight-for-length, weight-for-height
and body mass index-for-age: methods and development.** *Technical report,
WHO, Geneva*, 2006.

World Health Organisation. **WHO child growth standards: head
circumference-for-age, arm circumference-for-age, triceps skinfold-for-age
and subscapular skinfold-for-age: methods and development.** *Technical
report, WHO, Geneva*, 2007.

Cole TJ. **The LMS method for constructing normalized growth standards** *Eur
J Clin Nutr.* 1990, **44(1):45-60.** PMID:
[2354692](https://pubmed.ncbi.nlm.nih.gov/2354692/)

### Examples

1. Convert values to z-scores
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~sas
data have;
  input weight_kg age_days sex :$1.;
CARDS4;
10.1 504 M
10.2 505 F
10.3 506 M
;;;;
run;

data get;
  set have;
  acronym = "wfa";
  
  zscore = gigs_who_gs_value2zscore(
    weight_kg
  , age_days 
  , sex
  , acronym
  );
run;
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

---

  
---
 
## `gigs_who_gs_zscore2value()` function <a name="gigswhogszscore2value-functions-65"></a> ######

Convert z-scores to values in the WHO Child Growth Standards

### Synatx

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~sas
function gigs_who_gs_zscore2value(
  z
, x
, sex $
, acronym $
);
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

---


### Arguments

1. `z` - Numeric variable with z-scores to convert to values. 

2. `x` - Numeric variable with x values. Elements in `x` or its 
    standard-specific equivalents (`age_days`, `length_cm`, and `height_cm`) 
    should have specific units and be between certain values depending 
    on the standard in use (defined by `acronym`). 
    These are:
    - Between 0 and 1856 days for `"wfa"`, `"bfa"`, `"lhfa"`, and `"hcfa"`.
    - Between 45 and 110 cm for `"wfl"`.
    - Between 65 and 120 cm for `"wfh"`.
    - Between 91 and 1856 days for `"acfa"`, `"ssfa"`, `"tsfa"`.

    By default, gigs will return missing value (`.`) for 
    out-of-bounds elements in `x`.

3. `sex` - Character variable with sex(es), either "M" (male) or "F" (female).

4. `acronym` - Character variable denoting the WHO Child
    Growth standard(s) in use. Each element should be one of:
    - `"wfa"` (weight-for-age)
    - `"bfa"` (BMI-for-age)
    - `"lhfa"` (length/height-for-age)
    - `"wfl"` (weight-for-length)
    - `"wfh"` (weight-for-height)
    - `"hcfa"` (head circumference-for-age)
    - `"acfa"` (arm circumference-for-age)
    - `"ssfa"` (subscapular skinfold-for-age)
    - `"tsfa"` (triceps skinfold-for-age)

### Returns

Numeric variable of expected measurements for each z-score.

### Note

For each acronym from the list: 
`"wfa"`, `"bfa"`, `"lhfa"`, `"wfl"`, `"wfh"`,
`"hcfa"`, `"acfa"`, `"ssfa"`, and `"tsfa"` 
a counterpart "acronym function", which is a wrapper for 
the `gigs_who_gs_zscore2value`, is generated. 
The "acronym function" has the following form:

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~sas
gigs_who_gs_<acronym>_zscore2value(z, x, sex)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Complete list is:

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~sas
gigs_who_gs_wfa_zscore2value(z, age_days, sex)

gigs_who_gs_bfa_zscore2value(z, age_days, sex)

gigs_who_gs_lhfa_zscore2value(z, age_days, sex)

gigs_who_gs_wfl_zscore2value(z, length_cm, sex)

gigs_who_gs_wfh_zscore2value(z, height_cm, sex)

gigs_who_gs_hcfa_zscore2value(z, age_days, sex)

gigs_who_gs_acfa_zscore2value(z, age_days, sex)

gigs_who_gs_ssfa_zscore2value(z, age_days, sex)

gigs_who_gs_tsfa_zscore2value(z, age_days, sex)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Those functions are generated by the `%gigs_who_gs_acronym()` macro.

### See also

The function internally use
`gigs_validate_who_gs`,
`gigs_who_gs_lms`, and
`gigs_v_from_lms` functions.

### References

de Onis M, Garza C, Victora CG, Onyango AW, Frongillo EA, Martines J. **The
WHO Multicentre Growth Reference Study: planning, study design, and
methodology** *Food Nutr Bull.* 2004, **25(1 Suppl):S15-26.**
doi: [10.1177/15648265040251s104](https://dx.doi.org/10.1177/15648265040251s104)

World Health Organisation. **WHO child growth standards:
length/height-for-age, weight-for-age, weight-for-length, weight-for-height
and body mass index-for-age: methods and development.** *Technical report,
WHO, Geneva*, 2006.

World Health Organisation. **WHO child growth standards: head
circumference-for-age, arm circumference-for-age, triceps skinfold-for-age
and subscapular skinfold-for-age: methods and development.** *Technical
report, WHO, Geneva*, 2007.

Cole TJ. **The LMS method for constructing normalized growth standards** *Eur
J Clin Nutr.* 1990, **44(1):45-60.** PMID:
[2354692](https://pubmed.ncbi.nlm.nih.gov/2354692/)

### Examples

1. Convert z-scores to values
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~sas
data _null_;
  acronym = "wfa";

  do z = -1 to 1;
    do age_days = 500 to 502;
      do sex = "M", "F", "M";
        value = gigs_who_gs_zscore2value(z, age_days, sex, acronym);
        put (_ALL_) (=);
      end;
      put;
    end;
  end;
run;
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

---

  
---
 
## `gigs_ig_fet_centile2value()` function <a name="gigsigfetcentile2value-functions-66"></a> ######

Convert centiles to values in the INTERGROWTH-21<sup>st</sup> Fetal standards

### Syntax

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~sas
function gigs_ig_fet_centile2value(
  p
, x
, acronym $
);
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

---


### Arguments

1. `p` - Numeric variable with centiles to convert to values. 
    For `p`, if an element of `p` is not between 0 and 1, gigs produce missing value (`.`). 

2. `x` - Numeric variable with x values. 
    Elements should have specific units and be between certain values 
    depending on the standard in use (defined by `acronym`). 
    These are:
    - Between 98 and 280 days for `"hcfga"`, `"bpdfga"`, 
     `"acfga"`, `"flfga"`, `"ofdfga"`, and `"tcdfga"`.
    - Between 154 and 280 days for `"efwfga"`.
    - Between 112 and 294 days for `"sfhfga"`.
    - Between 58 and 105 days for `"crlfga"`.
    - Between 19 and 95 mm for `"gafcrl"`.
    - Between 105 and 280 days for `"gwgfga"`.
    - Between 168 and 280 days for `"pifga"`, `"rifga"`, and `"sdrfga"` 
      (the INTERGROWTH-21<sup>st</sup> Fetal Doppler standards).
    - Between 105 and 252 days for `"poffga"`, `"sffga"`, `"avfga"`, and `"pvfga"` 
      (the INTERGROWTH-21<sup>st</sup> Fetal Brain Development standards).
    - Between 126 and 287 days for `"hefwfga"` (the INTERGROWTH-21<sup>st</sup> 
      standard for Hadlock-based estimated fetal weight).


    By default, gigs will return missing value (`.`) 
    for out-of-bounds elements in `x`.
    
    Numeric variable `gest_days`, `crl_mm`, or `tcd_mm` 
    are standard-specific `x` variables. 
 
3. `acronym` - Character variable denoting the
    INTERGROWTH-21<sup>st</sup> Fetal Growth standard(s) in use. 
    Each value should be one of:
    - `"hcfga"` (head circumference-for-GA)
    - `"bpdfga"` (biparietal diameter-for-GA)
    - `"acfga"` (abdominal circumference-for-GA)
    - `"flfga"` (femur length-for-GA)
    - `"ofdfga"` (occipito-frontal diameter-for-GA)
    - `"efwfga"` (estimated fetal weight-for-GA)
    - `"sfhfga"` (symphisis-fundal height-for-GA)
    - `"crlfga"` (crown-rump length-for-GA)
    - `"gafcrl"` (GA-for-crown-rump length)
    - `"gwgfga"` (gestational weight gain-for-GA)
    - `"pifga"` (pulsatility index-for-GA)
    - `"rifga"` (resistance index-for-GA)
    - `"sdrfga"` (systolic/diastolic ratio-for-GA)
    - `"tcdfga"` (transcerebellar diameter-for-GA)
    - `"poffga"` (parieto-occipital fissure-for-GA)
    - `"sffga"` (Sylvian fissure-for-GA)
    - `"avfga"` (anterior horn of lateral ventricle-for-GA)
    - `"pvfga"` (atrium of posterior horn of lateral ventricle-for-GA)
    - `"cmfga"` (cisterna magna-for-GA)
    - `"hefwfga"` (Hadlock esimated fetal weight-for-GA)

   If elements in `acronym` are not one of the above values, 
   gigs will return missing value (`.`).

### Returns

Numeric variable of expected measurements for each centile.

### Note

For each acronym from the list: 
`"hcfga"`, `"bpdfga"`, `"acfga"`, `"flfga"`, `"ofdfga"`, 
`"efwfga"`, `"sfhfga"`, `"crlfga"`, `"gafcrl"`, `"gwgfga"`, 
`"pifga"`, `"rifga"`, `"sdrfga"`, `"tcdfga"`, `"poffga"`, 
`"hefwfga"`, `"sffga"`, `"avfga"`, `"pvfga"`, and `"cmfga"` 
a counterpart "acronym function", which is a wrapper for 
the `gigs_ig_fet_centile2value`, is generated. 
The "acronym function" has the following form:

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~sas
gigs_ig_fet_<acronym>_centile2value(p, x)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Complete list is:

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~sas
gigs_ig_fet_hcfga_centile2value(p, gest_days)

gigs_ig_fet_bpdfga_centile2value(p, gest_days)

gigs_ig_fet_acfga_centile2value(p, gest_days)

gigs_ig_fet_flfga_centile2value(p, gest_days)

gigs_ig_fet_ofdfga_centile2value(p, gest_days)

gigs_ig_fet_efwfga_centile2value(p, gest_days)

gigs_ig_fet_hefwfga_centile2value(p, gest_days)

gigs_ig_fet_sfhfga_centile2value(p, gest_days)

gigs_ig_fet_crlfga_centile2value(p, gest_days)

gigs_ig_fet_gafcrl_centile2value(p, crl_mm)

gigs_ig_fet_gwgfga_centile2value(p, gest_days)

gigs_ig_fet_pifga_centile2value(p, gest_days)

gigs_ig_fet_rifga_centile2value(p, gest_days)

gigs_ig_fet_sdrfga_centile2value(p, gest_days)

gigs_ig_fet_tcdfga_centile2value(p, gest_days)

gigs_ig_fet_gaftcd_centile2value(p, tcd_mm)

gigs_ig_fet_poffga_centile2value(p, gest_days)

gigs_ig_fet_sffga_centile2value(p, gest_days)

gigs_ig_fet_avfga_centile2value(p, gest_days)

gigs_ig_fet_pvfga_centile2value(p, gest_days)

gigs_ig_fet_cmfga_centile2value(p, gest_days)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Those functions are generated by the `%gigs_ig_fet_acronym()` macro.


### See also

See the following function used internally by this function:
`gigs_ig_fet_zscore2value` and SAS `QUANTILE`.

### References

Papageorghiou AT, Ohuma EO, Altman DG, Todros T, Cheikh Ismail L, Lambert A
et al. **International standards for fetal growth based on serial ultrasound
measurements: the Fetal Growth Longitudinal Study of the INTERGROWTH-21st
Project.** *Lancet* 2014, **384(9946):869-79.**
doi: [10.1016/S0140-6736(14)61490-2](https://dx.doi.org/10.1016/S0140-6736(14)61490-2)

Stirnemann J, Villar J, Salomon LJ, Ohuma EO, Lamber A, Victoria CG et al.
**International Estimated Fetal Weight Standards of the INTERGROWTH-21st
Project.** *Ultrasound Obstet Gynecol* 2016, **49:478-486**
doi: [10.1002/uog.17347](https://dx.doi.org/10.1002/uog.17347)

Papageorghiou AT, Ohuma EO, Gravett MG, Lamber A, Noble JA, Pang R et al.
**International standards for symphysis-fundal height based on serial
measurements from the Fetal Growth Longitudinal Study of the INTERGROWTH-21st
Project: prospective cohort study in eight countries.** *BMJ* 2016,
**355:i5662** 
doi: [10.1136/bmj.i5662](https://dx.doi.org/10.1136/bmj.i5662)

Papageorghiou AT, Kennedy SH, Salomon LJ, Ohuma EO, Cheikh Ismail L, Barros
FC et al. **International standards for early fetal size and pregnancy dating
based on ultrasound measurement of crown-rump length in the first trimester
of pregnancy.** *Ultrasound Obstet Gynecol* 2014, **44(6):641-48**
doi: [10.1002/uog.13448](https://dx.doi.org/10.1002/uog.13448)

Cheikh Ismail L, Bishop DC, Pang R, Ohuma EO, Kac G, Abrams B et al.
**Gestational weight gain standards based on women enrolled in the Fetal
Growth Longitudinal Study of the INTERGROWTH-21st Project: a prospective
longitudinal cohort study.** *BMJ* 2016, **352:i555** 
doi: [10.1136/bmj.i555](https://dx.doi.org/10.1136/bmj.i555)

Drukker L, Staines-Urias E, Villar J, Barros FC, Carvalho M, Munim S et al.
**International gestational age-specific centiles for umbilical artery
Doppler indices: a longitudinal prospective cohort study of the
INTERGROWTH-21st Project.** *Am J Obstet Gynecol* 2021,
**222(6):602.e1-602.e15** 
doi: [10.1016/j.ajog.2020.01.012](https://dx.doi.org/10.1016/j.ajog.2020.01.012)

Rodriguez-Sibaja MJ, Villar J, Ohuma EO, Napolitano R, Heyl S, Carvalho M et
al. **Fetal cerebellar growth and Sylvian fissure maturation: international
standards from Fetal Growth Longitudinal Study of INTERGROWTH-21st Project**
*Ultrasound Obstet Gynecol* 2021, **57(4):614-623** 
doi: [10.1002/uog.22017](https://dx.doi.org/10.1002/uog.22017)

Napolitano R, Molloholli M, Donadono V, Ohuma EO, Wanyonyi SZ, Kemp B et al.
**International standards for fetal brain structures based on serial
ultrasound measurements from Fetal Growth Longitudinal Study of
INTERGROWTH-21st Project** *Ultrasound Obstet Gynecol* 2020,
**56(3):359-370** 
doi: [10.1002/uog.21990](https://dx.doi.org/10.1002/uog.21990)

Stirnemann J, Salomon LJ, Papageorghiou AT. **INTERGROWTH-21st
standards for Hadlock's estimation of fetal weight** *Ultrasound Obstet
Gynecol* 2020, **56(6):946-948**
doi: [10.1002/uog.22000](https://dx.doi.org/10.1002/uog.22000)

### Examples

1. Calculate value from centiles 
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~sas
data _null_;
  acronym = "hcfga";

  do p = 0.25, 0.5, 0.75;
    do x = 279 to 281;
      value = gigs_ig_fet_centile2value(p,x,acronym);
      put (_ALL_) (=);
    end;
    put;
  end;
run;
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

---

  
---
 
## `gigs_ig_fet_value2centile()` function <a name="gigsigfetvalue2centile-functions-67"></a> ######

Convert values to centiles in the INTERGROWTH-21<sup>st</sup> Fetal Growth standards

### Syntax

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~sas
function gigs_ig_fet_value2centile(
  y
, x
, acronym $
);
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

---


### Arguments

1. `y` - Numeric variable with values to convert to z-scores/centiles.

2. `x` - Numeric variable with x values. 
    Elements should have specific units and be between certain values 
    depending on the standard in use (defined by `acronym`). 
    These are:
    - Between 98 and 280 days for `"hcfga"`, `"bpdfga"`, 
     `"acfga"`, `"flfga"`, `"ofdfga"`, and `"tcdfga"`.
    - Between 154 and 280 days for `"efwfga"`.
    - Between 112 and 294 days for `"sfhfga"`.
    - Between 58 and 105 days for `"crlfga"`.
    - Between 19 and 95 mm for `"gafcrl"`.
    - Between 105 and 280 days for `"gwgfga"`.
    - Between 168 and 280 days for `"pifga"`, `"rifga"`, and `"sdrfga"` 
      (the INTERGROWTH-21<sup>st</sup> Fetal Doppler standards).
    - Between 105 and 252 days for `"poffga"`, `"sffga"`, `"avfga"`, and `"pvfga"` 
      (the INTERGROWTH-21<sup>st</sup> Fetal Brain Development standards).
    - Between 126 and 287 days for `"hefwfga"` (the INTERGROWTH-21<sup>st</sup> 
      standard for Hadlock-based estimated fetal weight).

    By default, gigs will return missing value (`.`) 
    for out-of-bounds elements in `x`.
    
    Numeric variable `gest_days`, `crl_mm`, or `tcd_mm` 
    are standard-specific `x` variables. 
 
3. `acronym` - Character variable denoting the
    INTERGROWTH-21<sup>st</sup> Fetal Growth standard(s) in use. 
    Each value should be one of:
    - `"hcfga"` (head circumference-for-GA)
    - `"bpdfga"` (biparietal diameter-for-GA)
    - `"acfga"` (abdominal circumference-for-GA)
    - `"flfga"` (femur length-for-GA)
    - `"ofdfga"` (occipito-frontal diameter-for-GA)
    - `"efwfga"` (estimated fetal weight-for-GA)
    - `"sfhfga"` (symphisis-fundal height-for-GA)
    - `"crlfga"` (crown-rump length-for-GA)
    - `"gafcrl"` (GA-for-crown-rump length)
    - `"gwgfga"` (gestational weight gain-for-GA)
    - `"pifga"` (pulsatility index-for-GA)
    - `"rifga"` (resistance index-for-GA)
    - `"sdrfga"` (systolic/diastolic ratio-for-GA)
    - `"tcdfga"` (transcerebellar diameter-for-GA)
    - `"poffga"` (parieto-occipital fissure-for-GA)
    - `"sffga"` (Sylvian fissure-for-GA)
    - `"avfga"` (anterior horn of lateral ventricle-for-GA)
    - `"pvfga"` (atrium of posterior horn of lateral ventricle-for-GA)
    - `"cmfga"` (cisterna magna-for-GA)
    - `"hefwfga"` (Hadlock esimated fetal weight-for-GA)

   If elements in `acronym` are not one of the above values, 
   gigs will return missing value (`.`).
   
### Returns

Numeric variable of expected z-scores for each measurement.

### Note

For each acronym from the list: 
`"hcfga"`, `"bpdfga"`, `"acfga"`, `"flfga"`, `"ofdfga"`, 
`"efwfga"`, `"sfhfga"`, `"crlfga"`, `"gafcrl"`, `"gwgfga"`, 
`"pifga"`, `"rifga"`, `"sdrfga"`, `"tcdfga"`, `"poffga"`, 
`"hefwfga"`, `"sffga"`, `"avfga"`, `"pvfga"`, and `"cmfga"` 
a counterpart "acronym function", which is a wrapper for 
the `gigs_ig_fet_value2centile`, is generated. 
The "acronym function" has the following form:

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~sas
gigs_ig_fet_<acronym>_value2centile(y, x)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Complete list is:

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~sas
gigs_ig_fet_hcfga_value2centile(headcirc_mm, gest_days)

gigs_ig_fet_bpdfga_value2centile(bpd_mm, gest_days)

gigs_ig_fet_acfga_value2centile(abdocirc_mm, gest_days)

gigs_ig_fet_flfga_value2centile(femurlen_mm, gest_days)

gigs_ig_fet_ofdfga_value2centile(ofd_mm, gest_days)

gigs_ig_fet_efwfga_value2centile(efw_g, gest_days)

gigs_ig_fet_hefwfga_value2centile(hadlock_efw_g, gest_days)

gigs_ig_fet_sfhfga_value2centile(sfh_cm, gest_days)

gigs_ig_fet_crlfga_value2centile(crl_mm, gest_days)

gigs_ig_fet_gafcrl_value2centile(gest_days, crl_mm)

gigs_ig_fet_gwgfga_value2centile(gest_wt_gain_kg, gest_days)

gigs_ig_fet_pifga_value2centile(puls_idx, gest_days)

gigs_ig_fet_rifga_value2centile(resist_idx, gest_days)

gigs_ig_fet_sdrfga_value2centile(sys_dia_ratio, gest_days)

gigs_ig_fet_tcdfga_value2centile(tcd_mm, gest_days)

gigs_ig_fet_gaftcd_value2centile(gest_days, tcd_mm)

gigs_ig_fet_poffga_value2centile(par_occ_fiss_mm, gest_days)

gigs_ig_fet_sffga_value2centile(sylv_fiss_mm, gest_days)

gigs_ig_fet_avfga_value2centile(ant_hlv_mm, gest_days)

gigs_ig_fet_pvfga_value2centile(atr_phlv_mm, gest_days)

gigs_ig_fet_cmfga_value2centile(cist_mag_mm, gest_days)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Parameters meaning:

- `gest_days` - Numeric variable that is usually used as the `x` 
                variable, but can also be a `y` variable for the 
                `"gafcrl"` and `"gaftcd"` standards. 
                
- `headcirc_mm` - Numeric variable with head
                  circumference measurements in mm.
                  
- `bpd_mm` - Numeric variable with biparietal diameter
             measurement(s) in mm.
             
- `abdocirc_mm` - Numeric variable with abdominal
                  circumference measurement(s) in mm.
                  
- `femurlen_mm` - Numeric variable with femur length(s) in mm.

- `ofd_mm` - Numeric variable with in occipito-frontal
             diameter(s) in mm.
             
- `efw_g` - Numeric variable with estimated fetal weight(s) in g.
            
- `hadlock_efw_g` - Numeric variable with estimated fetal weight(s) in g.
            
- `sfh_cm` - Numeric variable with symphisis-fundal height(s) in mm.
             
- `crl_mm` - Numeric variable with crown-rump length(s) in mm.

- `gest_wt_gain_kg` - Numeric variable with gestational
                      weight gain(s)/loss(es) in kg.
                      
- `puls_idx` - Numeric variable with pulsatility index value(s).

- `resist_idx` - Numeric variable with resistance index value(s).

- `sys_dia_ratio` - Numeric variable with systolic/diastolic 
                    ratio value(s).
                    
- `tcd_mm` - Numeric variable with transcerebellar diameter(s) in mm.
             
- `par_occ_fiss_mm` - Numeric variable with parietal-occipital 
                      fissure measurement(s) in mm.
                      
- `sylv_fiss_mm` - Numeric variable with Sylvian fissure
                   measurement(s) in mm.
                   
- `ant_hlv_mm` - Numeric variable with anterior horn of
                 lateral ventricle measurements(s) in mm.
                 
- `atr_phlv_mm` - Numeric variable with atrium of
                  posterior horn of lateral ventricle measurement(s) in mm.
                  
- `cist_mag_mm` - Numeric variable with cisterna magna
                  measurement(s) in mm.

Those functions are generated by the `%gigs_ig_fet_acronym()` macro.

### See also 

See the following function used internally by this function:
`gigs_ig_fet_value2zscore` and SAS `CDF`.

### References

Papageorghiou AT, Ohuma EO, Altman DG, Todros T, Cheikh Ismail L, Lambert A
et al. **International standards for fetal growth based on serial ultrasound
measurements: the Fetal Growth Longitudinal Study of the INTERGROWTH-21st
Project.** *Lancet* 2014, **384(9946):869-79.**
doi: [10.1016/S0140-6736(14)61490-2](https://dx.doi.org/10.1016/S0140-6736(14)61490-2)

Stirnemann J, Villar J, Salomon LJ, Ohuma EO, Lamber A, Victoria CG et al.
**International Estimated Fetal Weight Standards of the INTERGROWTH-21st
Project.** *Ultrasound Obstet Gynecol* 2016, **49:478-486**
doi: [10.1002/uog.17347](https://dx.doi.org/10.1002/uog.17347)

Papageorghiou AT, Ohuma EO, Gravett MG, Lamber A, Noble JA, Pang R et al.
**International standards for symphysis-fundal height based on serial
measurements from the Fetal Growth Longitudinal Study of the INTERGROWTH-21st
Project: prospective cohort study in eight countries.** *BMJ* 2016,
**355:i5662** 
doi: [10.1136/bmj.i5662](https://dx.doi.org/10.1136/bmj.i5662)

Papageorghiou AT, Kennedy SH, Salomon LJ, Ohuma EO, Cheikh Ismail L, Barros
FC et al. **International standards for early fetal size and pregnancy dating
based on ultrasound measurement of crown-rump length in the first trimester
of pregnancy.** *Ultrasound Obstet Gynecol* 2014, **44(6):641-48**
doi: [10.1002/uog.13448](https://dx.doi.org/10.1002/uog.13448)

Cheikh Ismail L, Bishop DC, Pang R, Ohuma EO, Kac G, Abrams B et al.
**Gestational weight gain standards based on women enrolled in the Fetal
Growth Longitudinal Study of the INTERGROWTH-21st Project: a prospective
longitudinal cohort study.** *BMJ* 2016, **352:i555** 
doi: [10.1136/bmj.i555](https://dx.doi.org/10.1136/bmj.i555)

Drukker L, Staines-Urias E, Villar J, Barros FC, Carvalho M, Munim S et al.
**International gestational age-specific centiles for umbilical artery
Doppler indices: a longitudinal prospective cohort study of the
INTERGROWTH-21st Project.** *Am J Obstet Gynecol* 2021,
**222(6):602.e1-602.e15** 
doi: [10.1016/j.ajog.2020.01.012](https://dx.doi.org/10.1016/j.ajog.2020.01.012)

Rodriguez-Sibaja MJ, Villar J, Ohuma EO, Napolitano R, Heyl S, Carvalho M et
al. **Fetal cerebellar growth and Sylvian fissure maturation: international
standards from Fetal Growth Longitudinal Study of INTERGROWTH-21st Project**
*Ultrasound Obstet Gynecol* 2021, **57(4):614-623** 
doi: [10.1002/uog.22017](https://dx.doi.org/10.1002/uog.22017)

Napolitano R, Molloholli M, Donadono V, Ohuma EO, Wanyonyi SZ, Kemp B et al.
**International standards for fetal brain structures based on serial
ultrasound measurements from Fetal Growth Longitudinal Study of
INTERGROWTH-21st Project** *Ultrasound Obstet Gynecol* 2020,
**56(3):359-370** 
doi: [10.1002/uog.21990](https://dx.doi.org/10.1002/uog.21990)

Stirnemann J, Salomon LJ, Papageorghiou AT. **INTERGROWTH-21st
standards for Hadlock's estimation of fetal weight** *Ultrasound Obstet
Gynecol* 2020, **56(6):946-948**
doi: [10.1002/uog.22000](https://dx.doi.org/10.1002/uog.22000)

### Examples

1. Convert values to centiles 
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~sas
data _null_;
  acronym = "acfga";

  do abdocirc_mm = 335 to 340;
    do gest_days = 265 to 270;
      value = gigs_ig_fet_value2centile(abdocirc_mm,gest_days,acronym);
      put (_ALL_) (=);
    end;
    put;
  end;
run;
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

---

  
---
 
## `gigs_ig_nbs_centile2value()` function <a name="gigsignbscentile2value-functions-68"></a> ######

Convert centiles to values in the INTERGROWTH-21<sup>st</sup>
Newborn Size Standards

### Syntax 

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~sas
function gigs_ig_nbs_centile2value(
  p
, gest_days
, sex $
, acronym $
);
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

---


### Arguments

1. `p` - Numeric variable with centiles to
   convert to values. For `p`, if an element of `p` is not between `0` and
   `1`, gigs will produce missing value (`.`). 
  
2. `gest_days` -  Numeric variable with gestational ages
   in days. Elements should be between certain values depending on the Newborn
   Size standard in use (defined by `acronym`). These are:
   - Between 168 and 300 days for `"wfga"`, `"lfga"`, `"hcfga"`, and `"wlrfga"`.
   - Between 154 and 280 days for `"fmfga"`, `"bfpfga"`, and `"ffmfga"`.
   By default, gigs will ignore `gest_days` that are out of
   bounds for the growth standard and return missing value (`.`). 
  
3. `sex` - Character variable with sex, either "M" (male) or "F" (female). 
   This argument is not case-sensitive. 
  
4. `acronym` - Character variable denoting the
    INTERGROWTH-21<sup>st</sup> Newborn Size standard to use for each
    observation. Each element should be one of:
    * `"wfga"` (weight-for-GA)
    * `"lfga"` (length-for-GA)
    * `"hcfga"` (head circumference-for-GA)
    * `"wlrfga"` (weight/length ratio-for-GA)
    * `"fmfga"` (fat mass-for-GA)
    * `"bfpfga"` (body fat %-for-GA)
    * `"ffmfga"` (fat-free mass-for-GA)
    This argument is not case-sensitive.   
  
### Returns

Numeric variable of expected measurements for each centile.

### Note

For each acronym from the list: 
`"wfga"`, `"lfga"`, `"hcfga"`, `"wlrfga"`, `"fmfga"`, `"bfpfga"`, and `"ffmfga"`  
a counterpart "acronym function", which is a wrapper for the `gigs_ig_nbs_centile2value`,
is generated. The "acronym function" has the following form:

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~sas
gigs_ig_nbs_<acronym>_centile2value(p, gest_days, sex)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Complete list is:

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~sas
gigs_ig_nbs_wfga_centile2value(p, gest_days, sex)

gigs_ig_nbs_lfga_centile2value(p, gest_days, sex)

gigs_ig_nbs_hcfga_centile2value(p, gest_days, sex)

gigs_ig_nbs_wlrfga_centile2value(p, gest_days, sex)

gigs_ig_nbs_fmfga_centile2value(p, gest_days, sex)

gigs_ig_nbs_bfpfga_centile2value(p, gest_days, sex)

gigs_ig_nbs_ffmfga_centile2value(p, gest_days, sex)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Those functions are generated by the `%gigs_ig_nbs_acronym()` macro.

### See also

The function internally utilizes the following functions:
`gigs_validate_ig_nbs`,
`gigs_ig_nbs_msnt_p2v`,
`gigs_ig_vpns_zscore2value`,
`gigs_ig_nbs_wlrfga_p2v`,
and
`gigs_ig_nbs_bodycomp_p2v`.


### References

Villar J, Cheikh Ismail L, Victora CG, Ohuma EO, Bertino E, Altman DG, et al.
**International standards for newborn weight, length, and head circumference
by gestational age and sex: the Newborn Cross-Sectional Study of the
INTERGROWTH-21st Project.** *Lancet* 2014, **384(9946):857-68.**
doi: [10.1016/S0140-6736(14)60932-6](https://dx.doi.org/10.1016/S0140-6736(14)60932-6)

Villar J, Giuliani F, Fenton TR, Ohuma EO, Ismail LC, Kennedy SH et al.
**INTERGROWTH-21st very preterm size at birth reference charts.** *Lancet*
2016, **387(10021):844-45.**
doi: [10.1016/S0140-6736(16)00384-6](https://dx.doi.org/10.1016/S0140-6736(16)00384-6)

Villar J, Puglia FA, Fenton TR, Ismal LC, Staines-Urias E, Giuliani F, et al.
**Body composition at birth and its relationship with neonatal anthropometric
ratios: the newborn body composition study of the INTERGROWTH-21st project.**
*Pediatric Research* 2017, **82:305-316.**
doi: [10.1038/pr.2017.52](https://dx.doi.org/10.1038/pr.2017.52)

---

  
---
 
## `gigs_ig_nbs_value2centile()` function <a name="gigsignbsvalue2centile-functions-69"></a> ######

Convert values to centiles in the INTERGROWTH-21<sup>st</sup>
Newborn Size Standards

### Syntax

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~sas
  function gigs_ig_nbs_value2centile(
    y 
  , gest_days 
  , sex $
  , acronym $ 
  );
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

---


### Arguments

1. `y` - Numeric variable with measurements to
   convert to centiles. 
  
2. `gest_days` -  Numeric variable with gestational ages
   in days. Elements should be between certain values depending on the Newborn
   Size standard in use (defined by `acronym`). These are:
   - Between 168 and 300 days for `"wfga"`, `"lfga"`, `"hcfga"`, and `"wlrfga"`.
   - Between 154 and 280 days for `"fmfga"`, `"bfpfga"`, and `"ffmfga"`.
   By default, gigs will ignore `gest_days` that are out of
   bounds for the growth standard and return missing value (`.`). 
  
3. `sex` - Character variable with sex, either "M" (male) or "F" (female). 
   This argument is not case-sensitive. 
  
4. `acronym` - Character variable denoting the
    INTERGROWTH-21<sup>st</sup> Newborn Size standard to use for each
    observation. Each element should be one of:
    * `"wfga"` (weight-for-GA)
    * `"lfga"` (length-for-GA)
    * `"hcfga"` (head circumference-for-GA)
    * `"wlrfga"` (weight/length ratio-for-GA)
    * `"fmfga"` (fat mass-for-GA)
    * `"bfpfga"` (body fat %-for-GA)
    * `"ffmfga"` (fat-free mass-for-GA)
    This argument is not case-sensitive.

### Returns

Numeric variable of expected centiles for each measurement.

### Note

For each acronym from the list: 
`"wfga"`, `"lfga"`, `"hcfga"`, `"wlrfga"`, `"fmfga"`, `"bfpfga"`, and `"ffmfga"`  
a counterpart "acronym function", which is a wrapper for the `gigs_ig_nbs_value2centile`,
is generated. The "acronym function" has the following form:

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~sas
gigs_ig_nbs_<acronym>_value2centile(y, gest_days, sex)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Complete list is:

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~sas
gigs_ig_nbs_wfga_value2centile(weight_kg, gest_days, sex)

gigs_ig_nbs_lfga_value2centile(length_cm, gest_days, sex)

gigs_ig_nbs_hcfga_value2centile(headcirc_cm, gest_days, sex)

gigs_ig_nbs_wlrfga_value2centile(wei_len_ratio, gest_days, sex)

gigs_ig_nbs_fmfga_value2centile(fat_mass_g, gest_days, sex)

gigs_ig_nbs_bfpfga_value2centile(body_fat_perc, gest_days, sex)

gigs_ig_nbs_ffmfga_value2centile(fatfree_mass_g, gest_days, sex
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Parameters meaning:
  - `weight_kg` - Numeric variable with birth weight(s) in kg.
  - `length_cm` - Numeric variable with birth length(s) in cm.
  - `headcirc_cm` - Numeric variable with birth head circumference(s) in cm.
  - `wei_len_ratio` - Numeric variable with weight-length ratio(s) in kg per m.
  - `fat_mass_g` - Numeric variable with fat mass(es) in g.
  - `body_fat_perc` - Numeric variable with body fat percentage(s).
  - `fatfree_mass_g` - Numeric variable with fat-free mass(es) in g.

Those functions are generated by the `%gigs_ig_nbs_acronym()` macro.

### See also

The function internally utilizes the following functions:
`gigs_validate_ig_nbs`,
`gigs_ig_nbs_msnt`,
`gamlss_pST3`,
`gigs_ig_vpns_value2zscore`,
`gigs_ig_nbs_wlr`,
`gigs_ig_nbs_bodycomp`,
and SAS `CDF` and `PDF`.

### References

Villar J, Cheikh Ismail L, Victora CG, Ohuma EO, Bertino E, Altman DG, et al.
**International standards for newborn weight, length, and head circumference
by gestational age and sex: the Newborn Cross-Sectional Study of the
INTERGROWTH-21st Project.** *Lancet* 2014, **384(9946):857-68.**
doi: [10.1016/S0140-6736(14)60932-6](https://dx.doi.org/10.1016/S0140-6736(14)60932-6)

Villar J, Giuliani F, Fenton TR, Ohuma EO, Ismail LC, Kennedy SH et al.
**INTERGROWTH-21st very preterm size at birth reference charts.** *Lancet*
2016, **387(10021):844-45.**
doi: [10.1016/S0140-6736(16)00384-6](https://dx.doi.org/10.1016/S0140-6736(16)00384-6)

Villar J, Puglia FA, Fenton TR, Ismal LC, Staines-Urias E, Giuliani F, et al.
**Body composition at birth and its relationship with neonatal anthropometric
ratios: the newborn body composition study of the INTERGROWTH-21st project.**
*Pediatric Research* 2017, **82:305-316.**
doi: [10.1038/pr.2017.52](https://dx.doi.org/10.1038/pr.2017.52)

### Examples

1. Convert values to z-scores
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~sas
data have;
  input y gest_days sex :$1. acronym :$6.;
CARDS4;
2.90  274 F wfga
3.17  275 F wfga
3.46  276 F wfga
48.84 280 M lfga
;;;;
run;

data get;
  set have;
  
  centile=gigs_ig_nbs_value2centile(
    y
  , gest_days
  , sex
  , acronym
  );
run;
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

2. Use of "acronym function"
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~sas
data get_lfga;
  length_cm = 48.84;
  gest_days = 280;
  sex = "M";

  centile = gigs_ig_nbs_lfga_value2centile(
    length_cm
  , gest_days
  , sex
);
run;
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

---

  
---
 
## `gigs_who_gs_centile2value()` function <a name="gigswhogscentile2value-functions-70"></a> ######

Convert centiles to values in the WHO Child Growth Standards

### Synatx

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~sas
function gigs_who_gs_centile2value(
  p
, x
, sex $
, acronym $
);
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

---


### Arguments

1. `p` - Numeric variable with centiles to convert to values. 
    For `p`, if an element of p is not between 0 and 1, 
    gigs will return missing value (`.`). 

2. `x` - Numeric variable with x values. Elements in `x` or its 
    standard-specific equivalents (`age_days`, `length_cm`, and `height_cm`) 
    should have specific units and be between certain values depending 
    on the standard in use (defined by `acronym`). 
    These are:
    - Between 0 and 1856 days for `"wfa"`, `"bfa"`, `"lhfa"`, and `"hcfa"`.
    - Between 45 and 110 cm for `"wfl"`.
    - Between 65 and 120 cm for `"wfh"`.
    - Between 91 and 1856 days for `"acfa"`, `"ssfa"`, `"tsfa"`.

    By default, gigs will return missing value (`.`) for 
    out-of-bounds elements in `x`.

3. `sex` - Character variable with sex(es), either "M" (male) or "F" (female).

4. `acronym` - Character variable denoting the WHO Child
    Growth standard(s) in use. Each element should be one of:
    - `"wfa"` (weight-for-age)
    - `"bfa"` (BMI-for-age)
    - `"lhfa"` (length/height-for-age)
    - `"wfl"` (weight-for-length)
    - `"wfh"` (weight-for-height)
    - `"hcfa"` (head circumference-for-age)
    - `"acfa"` (arm circumference-for-age)
    - `"ssfa"` (subscapular skinfold-for-age)
    - `"tsfa"` (triceps skinfold-for-age)

### Returns

Numeric variable of expected measurements for each centile.

### Note

For each acronym from the list: 
`"wfa"`, `"bfa"`, `"lhfa"`, `"wfl"`, `"wfh"`,
`"hcfa"`, `"acfa"`, `"ssfa"`, and `"tsfa"` 
a counterpart "acronym function", which is a wrapper for 
the `gigs_who_gs_centile2value`, is generated. 
The "acronym function" has the following form:

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~sas
gigs_who_gs_<acronym>_centile2value(p, x, sex)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Complete list is:

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~sas
gigs_who_gs_wfa_centile2value(p, age_days, sex)

gigs_who_gs_bfa_centile2value(p, age_days, sex)

gigs_who_gs_lhfa_centile2value(p, age_days, sex)

gigs_who_gs_wfl_centile2value(p, length_cm, sex)

gigs_who_gs_wfh_centile2value(p, height_cm, sex)

gigs_who_gs_hcfa_centile2value(p, age_days, sex)

gigs_who_gs_acfa_centilevalue(p, age_days, sex)

gigs_who_gs_ssfa_centilevalue(p, age_days, sex)

gigs_who_gs_tsfa_centilevalue(p, age_days, sex)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Those functions are generated by the `%gigs_who_gs_acronym()` macro.

### See also

The function internally use
`gigs_who_gs_zscore2value`,
and SAS `QUANTILE` functions.

### References

de Onis M, Garza C, Victora CG, Onyango AW, Frongillo EA, Martines J. **The
WHO Multicentre Growth Reference Study: planning, study design, and
methodology** *Food Nutr Bull.* 2004, **25(1 Suppl):S15-26.**
doi: [10.1177/15648265040251s104](https://dx.doi.org/10.1177/15648265040251s104)

World Health Organisation. **WHO child growth standards:
length/height-for-age, weight-for-age, weight-for-length, weight-for-height
and body mass index-for-age: methods and development.** *Technical report,
WHO, Geneva*, 2006.

World Health Organisation. **WHO child growth standards: head
circumference-for-age, arm circumference-for-age, triceps skinfold-for-age
and subscapular skinfold-for-age: methods and development.** *Technical
report, WHO, Geneva*, 2007.

Cole TJ. **The LMS method for constructing normalized growth standards** *Eur
J Clin Nutr.* 1990, **44(1):45-60.** PMID:
[2354692](https://pubmed.ncbi.nlm.nih.gov/2354692/)

### Examples

1. Convert centiles to values
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~sas
data _null_;
  acronym = "wfa";

  do p = 0.25, 0.5, 0.75;
    do age_days = 500 to 502;
      do sex = "M", "F", "M";
        value = gigs_who_gs_centile2value(p, age_days, sex, acronym);
        put (_ALL_) (=);
      end;
      put;
    end;
  end;
run;
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

---

  
---
 
## `gigs_who_gs_value2centile()` function <a name="gigswhogsvalue2centile-functions-71"></a> ######

Convert values to centiles in the WHO Child Growth Standards

### Syntax

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~sas
function gigs_who_gs_value2centile(
  y
, x
, sex $
, acronym $
);
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

---


### Arguments

1. `y` - Numeric variable with anthropometric measurement(s) 
    to convert to centiles. 
    Units depend on which acronym(s) are in use.

2. `x` - Numeric variable with x values. Elements in `x` or its 
    standard-specific equivalents (`age_days`, `length_cm`, and `height_cm`) 
    should have specific units and be between certain values depending 
    on the standard in use (defined by `acronym`). 
    These are:
    - Between 0 and 1856 days for `"wfa"`, `"bfa"`, `"lhfa"`, and `"hcfa"`.
    - Between 45 and 110 cm for `"wfl"`.
    - Between 65 and 120 cm for `"wfh"`.
    - Between 91 and 1856 days for `"acfa"`, `"ssfa"`, `"tsfa"`.

    By default, gigs will return missing value (`.`) for 
    out-of-bounds elements in `x`.

3. `sex` - Character variable with sex(es), either "M" (male) or "F" (female).

4. `acronym` - Character variable denoting the WHO Child
    Growth standard(s) in use. Each element should be one of:
    - `"wfa"` (weight-for-age)
    - `"bfa"` (BMI-for-age)
    - `"lhfa"` (length/height-for-age)
    - `"wfl"` (weight-for-length)
    - `"wfh"` (weight-for-height)
    - `"hcfa"` (head circumference-for-age)
    - `"acfa"` (arm circumference-for-age)
    - `"ssfa"` (subscapular skinfold-for-age)
    - `"tsfa"` (triceps skinfold-for-age)

### Returns

Numeric variable of centiles for each measurement.

### Note

For each acronym from the list: 
`"wfa"`, `"bfa"`, `"lhfa"`, `"wfl"`, `"wfh"`,
`"hcfa"`, `"acfa"`, `"ssfa"`, and `"tsfa"` 
a counterpart "acronym function", which is a wrapper for 
the `gigs_who_gs_value2centile`, is generated. 
The "acronym function" has the following form:

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~sas
gigs_who_gs_<acronym>_value2centile(y, x, sex)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Complete list is:

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~sas
gigs_who_gs_wfa_value2centile(weight_kg, age_days, sex)

gigs_who_gs_bfa_value2centile(bmi, age_days, sex)

gigs_who_gs_lhfa_value2centile(lenht_cm, age_days, sex)

gigs_who_gs_wfl_value2centile(weight_kg, length_cm, sex)

gigs_who_gs_wfh_value2centile(weight_kg, height_cm, sex)

gigs_who_gs_hcfa_value2centile(headcirc_cm, age_days, sex)

gigs_who_gs_acfa_value2centile(armcirc_cm, age_days, sex)

gigs_who_gs_ssfa_value2centile(subscap_sf_mm, age_days, sex)

gigs_who_gs_tsfa_value2centile(triceps_sf_mm, age_days, sex)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Parameters meaning:

- `weight_kg` - Numeric variable with weight measurement(s) in kg.
- `bmi` - Numeric variable with body mass index measurement(s) in kg/m<sup>2</sup>.
- `lenht_cm` - Numeric variable with length/height measurement(s) in cm.
- `headcirc_cm` - Numeric variable with head circumference measurement(s) in cm.
- `armcirc_cm` - Numeric variable with arm circumference measurement(s) in cm.
- `subscap_sf_mm` - Numeric variable with subscapular skinfold measurement(s) in mm.
- `triceps_sf_mm` - Numeric variable with triceps skinfold measurement(s) in mm.

Those functions are generated by the `%gigs_who_gs_acronym()` macro.

### See also

The function internally use
`gigs_who_gs_value2zscore` 
and SAS `CDF` functions.

### References

de Onis M, Garza C, Victora CG, Onyango AW, Frongillo EA, Martines J. **The
WHO Multicentre Growth Reference Study: planning, study design, and
methodology** *Food Nutr Bull.* 2004, **25(1 Suppl):S15-26.**
doi: [10.1177/15648265040251s104](https://dx.doi.org/10.1177/15648265040251s104)

World Health Organisation. **WHO child growth standards:
length/height-for-age, weight-for-age, weight-for-length, weight-for-height
and body mass index-for-age: methods and development.** *Technical report,
WHO, Geneva*, 2006.

World Health Organisation. **WHO child growth standards: head
circumference-for-age, arm circumference-for-age, triceps skinfold-for-age
and subscapular skinfold-for-age: methods and development.** *Technical
report, WHO, Geneva*, 2007.

Cole TJ. **The LMS method for constructing normalized growth standards** *Eur
J Clin Nutr.* 1990, **44(1):45-60.** PMID:
[2354692](https://pubmed.ncbi.nlm.nih.gov/2354692/)

### Examples

1. Convert values to centiles
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~sas
data have;
  input weight_kg age_days sex :$1.;
CARDS4;
10.1 504 M
10.2 505 F
10.3 506 M
;;;;
run;

data get;
  set have;
  acronym = "wfa";
  
  centile = gigs_who_gs_value2centile(
    weight_kg
  , age_days 
  , sex
  , acronym
  );
run;
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

---

  
---
 
## `gigs_ig_nbs_value2zscore()` function <a name="gigsignbsvalue2zscore-functions-72"></a> ######

Convert values to z-scores in the INTERGROWTH-21<sup>st</sup>
Newborn Size Standards

### Syntax

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~sas
  function gigs_ig_nbs_value2zscore(
    y
  , gest_days
  , sex $
  , acronym $
  );
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

---


### Arguments

1. `y` - Numeric variable with measurements to
   convert to z-score. 
  
2. `gest_days` -  Numeric variable with gestational ages
   in days. Elements should be between certain values depending on the Newborn
   Size standard in use (defined by `acronym`). These are:
   - Between 168 and 300 days for `"wfga"`, `"lfga"`, `"hcfga"`, and `"wlrfga"`.
   - Between 154 and 280 days for `"fmfga"`, `"bfpfga"`, and `"ffmfga"`.
   By default, gigs will ignore `gest_days` that are out of
   bounds for the growth standard and return missing value (`.`). 
  
3. `sex` - Character variable with sex, either "M" (male) or "F" (female). 
   This argument is not case-sensitive. 
  
4. `acronym` - Character variable denoting the
    INTERGROWTH-21<sup>st</sup> Newborn Size standard to use for each
    observation. Each element should be one of:
    * `"wfga"` (weight-for-GA)
    * `"lfga"` (length-for-GA)
    * `"hcfga"` (head circumference-for-GA)
    * `"wlrfga"` (weight/length ratio-for-GA)
    * `"fmfga"` (fat mass-for-GA)
    * `"bfpfga"` (body fat %-for-GA)
    * `"ffmfga"` (fat-free mass-for-GA)
    This argument is not case-sensitive.

### Returns

Numeric variable of expected z-scores for each measurement.

### Note

For each acronym from the list: 
`"wfga"`, `"lfga"`, `"hcfga"`, `"wlrfga"`, `"fmfga"`, `"bfpfga"`, and `"ffmfga"`  
a counterpart "acronym function", which is a wrapper for the `gigs_ig_nbs_value2zscore`,
is generated. The "acronym function" has the following form:

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~sas
gigs_ig_nbs_<acronym>_value2zscore(y, gest_days, sex)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Complete list is:

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~sas
gigs_ig_nbs_wfga_value2zscore(weight_kg, gest_days, sex)

gigs_ig_nbs_lfga_value2zscore(length_cm, gest_days, sex)

gigs_ig_nbs_hcfga_value2zscore(headcirc_cm, gest_days, sex)

gigs_ig_nbs_wlrfga_value2zscore(wei_len_ratio, gest_days, sex)

gigs_ig_nbs_fmfga_value2zscore(fat_mass_g, gest_days, sex)

gigs_ig_nbs_bfpfga_value2zscore(body_fat_perc, gest_days, sex)

gigs_ig_nbs_ffmfga_value2zscore(fatfree_mass_g, gest_days, sex
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Parameters meaning:
  - `weight_kg` - Numeric variable with birth weight(s) in kg.
  - `length_cm` - Numeric variable with birth length(s) in cm.
  - `headcirc_cm` - Numeric variable with birth head circumference(s) in cm.
  - `wei_len_ratio` - Numeric variable with weight-length ratio(s) in kg per m.
  - `fat_mass_g` - Numeric variable with fat mass(es) in g.
  - `body_fat_perc` - Numeric variable with body fat percentage(s).
  - `fatfree_mass_g` - Numeric variable with fat-free mass(es) in g.

Those functions are generated by the `%gigs_ig_nbs_acronym()` macro.

### See also

The function internally utilizes the following functions:
`gigs_ig_nbs_value2centile`,
and SAS `QUANTILE`.

### References

Villar J, Cheikh Ismail L, Victora CG, Ohuma EO, Bertino E, Altman DG, et al.
**International standards for newborn weight, length, and head circumference
by gestational age and sex: the Newborn Cross-Sectional Study of the
INTERGROWTH-21st Project.** *Lancet* 2014, **384(9946):857-68.**
doi: [10.1016/S0140-6736(14)60932-6](https://dx.doi.org/10.1016/S0140-6736(14)60932-6)

Villar J, Giuliani F, Fenton TR, Ohuma EO, Ismail LC, Kennedy SH et al.
**INTERGROWTH-21st very preterm size at birth reference charts.** *Lancet*
2016, **387(10021):844-45.**
doi: [10.1016/S0140-6736(16)00384-6](https://dx.doi.org/10.1016/S0140-6736(16)00384-6)

Villar J, Puglia FA, Fenton TR, Ismal LC, Staines-Urias E, Giuliani F, et al.
**Body composition at birth and its relationship with neonatal anthropometric
ratios: the newborn body composition study of the INTERGROWTH-21st project.**
*Pediatric Research* 2017, **82:305-316.**
doi: [10.1038/pr.2017.52](https://dx.doi.org/10.1038/pr.2017.52)

### Examples

1. Convert values to z-scores
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~sas
data have;
  input y gest_days sex :$1. acronym :$6.;
CARDS4;
2.90  274 F wfga
3.17  275 F wfga
3.46  276 F wfga
48.84 280 M lfga
;;;;
run;

data get;
  set have;
  
  zScore=gigs_ig_nbs_value2zscore(
    y
  , gest_days
  , sex
  , acronym
  );
run;
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

2. Use of "acronym function"
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~sas
data get_lfga;
  length_cm = 48.84;
  gest_days = 280;
  sex = "M";

  zscore = gigs_ig_nbs_lfga_value2zscore(
    length_cm
  , gest_days
  , sex
);
run;
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

---

  
---
 
## `gigs_ig_nbs_zscore2value()` function <a name="gigsignbszscore2value-functions-73"></a> ######

Convert z-scores to values in the INTERGROWTH-21<sup>st</sup>
Newborn Size Standards

### Syntax

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~sas
function gigs_ig_nbs_zscore2value(
  z
, gest_days
, sex $
, acronym $
);
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

---


### Arguments


1. `z` - Numeric variable with z-scores to convert to values. 
  
2. `gest_days` -  Numeric variable with gestational ages
   in days. Elements should be between certain values depending on the Newborn
   Size standard in use (defined by `acronym`). These are:
   - Between 168 and 300 days for `"wfga"`, `"lfga"`, `"hcfga"`, and `"wlrfga"`.
   - Between 154 and 280 days for `"fmfga"`, `"bfpfga"`, and `"ffmfga"`.
   By default, gigs will ignore `gest_days` that are out of
   bounds for the growth standard and return missing value (`.`).
  
3. `sex` - Character variable with sex, either "M" (male) or "F" (female). 
    This argument is not case-sensitive. 
  
4. `acronym` - Character variable denoting the
    INTERGROWTH-21<sup>st</sup> Newborn Size standard to use for each
    observation. Each element should be one of:
    * `"wfga"` (weight-for-GA)
    * `"lfga"` (length-for-GA)
    * `"hcfga"` (head circumference-for-GA)
    * `"wlrfga"` (weight/length ratio-for-GA)
    * `"fmfga"` (fat mass-for-GA)
    * `"bfpfga"` (body fat %-for-GA)
    * `"ffmfga"` (fat-free mass-for-GA)

    This argument is not case-sensitive.   
  
### Returns

 Numeric variable of expected measurements for each z-score.

### Note

For each acronym from the list: 
`"wfga"`, `"lfga"`, `"hcfga"`, `"wlrfga"`, `"fmfga"`, `"bfpfga"`, and `"ffmfga"`  
a counterpart "acronym function", which is a wrapper for the `gigs_ig_nbs_zscore2value`,
is generated. The "acronym function" has the following form:

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~sas
gigs_ig_nbs_<acronym>_zscore2value(z, gest_days, sex)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Complete list is:

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~sas
gigs_ig_nbs_wfga_zscore2value(z, gest_days, sex)

gigs_ig_nbs_lfga_zscore2value(z, gest_days, sex)

gigs_ig_nbs_hcfga_zscore2value(z, gest_days, sex)

gigs_ig_nbs_wlrfga_zscore2value(z, gest_days, sex)

gigs_ig_nbs_fmfga_zscore2value(z, gest_days, sex)

gigs_ig_nbs_bfpfga_zscore2value(z, gest_days, sex)

gigs_ig_nbs_ffmfga_zscore2value(z, gest_days, sex)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Those functions are generated by the `%gigs_ig_nbs_acronym()` macro.

### See also

The function internally utilizes the `gigs_ig_nbs_centile2value` function 
and transforms `z` value to a centile value with `CDF('GAUSS', z, 0, 1)` function.


### References

Villar J, Cheikh Ismail L, Victora CG, Ohuma EO, Bertino E, Altman DG, et al.
**International standards for newborn weight, length, and head circumference
by gestational age and sex: the Newborn Cross-Sectional Study of the
INTERGROWTH-21st Project.** *Lancet* 2014, **384(9946):857-68.**
doi: [10.1016/S0140-6736(14)60932-6](https://dx.doi.org/10.1016/S0140-6736(14)60932-6)

Villar J, Giuliani F, Fenton TR, Ohuma EO, Ismail LC, Kennedy SH et al.
**INTERGROWTH-21st very preterm size at birth reference charts.** *Lancet*
2016, **387(10021):844-45.**
doi: [10.1016/S0140-6736(16)00384-6](https://dx.doi.org/10.1016/S0140-6736(16)00384-6)

Villar J, Puglia FA, Fenton TR, Ismal LC, Staines-Urias E, Giuliani F, et al.
**Body composition at birth and its relationship with neonatal anthropometric
ratios: the newborn body composition study of the INTERGROWTH-21st project.**
*Pediatric Research* 2017, **82:305-316.**
doi: [10.1038/pr.2017.52](https://dx.doi.org/10.1038/pr.2017.52)

---

  
---
 
## `%gigs_ig_fet_acronym()` macro <a name="gigsigfetacronym-macro-74"></a> ######

The macro produces: 

- `gigs_ig_fet_<acronym>_value2centile`,
 
- `gigs_ig_fet_<acronym>_value2zscore`,

- `gigs_ig_fet_<acronym>_zscore2value`, and

- `gigs_ig_fet_<acronym>_centile2value`

functions group for the following list of acronyms: 

`hcfga bpdfga acfga flfga ofdfga hefwfga efwfga sfhfga crlfga gafcrl gwgfga` 
`pifga rifga sdrfga tcdfga gaftcd poffga sffga avfga pvfga cmfga` 

Requires the `macroArray` package to work.

### See also

Details about how to use those functions can be found in 
the documentation of the following functions:
- `gigs_ig_fet_value2centile`,
- `gigs_ig_fet_value2zscore`,
- `gigs_ig_fet_zscore2value`, and
- `gigs_ig_fet_centile2value`.

### Synatax

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~sas
%macro gigs_ig_fet_acronym();
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

---

  
---
 
## `%gigs_ig_nbs_acronym()` macro <a name="gigsignbsacronym-macro-75"></a> ######

The macro produces: 

- `gigs_ig_nbs_<acronym>_value2centile`,
 
- `gigs_ig_nbs_<acronym>_value2zscore`,

- `gigs_ig_nbs_<acronym>_zscore2value`, and

- `gigs_ig_nbs_<acronym>_centile2value`

functions group for the following list of acronyms: 

`wfga lfga hcfga wlrfga fmfga bfpfga ffmfga`

Requires the `macroArray` package to work.

### See also

Details about how to use those functions can be found in 
the documentation of the following functions:
- `gigs_ig_nbs_value2centile`,
- `gigs_ig_nbs_value2zscore`,
- `gigs_ig_nbs_zscore2value`, and
- `gigs_ig_nbs_centile2value`.

### Synatax

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~sas
%macro gigs_ig_nbs_acronym();
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

---

  
---
 
## `%gigs_ig_png_acronym()` macro <a name="gigsigpngacronym-macro-76"></a> ######

The macro produces: 

- `gigs_ig_png_<acronym>_value2centile`,
 
- `gigs_ig_png_<acronym>_value2zscore`,

- `gigs_ig_png_<acronym>_zscore2value`, and

- `gigs_ig_png_<acronym>_centile2value`

functions group for the following list of acronyms: 

`wfa lfa hcfa wfl`

Requires the `macroArray` package to work.

### See also

Details about how to use those functions can be found in 
the documentation of the following functions:
- `gigs_ig_png_value2centile`,
- `gigs_ig_png_value2zscore`,
- `gigs_ig_png_zscore2value`, and
- `gigs_ig_png_centile2value`.

### Synatax

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~sas
%macro gigs_ig_png_acronym();
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

---

  
---
 
## `%gigs_who_gs_acronym()` macro <a name="gigswhogsacronym-macro-77"></a> ######

The macro produces: 

- `gigs_who_gs_<acronym>_value2centile`,
 
- `gigs_who_gs_<acronym>_value2zscore`,

- `gigs_who_gs_<acronym>_zscore2value`, and

- `gigs_who_gs_<acronym>_centile2value`

functions group for the following list of acronyms: 

`wfa bfa lhfa wfl wfh hcfa acfa ssfa tsfa`

Requires the `macroArray` package to work.

### See also

Details about how to use those functions can be found in 
the documentation of the following functions:
- `gigs_who_gs_<acronym>_value2centile`,
- `gigs_who_gs_<acronym>_value2zscore`,
- `gigs_who_gs_<acronym>_zscore2value`, and
- `gigs_who_gs_<acronym>_centile2value`.

### Synatax

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~sas
%macro gigs_who_gs_acronym();
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

---

  
---
 
## `gigs_acronym_functions` exec <a name="gigsacronymfunctions-exec-78"></a> ######

### Description

The exec code purpose is to generate
all the "acronym functions" in the package.

The following macros are executed:

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~sas
%gigs_ig_fet_acronym();
%gigs_ig_nbs_acronym();
%gigs_ig_png_acronym();
%gigs_who_gs_acronym();
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

See their documentation for the details.

If this exec code is disabled from
execution `gigs` will **not function**
correctly.

### Note

Temporary global macro variables:
`__acronym1` to `__acronymN`,
`__variableX1` to `__variableXN`,
`__variableY1` to `__variableYN`
and
`%__acronym()`, `%__variableX()`, `%__variableY()` 
macros are generated.
All are deleted when the code finishes.

---

  
---
 
## `gigs_acronym_functions` clean <a name="gigsacronymfunctions-clean-79"></a> ######

### Description

Code cleans up after "acronym" macros.

The `macroArray` package is required 
to run this cleaning code.

### Note

Temporary global macro variables:
`__acronym1` to `__acronymN` and
`%__acronym()` macro are generated.
All are deleted when the code finishes.

---

  
---
 
## `gigs_categorise_sfga()` function <a name="gigscategorisesfga-functions-84"></a> ######

Categorise birthweight centiles into size-for-gestational age strata

### Syntax

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~sas
  function gigs_categorise_sfga(
    p
  , severe /*=0 FALSE*/
  ) $ 8 ;
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

---


### Arguments 

1. `p` - Numeric variable with birth weight centiles from the
         INTERGROWTH-21<sup>st</sup> Newborn Size standard.

2. `severe` - A logical value specifying whether to categorise SGA
    values are below the third centile as `"SGA(<3)"`.

### Returns

A character variable of length 8 containing size-for-GA classifications. 
If `severe` is `0`, possible values are: `"SGA"`, `"AGA"`, and `"LGA"`. 
If `severe` is `1`, list of levels is extended by `"SGA(<3)"` value.

### Usage Note

[**Important.**] 
The function assumes that values provided are taken from a newborn, i.e.,
**at birth**. The function *does not check* age since birth! If your 
measurements were taken postnatally the returned values may be undesirable.
  
### References ###

WHO. **Physical status: the use and interpretation of anthropometry. Report
of a WHO Expert Committee.** *World Health Organisation Technical Report
Series 1995,* **854: 1–452**

Royal College of Obstetricians and Gynaecologists. **The Investigation and
Management of the Small-for-Gestational-Age Fetus: Green-top Guideline No.
31.** *Technical report, Royal College of Obstetricians and Gynaecologists,
London, 2013.*

---

### Examples

1. By default, does not differentiate between `p < 0.03` and `p < 0.10`
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~sas
data have;
  input p;
cards4;
0.02
0.11
0.25
0.5
0.75
0.99
;;;;
run;

data get;
  set have;
  
  sfga = gigs_categorise_sfga(
    p,
    0
  );
run;
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

2. With severe = 1, highlights `p < 0.03`
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~sas
data get;
  set have;
  
  severe = 1;
  
  sfgaSevere = gigs_categorise_sfga(
    p,
    severe
  );
run;
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


  
---
 
## `gigs_compute_sfga()` function <a name="gigscomputesfga-functions-85"></a> ######

Compute size-for-gestational age categories using the INTERGROWTH-21st
weight-for-gestational age standard

### Syntax

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~sas
  function gigs_compute_sfga(
    weight_kg
  , gest_days
  , sex $
  , severe /*=0 FALSE*/
  ) $ 8 ;
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

---


### Arguments 

1. `weight_kg` - Numeric variable with weight value(s) in kg.

2. `gest_days` - Numeric variable with gestational
    age(s) at birth in days between `168` and `300`. By default, gigs will
    produce missing value(`.`) for out-of-bounds elements in `gest_days`.

3. `sex` - Character variable with sex, either "M" (male) or "F" (female). 
    This argument is not case-sensitive. 

4. `severe` - A logical value specifying whether to categorise SGA
    values are below the third centile as `"SGA(<3)"`.

### Returns

A character variable of length 8 containing size-for-GA classifications. 
If `severe` is `0`, possible values are: `"SGA"`, `"AGA"`, and `"LGA"`. 
If `severe` is `1`, list of levels is extended by `"SGA(<3)"` value.

### Usage Note

[**Important.**] 
The function assumes that values provided are taken from a newborn, i.e.,
**at birth**. The function *does not check* age since birth! If your 
measurements were taken postnatally the returned values may be undesirable.

### See also 

See the [`gigs_ig_nbs_value2centile()`] function, which this function 
calls to get centiles for each observation.

### References ###

WHO. **Physical status: the use and interpretation of anthropometry. Report
of a WHO Expert Committee.** *World Health Organisation Technical Report
Series 1995,* **854: 1–452**

Royal College of Obstetricians and Gynaecologists. **The Investigation and
Management of the Small-for-Gestational-Age Fetus: Green-top Guideline No.
31.** *Technical report, Royal College of Obstetricians and Gynaecologists,
London, 2013.*

---

### Examples

1. By default, does not differentiate between `p < 0.03` and `p < 0.10`
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~sas
data have;
  input weight_kg gest_days sex :$1.;
cards4;
2.2 267 M
3.3 268 F
4.4 269 M
;;;;
run;

data get;
  set have;
  
  sfga = gigs_compute_sfga(
    weight_kg,
    gest_days,
    sex,
    0
  );
run;
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

2. With severe = 1, highlights `p < 0.03`
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~sas
data get;
  set have;
  
  severe = 1;
  
  sfgaSevere = gigs_compute_sfga(
    weight_kg,
    gest_days,
    sex,
    severe
  );
run;
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


  
---
 
## `gigs_categorise_headsize()` function <a name="gigscategoriseheadsize-functions-86"></a> ######

Categorise head circumference-for-age z-scores into head circumference-for-age
strata

### Syntax

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~sas
function gigs_categorise_headsize(
  hcaz
) $ 20;
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

---


### Arguments ###

1. `hcaz` - Numeric variable containing
    head circumference-for-age z-scores (HCAZs).
  
### Returns

A character variable of length 20 head circumference-for-age classifications. 
Its levels are `"microcephaly_severe"`, `"microcephaly"`, `"normal_headcirc"`,
`"macrocephaly"`, and `"macrocephaly_severe"`. 
  
### References

Victora CG, Schuler-Faccini L, Matijasevich A, Ribeiro E, Pessoa A,
Barros FC. **Microcephaly in Brazil: how to interpret reported numbers?**
*The Lancet* 2016, *387(10019):621-624*
doi: [10.1016/S0140-6736(16)00273-7](https://dx.doi.org/10.1016/S0140-6736(16)00273-7)

Accogli A, Geraldo AF, Piccolo G, Riva A, Scala M, Balagura G, et al.
**Diagnostic Approach to Macrocephaly in Children**. *Frontiers in
Paediatrics* 2022, *9:794069* 
doi: [10.3389/fped.2021.794069](https://dx.doi.org/10.3389/fped.2021.794069)

---

### Examples

1. The first observation uses the INTERGROWTH-21st Postnatal Growth 
standards; the next two use the WHO Child Growth Standards.
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~sas
data have;
  input hcaz;
cards4;
-6.5
-3.5
-2.5
0
2.5
3.5
;;;;
run;

data get;
  set have;
  
  headsize = gigs_categorise_headsize(
    hcaz
  );
run;
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

---

  
---
 
## `gigs_categorise_stunting()` function <a name="gigscategorisestunting-functions-87"></a> ######

Categorise length/height-for-age z-scores into stunting strata

### Syntax

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~sas
function gigs_categorise_stunting(
  lhaz
, outliers /*=0 FALSE*/
) $ 16;
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

---


### Arguments ###

1. `lhza` - Numeric variable containing
    length/height-for-age z-scores (LHAZs).

2. `outliers` - A single `TRUE` or `FALSE` value specifying whether
    implausible z-score value thresholds should be applied.
  
### Returns

A character variable of length 16 containing stunting classifications. 
Its levels are `"stunting_severe"`, `"stunting"`, and `"not_stunting"`. 
If `outliers` is `1` the list is extended by additional `"outlier"` value.
  
### Note 

This function assumes that your measurements were taken 
according to the WHO guidelines, which stipulate
that recumbent length should not be measured after 730 days. 
Implausible z-score bounds are sourced from the referenced 
WHO report, and classification cut-offs from the DHS manual.

### References

**'Implausible z-score values'** *in* World Health Organization (ed.)
*Recommendations for data collection, analysis and reporting on
anthropometric indicators in children under 5 years old*. Geneva: World
Health Organization and the United Nations Children's Fund UNICEF, (2019).
pp. 64-65.

**'Percentage of children stunted, wasted, and underweight, and mean z-scores
for stunting, wasting and underweight'** *in* *Guide to DHS Statistics DHS-7*
Rockville, Maryland, USA: ICF (2020). pp. 431-435.
<https://dhsprogram.com/data/Guide-to-DHS-Statistics/Nutritional_Status.htm>



### Examples

1. The first observation uses the INTERGROWTH-21st Postnatal Growth 
standards; the next two use the WHO Child Growth Standards.
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~sas
data have;
  input lhaz;
cards4;
-6.5
-5
-3
0
3
5
6.5
;;;;
run;

data get;
  set have;
  
  stunting = gigs_categorise_stunting(
    lhaz,
    0
  );
run;
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

2. And with outlier flagging:
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~sas
data get;
  set have;
  
  outliers = 1;
  
  stuntingOut = gigs_categorise_stunting(
    lhaz,
    outliers
  );
run;
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

---

  
---
 
## `gigs_categorise_svn()` function <a name="gigscategorisesvn-functions-88"></a> ######

Categorise birthweight centiles and gestational ages into small vulnerable
newborn strata

### Syntax

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~sas
function gigs_categorise_svn(
  p
, gest_days) 
$ 16; 
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

---


### Arguments ###

1. `p` - Numeric variable with birth weight centiles from the
         INTERGROWTH-21<sup>st</sup> Newborn Size standard.

2. `gest_days` - Numeric variable with gestational
    age(s) at birth in days between `168` and `300`. By default, gigs will
    produce missing value(`.`) for out-of-bounds elements in `gest_days`.

### Returns

A character variable of length 16 containing small vulnerable 
newborn classifications. Its levels are: `"Preterm SGA"`, 
`"Preterm AGA"`, `"Preterm LGA"`, `"Term SGA"`, `"Term AGA"`, and
`"Term LGA"`.

### Usage Note

[**Important.**] 
The function assumes that values provided are taken from a newborn, i.e.,
**at birth**. The function *does not check* age since birth! If your 
measurements were taken postnatally the returned values may be undesirable.

### See also 

See the `gigs_category_sfga()` function, which this function 
calls to get classifications for each observation.

### References
Lawn JE, Ohuma EO, Bradley E, Idueta LS, Hazel E, Okwaraji YB et al.
**Small babies, big risks: global estimates of prevalence and mortality for
vulnerable newborns to accelerate change and improve counting.** *The Lancet*
2023, *401(10389):1707-1719.*
doi: [10.1016/S0140-6736(23)00522-6](https://dx.doi.org/10.1016/S0140-6736(23)00522-6)

---

### Examples

1. Basic classification:
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~sas
data have;
  input p gest_days;
cards4;
0.02 235
0.11 257
0.25 235
0.5  275
0.75 235
0.99 295
;;;;
run;

data get;
  set have;
  
  svn = gigs_categorise_svn(
    p,
    gest_days
  );
run;
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

---

  
---
 
## `gigs_categorise_wasting()` function <a name="gigscategorisewasting-functions-89"></a> ######

Categorise weight-for-length/height z-scores into wasting strata

Categorise wasting (low weight-for-length/height) using the
INTERGROWTH-21<sup>st</sup> weight-for-length or WHO Child Growth standards,
specifically either the weight-for-length or weight-for-height standard
depending on the age of the child. Severe wasting is <-3SD relative to the
mean expected weight, whereas moderate wasting is -2SD from the mean.

### Syntax

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~sas
function gigs_categorise_wasting(
  wlz
, outliers /*=0 FALSE*/
) $ 20;
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

---


### Arguments 

1. `wlz` - Numeric variable with weight value(s) in kg.

2. `outliers` - A single `TRUE` or `FALSE` value specifying whether
    implausible z-score value thresholds should be applied.

### Returns 

A character variable of length 20 containing wasting classifications. 
Its levels are `"wasting_severe"`, `"wasting"`, `"not_wasting"`, and `"overweight"`.
If `outliers` is `1` the list is extended by additional `"outlier"` value.  
  
### Note 

Implausible z-score bounds are sourced from the referenced WHO report, 
and classification cut-offs from the DHS manual.
  
### References

**'Implausible z-score values'** *in* World Health Organization (ed.)
*Recommendations for data collection, analysis and reporting on
anthropometric indicators in children under 5 years old*. Geneva: World
Health Organization and the United Nations Children's Fund UNICEF, (2019).
pp. 64-65.

**'Percentage of children stunted, wasted, and underweight, and mean z-scores
for stunting, wasting and underweight'** *in* *Guide to DHS Statistics DHS-7*
Rockville, Maryland, USA: ICF (2020). pp. 431-435.
<https://dhsprogram.com/data/Guide-to-DHS-Statistics/Nutritional_Status.htm>


### Examples


1. Returns factor with stunting classifications
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~sas
data have;
  input wlz;
CARDS4;
-5.5 
-3 
0 
3 
5.5
;;;;
run;

data get;
  set have;
  
  wasting = gigs_categorise_wasting(
    wlz,
    0
  );
run;
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

2. Outliers can be flagged if `outliers` set to 1
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~sas
data get;
  set have;
  
  outliers = 1;
  
  wastingOut = gigs_categorise_wasting(
    wlz,
    outliers
  );
run;
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

---

  
---
 
## `gigs_categorise_wfa()` function <a name="gigscategorisewfa-functions-90"></a> ######

Categorise weight-for-age z-scores into weight-for-age strata

### Syntax

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~sas
function gigs_categorise_wfa(
  waz
, outliers /*=0 FALSE*/
) $ 20;
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

---


### Arguments 

1. `waz` - Numeric variable containing
    weight-for-age z-scores (WAZs).

2. `outliers` - A single `TRUE` or `FALSE` value specifying whether
    implausible z-score value thresholds should be applied.
    
### Returns 

A character variable of length 20 containing weight-for-age classifications. 
Its levels are `"underweight_severe"`, `"underweight"`, `"normal"`, and `"overweight"`.
If `outliers` is `1` the list is extended by additional `"outlier"` value.  

### Note 

Implausible z-score bounds are sourced from the referenced WHO report, 
and classification cut-offs from the DHS manual.

### References

**'Implausible z-score values'** *in* World Health Organization (ed.)
*Recommendations for data collection, analysis and reporting on
anthropometric indicators in children under 5 years old*. Geneva: World
Health Organization and the United Nations Children's Fund UNICEF, (2019).
pp. 64-65.

**'Percentage of children stunted, wasted, and underweight, and mean z-scores
for stunting, wasting and underweight'** *in* *Guide to DHS Statistics DHS-7*
Rockville, Maryland, USA: ICF (2020). pp. 431-435.
<https://dhsprogram.com/data/Guide-to-DHS-Statistics/Nutritional_Status.htm>

### Examples

1. Weight-for-age classifications
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~sas
data have;
  input waz;
CARDS4;
-6.5
-3.5
-2.5
0
2.5
  3.5
;;;;
run;

data get;
  set have;
  
  wfa = gigs_categorise_wfa(
    waz,
    0
  );
  
  wfaOut = gigs_categorise_wfa(
    waz,
    1
  );
run;
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

---

  
---
 
## `gigs_compute_headsize()` function <a name="gigscomputeheadsize-functions-91"></a> ######

Get head size categories using anthropometric measurements and GIGS-recommended
growth standards

### Syntax

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~sas
function gigs_compute_headsize(
  headcirc_cm
, age_days
, gest_days
, sex $
, isBirthMeasurement
) $ 20;
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

---


### Arguments ###

1. `headcirc_cm` - Numeric variable with head
    circumference measurement(s) in cm.

2. `age_days` - Numeric variable with age in days
    for each child. Should be between `0` to `1856` days. 
    By default, gigs will produce missing value(`.`) for 
    out-of-bounds elements in `gest_days`.

3. `gest_days` - Numeric variable with gestational
    age(s) at birth in days between `168` and `300`. 
    By default, gigs will produce missing value(`.`) for 
    out-of-bounds elements in `gest_days`.

4. `sex` - Character variable with sex, either "M" (male) or "F" (female). 
    This argument is not case-sensitive. 

5. `isBirthMeasurement` - Numeric variable indicating if a measurement was taken at birth.
  
### Returns

A character variable of length 20 head circumference-for-age classifications. 
Its levels are `"microcephaly_severe"`, `"microcephaly"`, `"normal_headcirc"`,
`"macrocephaly"`, and `"macrocephaly_severe"`. 
  
### References

Victora CG, Schuler-Faccini L, Matijasevich A, Ribeiro E, Pessoa A,
Barros FC. **Microcephaly in Brazil: how to interpret reported numbers?**
*The Lancet* 2016, *387(10019):621-624*
doi: [10.1016/S0140-6736(16)00273-7](https://dx.doi.org/10.1016/S0140-6736(16)00273-7)

Accogli A, Geraldo AF, Piccolo G, Riva A, Scala M, Balagura G, et al.
**Diagnostic Approach to Macrocephaly in Children**. *Frontiers in
Paediatrics* 2022, *9:794069* 
doi: [10.3389/fped.2021.794069](https://dx.doi.org/10.3389/fped.2021.794069)

---

### Examples

1. Categorise head circumference-for-age.
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~sas
data have;
  input headcirc_cm age_days gest_days sex :$1.;
cards4;
41 357 196 M
40 375 287 M
41 250 266 F
51 250 266 F
;;;;
run;

data get;
  set have;
  
  stunting = gigs_compute_headsize(
    headcirc_cm,
    age_days,
    gest_days,
    sex,
    0
  );
run;
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

---

  
---
 
## `gigs_compute_stunting()` function <a name="gigscomputestunting-functions-92"></a> ######

Get stunting categories using anthropometric measurements and GIGS-recommended
growth standards

### Syntax

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~sas
function gigs_compute_stunting(
  lenht_cm
, age_days
, gest_days
, sex $
, outliers /*=0 FALSE*/
, isBirthMeasurement
) $ 16;
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

---


### Arguments ###

1. `lenht_cm` - Numeric variable with length/height
    measurement(s) in cm.

2. `age_days` - Numeric variable with age in days
    for each child. Should be between `0` to `1856` days. 
    By default, gigs will produce missing value(`.`) for 
    out-of-bounds elements in `gest_days`.

3. `gest_days` - Numeric variable with gestational
    age(s) at birth in days between `168` and `300`. 
    By default, gigs will produce missing value(`.`) for 
    out-of-bounds elements in `gest_days`.

4. `sex` - Character variable with sex, either "M" (male) or "F" (female). 
    This argument is not case-sensitive. 

5. `outliers` - A single `TRUE` or `FALSE` value specifying whether
    implausible z-score value thresholds should be applied.
  
6. `isBirthMeasurement` - Numeric variable indicating if a measurement was taken at birth.
  
### Returns

A character variable of length 16 containing stunting classifications. 
Its levels are `"stunting_severe"`, `"stunting"`, and `"not_stunting"`. 
If `outliers` is `1` the list is extended by additional `"outlier"` value.
  
### Note 

This function assumes that your measurements were taken 
according to the WHO guidelines, which stipulate
that recumbent length should not be measured after 730 days. 
Implausible z-score bounds are sourced from the referenced 
WHO report, and classification cut-offs from the DHS manual.

### References

**'Implausible z-score values'** *in* World Health Organization (ed.)
*Recommendations for data collection, analysis and reporting on
anthropometric indicators in children under 5 years old*. Geneva: World
Health Organization and the United Nations Children's Fund UNICEF, (2019).
pp. 64-65.

**'Percentage of children stunted, wasted, and underweight, and mean z-scores
for stunting, wasting and underweight'** *in* *Guide to DHS Statistics DHS-7*
Rockville, Maryland, USA: ICF (2020). pp. 431-435.
<https://dhsprogram.com/data/Guide-to-DHS-Statistics/Nutritional_Status.htm>



### Examples

1. The first observation uses the INTERGROWTH-21st Postnatal Growth 
standards; the next two use the WHO Child Growth Standards.
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~sas
data have;
  input lenht_cm age_days gest_days sex :$1.;
cards4;
52.2 357 196 M
75.4 375 287 M
63.1 250 266 F
;;;;
run;

data get;
  set have;
  
  stunting = gigs_compute_stunting(
    lenht_cm,
    age_days,
    gest_days,
    sex,
    0,
    0
  );
run;
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

2. And with outlier flagging:
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~sas
data get;
  set have;
  
  outliers = 1;
  
  stuntingOut = gigs_compute_stunting(
    lenht_cm,
    age_days,
    gest_days,
    sex,
    outliers,
    0
  );
run;
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

---

  
---
 
## `gigs_compute_svn()` function <a name="gigscomputesvn-functions-93"></a> ######

Get small vulnerable newborn categories using anthropometric measurements and
GIGS-recommended growth standards

### Syntax

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~sas
function gigs_compute_svn(
  weight_kg
, gest_days
, sex $) $ 16; 
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

---


### Arguments ###

1. `weight_kg` - Numeric variable with weight value(s) in kg.

2. `gest_days` - Numeric variable with gestational
    age(s) at birth in days between `168` and `300`. By default, gigs will
    produce missing value(`.`) for out-of-bounds elements in `gest_days`.

3. `sex` - Character variable with sex, either "M" (male) or "F" (female). 
    This argument is not case-sensitive. 

### Returns

A character variable of length 16 containing small vulnerable 
newborn classifications. Its levels are: `"Preterm SGA"`, 
`"Preterm AGA"`, `"Preterm LGA"`, `"Term SGA"`, `"Term AGA"`, and
`"Term LGA"`.

### Usage Note

[**Important.**] 
The function assumes that values provided are taken from a newborn, i.e.,
**at birth**. The function *does not check* age since birth! If your 
measurements were taken postnatally the returned values may be undesirable.

### See also 

See the `gigs_compute_sfga()` function, which this function 
calls to get classifications for each observation.

### References
Lawn JE, Ohuma EO, Bradley E, Idueta LS, Hazel E, Okwaraji YB et al.
**Small babies, big risks: global estimates of prevalence and mortality for
vulnerable newborns to accelerate change and improve counting.** *The Lancet*
2023, *401(10389):1707-1719.*
doi: [10.1016/S0140-6736(23)00522-6](https://dx.doi.org/10.1016/S0140-6736(23)00522-6)

---

### Examples

1. Basic classification:
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~sas
data have;
  input weight_kg gest_days sex :$1.;
cards4;
1.5 235 F
2.6 257 M
2.6 275 F
3.5 295 M
;;;;
run;

data get;
  set have;
  
  svn = gigs_compute_svn(
    weight_kg,
    gest_days,
    sex
  );
run;
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

---

  
---
 
## `gigs_compute_wasting()` function <a name="gigscomputewasting-functions-94"></a> ######

Get wasting categories using anthropometric measurements and GIGS-recommended
growth standards

### Syntax

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~sas
function gigs_compute_wasting(
  weight_kg
, lenht_cm
, age_days
, gest_days
, sex $
, outliers /*=0 FALSE*/
, isBirthMeasurement
) $ 20;
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

---


### Arguments 

1. `weight_kg` - Numeric variable with weight value(s) in kg.

2. `lenht_cm` - Numeric variable with length/height
    measurement(s) in cm.

3. `age_days` - Numeric variable with age in days
    for each child. Should be between `0` to `1856` days. 
    By default, gigs will produce missing value(`.`) for 
    out-of-bounds elements in `gest_days`.

4. `gest_days` - Numeric variable with gestational
    age(s) at birth in days between `168` and `300`. 
    By default, gigs will produce missing value(`.`) for 
    out-of-bounds elements in `gest_days`.


5. `sex` - Character variable with sex, either "M" (male) or "F" (female). 
    This argument is not case-sensitive. 

6. `outliers` - A single `TRUE` or `FALSE` value specifying whether
    implausible z-score value thresholds should be applied.

7. `isBirthMeasurement` - Numeric variable indicating if a measurement was taken at birth.

### Returns 

A character variable of length 20 containing wasting classifications. 
Its levels are `"wasting_severe"`, `"wasting"`, `"not_wasting"`, and `"overweight"`.
If `outliers` is `1` the list is extended by additional `"outlier"` value.  
  
  
### Note 

Implausible z-score bounds are sourced from the referenced WHO report, 
and classification cut-offs from the DHS manual.
  
### References

**'Implausible z-score values'** *in* World Health Organization (ed.)
*Recommendations for data collection, analysis and reporting on
anthropometric indicators in children under 5 years old*. Geneva: World
Health Organization and the United Nations Children's Fund UNICEF, (2019).
pp. 64-65.

**'Percentage of children stunted, wasted, and underweight, and mean z-scores
for stunting, wasting and underweight'** *in* *Guide to DHS Statistics DHS-7*
Rockville, Maryland, USA: ICF (2020). pp. 431-435.
<https://dhsprogram.com/data/Guide-to-DHS-Statistics/Nutritional_Status.htm>


### Examples


1. Returns factor with wasting classifications
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~sas
data have;
  input weight_kg lenht_cm gest_days age_days sex :$1.;
CARDS4;
5.75 67.7 251 251 F
2.18 46.6 197 197 M
3.00 50.0 225 225 F
6.75 80.1 243 243 M
;;;;
run;

data get;
  set have;
  
  wasting = gigs_compute_wasting(
    weight_kg,
    lenht_cm,
    age_days,
    gest_days,
    sex,
    0,
    0
  );
run;
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

2. Outliers can be flagged if `outliers` set to 1
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~sas
data get;
  set have;
  
  outliers = 1;
  
  wastingOut = gigs_compute_wasting(
    weight_kg,
    lenht_cm,
    age_days,
    gest_days,
    sex,
    outliers,
    0
  );
run;
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

---

  
---
 
## `gigs_compute_wfa()` function <a name="gigscomputewfa-functions-95"></a> ######

Get weight-for-age categories using anthropometric measurements and
GIGS-recommended growth standards

### Syntax

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~sas
function gigs_compute_wfa(
  weight_kg
, age_days
, gest_days
, sex $
, outliers /*=0 FALSE*/
, isBirthMeasurement
) $ 20;
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

---


### Arguments 

1. `weight_kg` - Numeric variable with weight value(s) in kg.

2. `age_days` - Numeric variable with age in days
    for each child. Should be between `0` to `1856` days. 
    By default, gigs will produce missing value(`.`) for 
    out-of-bounds elements in `gest_days`.

3. `gest_days` - Numeric variable with gestational
    age(s) at birth in days between `168` and `300`. 
    By default, gigs will produce missing value(`.`) for 
    out-of-bounds elements in `gest_days`.


4. `sex` - Character variable with sex, either "M" (male) or "F" (female). 
    This argument is not case-sensitive. 

5. `outliers` - A single `TRUE` or `FALSE` value specifying whether
    implausible z-score value thresholds should be applied.

6. `isBirthMeasurement` - Numeric variable indicating if a measurement was taken at birth.

### Returns 

A character variable of length 20 containing weight-for-age classifications. 
Its levels are `"underweight_severe"`, `"underweight"`, `"normal"`, and `"overweight"`.
If `outliers` is `1` the list is extended by additional `"outlier"` value.  

### Note 

Implausible z-score bounds are sourced from the referenced WHO report, 
and classification cut-offs from the DHS manual.

### References

**'Implausible z-score values'** *in* World Health Organization (ed.)
*Recommendations for data collection, analysis and reporting on
anthropometric indicators in children under 5 years old*. Geneva: World
Health Organization and the United Nations Children's Fund UNICEF, (2019).
pp. 64-65.

**'Percentage of children stunted, wasted, and underweight, and mean z-scores
for stunting, wasting and underweight'** *in* *Guide to DHS Statistics DHS-7*
Rockville, Maryland, USA: ICF (2020). pp. 431-435.
<https://dhsprogram.com/data/Guide-to-DHS-Statistics/Nutritional_Status.htm>

### Examples

1. Weight-for-age classifications
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~sas
data have;
  input weight_kg gest_days age_days sex :$1.;
CARDS4;
7.2  401 189 F
4.5  185 252 M
9.1  101 280 F
24.0 607 287 M
;;;;
run;

data get;
  set have;
  
  wfa = gigs_compute_wfa(
    weight_kg,
    age_days,
    gest_days,
    sex,
    0,
    0
  );
  
  wfaOut = gigs_compute_wfa(
    weight_kg,
    age_days,
    gest_days,
    sex,
    1,
    0
  );
run;
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

---

  
---
 
## `gigs_classify_headsize()` function <a name="gigsclassifyheadsize-functions-96"></a> ######

Classify head size using GIGS-recommended standards

### Syntax

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~sas
subroutine gigs_classify_headsize(
  zScore
, headsize $
, headcirc_cm
, age_days
, gest_days
, sex $
, isBirthMeasurement
);
  OUTARGS zScore, headsize;
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

---


### Arguments ###

1. `zScore` - Numeric variable, of type `OUTARGS`, with z-score.

2. `headsize` - Character variable of length 20, of type `OUTARGS`, with classification category.

3. `headcirc_cm` - Numeric variable with head
    circumference measurement(s) in cm.

4. `age_days` - Numeric variable with age in days
    for each child. Should be between `0` to `1856` days. 
    By default, gigs will produce missing value(`.`) for 
    out-of-bounds elements in `gest_days`.

5. `gest_days` - Numeric variable with gestational
    age(s) at birth in days between `168` and `300`. 
    By default, gigs will produce missing value(`.`) for 
    out-of-bounds elements in `gest_days`.

6. `sex` - Character variable with sex, either "M" (male) or "F" (female). 
    This argument is not case-sensitive. 

7. `isBirthMeasurement` - Numeric variable indicating if a measurement was taken at birth.

### Returns

Variable `category` contains head circumference classifications. 
Levels are `"microcephaly_severe"`, `"microcephaly"`, `"normal_headcirc"`,
`"macrocephaly"`, and `"macrocephaly_severe"`.
  
### References

Victora CG, Schuler-Faccini L, Matijasevich A, Ribeiro E, Pessoa A,
Barros FC. **Microcephaly in Brazil: how to interpret reported numbers?**
*The Lancet* 2016, *387(10019):621-624*
doi: [10.1016/S0140-6736(16)00273-7](https://dx.doi.org/10.1016/S0140-6736(16)00273-7)

Accogli A, Geraldo AF, Piccolo G, Riva A, Scala M, Balagura G, et al.
**Diagnostic Approach to Macrocephaly in Children**. *Frontiers in
Paediatrics* 2022, *9:794069* 
doi: [10.3389/fped.2021.794069](https://dx.doi.org/10.3389/fped.2021.794069)

---

### Examples

1. The first observation uses the INTERGROWTH-21st Postnatal Growth 
standards; the next two use the WHO Child Growth Standards.
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~sas
data have;
  input headcirc_cm age_days gest_days sex :$1.;
cards4;
41 357 196 M
40 375 287 M
41 250 266 F
51 250 266 F
;;;;
run;


data get;
  set have;
  
  length zscore 8 headsize $ 20;
  call missing(zscore, headsize);
  
  call gigs_classify_headsize(
    zscore, 
    headsize,
    headcirc_cm,
    age_days,
    gest_days,
    sex,
    0
  );
run;
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

---

  
---
 
## `gigs_classify_sfga()` function <a name="gigsclassifysfga-functions-97"></a> ######

Classify size-for-gestational age using the INTERGROWTH-21<sup>st</sup> Newborn
Size standard for weight-for-gestational age

### Syntax

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~sas
subroutine gigs_classify_sfga(
  centile
, sfga $
, sfgaSev $
, weight_kg
, gest_days
, sex $
);
  OUTARGS centile, sfga, sfgaSev;
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

---


### Arguments 

1. `centile` - Numeric variable, of type `OUTARGS`, with centile.

2. `sfga` - Character variable of length 8, of type `OUTARGS`, with classification category.

3. `sfgaSev` - Character variable of length 8, of type `OUTARGS`, with classification category
    taking severity into account.

4. `weight_kg` - Numeric variable with weight value(s) in kg.

5. `gest_days` - Numeric variable with gestational
    age(s) at birth in days between `168` and `300`. By default, gigs will
    produce missing value(`.`) for out-of-bounds elements in `gest_days`.

6. `sex` - Character variable with sex, either "M" (male) or "F" (female). 
    This argument is not case-sensitive. 

### Returns

Variables `sfga` and `sfgaSev` contain  size-for-GA classifications. 
Possible values are: `"SGA"`, `"AGA"`, and `"LGA"`. 
For `sfgaSev` list of levels is extended by `"SGA(<3)"` value.
  
### Usage Note

[**Important.**] 
The function assumes that values provided are taken from a newborn, i.e.,
**at birth**. The function *does not check* age since birth! If your 
measurements were taken postnatally the returned values may be undesirable.
  
### See also 

See the `gigs_ig_nbs_value2centile()` function, which this function 
calls to get centiles for each observation.

### References ###

WHO. **Physical status: the use and interpretation of anthropometry. Report
of a WHO Expert Committee.** *World Health Organisation Technical Report
Series 1995,* **854: 1–452**

Royal College of Obstetricians and Gynaecologists. **The Investigation and
Management of the Small-for-Gestational-Age Fetus: Green-top Guideline No.
31.** *Technical report, Royal College of Obstetricians and Gynaecologists,
London, 2013.*

---

### Examples

1. By default, does not differentiate between `p < 0.03` and `p < 0.10`
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~sas
data have;
  input weight_kg gest_days sex :$1.;
cards4;
2.2 267 M
3.3 268 F
4.4 269 M
;;;;
run;

data get;
  set have;

  length centile 8 sfga sfgaSev $ 20;
  call missing(centile, sfga, sfgaSev);
  
  call gigs_classify_sfga(
    centile, 
    sfga, 
    sfgaSev,
    weight_kg,
    gest_days,
    sex
  );
run;
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

---

  
---
 
## `gigs_classify_stunting()` function <a name="gigsclassifystunting-functions-98"></a> ######

Classify stunting using GIGS-recommended standards

### Syntax

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~sas
subroutine gigs_classify_stunting(
  zScore
, stunting $
, stuntingOut $
, lenht_cm
, age_days
, gest_days
, sex $
, isBirthMeasurement
);
  OUTARGS zScore, stunting, stuntingOut;
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

---


### Arguments ###

1. `zScore` - Numeric variable, of type `OUTARGS`, with z-score.

2. `stunting` - Character variable of length 20, of type `OUTARGS`, with classification category.

3. `stuntingOut` - Character variable of length 20, of type `OUTARGS`, with classification category
    taking outliers into account.

4. `lenht_cm` - Numeric variable with length/height
    measurement(s) in cm.

5. `age_days` - Numeric variable with age in days
    for each child. Should be between `0` to `1856` days. 
    By default, gigs will produce missing value(`.`) for 
    out-of-bounds elements in `gest_days`.

6. `gest_days` - Numeric variable with gestational
    age(s) at birth in days between `168` and `300`. 
    By default, gigs will produce missing value(`.`) for 
    out-of-bounds elements in `gest_days`.

7. `sex` - Character variable with sex, either "M" (male) or "F" (female). 
    This argument is not case-sensitive. 

8. `isBirthMeasurement` - Numeric variable indicating if a measurement was taken at birth.

### Returns

Variables `stunting` and `stuntingOut` contain stunting classifications. 
Levels are `"stunting_severe"`, `"stunting"`, and `"not_stunting"`. 
For `stuntingOut` the list is extended by additional `"outlier"` value.
  
### Note 

This function assumes that your measurements were taken 
according to the WHO guidelines, which stipulate
that recumbent length should not be measured after 730 days. 
Implausible z-score bounds are sourced from the referenced 
WHO report, and classification cut-offs from the DHS manual.

### References

**'Implausible z-score values'** *in* World Health Organization (ed.)
*Recommendations for data collection, analysis and reporting on
anthropometric indicators in children under 5 years old*. Geneva: World
Health Organization and the United Nations Children's Fund UNICEF, (2019).
pp. 64-65.

**'Percentage of children stunted, wasted, and underweight, and mean z-scores
for stunting, wasting and underweight'** *in* *Guide to DHS Statistics DHS-7*
Rockville, Maryland, USA: ICF (2020). pp. 431-435.
<https://dhsprogram.com/data/Guide-to-DHS-Statistics/Nutritional_Status.htm>

---

### Examples

1. The first observation uses the INTERGROWTH-21st Postnatal Growth 
standards; the next two use the WHO Child Growth Standards.
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~sas
data have;
  input lenht_cm age_days gest_days sex :$1.;
cards4;
52.2 357 196 M
75.4 375 287 M
63.1 250 266 F
;;;;
run;

data get;
  set have;
  
  length zscore 8 stunting stuntingOut $ 20;
  call missing(zscore, stunting, stuntingOut);
  
  call gigs_classify_stunting(
    zscore, 
    stunting, 
    stuntingOut,
    lenht_cm,
    age_days,
    gest_days,
    sex,
    0
  );
run;
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

---

  
---
 
## `gigs_classify_svn()` function <a name="gigsclassifysvn-functions-99"></a> ######

Classify small vulnerable newborns using the INTERGROWTH-21<sup>st</sup> Newborn
Size standard for weight-for-gestational age
### Syntax

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~sas
subroutine gigs_classify_svn(
  centile
, svn $
, weight_kg
, gest_days
, sex $
);
  OUTARGS centile, svn;
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

---


### Arguments 

1. `centile` - Numeric variable, of type `OUTARGS`, with centile.

2. `svn` - Character variable of length 16, of type `OUTARGS`, with classification category.

3. `weight_kg` - Numeric variable with weight value(s) in kg.

4. `gest_days` - Numeric variable with gestational
    age(s) at birth in days between `168` and `300`. By default, gigs will
    produce missing value(`.`) for out-of-bounds elements in `gest_days`.

5. `sex` - Character variable with sex, either "M" (male) or "F" (female). 
    This argument is not case-sensitive. 

### Returns

Variable `svn` contains size-for-GA classifications. 
Possible values are: `"SGA"`, `"AGA"`, and `"LGA"`. 
With a "Term" or "Preterm" prefix.
  
### Usage Note

[**Important.**] 
The function assumes that values provided are taken from a newborn, i.e.,
**at birth**. The function *does not check* age since birth! If your 
measurements were taken postnatally the returned values may be undesirable.
  
### See also 

See the `gigs_ig_nbs_value2centile()` function, which this function 
calls to get centiles for each observation.

### References ###

WHO. **Physical status: the use and interpretation of anthropometry. Report
of a WHO Expert Committee.** *World Health Organisation Technical Report
Series 1995,* **854: 1–452**

Royal College of Obstetricians and Gynaecologists. **The Investigation and
Management of the Small-for-Gestational-Age Fetus: Green-top Guideline No.
31.** *Technical report, Royal College of Obstetricians and Gynaecologists,
London, 2013.*

---

### Examples

1. Simple calculation.
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~sas
data have;
  input weight_kg gest_days sex :$1.;
cards4;
2.2 267 M
3.3 268 F
4.4 269 M
;;;;
run;

data get;
  set have;

  length centile 8 svn $ 20;
  call missing(centile, svn);
  
  call gigs_classify_svn(
    centile, 
    svn, 
    weight_kg,
    gest_days,
    sex
  );
run;
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

---

  
---
 
## `gigs_classify_wasting()` function <a name="gigsclassifywasting-functions-100"></a> ######

Classify wasting using GIGS-recommended standards

### Syntax

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~sas
subroutine gigs_classify_wasting(
  zScore
, wasting $
, wastingOut $
, weight_kg
, lenht_cm
, age_days
, gest_days
, sex $
, isBirthMeasurement
);
  OUTARGS zScore, wasting, wastingOut;
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

---


### Arguments 

1. `zScore` - Numeric variable, of type `OUTARGS`, with z-score.

2. `wasting` - Character variable of length 20, of type `OUTARGS`, with classification category.

3. `wastingOut` - Character variable of length 20, of type `OUTARGS`, with classification category
    taking outliers into account.

4. `weight_kg` - Numeric variable with weight value(s) in kg.

5. `lenht_cm` - Numeric variable with length/height
    measurement(s) in cm.

6. `age_days` - Numeric variable with age in days
    for each child. Should be between `0` to `1856` days. 
    By default, gigs will produce missing value(`.`) for 
    out-of-bounds elements in `gest_days`.

7. `gest_days` - Numeric variable with gestational
    age(s) at birth in days between `168` and `300`. 
    By default, gigs will produce missing value(`.`) for 
    out-of-bounds elements in `gest_days`.

8. `sex` - Character variable with sex, either "M" (male) or "F" (female). 
    This argument is not case-sensitive. 

9. `isBirthMeasurement` - Numeric variable indicating if a measurement was taken at birth.

### Returns 

Variables `wasting` and `wastingOut` contain wasting classifications. 
Levels are `"wasting_severe"`, `"wasting"`, `"not_wasting"`, and `"overweight"`.
For `wastingOut` the list is extended by additional `"outlier"` value.  
  
### Note 

Implausible z-score bounds are sourced from the referenced WHO report, 
and classification cut-offs from the DHS manual.
  
### References

**'Implausible z-score values'** *in* World Health Organization (ed.)
*Recommendations for data collection, analysis and reporting on
anthropometric indicators in children under 5 years old*. Geneva: World
Health Organization and the United Nations Children's Fund UNICEF, (2019).
pp. 64-65.

**'Percentage of children stunted, wasted, and underweight, and mean z-scores
for stunting, wasting and underweight'** *in* *Guide to DHS Statistics DHS-7*
Rockville, Maryland, USA: ICF (2020). pp. 431-435.
<https://dhsprogram.com/data/Guide-to-DHS-Statistics/Nutritional_Status.htm>

---

### Examples

1. Returns factor with stunting classifications
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~sas
data have;
  input weight_kg lenht_cm gest_days age_days sex :$1.;
CARDS4;
5.75 67.7 251 251 F
2.18 46.6 197 197 M
3.00 50.0 225 225 F
6.75 80.1 243 243 M
;;;;
run;

data get;
  set have;
  
  length zscore 8 wasting wastingOut $ 20;
  call missing(zscore, wasting, wastingOut);
  
  call gigs_classify_wasting(
    zscore, 
    wasting, 
    wastingOut,
    weight_kg,
    lenht_cm,
    age_days,
    gest_days,
    sex,
    0
  );
run;
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

---

  
---
 
## `gigs_classify_wfa()` function <a name="gigsclassifywfa-functions-101"></a> ######

Classify weight-for-age using GIGS-recommended standards

### Syntax

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~sas
subroutine gigs_classify_wfa(
  zScore
, wfa $
, wfaOut $
, weight_kg
, age_days
, gest_days
, sex $
, isBirthMeasurement
);
  OUTARGS zScore, wfa, wfaOut;
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

---


### Arguments 

1. `zScore` - Numeric variable, of type `OUTARGS`, with z-score.

2. `wfa` - Character variable of length 20, of type `OUTARGS`, with classification category.

3. `wfaOut` - Character variable of length 20, of type `OUTARGS`, with classification category
    taking outliers into account.

4. `weight_kg` - Numeric variable with weight value(s) in kg.

5. `age_days` - Numeric variable with age in days
    for each child. Should be between `0` to `1856` days. 
    By default, gigs will produce missing value(`.`) for 
    out-of-bounds elements in `gest_days`.

6. `gest_days` - Numeric variable with gestational
    age(s) at birth in days between `168` and `300`. 
    By default, gigs will produce missing value(`.`) for 
    out-of-bounds elements in `gest_days`.

7. `sex` - Character variable with sex, either "M" (male) or "F" (female). 
    This argument is not case-sensitive. 

8. `isBirthMeasurement` - Numeric variable indicating if a measurement was taken at birth.

### Returns 

Variables `wfa` and  `wfaOut` contain weight-for-age classifications. 
Levels are `"underweight_severe"`, `"underweight"`, `"normal"`, and `"overweight"`.
For `wfaOut` the list is extended by additional `"outlier"` value.  

### Note 

Implausible z-score bounds are sourced from the referenced WHO report, 
and classification cut-offs from the DHS manual.

### References

**'Implausible z-score values'** *in* World Health Organization (ed.)
*Recommendations for data collection, analysis and reporting on
anthropometric indicators in children under 5 years old*. Geneva: World
Health Organization and the United Nations Children's Fund UNICEF, (2019).
pp. 64-65.

**'Percentage of children stunted, wasted, and underweight, and mean z-scores
for stunting, wasting and underweight'** *in* *Guide to DHS Statistics DHS-7*
Rockville, Maryland, USA: ICF (2020). pp. 431-435.
<https://dhsprogram.com/data/Guide-to-DHS-Statistics/Nutritional_Status.htm>

---

### Examples

1. Weight-for-age classifications
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~sas
data have;
  input weight_kg gest_days age_days sex :$1.;
CARDS4;
7.2  401 189 F
4.5  185 252 M
9.1  101 280 F
24.0 607 287 M
;;;;
run;

data get;
  set have;
  
  length zscore 8 wfa wfaOut $ 20;
  call missing(zscore, wfa, wfaOut);
  
  call gigs_classify_wfa(
    zscore, 
    wfa, 
    wfaOut,
    weight_kg,
    age_days,
    gest_days,
    sex,
    0
  );
run;
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

---

  
---
 
## `%gigs_classify_growth()` macro <a name="gigsclassifygrowth-macro-102"></a> ######

Macro to classify multiple growth indicators at the same time using
GIGS-recommended growth standards.

This macro permits classification of multiple growth indicators (stunting,
wasting, weight-for-age, and more) at once on a given data set.

### Syntax

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~sas
%macro gigs_classify_growth(
  dataIn,
  dataOut=WORK.RESULT,
  by =,
  gest_days=gest_days,
  age_days=age_days,
  sex=sex,
  weight_kg=weight_kg,
  lenht_cm=lenht_cm,
  headcirc_cm=headcirc_cm,
  outcomes = sfga svn stunting wasting wfa headsize,
  SfgaSvnWarn=WARNING
)/minoperator;
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

---


### Arguments

1. `dataIn` - *Required*, name of a data set with vales to be evaluated,

- `dataOut` - name of a data set with result, default value is `WORK.RESULT`,

- `by` - a space separated list of variable names that give group-by processing order
         of the data set, default value is empty.

- `gest_days` - name of a numeric variable with gestational age at birth in days, default value: `gest_days`,

- `age_days` - name of a numeric variable containing age in days, default value: `age_days`,

- `sex` - name of a character variable containing sex, default value: `sex`,

- `weight_kg` - name of a numeric variable containing weight in kilograms, default value: `weight_kg`,

- `lenht_cm` - name of a numeric variable containing length/height in centimetres, default value: `lenht_cm`,
  
- `headcirc_cm` - name of a numeric variable containing head circumference in centimetres, default value: `headcirc_cm`,
  
- `outcomes` - a space-separated list of outcomes analyses to be executed on provided data, outcomes 
   available to run are: `sfga` `svn` `stunting` `wasting` `wfa` and `headsize`.

- `SfgaSvnWarn` - technical parameter indicating what type of message should be displayed for "out of range"
                  values of age days for `sfga` and `svn` outcomes. Default value: `WARNING`, can be replaced
                  with `NOTE`, `ERROR` text. See *Usage Note* below for details.

### Result

The data set created after macro execution contains the following variables 
created based on which outcomes are provided in the `outcomes` argument:

- sfga: `birthweight_centile`, `sfga`, `sfga_severe`,
- svn: `birthweight_centile`, `svn`,
- stunting: `lhaz`, `stunting`, `stunting_outliers`,
- wasting: `wlz`, `wasting`, `wasting_outliers`,
- wfa: `waz`, `wfa`, `wfa_outliers`,
- headsize: `hcaz`, `headsize`.

### Usage Note
 
When `sfga` or `svn` outcome is used there are some additional requirements!
 
If a data set contains multiple observations for each subject, e.g., each value of `ChildID` variable
has 5 observations with different measurements at different time points, then the `by=` parameter should
be used to indicate that fact. See *Examples* below.
 
The macro will calculate birth outcomes (size-for-GA + SVN) for observations with the minimum age, where that minimum age is <3 days (provided in the `&age_days` macro parameter). 
 
Typically, assessment size-for-GA or SVN categories should be done with anthropometry taken no later than 12 hours
after birth (`< 0.5` days). Therefore, when the age days for a 'birth' measurement is greater than `0.5`, a warning is issued in the log. You can also signal this information as a NOTE or ERROR using the `SfgaSvnWarn` parameter.


### References

WHO. **Physical status: the use and interpretation of anthropometry. Report
of a WHO Expert Committee.** *World Health Organisation Technical Report
Series 1995,* **854: 1–452**

Royal College of Obstetricians and Gynaecologists. **The Investigation and
Management of the Small-for-Gestational-Age Fetus: Green-top Guideline No.
31.** *Technical report, Royal College of Obstetricians and Gynaecologists,
London, 2013.*

Lawn JE, Ohuma EO, Bradley E, Idueta LS, Hazel E, Okwaraji YB et al.
**Small babies, big risks: global estimates of prevalence and mortality for
vulnerable newborns to accelerate change and improve counting.** *The Lancet*
2023, *401(10389):1707-1719.*
doi: [10.1016/S0140-6736(23)00522-6](https://dx.doi.org/10.1016/S0140-6736(23)00522-6)


**'Implausible z-score values'** *in* World Health Organization (ed.)
*Recommendations for data collection, analysis and reporting on
anthropometric indicators in children under 5 years old*. Geneva: World
Health Organization and the United Nations Children's Fund UNICEF, (2019).
pp. 64-65.

**'Percentage of children stunted, wasted, and underweight, and mean z-scores
for stunting, wasting and underweight'** *in* *Guide to DHS Statistics DHS-7*
Rockville, Maryland, USA: ICF (2020). pp. 431-435.
[https://dhsprogram.com/data/Guide-to-DHS-Statistics/Nutritional_Status.htm](https://dhsprogram.com/data/Guide-to-DHS-Statistics/Nutritional_Status.htm)

Victora CG, Schuler-Faccini L, Matijasevich A, Ribeiro E, Pessoa A,
Barros FC. **Microcephaly in Brazil: how to interpret reported numbers?**
*The Lancet* 2016, *387(10019):621-624* 
doi: [10.1016/S0140-6736(16)00273-7](https://dx.doi.org/10.1016/S0140-6736(16)00273-7)

Accogli A, Geraldo AF, Piccolo G, Riva A, Scala M, Balagura G, et al.
**Diagnostic Approach to Macrocephaly in Children**. *Frontiers in
Paediatrics* 2022, *9:794069* 
doi: [10.3389/fped.2021.794069](https://dx.doi.org/10.3389/fped.2021.794069)


### Examples

1. Executing all analyses: sfga, svn, stunting, wasting, wfa, 
and headsize at once.
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~sas
%gigs_classify_growth(
_tmpgigs.Life6mo
,dataOut=WORK.ANALYSIS_RESULT
,by=ID
,gest_days=gest_days
,age_days=age_days
,sex=sex
,weight_kg=wt_kg
,lenht_cm=len_cm
,headcirc_cm=headcirc_cm
)

proc print 
  data=WORK.ANALYSIS_RESULT(obs=24) 
  Label
;
run;
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

2. Executing only selected analyses for: sfga and headsize.
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~sas
%gigs_classify_growth(
_tmpgigs.Life6mo
,dataOut=WORK.ANALYSIS_RESULT2
,by=ID
,outcomes=sfga headsize
,weight_kg=wt_kg
,headcirc_cm=headcirc_cm
)

proc print 
  data=WORK.ANALYSIS_RESULT2(obs=24) 
  Label
;
run;
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

3. Executing analysis for: sfga with and without BY= parameter.
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~sas
data WORK.have;
  infile cards missover;
  input id $1. wt_kg gest_days age_days sex :$1.;
CARDS4;
A 2.0 280 . M
A 2.8 280 4 M
A 2.5 280 1 M
B 3.0 280 2 M
B 3.2 280 3 M
C 2.9 280 4 M
C 2.7 280 3 M
D 2.7 280 1 M
D 2.8 280 3 M
;;;;
run;
title "original data";
proc print data=WORK.have;
run;

%gigs_classify_growth(
 work.have
,dataOut=work.ANALYSIS_RESULT3
,gest_days=gest_days
,age_days=age_days
,sex=sex
,weight_kg=wt_kg
,outcomes=SFGA
,BY=id
)

title "In groups by ID";
proc print
  data=WORK.ANALYSIS_RESULT3
  Label
;
run;

%gigs_classify_growth(
 work.have
,dataOut=work.ANALYSIS_RESULT4
,gest_days=gest_days
,age_days=age_days
,sex=sex
,weight_kg=wt_kg
,outcomes=SFGA
)

title "NO groups";
proc print
  data=WORK.ANALYSIS_RESULT4
  Label
;
run;
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


---

  
---
 
  
---
 
# License <a name="license"></a> ######
 
GNU General Public License
==========================

_Version 3, 29 June 2007_  
_Copyright © 2007 Free Software Foundation, Inc. &lt;<http://fsf.org/>&gt;_

Everyone is permitted to copy and distribute verbatim copies of this license
document, but changing it is not allowed.

## Preamble

The GNU General Public License is a free, copyleft license for software and other
kinds of works.

The licenses for most software and other practical works are designed to take away
your freedom to share and change the works. By contrast, the GNU General Public
License is intended to guarantee your freedom to share and change all versions of a
program--to make sure it remains free software for all its users. We, the Free
Software Foundation, use the GNU General Public License for most of our software; it
applies also to any other work released this way by its authors. You can apply it to
your programs, too.

When we speak of free software, we are referring to freedom, not price. Our General
Public Licenses are designed to make sure that you have the freedom to distribute
copies of free software (and charge for them if you wish), that you receive source
code or can get it if you want it, that you can change the software or use pieces of
it in new free programs, and that you know you can do these things.

To protect your rights, we need to prevent others from denying you these rights or
asking you to surrender the rights. Therefore, you have certain responsibilities if
you distribute copies of the software, or if you modify it: responsibilities to
respect the freedom of others.

For example, if you distribute copies of such a program, whether gratis or for a fee,
you must pass on to the recipients the same freedoms that you received. You must make
sure that they, too, receive or can get the source code. And you must show them these
terms so they know their rights.

Developers that use the GNU GPL protect your rights with two steps: **(1)** assert
copyright on the software, and **(2)** offer you this License giving you legal permission
to copy, distribute and/or modify it.

For the developers' and authors' protection, the GPL clearly explains that there is
no warranty for this free software. For both users' and authors' sake, the GPL
requires that modified versions be marked as changed, so that their problems will not
be attributed erroneously to authors of previous versions.

Some devices are designed to deny users access to install or run modified versions of
the software inside them, although the manufacturer can do so. This is fundamentally
incompatible with the aim of protecting users' freedom to change the software. The
systematic pattern of such abuse occurs in the area of products for individuals to
use, which is precisely where it is most unacceptable. Therefore, we have designed
this version of the GPL to prohibit the practice for those products. If such problems
arise substantially in other domains, we stand ready to extend this provision to
those domains in future versions of the GPL, as needed to protect the freedom of
users.

Finally, every program is threatened constantly by software patents. States should
not allow patents to restrict development and use of software on general-purpose
computers, but in those that do, we wish to avoid the special danger that patents
applied to a free program could make it effectively proprietary. To prevent this, the
GPL assures that patents cannot be used to render the program non-free.

The precise terms and conditions for copying, distribution and modification follow.

## TERMS AND CONDITIONS

### 0. Definitions

“This License” refers to version 3 of the GNU General Public License.

“Copyright” also means copyright-like laws that apply to other kinds of
works, such as semiconductor masks.

“The Program” refers to any copyrightable work licensed under this
License. Each licensee is addressed as “you”. “Licensees” and
“recipients” may be individuals or organizations.

To “modify” a work means to copy from or adapt all or part of the work in
a fashion requiring copyright permission, other than the making of an exact copy. The
resulting work is called a “modified version” of the earlier work or a
work “based on” the earlier work.

A “covered work” means either the unmodified Program or a work based on
the Program.

To “propagate” a work means to do anything with it that, without
permission, would make you directly or secondarily liable for infringement under
applicable copyright law, except executing it on a computer or modifying a private
copy. Propagation includes copying, distribution (with or without modification),
making available to the public, and in some countries other activities as well.

To “convey” a work means any kind of propagation that enables other
parties to make or receive copies. Mere interaction with a user through a computer
network, with no transfer of a copy, is not conveying.

An interactive user interface displays “Appropriate Legal Notices” to the
extent that it includes a convenient and prominently visible feature that **(1)**
displays an appropriate copyright notice, and **(2)** tells the user that there is no
warranty for the work (except to the extent that warranties are provided), that
licensees may convey the work under this License, and how to view a copy of this
License. If the interface presents a list of user commands or options, such as a
menu, a prominent item in the list meets this criterion.

### 1. Source Code

The “source code” for a work means the preferred form of the work for
making modifications to it. “Object code” means any non-source form of a
work.

A “Standard Interface” means an interface that either is an official
standard defined by a recognized standards body, or, in the case of interfaces
specified for a particular programming language, one that is widely used among
developers working in that language.

The “System Libraries” of an executable work include anything, other than
the work as a whole, that **(a)** is included in the normal form of packaging a Major
Component, but which is not part of that Major Component, and **(b)** serves only to
enable use of the work with that Major Component, or to implement a Standard
Interface for which an implementation is available to the public in source code form.
A “Major Component”, in this context, means a major essential component
(kernel, window system, and so on) of the specific operating system (if any) on which
the executable work runs, or a compiler used to produce the work, or an object code
interpreter used to run it.

The “Corresponding Source” for a work in object code form means all the
source code needed to generate, install, and (for an executable work) run the object
code and to modify the work, including scripts to control those activities. However,
it does not include the work's System Libraries, or general-purpose tools or
generally available free programs which are used unmodified in performing those
activities but which are not part of the work. For example, Corresponding Source
includes interface definition files associated with source files for the work, and
the source code for shared libraries and dynamically linked subprograms that the work
is specifically designed to require, such as by intimate data communication or
control flow between those subprograms and other parts of the work.

The Corresponding Source need not include anything that users can regenerate
automatically from other parts of the Corresponding Source.

The Corresponding Source for a work in source code form is that same work.

### 2. Basic Permissions

All rights granted under this License are granted for the term of copyright on the
Program, and are irrevocable provided the stated conditions are met. This License
explicitly affirms your unlimited permission to run the unmodified Program. The
output from running a covered work is covered by this License only if the output,
given its content, constitutes a covered work. This License acknowledges your rights
of fair use or other equivalent, as provided by copyright law.

You may make, run and propagate covered works that you do not convey, without
conditions so long as your license otherwise remains in force. You may convey covered
works to others for the sole purpose of having them make modifications exclusively
for you, or provide you with facilities for running those works, provided that you
comply with the terms of this License in conveying all material for which you do not
control copyright. Those thus making or running the covered works for you must do so
exclusively on your behalf, under your direction and control, on terms that prohibit
them from making any copies of your copyrighted material outside their relationship
with you.

Conveying under any other circumstances is permitted solely under the conditions
stated below. Sublicensing is not allowed; section 10 makes it unnecessary.

### 3. Protecting Users' Legal Rights From Anti-Circumvention Law

No covered work shall be deemed part of an effective technological measure under any
applicable law fulfilling obligations under article 11 of the WIPO copyright treaty
adopted on 20 December 1996, or similar laws prohibiting or restricting circumvention
of such measures.

When you convey a covered work, you waive any legal power to forbid circumvention of
technological measures to the extent such circumvention is effected by exercising
rights under this License with respect to the covered work, and you disclaim any
intention to limit operation or modification of the work as a means of enforcing,
against the work's users, your or third parties' legal rights to forbid circumvention
of technological measures.

### 4. Conveying Verbatim Copies

You may convey verbatim copies of the Program's source code as you receive it, in any
medium, provided that you conspicuously and appropriately publish on each copy an
appropriate copyright notice; keep intact all notices stating that this License and
any non-permissive terms added in accord with section 7 apply to the code; keep
intact all notices of the absence of any warranty; and give all recipients a copy of
this License along with the Program.

You may charge any price or no price for each copy that you convey, and you may offer
support or warranty protection for a fee.

### 5. Conveying Modified Source Versions

You may convey a work based on the Program, or the modifications to produce it from
the Program, in the form of source code under the terms of section 4, provided that
you also meet all of these conditions:

* **a)** The work must carry prominent notices stating that you modified it, and giving a
relevant date.
* **b)** The work must carry prominent notices stating that it is released under this
License and any conditions added under section 7. This requirement modifies the
requirement in section 4 to “keep intact all notices”.
* **c)** You must license the entire work, as a whole, under this License to anyone who
comes into possession of a copy. This License will therefore apply, along with any
applicable section 7 additional terms, to the whole of the work, and all its parts,
regardless of how they are packaged. This License gives no permission to license the
work in any other way, but it does not invalidate such permission if you have
separately received it.
* **d)** If the work has interactive user interfaces, each must display Appropriate Legal
Notices; however, if the Program has interactive interfaces that do not display
Appropriate Legal Notices, your work need not make them do so.

A compilation of a covered work with other separate and independent works, which are
not by their nature extensions of the covered work, and which are not combined with
it such as to form a larger program, in or on a volume of a storage or distribution
medium, is called an “aggregate” if the compilation and its resulting
copyright are not used to limit the access or legal rights of the compilation's users
beyond what the individual works permit. Inclusion of a covered work in an aggregate
does not cause this License to apply to the other parts of the aggregate.

### 6. Conveying Non-Source Forms

You may convey a covered work in object code form under the terms of sections 4 and
5, provided that you also convey the machine-readable Corresponding Source under the
terms of this License, in one of these ways:

* **a)** Convey the object code in, or embodied in, a physical product (including a
physical distribution medium), accompanied by the Corresponding Source fixed on a
durable physical medium customarily used for software interchange.
* **b)** Convey the object code in, or embodied in, a physical product (including a
physical distribution medium), accompanied by a written offer, valid for at least
three years and valid for as long as you offer spare parts or customer support for
that product model, to give anyone who possesses the object code either **(1)** a copy of
the Corresponding Source for all the software in the product that is covered by this
License, on a durable physical medium customarily used for software interchange, for
a price no more than your reasonable cost of physically performing this conveying of
source, or **(2)** access to copy the Corresponding Source from a network server at no
charge.
* **c)** Convey individual copies of the object code with a copy of the written offer to
provide the Corresponding Source. This alternative is allowed only occasionally and
noncommercially, and only if you received the object code with such an offer, in
accord with subsection 6b.
* **d)** Convey the object code by offering access from a designated place (gratis or for
a charge), and offer equivalent access to the Corresponding Source in the same way
through the same place at no further charge. You need not require recipients to copy
the Corresponding Source along with the object code. If the place to copy the object
code is a network server, the Corresponding Source may be on a different server
(operated by you or a third party) that supports equivalent copying facilities,
provided you maintain clear directions next to the object code saying where to find
the Corresponding Source. Regardless of what server hosts the Corresponding Source,
you remain obligated to ensure that it is available for as long as needed to satisfy
these requirements.
* **e)** Convey the object code using peer-to-peer transmission, provided you inform
other peers where the object code and Corresponding Source of the work are being
offered to the general public at no charge under subsection 6d.

A separable portion of the object code, whose source code is excluded from the
Corresponding Source as a System Library, need not be included in conveying the
object code work.

A “User Product” is either **(1)** a “consumer product”, which
means any tangible personal property which is normally used for personal, family, or
household purposes, or **(2)** anything designed or sold for incorporation into a
dwelling. In determining whether a product is a consumer product, doubtful cases
shall be resolved in favor of coverage. For a particular product received by a
particular user, “normally used” refers to a typical or common use of
that class of product, regardless of the status of the particular user or of the way
in which the particular user actually uses, or expects or is expected to use, the
product. A product is a consumer product regardless of whether the product has
substantial commercial, industrial or non-consumer uses, unless such uses represent
the only significant mode of use of the product.

“Installation Information” for a User Product means any methods,
procedures, authorization keys, or other information required to install and execute
modified versions of a covered work in that User Product from a modified version of
its Corresponding Source. The information must suffice to ensure that the continued
functioning of the modified object code is in no case prevented or interfered with
solely because modification has been made.

If you convey an object code work under this section in, or with, or specifically for
use in, a User Product, and the conveying occurs as part of a transaction in which
the right of possession and use of the User Product is transferred to the recipient
in perpetuity or for a fixed term (regardless of how the transaction is
characterized), the Corresponding Source conveyed under this section must be
accompanied by the Installation Information. But this requirement does not apply if
neither you nor any third party retains the ability to install modified object code
on the User Product (for example, the work has been installed in ROM).

The requirement to provide Installation Information does not include a requirement to
continue to provide support service, warranty, or updates for a work that has been
modified or installed by the recipient, or for the User Product in which it has been
modified or installed. Access to a network may be denied when the modification itself
materially and adversely affects the operation of the network or violates the rules
and protocols for communication across the network.

Corresponding Source conveyed, and Installation Information provided, in accord with
this section must be in a format that is publicly documented (and with an
implementation available to the public in source code form), and must require no
special password or key for unpacking, reading or copying.

### 7. Additional Terms

“Additional permissions” are terms that supplement the terms of this
License by making exceptions from one or more of its conditions. Additional
permissions that are applicable to the entire Program shall be treated as though they
were included in this License, to the extent that they are valid under applicable
law. If additional permissions apply only to part of the Program, that part may be
used separately under those permissions, but the entire Program remains governed by
this License without regard to the additional permissions.

When you convey a copy of a covered work, you may at your option remove any
additional permissions from that copy, or from any part of it. (Additional
permissions may be written to require their own removal in certain cases when you
modify the work.) You may place additional permissions on material, added by you to a
covered work, for which you have or can give appropriate copyright permission.

Notwithstanding any other provision of this License, for material you add to a
covered work, you may (if authorized by the copyright holders of that material)
supplement the terms of this License with terms:

* **a)** Disclaiming warranty or limiting liability differently from the terms of
sections 15 and 16 of this License; or
* **b)** Requiring preservation of specified reasonable legal notices or author
attributions in that material or in the Appropriate Legal Notices displayed by works
containing it; or
* **c)** Prohibiting misrepresentation of the origin of that material, or requiring that
modified versions of such material be marked in reasonable ways as different from the
original version; or
* **d)** Limiting the use for publicity purposes of names of licensors or authors of the
material; or
* **e)** Declining to grant rights under trademark law for use of some trade names,
trademarks, or service marks; or
* **f)** Requiring indemnification of licensors and authors of that material by anyone
who conveys the material (or modified versions of it) with contractual assumptions of
liability to the recipient, for any liability that these contractual assumptions
directly impose on those licensors and authors.

All other non-permissive additional terms are considered “further
restrictions” within the meaning of section 10. If the Program as you received
it, or any part of it, contains a notice stating that it is governed by this License
along with a term that is a further restriction, you may remove that term. If a
license document contains a further restriction but permits relicensing or conveying
under this License, you may add to a covered work material governed by the terms of
that license document, provided that the further restriction does not survive such
relicensing or conveying.

If you add terms to a covered work in accord with this section, you must place, in
the relevant source files, a statement of the additional terms that apply to those
files, or a notice indicating where to find the applicable terms.

Additional terms, permissive or non-permissive, may be stated in the form of a
separately written license, or stated as exceptions; the above requirements apply
either way.

### 8. Termination

You may not propagate or modify a covered work except as expressly provided under
this License. Any attempt otherwise to propagate or modify it is void, and will
automatically terminate your rights under this License (including any patent licenses
granted under the third paragraph of section 11).

However, if you cease all violation of this License, then your license from a
particular copyright holder is reinstated **(a)** provisionally, unless and until the
copyright holder explicitly and finally terminates your license, and **(b)** permanently,
if the copyright holder fails to notify you of the violation by some reasonable means
prior to 60 days after the cessation.

Moreover, your license from a particular copyright holder is reinstated permanently
if the copyright holder notifies you of the violation by some reasonable means, this
is the first time you have received notice of violation of this License (for any
work) from that copyright holder, and you cure the violation prior to 30 days after
your receipt of the notice.

Termination of your rights under this section does not terminate the licenses of
parties who have received copies or rights from you under this License. If your
rights have been terminated and not permanently reinstated, you do not qualify to
receive new licenses for the same material under section 10.

### 9. Acceptance Not Required for Having Copies

You are not required to accept this License in order to receive or run a copy of the
Program. Ancillary propagation of a covered work occurring solely as a consequence of
using peer-to-peer transmission to receive a copy likewise does not require
acceptance. However, nothing other than this License grants you permission to
propagate or modify any covered work. These actions infringe copyright if you do not
accept this License. Therefore, by modifying or propagating a covered work, you
indicate your acceptance of this License to do so.

### 10. Automatic Licensing of Downstream Recipients

Each time you convey a covered work, the recipient automatically receives a license
from the original licensors, to run, modify and propagate that work, subject to this
License. You are not responsible for enforcing compliance by third parties with this
License.

An “entity transaction” is a transaction transferring control of an
organization, or substantially all assets of one, or subdividing an organization, or
merging organizations. If propagation of a covered work results from an entity
transaction, each party to that transaction who receives a copy of the work also
receives whatever licenses to the work the party's predecessor in interest had or
could give under the previous paragraph, plus a right to possession of the
Corresponding Source of the work from the predecessor in interest, if the predecessor
has it or can get it with reasonable efforts.

You may not impose any further restrictions on the exercise of the rights granted or
affirmed under this License. For example, you may not impose a license fee, royalty,
or other charge for exercise of rights granted under this License, and you may not
initiate litigation (including a cross-claim or counterclaim in a lawsuit) alleging
that any patent claim is infringed by making, using, selling, offering for sale, or
importing the Program or any portion of it.

### 11. Patents

A “contributor” is a copyright holder who authorizes use under this
License of the Program or a work on which the Program is based. The work thus
licensed is called the contributor's “contributor version”.

A contributor's “essential patent claims” are all patent claims owned or
controlled by the contributor, whether already acquired or hereafter acquired, that
would be infringed by some manner, permitted by this License, of making, using, or
selling its contributor version, but do not include claims that would be infringed
only as a consequence of further modification of the contributor version. For
purposes of this definition, “control” includes the right to grant patent
sublicenses in a manner consistent with the requirements of this License.

Each contributor grants you a non-exclusive, worldwide, royalty-free patent license
under the contributor's essential patent claims, to make, use, sell, offer for sale,
import and otherwise run, modify and propagate the contents of its contributor
version.

In the following three paragraphs, a “patent license” is any express
agreement or commitment, however denominated, not to enforce a patent (such as an
express permission to practice a patent or covenant not to sue for patent
infringement). To “grant” such a patent license to a party means to make
such an agreement or commitment not to enforce a patent against the party.

If you convey a covered work, knowingly relying on a patent license, and the
Corresponding Source of the work is not available for anyone to copy, free of charge
and under the terms of this License, through a publicly available network server or
other readily accessible means, then you must either **(1)** cause the Corresponding
Source to be so available, or **(2)** arrange to deprive yourself of the benefit of the
patent license for this particular work, or **(3)** arrange, in a manner consistent with
the requirements of this License, to extend the patent license to downstream
recipients. “Knowingly relying” means you have actual knowledge that, but
for the patent license, your conveying the covered work in a country, or your
recipient's use of the covered work in a country, would infringe one or more
identifiable patents in that country that you have reason to believe are valid.

If, pursuant to or in connection with a single transaction or arrangement, you
convey, or propagate by procuring conveyance of, a covered work, and grant a patent
license to some of the parties receiving the covered work authorizing them to use,
propagate, modify or convey a specific copy of the covered work, then the patent
license you grant is automatically extended to all recipients of the covered work and
works based on it.

A patent license is “discriminatory” if it does not include within the
scope of its coverage, prohibits the exercise of, or is conditioned on the
non-exercise of one or more of the rights that are specifically granted under this
License. You may not convey a covered work if you are a party to an arrangement with
a third party that is in the business of distributing software, under which you make
payment to the third party based on the extent of your activity of conveying the
work, and under which the third party grants, to any of the parties who would receive
the covered work from you, a discriminatory patent license **(a)** in connection with
copies of the covered work conveyed by you (or copies made from those copies), or **(b)**
primarily for and in connection with specific products or compilations that contain
the covered work, unless you entered into that arrangement, or that patent license
was granted, prior to 28 March 2007.

Nothing in this License shall be construed as excluding or limiting any implied
license or other defenses to infringement that may otherwise be available to you
under applicable patent law.

### 12. No Surrender of Others' Freedom

If conditions are imposed on you (whether by court order, agreement or otherwise)
that contradict the conditions of this License, they do not excuse you from the
conditions of this License. If you cannot convey a covered work so as to satisfy
simultaneously your obligations under this License and any other pertinent
obligations, then as a consequence you may not convey it at all. For example, if you
agree to terms that obligate you to collect a royalty for further conveying from
those to whom you convey the Program, the only way you could satisfy both those terms
and this License would be to refrain entirely from conveying the Program.

### 13. Use with the GNU Affero General Public License

Notwithstanding any other provision of this License, you have permission to link or
combine any covered work with a work licensed under version 3 of the GNU Affero
General Public License into a single combined work, and to convey the resulting work.
The terms of this License will continue to apply to the part which is the covered
work, but the special requirements of the GNU Affero General Public License, section
13, concerning interaction through a network will apply to the combination as such.

### 14. Revised Versions of this License

The Free Software Foundation may publish revised and/or new versions of the GNU
General Public License from time to time. Such new versions will be similar in spirit
to the present version, but may differ in detail to address new problems or concerns.

Each version is given a distinguishing version number. If the Program specifies that
a certain numbered version of the GNU General Public License “or any later
version” applies to it, you have the option of following the terms and
conditions either of that numbered version or of any later version published by the
Free Software Foundation. If the Program does not specify a version number of the GNU
General Public License, you may choose any version ever published by the Free
Software Foundation.

If the Program specifies that a proxy can decide which future versions of the GNU
General Public License can be used, that proxy's public statement of acceptance of a
version permanently authorizes you to choose that version for the Program.

Later license versions may give you additional or different permissions. However, no
additional obligations are imposed on any author or copyright holder as a result of
your choosing to follow a later version.

### 15. Disclaimer of Warranty

THERE IS NO WARRANTY FOR THE PROGRAM, TO THE EXTENT PERMITTED BY APPLICABLE LAW.
EXCEPT WHEN OTHERWISE STATED IN WRITING THE COPYRIGHT HOLDERS AND/OR OTHER PARTIES
PROVIDE THE PROGRAM “AS IS” WITHOUT WARRANTY OF ANY KIND, EITHER
EXPRESSED OR IMPLIED, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF
MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE. THE ENTIRE RISK AS TO THE
QUALITY AND PERFORMANCE OF THE PROGRAM IS WITH YOU. SHOULD THE PROGRAM PROVE
DEFECTIVE, YOU ASSUME THE COST OF ALL NECESSARY SERVICING, REPAIR OR CORRECTION.

### 16. Limitation of Liability

IN NO EVENT UNLESS REQUIRED BY APPLICABLE LAW OR AGREED TO IN WRITING WILL ANY
COPYRIGHT HOLDER, OR ANY OTHER PARTY WHO MODIFIES AND/OR CONVEYS THE PROGRAM AS
PERMITTED ABOVE, BE LIABLE TO YOU FOR DAMAGES, INCLUDING ANY GENERAL, SPECIAL,
INCIDENTAL OR CONSEQUENTIAL DAMAGES ARISING OUT OF THE USE OR INABILITY TO USE THE
PROGRAM (INCLUDING BUT NOT LIMITED TO LOSS OF DATA OR DATA BEING RENDERED INACCURATE
OR LOSSES SUSTAINED BY YOU OR THIRD PARTIES OR A FAILURE OF THE PROGRAM TO OPERATE
WITH ANY OTHER PROGRAMS), EVEN IF SUCH HOLDER OR OTHER PARTY HAS BEEN ADVISED OF THE
POSSIBILITY OF SUCH DAMAGES.

### 17. Interpretation of Sections 15 and 16

If the disclaimer of warranty and limitation of liability provided above cannot be
given local legal effect according to their terms, reviewing courts shall apply local
law that most closely approximates an absolute waiver of all civil liability in
connection with the Program, unless a warranty or assumption of liability accompanies
a copy of the Program in return for a fee.

_END OF TERMS AND CONDITIONS_

## How to Apply These Terms to Your New Programs

If you develop a new program, and you want it to be of the greatest possible use to
the public, the best way to achieve this is to make it free software which everyone
can redistribute and change under these terms.

To do so, attach the following notices to the program. It is safest to attach them
to the start of each source file to most effectively state the exclusion of warranty;
and each file should have at least the “copyright” line and a pointer to
where the full notice is found.

    GIGS a SAS package for Guidance for International Growth Standards project.
    Copyright (C) 2024 Bartosz Jablonski (yabwon@gmail.com), Simon Parker (simon.parker@lshtm.ac.uk), Linda Vesel, Eric Ohuma, Bill & Melinda Gates Foundation

    This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program.  If not, see <http://www.gnu.org/licenses/>.

Also add information on how to contact you by electronic and paper mail.

If the program does terminal interaction, make it output a short notice like this
when it starts in an interactive mode:

    GIGS Package Copyright (C) 2024 Bartosz Jablonski (yabwon@gmail.com), Simon Parker (simon.parker@lshtm.ac.uk), Linda Vesel, Eric Ohuma, Bill & Melinda Gates Foundation
    This program comes with ABSOLUTELY NO WARRANTY; for details type 'show w'.
    This is free software, and you are welcome to redistribute it
    under certain conditions; type 'show c' for details.

The hypothetical commands `show w` and `show c` should show the appropriate parts of
the General Public License. Of course, your program's commands might be different;
for a GUI interface, you would use an “about box”.

You should also get your employer (if you work as a programmer) or school, if any, to
sign a “copyright disclaimer” for the program, if necessary. For more
information on this, and how to apply and follow the GNU GPL, see
&lt;<http://www.gnu.org/licenses/>&gt;.

The GNU General Public License does not permit incorporating your program into
proprietary programs. If your program is a subroutine library, you may consider it
more useful to permit linking proprietary applications with the library. If this is
what you want to do, use the GNU Lesser General Public License instead of this
License. But first, please read
&lt;<http://www.gnu.org/philosophy/why-not-lgpl.html>&gt;.
  
---
 
