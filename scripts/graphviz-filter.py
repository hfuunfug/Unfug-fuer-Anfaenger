#!/usr/bin/env python

"""
Pandoc filter to process code blocks with class "graphviz" into
graphviz-generated images.
"""

import pygraphviz
import hashlib
import os
import sys
from pandocfilters import toJSONFilter, Str, Para, Image


def sha1(x):
    return hashlib.sha1(x.encode(sys.getfilesystemencoding())).hexdigest()

def out(s):
    sys.stderr.write('[GRAPHV] ' + s + "\n");

imagedir = "graphviz-images"

def graphviz(key, value, format, meta):
    if key == 'CodeBlock':
        [[ident, classes, keyvals], code] = value
        caption = "caption"

        if "graphviz" in classes:
            G = pygraphviz.AGraph(string=code)
            layout = "dot"
            for elem in keyvals:
                if elem[0] == "layout":
                    layout = elem[1]
            G.layout(layout)
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
                except OSError:
                    pass
                G.draw(src)
                out(src)
            tit = ""
            return Para([Image(['', [], []], [alt], [src, tit])])

if __name__ == "__main__":
    toJSONFilter(graphviz)
