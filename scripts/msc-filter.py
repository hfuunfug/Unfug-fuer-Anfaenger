#!/usr/bin/env python

"""
Pandoc filter to process code blocks with class "msc" into
msc-generated images.

On msc:

    http://www.mcternan.me.uk/mscgen/
"""

import hashlib
import os
import sys
from pandocfilters import toJSONFilter, Str, Para, Image

def out(s):
    sys.stderr.write('[MSCGEN] ' + s + '\n')

def sha1(x):
    return hashlib.sha1(x.encode(sys.getfilesystemencoding())).hexdigest()

imagedir = "generated-images"

def mscgen(key, value, format, meta):
    if key == 'CodeBlock':
        [[ident, classes, keyvals], code] = value
        caption = "caption"

        if "msc" in classes:
            filename = sha1(code)
            if format == "html":
                filetype = "png"
            elif format == "latex":
                filetype = "png"
            else:
                filetype = "png"
            alt = Str(caption)
            src = imagedir + '/' + filename + '.' + filetype
            if not os.path.isfile(src):
                try:
                    os.mkdir(imagedir)
                    out('Created directory ' + imagedir)
                except OSError:
                    pass
                subprocess = os.popen("mscgen -Tpng -i - -o" + src, 'w')
                subprocess.write(code)
                subprocess.close()
                out('Created image ' + src)
            tit = ""
            return Para([Image(['', [], []], [alt], [src, tit])])

if __name__ == "__main__":
    toJSONFilter(mscgen)

