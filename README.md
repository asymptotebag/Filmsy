# Project 2 - *Filmsy*

**Filmsy** is a movies app using the [The Movie Database API](http://docs.themoviedb.apiary.io/#).

Time spent: **X** hours spent in total

## User Stories

The following **required** functionality is complete:

- [x] User sees an app icon on the home screen and a styled launch screen.
- [x] User can view a list of movies currently playing in theaters from The Movie Database.
- [x] Poster images are loaded using the UIImageView category in the AFNetworking library.
- [x] User sees a loading state while waiting for the movies API.
- [x] User can pull to refresh the movie list.
- [x] User sees an error message when there's a networking error.
- [x] User can tap a tab bar button to view a grid layout of Movie Posters using a CollectionView.

The following **optional** features are implemented:

- [x] User can tap a poster in the collection view to see a detail screen of that movie
- [x] User can search for a movie.
- [x] All images fade in as they are loading. Images do not fade in if they are already cached, UNLESS they are part of the CollectionView of posters. I found that the interface was much smoother if all posters faded in in the grid view, regardless of cache status.
- [ ] User can view the large movie poster by tapping on a cell.
- [ ] For the large poster, load the low resolution image first and then switch to the high resolution image when complete.
- [x] Customize the selection effect of the cell. Not a big change, but I've made it a subtler gray.
- [ ] Customize the navigation bar.
- [x] Customize the UI.
- [ ] User can view the app on various device sizes and orientations.
- [x] Run your app on a real device.

The following **additional** features are implemented:

- [ ] List anything else that you can get done to improve the app functionality!

Please list two areas of the assignment you'd like to **discuss further with your peers** during the next class (examples include better ways to implement something, how to extend your app in certain ways, etc):

1. There seems to be a lot of reused code for actions done multiple times for different objects and different view controllers. For example, in order to make all images fade in as they loaded, I needed to copy-paste a sizeable chunk of code whenever an image was displayed. It was performing nearly the exact same operation every time. I feel like there is probably a cleaner way of doing this, perhaps by extracting out the fade-in code as a separate method, but I wasn't quite familiar enough with Objective-C to try.
2.

## Video Walkthrough

Here's a walkthrough of implemented user stories. The gifs showcase, in order:

1. App icon, launch screen, Now Playing list, pull to refresh, CollectionView of movie posters, movie details screen visible from both TableView and CollectionView, customized cell selection effect, customized UI in the details screen, and images fading in (gif is sped up 2x to conserve file size, so fade-ins are no longer obvious).
2. Better view of the loading state while waiting for movies API. (This was recorded before I made images fade in.)
3. Search functionality, which is case-insensitive.
4. Offline error message. Here Filmsy is being run and recorded on a real iPhone 11.


![filmsy_main](https://user-images.githubusercontent.com/43052066/123343636-20269000-d520-11eb-994c-2ac1a971a0a4.gif)
![filmsy_load](https://user-images.githubusercontent.com/43052066/123343650-2a488e80-d520-11eb-9ede-032a7c0b8722.gif)

![filmsy_search](https://user-images.githubusercontent.com/43052066/123343644-27e63480-d520-11eb-95e0-e74b060e2fa7.gif)
![filmsy_offline](https://user-images.githubusercontent.com/43052066/123343656-2caae880-d520-11eb-9139-078ff2628f24.gif)


## Notes

Describe any challenges encountered while building the app.

## Credits

List an 3rd party libraries, icons, graphics, or other assets you used in your app.

- [AFNetworking](https://github.com/AFNetworking/AFNetworking) - networking task library

## License

    Copyright 2021 Emily Jiang

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

        http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.
