# Changelog
All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](http://keepachangelog.com/en/1.0.0/)
and this project adheres to [Semantic Versioning](http://semver.org/spec/v2.0.0.html).

## [Unreleased]

## [2.1.0] - 2020-03-17
### Added
- Extended `cosine` to allow usage of N-grams (thanks @imustafin)
### Fixed
- updated outdated development dependencies

## [2.0.1] - 2017-11-22
### Fixed
- `require 'string-similarity'` now actually loads the module. (thanks @wppurking)
### Changed
- CI: Test against recent ruby versions
- CI: use new CodeClimate reporters

## [2.0.0] (2016-02-19)
### Removed
- Core extensions on `String`.

### Added
- Refinements for `String` (see README!).


## [1.1.1] - (2016-02-19)
### Added
- `require 'string-similarity'` now works as well.

## [1.1.0] - (2015-09-07)
### Added
- Implemented Levenshtein distance/similarity
- CI setup
- Proper Documentation


[Unreleased]: https://github.com/mhutter/string-similarity/compare/v2.1.0...HEAD
[2.1.0]: https://github.com/mhutter/string-similarity/compare/v2.0.1...v2.2.0
[2.0.1]: https://github.com/mhutter/string-similarity/compare/v2.0.0...v2.0.1
[2.0.0]: https://github.com/mhutter/string-similarity/compare/v1.1.1...v2.0.0
[1.1.1]: https://github.com/mhutter/string-similarity/compare/v1.1.0...v1.1.1
[1.1.0]: https://github.com/mhutter/string-similarity/compare/v1.0.0...v1.1.0
