

		tempname pv_ pv0_ pv1_ pv2_ v v0 v1 v2 df obs i j k

		local `pv0_' = $pv0_
		local `pv1_' = $pv1_
		local `pv2_' = $pv2_
		local mdd $mdd
		local mdd1 $mdd1
		local commands "$commands"
		local options "$options"


		/* 2.2 for each combination of plausible values */

			local `pv_' = 0

			forvalues `i' = 1 (1) ``pv0_'' {

				forvalues `j' = 1 (1) ``pv1_'' {

					forvalues `k' = 1 (1) ``pv2_'' {
					
					parallel break

					/* 2.2.1 define plausible values */

						if "`mdd'" == "" & "`mdd1'" == "" {

							local `v0' = word("`pv'", ``i'')

							local `v1' = word("`pv1'", ``j'')

							local `v2' = word("`pv2'", ``k'')

						}

						if "`mdd'" != "" {
	
							local `v0' = word("`pv'", ``i'')

							local `v1' = word("`pv1'", ``i'')

							local `v2' = word("`pv2'", ``i'')

						}

						if "`mdd1'" != "" {

							local `v0' = word("`pv'", ``i'')

							local `v1' = word("`pv1'", ``j'')

							local `v2' = word("`pv2'", ``j'')

						}

					/* 2.2.2 replace @pv with pv's */

						tempname cmd_all cmd_n

						mata: msubinstr(`"`commands'"', "@pv", "``v0''", .)

						local `cmd_all' `"`msubinstr'"'

						mata: msubinstr(`"``cmd_all''"', "@1pv", "``v1''", .)

						local `cmd_all' `"`msubinstr'"'

						mata: msubinstr(`"``cmd_all''"', "@2pv", "``v2''", .)

						local `cmd_all' `"`msubinstr'"'

						forvalues `cmd_n' = 1 (1) ``cmds'' {

							tempname cmd_``cmd_n''

							mata: msubinstr(`"`cmd``cmd_n'''"', "@pv", "``v0''", .)

							local `cmd_``cmd_n''' `"`msubinstr'"'

							mata: msubinstr(`"``cmd_``cmd_n''''"', "@1pv", "``v1''", .)

							local `cmd_``cmd_n''' `"`msubinstr'"'

							mata: msubinstr(`"``cmd_``cmd_n''''"', "@2pv", "``v2''", .)

							local `cmd_``cmd_n''' `"`msubinstr'"'							
						}

					/* 2.2.3 calculate statistic */
					/* add the parallel option here */

						local `pv_' = ``pv_'' + 1

						if "`brr'" != "" | ("`jrr'" != "" & "`rw'" != "") {

							qui _brr `options': ``cmd_all''

						}

						if "`jrr'" != "" & "`rw'" == "" {

							// if "`jrrt2'" == "" {

								qui _jrr  `options': ``cmd_all''

							// }

						}

						if "`jrrt2'" != "" & "`rw'" == "" {

							// else {

								qui _jrrt2  `options': ``cmd_all''

							// }

						}

						if "``def''" != "" {

							forvalues `cmd_n' = 1 (1) ``cmds'' {

								qui ``cmd_``cmd_n''''

							}

						}

					/* 2.2.4 save results */

						tempname b``pv_'' V``pv_'' r2``pv_'' e_b e_V

						local `e_b' = "e(b)"

						local `e_V' = "e(V)"

						local `df' = e(df_r)
	
						if "`rclass'" != "" {

							local `e_b' = "r(b)"

							local `e_V' = "r(V)"

							local `df' = "r(df_r)"
							
						}

						mat `b``pv_''' = ``e_b''

						mat `V``pv_''' = ``e_V''

						
						local `obs' = e(N)

						local `r2``pv_''' = e(r2)

						if ``pv_'' > 1 {

							if colsof(`b`=``pv_''-1'') != colsof(`b``pv_''') {

								di in re "Estimates for ``v'' yields different number of coefficients than the previous."

								exit 100

							}

						}

						di in gr "Estimates for ``v0'' ``v1'' ``v2'' complete"

					} // end of k

				} // end of j

			} // end of i
