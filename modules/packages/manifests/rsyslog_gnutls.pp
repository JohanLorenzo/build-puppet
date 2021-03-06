# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at http://mozilla.org/MPL/2.0/.
class packages::rsyslog_gnutls {
    case $::operatingsystem {
        CentOS: {
            realize(Packages::Yumrepo['rsyslog'])
            package {
                "rsyslog-gnutls":
                    ensure => latest,
                    require => Class['packages::rsyslog'];
            }
        }

        Ubuntu: {
            package {
                "rsyslog-gnutls":
                    ensure => latest,
                    require => Class['packages::rsyslog'];
            }
        }

        default: {
            fail("cannot install on $::operatingsystem")
        }
    }
}
