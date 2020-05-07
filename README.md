# Redirects

I use a lot of free hosting/DNS solutions for my web projects and needed a quick way to create URL redirects that would never expire. This repository (hosted via GitHub Pages) represents that functionality.

I have a CloudFlare page rule set up to redirect `jessemillar.com/r/*` links here.

## Usage

```
./generate.sh "desiredurl" "newurl.com/something"
```

### Note

Shortened URLs can be nested for organization purposes.

```
./generate.sh "blog/desiredurl" "newurl.com/something"
```
