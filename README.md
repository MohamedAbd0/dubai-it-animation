# Dubai-It Native Flutter Animation

A native Flutter Web animation explaining Dubai-It / دبي الأفعال using Arabic
and English text, Dubai Font styling, dark navy visuals, and gold motion
accents.

![Cover](cover.png)

**Live Demo:** [https://mohamedabd0.github.io/dubai-it-animation/](https://mohamedabd0.github.io/dubai-it-animation/)

## Demo

<video src="demo.mov" controls width="100%"></video>

> If the video doesn't render, open `demo.mov` from the repository root.

## Features

- Native Flutter animation
- No Lottie, Rive, video, or external animation assets
- Responsive mobile, tablet, and desktop web layout
- CustomPainter visuals for all scenes
- Dubai Font ready with fallback fonts
- GitHub Pages ready

## Requirements

- FVM
- Flutter stable
- Chrome for local web run

## Setup

```bash
dart pub global activate fvm
fvm install stable
fvm use stable
fvm flutter pub get
```

## Run

```bash
fvm flutter run -d chrome
```

## Build

```bash
fvm flutter build web --release
```

## Build for GitHub Pages

This repository is configured for the GitHub Pages base path
`/dubai-it-animation/`.

```bash
fvm flutter build web --release --base-href /dubai-it-animation/
```

If the repository name changes, replace `/dubai-it-animation/` with the new
repository path in the build command and in `.github/workflows/deploy.yml`.

## Dubai Font

The official Dubai Font files are bundled under `assets/fonts/`:

- `assets/fonts/Dubai-Light.ttf`
- `assets/fonts/Dubai-Regular.ttf`
- `assets/fonts/Dubai-Medium.ttf`
- `assets/fonts/Dubai-Bold.ttf`

They were downloaded from Internet Archive captures of the official
`dubaifont.com/css/fonts/` font files because the live official domain was not
reachable from this environment. Do not include font license text unless it is
available from the official font source.
