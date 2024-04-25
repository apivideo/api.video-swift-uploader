# Changelog
All changes to this project will be documented in this file.

## [1.2.3] - 2024-04-25
- Add API to get rate limiting headers

## [1.2.2] - 2023-08-25
- Fix progressive upload with upload token and video id

## [1.2.1] - 2023-08-10
- Add an API to upload with upload token and video id
- Fix Models in documentation

## [1.1.1] - 2022-12-09
- Fix on upload by chunk and progressive upload.
- Add test on progressive upload.
- Add a `build.yml` CI workflow.

## [1.1.0] - 2022-12-06
- Refactor upload by chunk and progressive upload. It is now possible to cancel an upload.
- Add timeout API

## [1.0.1] - 2022-09-13
- period parameter is now mandatory in analytics endpoints

## [1.0.0] - 2022-07-05
- Add SDK origin header

## [0.1.5] - 2022-04-21
- Fix `video.publishedAt` type

## [0.1.4] - 2022-03-11
- Add Origin identification headers

## [0.1.3] - 2022-01-24
- Add applicationName parameter (to allow user agent extension)

## [0.1.2] - 2021-12-14
- Set protocol for progressive upload session visibility to public

## [0.1.1] - 2021-12-14
- Add a protocol for progressive upload session

## [0.1.0] - 2021-12-06
- Initial release of generated version

## [0.0.3] - 2021-11-22
- Fix large upload request time out
- Fix callback on wrong token
