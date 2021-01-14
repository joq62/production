%%% -------------------------------------------------------------------
%%% Author  : uabjle
%%% Description : dbase using dets 
%%% 
%%% Created : 10 dec 2012
%%% -------------------------------------------------------------------
-module(cluster).   
   
%% --------------------------------------------------------------------
%% Include files
%% --------------------------------------------------------------------

%% --------------------------------------------------------------------

%% External exports
-export([start/0,
	 extract_app_spec/2]).

-define(StartConfigC0,"../app_specs/dbase_100_c0.app_spec").
-define(StartConfigC1,"../app_specs/dbase_100_c1.app_spec").
-define(StartConfigC2,"../app_specs/dbase_100_c2.app_spec").

%% ====================================================================
%% External functions
%% ====================================================================

%% --------------------------------------------------------------------
%% Function:tes cases
%% Description: List of test cases 
%% Returns: non
%% --------------------------------------------------------------------
start()->
    dbase(),
    ok.

%% --------------------------------------------------------------------
%% Function:start/0 
%% Description: Initiate the eunit tests, set upp needed processes etc
%% Returns: non
%% --------------------------------------------------------------------
lock_test_1()->
    %% db_lock timeout set to
%
    LockId=test_lock,
    LockTimeOut=3,   %% 3 Seconds
%    ?assertMatch({atomic,ok},db_lock:create(LockId,LockTimeOut)),

    ok.

%% --------------------------------------------------------------------
%% Function:start/0 
%% Description: Initiate the eunit tests, set upp needed processes etc
%% Returns: non
%% --------------------------------------------------------------------
status_machines()->
    ssh:start(),
    MachineStatus= machine:status(all),
    ok=machine:update_status(MachineStatus),
    ok.
%% --------------------------------------------------------------------
%% Function:start/0 
%% Description: Initiate the eunit tests, set upp needed processes etc
%% Returns: non
%% --------------------------------------------------------------------
syslog()->
    
    {ok,HostId}=net:gethostname(),
    SyslogNode=list_to_atom("syslog@"++HostId),
    {ok,SyslogNode}=slave:start(HostId,syslog,"-pa log/ebin -setcookie abc"),
    ok=rpc:call(SyslogNode,application,start,[syslog],5000),
    {pong,SyslogNode,syslog}=rpc:call(SyslogNode,syslog,ping,[],1000), 
  %% Syslog
   % ?assertMatch({atomic,ok},rpc:call(sd:dbase_node(),db_sd,create,[ServiceId,ServiceVsn,AppId,AppVsn,HostId,VmId,VmDir,Vm],2000)),
    {atomic,ok}=rpc:call(sd:dbase_node(),db_sd,create,["syslog","1.0.0",
						       "syslog_100_c2.app_spec","1.0.0",
						       "c2","syslog","log",syslog],2000),
    ok.
%% --------------------------------------------------------------------
%% Function:start/0 
%% Description: Initiate the eunit tests, set upp needed processes etc
%% Returns: non
%% --------------------------------------------------------------------
dbase()->
    {ok,AppSpec}=file:consult(?StartConfigC2), %Start system from c2 host
   
    DbaseEnvs=AppSpec,
    exit(glurk),

    {ok,HostId}=net:gethostname(),
    DbaseNode=list_to_atom("dbase@"++HostId),
    {ok,DbaseNode}=slave:start(HostId,dbase,"-pa dbase/ebin -setcookie abc"),
    [ok,ok,ok,ok,ok,ok,ok]=[rpc:call(DbaseNode,application,set_env,[dbase,Par,Val],5000)||{Par,Val}<-DbaseEnvs],
    ok=rpc:call(DbaseNode,application,start,[dbase],5000),
    {pong,DbaseNode,dbase}=rpc:call(DbaseNode,dbase,ping,[],1000), 
   
    
    
    
    ok.



%% --------------------------------------------------------------------
%% Function:start/0 
%% Description: Initiate the eunit tests, set upp needed processes etc
%% Returns: non
%% --------------------------------------------------------------------

extract_app_spec(Key,AppSpecFile)->
    {ok,[I]}=file:consult(AppSpecFile),
    I1=lists:delete(db_app_spec,I),
    app_spec_key(Key,I1).

app_spec_key(service_id,L)->
    {services,[L2]}=lists:keyfind(services,1,L),
    L3=lists:delete(services,L2),
    {service_id,ServiceId}=lists:keyfind(service_id,1,L3),
    ServiceId;
app_spec_key(service_vsn,L)->
    {services,[L2]}=lists:keyfind(services,1,L),
    {service_vsn,ServiceVsn}=lists:keyfind(service_vsn,1,L2),
    ServiceVsn;
app_spec_key(git_path,L)->
    {services,[L2]}=lists:keyfind(services,1,L),
    {git_path,GitPath}=lists:keyfind(git_path,1,L2),
    GitPath;
app_spec_key(start_cmd,L)->
    {services,[L2]}=lists:keyfind(services,1,L),
    {start_cmd,StartCmd}=lists:keyfind(start_cmd,1,L2),
    StartCmd;
app_spec_key(env_vars,L)->
     {services,[L2]}=lists:keyfind(services,1,L),
     {env_vars,EnvVars}=lists:keyfind(env_vars,1,L2),
    EnvVars;
app_spec_key(Key,L)->
    {Key,Value}=lists:keyfind(Key,1,L),
    Value.

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
