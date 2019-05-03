# NDD Docker Sphinx

## Version 1.8.5-2

- Add development section to the README
- Add references of the Docker image having generated the project to the configuration
- Remove version from utility scripts
- Fix summary in README to be compatible with Docker Hub

## Version 1.8.5-1

- Update Sphinx version to 1.8.5 and plugins versions
- Add utility scripts
- Enable LiveReload on multiple projects at the same time
- Move initialization configuration file to its own directory
- Add test for project initialization

## Version 1.8.4-2

- Remove the 'doc-git' volume
- Enhance documentation

## Version 1.8.4-1

- Update Sphinx version to 1.8.4
- Update Python version to 3.6.8

## Version 1.8.3-2

- Fix [#4 Don't fail when the user already exists](https://bitbucket.org/ndd-docker/ndd-docker-sphinx/issues/4)
- Fix failing HTML test

## Version 1.8.3-1

- Update Sphinx version to 1.8.3 and plugins versions
- Update PlanPlantUML version to 1.2019.0

## Version 1.8.1-5

- Add French language support for PDF

## Version 1.8.1-4

- Add GIT pseudo extension for hash, tag and date

## Version 1.8.1-3

- Update plugin `sphinx_rtd_theme` version to 0.4.2, restoring the search feature

## Version 1.8.1-2

- Fix `sphinx-init` script to use Python 3.6
- Update documentation: initialisation

## Version 1.8.1-1

- New versioning scheme `<SPHINX_VERSION>-<DOCKER_IMAGE_VERSION>`
- Update Sphinx version to 1.8.1 and plugins versions
- Update Python version to 3.6.6
- Update documentation: how to install a new extension
- Add pluggins:
  - `sphinxcontrib-excel-table`
  - `sphinxcontrib-fulltoc`
  - `guzzle_sphinx_theme`
- Remove pluggins:
  - `sphinxcontrib-exceltable`
  - `sphinxcontrib-libreoffice`
- Refactor "testing framework"

## Version 0.9.0

- Fix documentation with the new entrypoint
- Fix expected test results
- Fix entrypoint
- Update Sphinx version to 1.5.5 and plugins versions

## Version 0.8.1

- Rename DOC_DIR to DATA_DIR
- Update PlantUML version
- Fix image name in Dockerfile

## Version 0.8.0

- Update Sphinx version to 1.4.6 and plugins versions
- Add LaTeX support
- Reorganize tests to support both HTML and PDF

## Version 0.7.0

- Rename Docker image to `ddidier/sphinx-doc`
- Update Sphinx version to 1.3.6
- Update plugins versions
- Add `sphinxcontrib-exceltable` back

## Version 0.6.0

- Add basic Markdow support
- Update Sphinx and plugins versions
- Remove `sphinxcontrib-exceltable` because of an incompatibility issue

## Version 0.5.0

- Add pluggins:
  - `sphinx.ext.graphviz`
  - `sphinxcontrib-actdiag`
  - `sphinxcontrib-blockdiag`
  - `sphinxcontrib-nwdiag`
  - `sphinxcontrib-seqdiag`
  - `sphinxcontrib-exceltable`
  - `sphinxcontrib-googleanalytics`
  - `sphinxcontrib-googlechart`
  - `sphinxcontrib-googlemaps`
  - `sphinxcontrib-libreoffice`
  - `sphinxcontrib-plantuml`
- Add test documentation

## Version 0.4.1

- Fix the live HTML build

## Version 0.4.0

- Rebase upon the official [python:2.7](https://hub.docker.com/_/python/) image
- Fix files permissions by using the host group of the documentation directory

## Version 0.3.4

- Add the _unselectable prompt_ Sphinx directive ([sphinx-prompt](https://github.com/sbrunner/sphinx-prompt))

## Version 0.3.3

- Fix `livehtml` target by specifying host address

## Version 0.3.2

- Fix file permissions

## Version 0.3.1

- Fix missing `acl` package
- Fix configuration file location
- Fix `sphinx-autobuild` configuration
- Add parameters passing to `sphinx-init`

## Version 0.3.0

- Rebase image upon [envygeeks/ubuntu](https://github.com/envygeeks/docker-ubuntu)
- Add reStructuredText to PDF converter ([rst2pdf](https://github.com/rst2pdf/rst2pdf))

## Version 0.2.0

- Add Sphinx documentation watcher ([sphinx-autobuild](https://github.com/GaretJax/sphinx-autobuild))
- Remove Latex and PDF support (too big)

## Version 0.1.0

- Initial commit
- Add Sphinx documentation builder ([sphinx-doc](http://sphinx-doc.org))
- Add Sphinx documentation themes ([sphinx-themes](http://docs.writethedocs.org/tools/sphinx-themes))
