# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at http://mozilla.org/MPL/2.0/.

class balrog_scriptworker::settings {
    $root                     = '/builds/scriptworker'
    $task_script_executable   = "${root}/py27venv/bin/python"
    $task_script              = "${root}/py27venv/bin/balrogscript"
    $task_script_config       = "${root}/script_config.json"
    $task_max_timeout         = 1800
    $tools_branch             = 'default'
    $worker_group             = 'balrogworker-v1'
    $verbose_logging          = true

    $env_config = {
        'dev' => {
            balrog_username => 'balrog-stage-ffxbld',
            balrog_password => secret('balrog-stage-ffxbld_ldap_password'),
            balrog_api_root => 'https://balrog-admin.stage.mozaws.net/api',

            dummy => true,
            tools_repo => 'https://hg.mozilla.org/build/tools',
            taskcluster_client_id => 'project/releng/scriptworker/balrogworker-dev',
            taskcluster_access_token => secret('balrogworker_dev_taskcluster_access_token'),
            worker_type => 'balrogworker-dev',
            sign_chain_of_trust => false,
            verify_chain_of_trust => true,
            verify_cot_signature => false,
        },
        'prod' => {
            balrog_username => 'balrog-ffxbld',
            balrog_password => secret('balrog-ffxbld_ldap_password'),
            balrog_api_root => 'https://aus4-admin.mozilla.org/api',

            dummy => false,
            tools_repo => 'https://hg.mozilla.org/build/tools',
            taskcluster_client_id => 'project/releng/scriptworker/balrogworker',
            taskcluster_access_token => secret('balrogworker_prod_taskcluster_access_token'),
            worker_type => 'balrogworker-v1',
            sign_chain_of_trust => true,
            verify_chain_of_trust => true,
            verify_cot_signature => true,
        }
    }
}
