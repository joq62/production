%% This is the application resource file (.app file) for the 'base'
%% application.
{application, production_test,
[{description, "production_test  " },
{vsn, "1.0.0" },
{modules, 
	  [production_test_app,production_test_sup,production_test]},
{registered,[production_test]},
{applications, [kernel,stdlib]},
{mod, {production_test_app,[]}},
{start_phases, []}
]}.
