# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at http://mozilla.org/MPL/2.0/.
# Set up the ciduty user - this is 'ciduty' on firefox systems, but flexible
# enough to be anything

class users::ciduty {
    include config
    anchor {
        'users::ciduty::begin': ;
        'users::ciduty::end': ;
    }
    # public variables used by other modules

    $username = $::config::ciduty_username
    $group = $username
    $home = "/home/${username}"

    # account happens in the users stage, and is not included in the anchor
    class {
        'users::ciduty::account':
            stage    => users,
            username => $username,
            group    => $group,
            home     => $home;
    }

    Anchor['users::ciduty::begin'] ->
    class {
        'users::ciduty::setup':
            username => $username,
            group    => $group,
            home     => $home;
    } -> Anchor['users::ciduty::end']
}
