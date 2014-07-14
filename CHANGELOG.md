supervisor CHANGELOG
=================

This file is used to list changes made in each version of the supervisor cookbook.

0.1.5
-----
- enabled support for why-run

0.1.4
-----
- bugfix of chef-client crashing when using both :supervise and :start at the same time

0.1.3
-----
- updated start command for managed processes
- updated status command for supervisor

0.1.2
-----
- If the supervisor is not running the `supervisor_program` now would fail when starting new service.
  This probably could have some unwanted side-effects though.

0.1.1
-----
- Enable and start supervisord service by default

0.1.0
-----
- Initial fork of supervisor cookbook

- - -
Check the [Markdown Syntax Guide](http://daringfireball.net/projects/markdown/syntax) for help with Markdown.

The [Github Flavored Markdown page](http://github.github.com/github-flavored-markdown/) describes the differences between markdown on github and standard markdown.
