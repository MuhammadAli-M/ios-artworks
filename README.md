# Artworks iOS Demo Application

![Artworks presentation 001](https://user-images.githubusercontent.com/36597057/147503594-6157cf86-0fba-4d11-b325-06e0cd63c4bd.png)

![Artworks presentation 002](https://user-images.githubusercontent.com/36597057/147503997-4abce218-fb71-4ef3-ab35-1186467dc133.png)

## Architecture

- MVP 
- Clean Architecture (check [Known Issues](##Known-Issues)) 
- Dependency Injection

## Features 
- Localization
- Dark mode support

## Backlog

### Artworks List 

- [x] Create UI for the artwork list 
- [x] Get the artworks list from API 
    - [x] Create artworks (repos, services)
- [x] Handle error cases 

#### Handled Errors

```
NoInternetConnection
ConnectionTimeout
InternalError
```

### Artist Details 

- [x] Create UI for the artist details 
- [x] Get the artist details from API 
    - [x] Create details (repos, services)
    - [x] Add simple test for hiting the service & parsing response
- [x] Add title label instead of VC title 
- [x] Handle error cases 

#### Device Orientation Feature 

- [x] Add the orientatian manager

#### Handled Errors

```
NoInternetConnection
ConnectionTimeout
InternalError
```

- [ ] Add code doc
- [ ] Add Unit tests.

## Known Issues

- Fix limiting the pages
- Fix issue of no found image for artwork
- Chain of Error handling (ex: `ArtistInfoError` to be to reflect all errors)
- Presenter should has use case property not repo directly, but I do it that way as the repo will do the required for now.
- No listening to internet changes