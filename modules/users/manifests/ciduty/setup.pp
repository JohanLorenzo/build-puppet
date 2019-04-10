# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at http://mozilla.org/MPL/2.0/.
class users::ciduty::setup($home, $username, $group) {
    anchor {
        'users::ciduty::setup::begin': ;
        'users::ciduty::setup::end': ;
    }

    ##
    # install a pip.conf for the ciduty user

    Anchor['users::ciduty::setup::begin'] ->
    python::user_pip_conf {
        $username:
            homedir => $home,
            group   => $group;
    } -> Anchor['users::ciduty::setup::end']

    ##
    # set up SSH configuration

    Anchor['users::ciduty::setup::begin'] ->
    ssh::userconfig {
        $username:
            home                          => $home,
            group                         => $group,
            authorized_keys               => $::config::admin_users,
            authorized_keys_allows_extras => true,
            config                        => template('users/buildduty-ssh-config.erb');
    } -> Anchor['users::ciduty::setup::end']

    File {
        mode   => '0644',
        owner  => $username,
        group  => $group,
    }

    ##
    # Manage some configuration files
    file {
        "${home}/.gitconfig":
            source => 'puppet:///modules/users/gitconfig';
        "${home}/.bashrc":
            content => template("${module_name}/buildduty-bashrc.erb");
        "${home}/.vimrc":
            source => 'puppet:///modules/users/vimrc';
        "${home}/.screenrc":
            source => 'puppet:///modules/users/screenrc';
    }
}
