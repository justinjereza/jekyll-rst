.. contents:: Table of Contents

Overview
========

This plugin adds `ReStructuredText`_ support to `Jekyll`_ and `Octopress`_.
It renders ReST in posts and pages, and provides a custom directive to
support Octopress-compatible syntax highlighting.

The motivation to fork this project is to clean up the code and bring it in
line with modern practice. The hope is that in doing so, it will continue to
work without issue for the foreseeable future.

The `original project`_ hasn't been touched since 2013 and the `initial fork`_
still has room for improvement.

Requirements
============

* `Jekyll`_ *or* `Octopress`_ >= 2.0
* `Docutils`_
* `Pygments`_
* `RbST`_

Installation
============

1. Install Docutils and Pygments.

A convenient method is to use `venv`_ and `pip`_:

.. code:: shell

   $ python -m venv $SITE_DIR/.venv
   $ source $SITE_DIR/.venv/bin/activate
   $ pip install docutils pygments

On \*nix, you can also use your distribution's package manager. On Debian or
Ubuntu, you can install the packages with `apt`.

.. code:: shell

   $ sudo apt install python3-docutils python3-pygments

On Fedora, you can use `dnf`.

.. code:: shell

   $ sudo dnf install python3-docutils python3-pygments

From here on, it is assumed that these prerequisites are installed and in
your `PATH` such that running ``command -v rst2html5`` and
``command -v pygmentize`` will print where those respective Python scripts are
installed.

2. Install the plugin.

Add the following to the `:jekyll_plugins` group in your `Gemfile`.

.. code:: ruby

   gem "jekyll-rst", git: "https://github.com/justinjereza/jekyll-rst", tag: "3.0.0"

Run ``bundle install`` to install the plugin.

3. Start blogging using ReStructuredText. Any file with the `.rst` extension
   will be parsed as ReST and rendered to HTML.

.. note:: If you installed Docutils and Pygments using `venv` and `pip`,
   activate the `jekyll-rst` venv before generating the site by running
   ``source $SITE_DIR/.venv/bin/activate``. I suggest you follow
   `Harry Marr's advice`_ and create a `.venv` file that will
   automatically activate the `jekyll-rst` venv when you change to
   your site's directory.

Source Code Highlighting
========================

Use the `code` directive to add syntax highlighting. The `:number-lines`
option may be used for line numbers.

.. code:: rest

   .. code:: ruby
      :number-lines:

      # Output "I love ReST"
      say = "I love ReST"
      puts say

You can also embed `ReST` in `Markdown` with the ``restify`` filter.

.. code:: markdown

   {{ "`GitHub <https://github.com/>`_" | restify }}

.. warning:: The rendered tag is enclosed in a `div`.

Octopress already includes style sheets for syntax highlighting but
you'll need to generate one for yourself if you are using Jekyll.

.. code:: console

   $ cat << EOF > _sass/pygments.scss
   ---
   ---

   EOF
   $ pygmentize -S default -f html -a .document >> _sass/pygments.scss

The style sheet must be imported into your theme. To do so, copy `main.scss`
from your theme to `assets/` and add ``@import "pygments";`` to it.

Octopress Tips
==============

* Use `.. more` in your ReST documents to indicate where Octopress's
  `excerpt` tag should split your content for summary views.

Restoring Default CSS
=====================

If you want to restore the default style sheets of `Docutils`_, copy the
relevant files from 
`$SITE_DIR/.venv/lib/python3.*/site-packages/docutils/writers/` to `assets/`.
Add them to your `_includes/head.html` similar to the following:

.. code:: html

   <link rel="stylesheet" href="{{ "/assets/math.css" | relative_url }}">
   <link rel="stylesheet" href="{{ "/assets/minimal.css" | relative_url }}">
   <link rel="stylesheet" href="{{ "/assets/plain.css" | relative_url }}">

Known Limitations
=================

`jekyll-rst` only knows the directives that `Docutils`_ implements as that is
what `RbST`_ uses. `sphinx`'s extended ReST variant is unsupported and as such,
things like the `:ref:` role won't work.

.. _ReStructuredText: https://docutils.sourceforge.io/rst.html
.. _Jekyll: https://jekyllrb.com/
.. _Octopress: https://octopress.org/
.. _Docutils: https://pypi.org/project/docutils/
.. _Pygments: https://pypi.org/project/Pygments/
.. _RbST: https://rubygems.org/gems/RbST
.. _original project: https://github.com/xdissent/jekyll-rst
.. _initial fork: https://github.com/languidnights/jekyll-rst-ng
.. _venv: https://docs.python.org/3/library/venv.html
.. _pip: https://docs.python.org/3/installing/index.html
.. _Harry Marr's advice: https://hmarr.com/2010/jan/19/making-virtualenv-play-nice-with-git/
