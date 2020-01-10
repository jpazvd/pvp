cd $root/02_code

set seed 121

use "$root\01_data\pvp_test", clear

pv, pv(score_timss_math* ) pv1(score_timss_science*) jkzone(jkzone) jkrep(jkrep) weight(learner_weight) jrr timss mdd : mean @pv @1pv [aw=@w]


pvp, pv(score_timss_math* ) pv1(score_timss_science*) jkzone(jkzone) jkrep(jkrep) weight(learner_weight) jrr timss mdd : mean @pv @1pv [aw=@w]


pvp, pv(score_timss_math* ) pv1(score_timss_science*) jkzone(jkzone) jkrep(jkrep) weight(learner_weight) jrr timss mdd parallel : mean @pv @1pv [aw=@w]
