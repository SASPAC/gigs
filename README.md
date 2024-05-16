![gigs](./logoSAS.png)
---

*Assess Fetal, Newborn, and Child Growth with International Standards* 

### Version information:

- Package: gigs
- Version: 0.0.7
- Generated: 2024-05-16T17:17:08
- Author(s): Bartosz Jablonski (yabwon@gmail.com), Simon Parker (simon.parker@lshtm.ac.uk), Linda Vesel, Eric Ohuma (eric.ohuma@lshtm.ac.uk)
- Maintainer(s): Bartosz Jablonski (yabwon@gmail.com)
- License: GNU General Public License v3.0
- File SHA256: `F*9B3B83F9CE523633159727EED8688851AC1DBDC0B7EE492DF90BFD6448933D4C` for this version
- Content SHA256: `C*A3084D73E2B717E303A1F97AEE11E8D43E5C07738C2B0EB3C59BB741DB84B6FF` for this version
  
---
 
# `gigs` version: `0.0.7`;
  
---
 

# `gigs` SAS Package

## Overview

Produced as part of the Guidance for International Growth Standards (GIGS)
project at the London School of Hygiene & Tropical Medicine,
`gigs` provides a single, simple interface for working with
the WHO Child Growth standards and outputs from the
INTERGROWTH-21<sup>st</sup> project. You will find functions for
converting from anthropometric measures (e.g. weight or length) to
z-scores and centiles, and the inverse. Also included are functions for
classifying newborn and infant growth according to literature-based
cut-offs.

`gigs` is of use to anyone interested in fetal and child growth, including
child health researchers, policymakers, and clinicians. This package is best
suited to growth data where the gestational age (GA) of each child is known, as
the use of the growth standards included in `gigs` is GA-dependent.
We recommend you check out the
[available standards](#available-international-growth-standards) section to
see if your anthropometric measurements can be converted to z-scores/centiles by
`gigs`. We recommend using `gigs` to generate continuous or categorical
measures of fetal/newborn/child growth, which can then be used in downstream
analyses.

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

## Documentation

### [Package Documentation](./gigs.md)

### [Introductory Examples](./examples/gigs_examples.md)

## Terminology

`gigs` operates with anthropometric measurements, and can convert between these and
*z-scores*/*centiles*. Z-scores and centiles represent the location of a
measurement within a normal distribution of values, such that:

* A *z-score* is the number of standard deviations from the mean for a given
  anthropometric measurement (e.g. height or weight).
* A *centile* represents the proportion of measurements in some distribution
  which we would expect to be lower than a measurement we've taken. In `gigs`,
  these are represented as a value between `0` and `1`. For example, `0.5`
  corresponds to the 50<sup>th</sup> centile (i.e. the mean), whereas `0.75`
  corresponds to the 75<sup>th</sup> centile.

In growth data, z-scores and centiles represent the size a fetus, newborn, or
child relative to its peers. Its size is considered relative to some
standardising variable, which is usually age but could also be another variable
such as their length. By tracking a child's relative size as they
grow, you can see if they are achieving their growth potential or not. If not,
this may indicate underlying issues such as ill health or undernutrition.

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
 
*SAS package generated by SAS Package Framework, version `20240423`*
 
--------------------------------------------------------------------

---
