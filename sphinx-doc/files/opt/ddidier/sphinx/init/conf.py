




# == NDD DOCKER SPHINX - OVERRIDE ============================================

# -- General configuration ---------------------------------------------------

# Add any Sphinx extension module names here, as strings. They can be
# extensions coming with Sphinx (named 'sphinx.ext.*') or your custom ones.
extensions = [
    'sphinx.ext.graphviz',
    'sphinx.ext.ifconfig',
    # 'sphinx.ext.imgmath',
    'sphinx.ext.mathjax',
    'sphinx.ext.todo',

    'sphinx-prompt',

    'sphinxcontrib.actdiag',
    'sphinxcontrib.blockdiag',
    'sphinxcontrib.excel_table',
  # 'sphinxcontrib.googleanalytics',
  # 'sphinxcontrib.googlechart',
  # 'sphinxcontrib.googlemaps',
    'sphinxcontrib.nwdiag',
    'sphinxcontrib.packetdiag',
    'sphinxcontrib.plantuml',
    'sphinxcontrib.rackdiag',
    'sphinxcontrib.seqdiag',
]

# The theme to use for HTML and HTML Help pages.  See the documentation for
# a list of builtin themes.
html_theme = 'sphinx_rtd_theme'

# If true, 'todo' and 'todoList' produce output, else they produce nothing.
todo_include_todos = True

# -- Markdown ----------------------------------------------------------------
# http://www.sphinx-doc.org/en/stable/usage/markdown.html

# The suffix(es) of source filenames.
# You can specify multiple suffix as a list of string:
source_suffix = ['.rst', '.md']

from recommonmark.parser import CommonMarkParser

source_parsers = {
    '.md': CommonMarkParser,
}

# -- Pseudo extensions -------------------------------------------------------

# Uncomment to enable Git parsing
# TODO: extract in a Sphinx plugin
#
# Must be defined somewhere
# html_context = {}
#
# import os.path
# source_directory = os.path.dirname(os.path.realpath(__file__))
# python_directory = os.path.join(source_directory, '_python')
# exec(open(os.path.join(python_directory, 'sphinx-git.py'), 'rb').read())

# -- Generator properties ----------------------------------------------------

# The Docker tag of the image that generated this project
ddidier_sphinxdoc_image_tag = 'unknown'
# The Git tag of the image that generated this project
# This is the most recent tag if the image is 'latest'
# Hopefully it will be (manually) updated while releasing...
ddidier_sphinxdoc_git_tag = '1.8.5-2'
