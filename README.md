# Redirects

[![build status](https://github.com/jessemillar/redirects/actions/workflows/check-links.yml/badge.svg)](https://github.com/jessemillar/redirects/actions/workflows/check-links.yml)

I use a lot of free hosting/DNS solutions for my web projects and needed a quick way to create URL redirects that would never expire. This repository (hosted via GitHub Pages) represents that functionality.

I have a CloudFlare page rule set up to redirect `jessemillar.com/r/*` links here.

## Usage

```
./new.sh "desiredurl" "newurl.com/something" "desiredtitle (optional)"
```

Shortened URLs can be nested for organization purposes.

```
./new.sh "blog/desiredurl" "newurl.com/something" "desiredtitle (optional)"
```

If you clone this repo into your own, modify `config.sh` to contain your domain name. This allows you to run `./update.sh` to pull in the latest shell scripts without affecting your redirects.
