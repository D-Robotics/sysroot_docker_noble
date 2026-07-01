#!/bin/sh

# For more information, see LP: #2148074

# 4.0.1really4.0.1-0ubuntu0.24.04.6 broke nautilus thumbnailing by removing
# its unconfined userns profile. 4.0.1really4.0.1-0ubuntu0.24.04.7 will
# restore the profile, but we need to remove cached thumbnail generation
# failures in order to get the thumbnails to regenerate.

# This script is not idempotent, but removing the failure cache again if
# session-migration hiccups and reruns scripts does not cause lasting harm
# (at most the file browser tries again and maybe fails at creating more
# thumbnails).

# See https://specifications.freedesktop.org/thumbnail/latest/failures.html
# for details about the path below: gnome-thumbnail-factory is the
# application-specific path chosen by the nautilus file browser.
if [ -d "$HOME/.cache/thumbnails/fail/gnome-thumbnail-factory" ]; then
	rm -r "$HOME/.cache/thumbnails/fail/gnome-thumbnail-factory"
fi
