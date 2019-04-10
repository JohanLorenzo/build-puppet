# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at http://mozilla.org/MPL/2.0/.
class users::ciduty::account($username, $group, $home) {
    include ::config

    ##
    # sanity checks

    if ($username == '') {
        fail('No ciduty username set')
    }

    ##
    # create the user

    case $::operatingsystem {
        CentOS, Ubuntu: {
            if (secret('ciduty_pw_hash') == '') {
                fail('No ciduty password hash set')
            }

            user {
                $username:
                    password   => secret('ciduty_pw_hash'),
                    shell      => '/bin/bash',
                    managehome => true,
                    comment    => 'ciduty';
            }
        }
        default: {
            fail("users::ciduty::account: ${::operatingsystem} not suported")
        }
    }
}
