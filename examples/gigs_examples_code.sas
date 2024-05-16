
resetline;
filename packages "/path/to/packages";
%include packages(SPFinit.sas);
%loadPackageS(gigs)




resetline;
proc contents data=_tmpgigs.life6mo varnum;
run;

data work.life6mo;
  set _tmpgigs.life6mo(
    keep=id visitweek sex 
         pma age_days gest_days 
         wt_kg
    );
  preterm = ifc(37*7 > gest_days,"Preterm","Term");
  label
    preterm = 
      "Preterm when an infant was born before 37 weeks' gestational age; Term otherwise"
  ;
run;
proc print data=life6mo(obs=6) label;
run;




resetline;
/* %helpPackage(gigs, gigs_classify_growth) */

%gigs_classify_growth(
 Life6mo
,dataOut=RESULT1
,weight_kg=wt_kg
,outcomes=wfa
)

proc print data=RESULT1(obs=6) label;
run;






resetline;
/* %helpPackage(gigs, gigs_classify_wfa) */

data RESULT2;
  set Life6mo;

  length waz 8 wfa wfa_outliers $ 20;
  call missing(waz, wfa, wfa_outliers);

  call gigs_classify_wfa(
    waz,
    wfa,
    wfa_outliers,
    wt_kg,
    age_days,
    gest_days,
    sex
  );
run;

proc print data=RESULT2(obs=6) label;
run;


resetline;
ods graphics / width=1024px height=738px;
proc means data=RESULT1 noprint;
  class preterm visitweek;
  var waz;
  ways 2;
  output out=PRINT1 mean=mean_waz;
run;
proc sgplot data=PRINT1;
  title1 "Mean WAZ by visit week in 300 infants from the LIFE study";
  title2 "(single-step approach)";
  styleattrs datacontrastcolors=(blue red);
  refline 0 / lineattrs=(color=grey pattern=shortDash);
  series x=visitweek y=mean_waz / group=preterm name="s";
  xaxis label="Visit week" values=(0 1 2 4 6 10 14 18 26);
  yaxis label="Mean weight-for-age z-score (WAZ)" min=-3 max=3;
  keylegend "s" / location=outside position=bottom;
run;




resetline;
data RESULT3;
  set Life6mo;

    waz_nbs = gigs_ig_nbs_value2zscore(
            wt_kg,
            gest_days,
            sex,
            "wfga"); /*acronym*/

    waz_who = gigs_who_gs_value2zscore(
            wt_kg,
            age_days,
            sex,
            "wfa"); /*acronym*/

    waz_png = gigs_ig_png_value2zscore(
            wt_kg,
            pma / 7,
            sex,
            "wfa"); /*acronym*/
run;
proc print data=RESULT3(obs=6) label;
run;


resetline;
data RESULT4;
  set RESULT3;

  if age_days <= 0.5 
    then waz = waz_nbs;
  else
    if (age_days > 0.5 and preterm='Term') 
       or (preterm="Preterm" and pma > 64 * 7)
      then waz = waz_who;
    else waz = waz_png; 

run;



resetline;
ods graphics / width=1024px height=738px;
proc means data=RESULT4 noprint;
  class preterm visitweek;
  var waz;
  ways 2;
  output out=PRINT4 mean=mean_waz;
run;
proc sgplot data=PRINT4;
  title1 "Mean WAZ by visit week in 300 infants from the LIFE study";
  title2 "(multi-step approach)";
  styleattrs datacontrastcolors=(orange green);
  refline 0 / lineattrs=(color=grey pattern=shortDash);
  series x=visitweek y=mean_waz / group=preterm name="s";
  xaxis label="Visit week" values=(0 1 2 4 6 10 14 18 26);
  yaxis label="Mean weight-for-age z-score (WAZ)" min=-3 max=3;
  keylegend "s" / location=outside position=bottom;
run;





resetline;
data RESULT5;
  set Life6mo;
  where visitweek = 0 AND age_days < 0.5;

  sfga = gigs_compute_sfga(
    wt_kg,
    gest_days,
    sex,
    0
  );
run;
proc freq data=RESULT5;
  table sfga / nocum;
run;
proc sgplot data=RESULT5;
  title "Size-for-GA categorisations in the LIFE data extract";
  vbar sfga / stat=percent categoryorder=respdesc fillattrs=(color=grey);
  xaxis label="Size-for-gestational age category"; 
  yaxis label="Percentage of cases" min=0 max=1 grid;
run;


resetline;
data RESULT6;
  set Life6mo;
  where visitweek = 0 AND age_days < 0.5;

  svn = gigs_compute_svn(
    wt_kg,
    gest_days,
    sex
  );
run;
proc freq data=RESULT6;
  table svn / nocum;
run;
proc sgplot data=RESULT6;
  title "Small vulnerable newborn categorisations in the LIFE data extract";
  vbar svn / stat=percent categoryorder=respdesc fillattrs=(color=grey);
  xaxis label="Small vulnerable newborn category"
        values=("Preterm SGA" "Preterm AGA" "Preterm LGA" "Term SGA"); 
  yaxis label="Percentage of cases" min=0 max=1 grid;
run;



