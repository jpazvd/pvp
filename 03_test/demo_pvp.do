
global root "C:\Users\wb255520\Documents\myados\pvp\"

/*
datalibweb, country(PRT) year(2015) type(GLAD) surveyid(PRT_2015_TIMSS_v01_M_v01_A_GLAD) filename(PRT_2015_TIMSS_v01_M_v01_A_GLAD_ALL.dta)
save "$root\01_data\PRT_2015_TIMSS_v01_M_v01_A_GLAD", replace
*/


cd $root/02_code

set seed 121

use "$root\01_data\PRT_2015_TIMSS_v01_M_v01_A_GLAD", clear

pv, pv(score_timss_math* ) pv1(score_timss_science*) jkzone(jkzone) jkrep(jkrep) weight(learner_weight) jrr timss mdd : mean @pv @1pv [aw=@w]


pvp, pv(score_timss_math* ) pv1(score_timss_science*) jkzone(jkzone) jkrep(jkrep) weight(learner_weight) jrr timss mdd : mean @pv @1pv [aw=@w]


pvp, pv(score_timss_math* ) pv1(score_timss_science*) jkzone(jkzone) jkrep(jkrep) weight(learner_weight) jrr timss mdd parallel : mean @pv @1pv [aw=@w]
