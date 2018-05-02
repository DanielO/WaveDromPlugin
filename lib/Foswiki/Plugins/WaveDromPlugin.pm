# See bottom of file for default license and copyright information

=begin TML

---+ package WaveDromPlugin

https://github.com/drom/wavedrom/wiki/WaveJSON

ToDo
- Load JS only if there is a matching tag
- Only call ProcessAll once at the end

=cut

package Foswiki::Plugins::WaveDromPlugin;

# Always use strict to enforce variable scoping
use strict;

require Foswiki::Func;    # The plugins API
require Foswiki::Plugins; # For the API version

# $VERSION is referred to by Foswiki, and is the only global variable that
# *must* exist in this package.
# This should always be $Rev: 5770 (2009-12-11) $ so that Foswiki can determine the checked-in
# status of the plugin. It is used by the build automation tools, so
# you should leave it alone.
our $VERSION = '$Rev: 5770 (2009-12-11) $';

# This is a free-form string you can use to "name" your own plugin version.
# It is *not* used by the build automation tools, but is reported as part
# of the version number in PLUGINDESCRIPTIONS.
our $RELEASE = '1.0.0';
our $SHORTDESCRIPTION = 'Display WaveDrom graphs inline';
our $NO_PREFS_IN_TOPIC = 1;

=begin TML

=cut
sub initPlugin {
    my( $topic, $web, $user, $installWeb ) = @_;
    print STDERR 'initPlugin for WaveDrom called\n';
    Foswiki::Func::writeWarning("initPlugin for WaveDrom called");
    # check for Plugins.pm versions
    if( $Foswiki::Plugins::VERSION < 2.0 ) {
        Foswiki::Func::writeWarning( 'Version mismatch between ',
                                     __PACKAGE__, ' and Plugins.pm' );
        return 0;
    }

    Foswiki::Func::registerTagHandler( 'WAVEDROM', \&_WAVEDROM );

    return 1;
}

sub _WAVEDROM {
  my($session, $params, $topic, $web, $topicObject) = @_;
  #print STDERR 'matched tag "' . $params->{_DEFAULT} . '"';
  return <<"SCRIPT";
<script type="WaveDrom">$params->{_DEFAULT}</script>
<script type="text/javascript">
(function() {
    try {
        WaveDrom.ProcessAll();
    } catch(e) {}
})();
</script>
SCRIPT
}

=begin TML

---++ postRenderingHandler( $text )
   * =$text= - the text that has just been rendered. May be modified in place.

*NOTE*: This handler is called once for each rendered block of text i.e.
it may be called several times during the rendering of a topic.

*NOTE:* meta-data is _not_ embedded in the text passed to this
handler.

Since Foswiki::Plugins::VERSION = '2.0'
=cut
sub postRenderingHandler {
    my $text = shift;
    Foswiki::Func::addToHEAD('WAVEDROMPLUGIN', <<"SCRIPT");
<script src="https://cdnjs.cloudflare.com/ajax/libs/wavedrom/1.6.2/skins/default.js" type="text/javascript"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/wavedrom/1.6.2/wavedrom.min.js" type="text/javascript"></script>
SCRIPT
}


1;
__END__
This copyright information applies to the WaveDrom plugin:

# Plugin for Foswiki - The Free and Open Source Wiki, http://foswiki.org/
#
# WaveDrom is Copyright (C) 2018 Daniel O'Connor <doconnor@gsoft.com.au>. All rights reserved.
#
# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions
# are met:
# 1. Redistributions of source code must retain the above copyright
#    notice, this list of conditions and the following disclaimer.
# 2. Redistributions in binary form must reproduce the above copyright
#    notice, this list of conditions and the following disclaimer in the
#    documentation and/or other materials provided with the distribution.
#
# THIS SOFTWARE IS PROVIDED BY THE AUTHOR AND CONTRIBUTORS ``AS IS'' AND
# ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
# IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
# ARE DISCLAIMED.  IN NO EVENT SHALL THE AUTHOR OR CONTRIBUTORS BE LIABLE
# FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
# DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS
# OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
# HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT
# LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY
# OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF
# SUCH DAMAGE.
#

