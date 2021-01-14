%%% -------------------------------------------------------------------
%%% Author  : uabjle
%%% Description : dbase using dets 
%%% 
%%% Created : 10 dec 2012
%%% -------------------------------------------------------------------
-module(production_init_test).   
   
%% --------------------------------------------------------------------
%% Include files
%% --------------------------------------------------------------------
-include_lib("eunit/include/eunit.hrl").
%% --------------------------------------------------------------------

%% External exports
-export([start/0]).
-define(AppSpec,"../app_specs/dbase_100_c2.app_spec").


%% ====================================================================
%% External functions
%% ====================================================================

%% --------------------------------------------------------------------
%% Function:tes cases
%% Description: List of test cases 
%% Returns: non
%% --------------------------------------------------------------------
start()->
    ?debugMsg("Start setup"),
    ?assertEqual(ok,setup()),
    ?debugMsg("stop setup"),

    ?debugMsg("Start app_spec"),
    ?assertEqual(ok,app_spec(?AppSpec)),
    ?debugMsg("stop app_spec"),

      %% End application tests
    ?debugMsg("Start cleanup"),
    ?assertEqual(ok,cleanup()),
    ?debugMsg("Stop cleanup"),

    ?debugMsg("------>"++atom_to_list(?MODULE)++" ENDED SUCCESSFUL ---------"),
    ok.

%% --------------------------------------------------------------------
%% Function:start/0 
%% Description: Initiate the eunit tests, set upp needed processes etc
%% Returns: non
%% --------------------------------------------------------------------
app_spec(AppSpec)->
   
    ?assertMatch("dbase_100_c2.app_spec",
		 cluster:extract_app_spec(app_id,AppSpec)),
    ?assertMatch("1.0.0",
		 cluster:extract_app_spec(app_vsn,AppSpec)),
    ?assertMatch(dbase,
		 cluster:extract_app_spec(type,AppSpec)),
    ?assertMatch("c2",
		 cluster:extract_app_spec(host,AppSpec)),
    ?assertMatch("dbase",
		 cluster:extract_app_spec(vm_id,AppSpec)),
    ?assertMatch("dbase_100",
		 cluster:extract_app_spec(vm_dir,AppSpec)),
    ?assertMatch("abc",
		 cluster:extract_app_spec(cookie,AppSpec)),
    ?assertMatch("dbase",
		 cluster:extract_app_spec(service_id,AppSpec)),
    ?assertMatch("1.0.0",
		 cluster:extract_app_spec(service_vsn,AppSpec)),
    ?assertMatch("https://github.com/joq62/dbase_application.git",
		 cluster:extract_app_spec(git_path,AppSpec)),
    ?assertMatch({application,start,[dbase]},
		 cluster:extract_app_spec(start_cmd,AppSpec)),
    
    ?assertMatch([{dbase,git_user,_},
		  {dbase,git_pw,_},
		  {dbase,cl_dir,"cluster_config"},
		  {dbase,cl_file,"cluster_info.hrl"},
		  {dbase,app_specs_dir,"app_specs"},
		  {dbase,service_specs_dir,"service_specs"},
		  {dbase,dbase_nodes,[dbase@c0,dbase@c1,dbase@c2]}],
		 cluster:extract_app_spec(env_vars,AppSpec)),
    ok.
%% --------------------------------------------------------------------
%% Function:start/0 
%% Description: Initiate the eunit tests, set upp needed processes etc
%% Returns: non
%% --------------------------------------------------------------------


%% --------------------------------------------------------------------
%% Function:start/0 
%% Description: Initiate the eunit tests, set upp needed processes etc
%% Returns: non
%% --------------------------------------------------------------------
setup()->
    
    
    ok.
%% --------------------------------------------------------------------
%% Function:start/0 
%% Description: Initiate the eunit tests, set upp needed processes etc
%% Returns: non
%% -------------------------------------------------------------------    

cleanup()->
  
  %  init:stop(),
    ok.
%% --------------------------------------------------------------------
%% Function:start/0 
%% Description: Initiate the eunit tests, set upp needed processes etc
%% Returns: non
%% --------------------------------------------------------------------
